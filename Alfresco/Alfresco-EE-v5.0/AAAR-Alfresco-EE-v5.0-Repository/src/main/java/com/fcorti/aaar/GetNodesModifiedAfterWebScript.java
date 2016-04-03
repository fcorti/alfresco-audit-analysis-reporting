/*
Licensed to the Apache Software Foundation (ASF) under one or more
contributor license agreements.  See the NOTICE file distributed with
this work for additional information regarding copyright ownership.
The ASF licenses this file to You under the Apache License, Version 2.0
(the "License"); you may not use this file except in compliance with
the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/
package com.fcorti.aaar;

import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.alfresco.model.ContentModel;
import org.alfresco.service.ServiceRegistry;
import org.alfresco.service.cmr.dictionary.DataTypeDefinition;
import org.alfresco.service.cmr.dictionary.DictionaryService;
import org.alfresco.service.cmr.dictionary.PropertyDefinition;
import org.alfresco.service.cmr.repository.ContentData;
import org.alfresco.service.cmr.repository.NodeService;
import org.alfresco.service.cmr.repository.StoreRef;
import org.alfresco.service.cmr.search.LimitBy;
import org.alfresco.service.cmr.search.PermissionEvaluationMode;
import org.alfresco.service.cmr.search.ResultSet;
import org.alfresco.service.cmr.search.ResultSetRow;
import org.alfresco.service.cmr.search.SearchParameters;
import org.alfresco.service.cmr.search.SearchService;
import org.alfresco.service.namespace.NamespaceService;
import org.alfresco.service.namespace.QName;
import org.alfresco.util.ISO9075;
import org.apache.commons.math3.exception.OutOfRangeException;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.extensions.webscripts.Cache;
import org.springframework.extensions.webscripts.DeclarativeWebScript;
import org.springframework.extensions.webscripts.Status;
import org.springframework.extensions.webscripts.WebScriptException;
import org.springframework.extensions.webscripts.WebScriptRequest;

import com.sun.star.io.WrongFormatException;

import freemarker.template.utility.NullArgumentException;

/**
 * Get nodes modified after a date time for A.A.A.R. analytics.
 *
 * @author fcorti@gmail.com
 * @since 2.1.0
 */
public class GetNodesModifiedAfterWebScript extends DeclarativeWebScript {

	private static final String  PARAMETER_BASETYPE		                  = "baseType";
	private static final String  PARAMETER_CUSTOM_PROPERTIES              = "customProperties";
	private static final String  PARAMETER_CUSTOM_PROPERTIES_TYPES        = "types";
	private static final String  PARAMETER_CUSTOM_PROPERTIES_ASPECTS      = "aspects";
	private static final String  PARAMETER_CUSTOM_PROPERTIES_DEFAULT      = "{ \"" + PARAMETER_CUSTOM_PROPERTIES_TYPES + "\":[], \"" + PARAMETER_CUSTOM_PROPERTIES_ASPECTS + "\":[] }";
	private static final String  PARAMETER_DATE			                  = "dt";
	private static final String  PARAMETER_LIMIT			              = "limit";
	private static final int     PARAMETER_LIMIT_DEFAULT                  = 10000;
	private static final String  PARAMETER_SKIP			                  = "skip";
	private static final int     PARAMETER_SKIP_DEFAULT	                  = 0;
	private static final String  PARAMETER_NAMESPACEURI_COMPACTED         = "namespaceuriCompacted";
	private static final Boolean PARAMETER_NAMESPACEURI_COMPACTED_DEFAULT = true;
	private static final String  DATE_FORMAT                              = "yyyy-MM-dd";
	private static final String  DATETIME_FORMAT                          = "yyyy-MM-dd'T'HH:mm:ss.SSS";

	private DictionaryService dictionaryService;
	private NamespaceService namespaceService;
	private NodeService nodeService;
	private SearchService searchService;
	@SuppressWarnings("unused")
	private ServiceRegistry serviceRegistry;

	private Map<String, Object> parameters = null;

	// private static Logger logger = Logger.getLogger(GetNodesModifiedAfterWebScript.class);

	protected Map<String, Object> executeImpl(WebScriptRequest req, Status status, Cache cache) {

		// Parameters.
		try {
			getParameters(req);
		}
		catch (Exception e) {
			throw new WebScriptException(Status.STATUS_BAD_REQUEST, e.getMessage());
		}

		// Query execution.
		ResultSet resultSet = searchService.query(getSearchParameters(parameters));
		Iterator<ResultSetRow> resultIterator = resultSet.iterator();

		// New parameter values.
		Date newParameterDt = (Date) parameters.get(PARAMETER_DATE);
		int newParameterSkip = (int) parameters.get(PARAMETER_SKIP);

		// Custom properties.
		JSONArray jsonCustomTypes = null;
		JSONArray jsonCustomAspects = null;
		try {
			jsonCustomTypes = ((JSONObject) parameters.get(PARAMETER_CUSTOM_PROPERTIES)).getJSONArray(PARAMETER_CUSTOM_PROPERTIES_TYPES);
			jsonCustomAspects = ((JSONObject) parameters.get(PARAMETER_CUSTOM_PROPERTIES)).getJSONArray(PARAMETER_CUSTOM_PROPERTIES_ASPECTS);
		} catch (JSONException e) {
			throw new WebScriptException(Status.STATUS_INTERNAL_SERVER_ERROR, e.getMessage());
		}

		// Result composition.
		List<Map<String, Object>> results = new ArrayList<Map<String, Object>>();
		while (resultIterator.hasNext()) {

			ResultSetRow resultSetRow = resultIterator.next();

			Map<String, Object> result = new HashMap<String, Object>();
			result.put(ContentModel.PROP_NODE_DBID.getLocalName(),        String.valueOf(resultSetRow.getValue(ContentModel.PROP_NODE_DBID)));
			result.put(ContentModel.PROP_STORE_PROTOCOL.getLocalName(),   resultSetRow.getNodeRef().getStoreRef().getProtocol());
			result.put(ContentModel.PROP_STORE_IDENTIFIER.getLocalName(), resultSetRow.getNodeRef().getStoreRef().getIdentifier());
			result.put(ContentModel.PROP_NODE_UUID.getLocalName(),        resultSetRow.getNodeRef().getId());
			result.put(ContentModel.PROP_NAME.getLocalName(),             resultSetRow.getQName().getLocalName());
			result.put("type",                                            nodeService.getType(resultSetRow.getNodeRef()).toPrefixString(namespaceService));
			result.put(ContentModel.PROP_CREATOR.getLocalName(),          resultSetRow.getValue(ContentModel.PROP_CREATOR));
			result.put(ContentModel.PROP_CREATED.getLocalName(),          getDateAsString((Date) resultSetRow.getValue(ContentModel.PROP_CREATED), DATETIME_FORMAT));
			result.put(ContentModel.PROP_MODIFIER.getLocalName(),         resultSetRow.getValue(ContentModel.PROP_MODIFIER));
			result.put(ContentModel.PROP_MODIFIED.getLocalName(),         getDateAsString((Date) resultSetRow.getValue(ContentModel.PROP_MODIFIED), DATETIME_FORMAT));
			result.put(ContentModel.PROP_LOCALE.getLocalName(),           resultSetRow.getValue(ContentModel.PROP_LOCALE));
			result.put("path",                                            ISO9075.decode(nodeService.getPath(resultSetRow.getNodeRef()).toPrefixString(namespaceService)));

			// Content optional properties.
			if (resultSetRow.getValues().containsKey(ContentModel.PROP_CONTENT.toString())) {

				ContentData contentData = (ContentData) resultSetRow.getValue(ContentModel.PROP_CONTENT);

				result.put("mimetype",       contentData.getMimetype());
				result.put("size",           String.valueOf(contentData.getSize()));
				result.put("encoding",       contentData.getEncoding());
				result.put("content-locale", contentData.getLocale());
			}

			// Custom properties for types and aspects.
			result.put("customTypes",   getCustomProperties(resultSetRow, jsonCustomTypes));
			result.put("customAspects", getCustomProperties(resultSetRow, jsonCustomAspects));

			// Parent reference.
			result.put("parent-" + ContentModel.PROP_NODE_UUID.getLocalName(), resultSetRow.getChildAssocRef().getParentRef().getId());

			results.add(result);

			// New parameter values.
			if (!getDateAsString(newParameterDt, DATE_FORMAT).equals(getDateAsString((Date) resultSetRow.getValue(ContentModel.PROP_MODIFIED), DATE_FORMAT))) {
				newParameterDt = (Date) resultSetRow.getValue(ContentModel.PROP_MODIFIED);
				newParameterSkip = 0;
			}

			// Skip counter.
			++newParameterSkip;
		}

		resultSet.close();

		// Parameter values.
		parameters.replace(PARAMETER_DATE,                   getDateAsString((Date) parameters.get(PARAMETER_DATE), DATE_FORMAT));
		parameters.replace(PARAMETER_LIMIT,                  String.valueOf(parameters.get(PARAMETER_LIMIT)));
		parameters.replace(PARAMETER_SKIP,                   String.valueOf(parameters.get(PARAMETER_SKIP)));
		parameters.replace(PARAMETER_NAMESPACEURI_COMPACTED, String.valueOf(parameters.get(PARAMETER_NAMESPACEURI_COMPACTED)));

		// New parameters values.
		Map<String, Object> newParameters = new HashMap<String, Object>();
		newParameters.put(PARAMETER_BASETYPE,               parameters.get(PARAMETER_BASETYPE));
		newParameters.put(PARAMETER_DATE,                   getDateAsString(newParameterDt, DATE_FORMAT));
		newParameters.put(PARAMETER_LIMIT,                  parameters.get(PARAMETER_LIMIT));
		newParameters.put(PARAMETER_SKIP,                   String.valueOf(newParameterSkip));
		newParameters.put(PARAMETER_NAMESPACEURI_COMPACTED, parameters.get(PARAMETER_NAMESPACEURI_COMPACTED));

		// Model definition.
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("count",	       String.valueOf(results.size()));
		model.put("results",	   results);
		model.put("parameters",    parameters);
		model.put("newParameters", newParameters);

		return model;
	}

	/**
	 * Get the custom properties from the resultSetRow.
	 * 
	 * @param resultSetRow
	 * @param jsonCustomTypesOrAspects
	 * @return
	 */
	private List<Map<String, Object>> getCustomProperties(ResultSetRow resultSetRow, JSONArray jsonCustomTypesOrAspects) {

		// Note:
		// If the property comes with the extended format (i.e. {http://...}property)) or prefixed (i.e. cm:property),
		// the command below get the extended format of the property name:
		// customProperty.toString();
		// the command below get the prefixed format of the property name:
		// customProperty.toPrefixString(namespaceService);

		Map<String, Serializable> resultSetValues = resultSetRow.getValues();
		List<Map<String, Object>> results = new ArrayList<Map<String, Object>>();

		for (int i = 0; i < jsonCustomTypesOrAspects.length(); i++) {

			// Type or aspect retrieve.
			JSONObject jsonCustomTypeOrAspect = null;
			try {
				jsonCustomTypeOrAspect = ((JSONObject) jsonCustomTypesOrAspects.getJSONObject(i));
			} catch (JSONException e) {
				throw new WebScriptException(Status.STATUS_INTERNAL_SERVER_ERROR, e.getMessage());
			}
			QName customTypeOrAspect = QName.resolveToQName(namespaceService, (String) jsonCustomTypeOrAspect.keys().next());

			// Type or aspect name.
			String customTypeOrAspectName = customTypeOrAspect.toString();
			if ((boolean) parameters.get(PARAMETER_NAMESPACEURI_COMPACTED)) {
				customTypeOrAspectName = customTypeOrAspect.toPrefixString(namespaceService);
			}

			// Custom properties scanning.
			JSONArray jsonCustomProperties = null;
			try {
				jsonCustomProperties = (JSONArray) jsonCustomTypeOrAspect.getJSONArray((String) jsonCustomTypeOrAspect.keys().next());
			} catch (JSONException e) {
				throw new WebScriptException(Status.STATUS_INTERNAL_SERVER_ERROR, e.getMessage());
			}
			List<Map<String, String>> resultsForCustomProperties = new ArrayList<Map<String, String>>();
			for (int j = 0; j < jsonCustomProperties.length(); j++) {

				// Property retrieve.
				QName customProperty = null;
				try {
					customProperty = QName.resolveToQName(namespaceService, jsonCustomProperties.getString(j));
				} catch (JSONException e) {
					throw new WebScriptException(Status.STATUS_INTERNAL_SERVER_ERROR, e.getMessage());
				}

				// Property extraction of value.
				if (resultSetValues.containsKey(customProperty.toString())) {

					// Property definition.
					PropertyDefinition customPropertyDefinition = dictionaryService.getProperty(customProperty);

					// Property name.
					String customPropertyName = customProperty.toString();
					if ((boolean) parameters.get(PARAMETER_NAMESPACEURI_COMPACTED)) {
						customPropertyName = customProperty.toPrefixString(namespaceService);
					}

					// Property value.
					String customPropertyValue = null;
					if (customPropertyDefinition.getDataType().getName().isMatch(DataTypeDefinition.BOOLEAN)) {
						customPropertyValue = ((Boolean) resultSetRow.getValue(customPropertyDefinition.getName())) ? "true" : "false";
					}
					else if (customPropertyDefinition.getDataType().getName().isMatch(DataTypeDefinition.DATE)) {
						customPropertyValue = getDateAsString((Date) resultSetRow.getValue(customPropertyDefinition.getName()), DATE_FORMAT);
						}
					else if (customPropertyDefinition.getDataType().getName().isMatch(DataTypeDefinition.DATETIME)) {
						customPropertyValue = getDateAsString((Date) resultSetRow.getValue(customPropertyDefinition.getName()), DATETIME_FORMAT);
					}
					else if (customPropertyDefinition.getDataType().getName().isMatch(DataTypeDefinition.INT) ||
						customPropertyDefinition.getDataType().getName().isMatch(DataTypeDefinition.FLOAT) ||
						customPropertyDefinition.getDataType().getName().isMatch(DataTypeDefinition.LONG) ||
						customPropertyDefinition.getDataType().getName().isMatch(DataTypeDefinition.DOUBLE)) {
						customPropertyValue = String.valueOf(resultSetRow.getValue(customPropertyDefinition.getName()));
					}
					else {
						customPropertyValue = ((String) resultSetRow.getValue(customPropertyDefinition.getName())).replace("\\", "\\\\");
					}
					
					Map<String, String> resultForCustomProperty = new HashMap<String, String>();
					resultForCustomProperty.put("name",  customPropertyName);
					resultForCustomProperty.put("value", customPropertyValue);

					resultsForCustomProperties.add(resultForCustomProperty);
				}
			}

			// Adding result.
			if (!resultsForCustomProperties.isEmpty()) {

				Map<String, Object> resultForCustomTypeOrAspect = new HashMap<String, Object>();
				resultForCustomTypeOrAspect.put("name",       customTypeOrAspectName);
				resultForCustomTypeOrAspect.put("properties", resultsForCustomProperties);

				results.add(resultForCustomTypeOrAspect);
			}

		}

		return results;
	}

	/**
	 * Get the search parameters.
	 * 
	 * @param parameters
	 * @return
	 */
	private static final SearchParameters getSearchParameters(Map<String, Object> parameters) {

		SearchParameters searchParameters = new SearchParameters();

		searchParameters.addStore(StoreRef.STORE_REF_WORKSPACE_SPACESSTORE);
		searchParameters.setLanguage(SearchService.LANGUAGE_FTS_ALFRESCO);
		searchParameters.setPermissionEvaluation(PermissionEvaluationMode.NONE);
		searchParameters.setUseInMemorySort(false);
		searchParameters.setLimitBy(LimitBy.FINAL_SIZE);
		searchParameters.setLimit((int) parameters.get(PARAMETER_LIMIT));
		searchParameters.setQuery(getQuery(parameters));
		searchParameters.setSkipCount((int) parameters.get(PARAMETER_SKIP));
		searchParameters.addSort("@" + ContentModel.PROP_MODIFIED, true);
		searchParameters.addSort("@" + ContentModel.PROP_NODE_DBID, true);

		return searchParameters;
	}

	/**
	 * Get the query string.
	 * 
	 * @param parameters
	 * @return
	 */
	private static final String getQuery(Map<String, Object> parameters) {

		String query = "";

		// Base type filter.
		query += "(TYPE:\"" + parameters.get(PARAMETER_BASETYPE) + "\") ";

		// Date filter.
		query += "AND ";
		query += "(@" + ContentModel.PROP_MODIFIED + ":[\"" + getDateAsString((Date) parameters.get(PARAMETER_DATE), DATE_FORMAT) + "\" TO MAX]) ";

		return query;
	}

	/**
	 * Get parameters from the request.
	 * 
	 * @param req
	 * @return
	 * @throws WrongFormatException 
	 */
	private final void getParameters(WebScriptRequest req) throws WrongFormatException {

		parameters = new HashMap<String, Object>();

		// BaseType parameter.
		String baseTypeParameter = req.getParameter(PARAMETER_BASETYPE);
		if (baseTypeParameter == null) {
			throw new NullArgumentException("Parameter '" + PARAMETER_BASETYPE + "' not specified.");
		}
		baseTypeParameter = baseTypeParameter.trim();
		if (baseTypeParameter.isEmpty()) {
			throw new NullArgumentException("Parameter '" + PARAMETER_BASETYPE + "' cannot be empty.");
		}

		// Custom properties parameter.
		String customPropertiesParameter = req.getParameter(PARAMETER_CUSTOM_PROPERTIES);
		if (customPropertiesParameter == null) {
			customPropertiesParameter = PARAMETER_CUSTOM_PROPERTIES_DEFAULT;
		}
		try {
			customPropertiesParameter = URLDecoder.decode(customPropertiesParameter.trim(), "UTF-8");
		} catch (UnsupportedEncodingException e1) {
	        throw new WrongFormatException("Parameter '" + PARAMETER_CUSTOM_PROPERTIES + "' impossible to decode.");
		}
		if (customPropertiesParameter.isEmpty()) {
			customPropertiesParameter = PARAMETER_CUSTOM_PROPERTIES_DEFAULT;
		}
		JSONObject customPropertiesParameterValue = null;
	    try {
	    	customPropertiesParameterValue = new JSONObject(customPropertiesParameter);
	    }
	    catch (Exception e) {
	        throw new WrongFormatException("Parameter '" + PARAMETER_CUSTOM_PROPERTIES + "' with a wrong JSON format. " + e.getMessage());
	    }
		if (!customPropertiesParameterValue.has(PARAMETER_CUSTOM_PROPERTIES_TYPES)) {
	        throw new NullArgumentException("Parameter '" + PARAMETER_CUSTOM_PROPERTIES + "' without the mandatory item '" + PARAMETER_CUSTOM_PROPERTIES_TYPES + "'. ");
		}
		if (!customPropertiesParameterValue.has(PARAMETER_CUSTOM_PROPERTIES_ASPECTS)) {
	        throw new NullArgumentException("Parameter '" + PARAMETER_CUSTOM_PROPERTIES + "' without the mandatory item '" + PARAMETER_CUSTOM_PROPERTIES_ASPECTS + "'. ");
		}
		try {
			customPropertiesParameterValue.getJSONArray(PARAMETER_CUSTOM_PROPERTIES_TYPES);
		} catch (JSONException e) {
	        throw new WrongFormatException("Parameter '" + PARAMETER_CUSTOM_PROPERTIES + "' where '" + PARAMETER_CUSTOM_PROPERTIES_TYPES + "' is not an arrray. ");
		}
		try {
			customPropertiesParameterValue.getJSONArray(PARAMETER_CUSTOM_PROPERTIES_ASPECTS);
		} catch (JSONException e) {
	        throw new WrongFormatException("Parameter '" + PARAMETER_CUSTOM_PROPERTIES + "' where '" + PARAMETER_CUSTOM_PROPERTIES_ASPECTS + "' is not an arrray. ");
		}

		// Date parameter.
		String dateParameter = req.getParameter(PARAMETER_DATE);
		if (dateParameter == null) {
			throw new NullArgumentException("Parameter '" + PARAMETER_DATE + "' not specified.");
		}
		dateParameter = dateParameter.trim();
		if (dateParameter.isEmpty()) {
			throw new NullArgumentException("Parameter '" + PARAMETER_DATE + "' cannot be empty.");
		}
		Date dateParameterValue = null;
	    try {
	    	dateParameterValue = (new SimpleDateFormat(DATE_FORMAT)).parse(dateParameter);
	    }
	    catch (Exception e) {
	        throw new WrongFormatException("Parameter '" + PARAMETER_DATE + "' with a wrong format. Request '" + DATE_FORMAT + "'.");
	    }

		// Limit parameter.
		String limitParameter = req.getParameter(PARAMETER_LIMIT);
		if (limitParameter == null) {
			limitParameter = "" + PARAMETER_LIMIT_DEFAULT;
		}
		limitParameter = limitParameter.trim();
		if (limitParameter.isEmpty()) {
			throw new NullArgumentException("Parameter '" + PARAMETER_LIMIT + "' cannot be empty.");
		}
		int limitParameterValue = Integer.parseInt(limitParameter);
		if (limitParameterValue <= 0) {
			throw new OutOfRangeException(limitParameterValue, 0, Integer.MAX_VALUE);			
		}

		// Skip parameter.
		String skipParameter = req.getParameter(PARAMETER_SKIP);
		if (skipParameter == null) {
			skipParameter = "" + PARAMETER_SKIP_DEFAULT;
		}
		skipParameter = skipParameter.trim();
		if (skipParameter.isEmpty()) {
			throw new NullArgumentException("Parameter '" + PARAMETER_SKIP + "' cannot be empty.");
		}
		int skipParameterValue = Integer.parseInt(skipParameter);
		if (skipParameterValue < 0) {
			throw new OutOfRangeException(skipParameterValue, 0, Long.MAX_VALUE);			
		}

		// Namespace URI compacted parameter.
		String namespaceuriCompactedParameter = req.getParameter(PARAMETER_NAMESPACEURI_COMPACTED);
		if (namespaceuriCompactedParameter == null) {
			namespaceuriCompactedParameter = "" + PARAMETER_NAMESPACEURI_COMPACTED_DEFAULT;
		}
		namespaceuriCompactedParameter = namespaceuriCompactedParameter.trim();
		if (namespaceuriCompactedParameter.isEmpty()) {
			throw new NullArgumentException("Parameter '" + PARAMETER_NAMESPACEURI_COMPACTED + "' cannot be empty.");
		}
		Boolean namespaceuriCompactedParameterValue = Boolean.parseBoolean(namespaceuriCompactedParameter);

		parameters.put(PARAMETER_BASETYPE,               baseTypeParameter);
		parameters.put(PARAMETER_CUSTOM_PROPERTIES,      customPropertiesParameterValue);
		parameters.put(PARAMETER_DATE,                   dateParameterValue);
		parameters.put(PARAMETER_LIMIT,                  limitParameterValue);
		parameters.put(PARAMETER_SKIP,                   skipParameterValue);
		parameters.put(PARAMETER_NAMESPACEURI_COMPACTED, namespaceuriCompactedParameterValue);
	}

	/**
	 * Get the string representation of the date.
	 * 
	 * @param date
	 * @param format
	 * @return
	 */
	private static final String getDateAsString(Date date, String format) {
		return (date == null) ? "" : (new SimpleDateFormat(format)).format(date);
	}

	public void setDictionaryService(DictionaryService dictionaryService) {
		this.dictionaryService = dictionaryService;
	}

	public void setNodeService(NodeService nodeService) {
		this.nodeService = nodeService;
	}

	public void setServiceRegistry(ServiceRegistry serviceRegistry) {
		this.serviceRegistry = serviceRegistry;
		this.namespaceService = serviceRegistry.getNamespaceService();
	}

	public void setSearchService(SearchService searchService) {
		this.searchService = searchService;
	}
}