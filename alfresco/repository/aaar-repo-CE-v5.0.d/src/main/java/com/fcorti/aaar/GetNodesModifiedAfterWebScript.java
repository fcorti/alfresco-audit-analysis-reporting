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

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.alfresco.model.ContentModel;
import org.alfresco.service.cmr.repository.ContentData;
import org.alfresco.service.cmr.repository.NodeService;
import org.alfresco.service.cmr.repository.StoreRef;
import org.alfresco.service.cmr.search.LimitBy;
import org.alfresco.service.cmr.search.ResultSet;
import org.alfresco.service.cmr.search.ResultSetRow;
import org.alfresco.service.cmr.search.SearchParameters;
import org.alfresco.service.cmr.search.SearchService;
import org.apache.commons.math3.exception.OutOfRangeException;
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

	private static final String PARAMETER_BASETYPE		    = "baseType";
	private static final String PARAMETER_DATE			    = "dt";
	private static final String PARAMETER_LIMIT			    = "limit";
	private static final int    PARAMETER_LIMIT_DEFAULT     = 10000;
	private static final String PARAMETER_SKIP			    = "skip";
	private static final int    PARAMETER_SKIP_DEFAULT	    = 0;
	private static final String DATE_FORMAT                 = "yyyy-MM-dd";
	private static final String DATETIME_FORMAT             = "yyyy-MM-dd'T'HH:mm:ss.SSS";

	private NodeService nodeService;
	private SearchService searchService;

	// private static Logger logger = Logger.getLogger(GetNodesModifiedAfterWebScript.class);

	protected Map<String, Object> executeImpl(WebScriptRequest req, Status status, Cache cache) {

		// Parameters.
		Map<String, Object> parameters = null;
		try {
			parameters = getParameters(req);
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

		// Result composition.
		List<Map<String, Object>> results = new ArrayList<Map<String, Object>>();
		while (resultIterator.hasNext()) {

			ResultSetRow resultSetRow = resultIterator.next();

			// Retrieve values.
			resultSetRow.getValues();

			Map<String, Object> result = new HashMap<String, Object>();
			result.put(ContentModel.PROP_NODE_DBID.getLocalName(),        resultSetRow.getValue(ContentModel.PROP_NODE_DBID));
			result.put(ContentModel.PROP_STORE_PROTOCOL.getLocalName(),   resultSetRow.getNodeRef().getStoreRef().getProtocol());
			result.put(ContentModel.PROP_STORE_IDENTIFIER.getLocalName(), resultSetRow.getNodeRef().getStoreRef().getIdentifier());
			result.put(ContentModel.PROP_NODE_UUID.getLocalName(),        resultSetRow.getNodeRef().getId());
			result.put(ContentModel.PROP_NAME.getLocalName(),             resultSetRow.getQName().getLocalName());
			result.put("type",                                            nodeService.getType(resultSetRow.getNodeRef()));
			result.put(ContentModel.PROP_CREATOR.getLocalName(),          resultSetRow.getValue(ContentModel.PROP_CREATOR));
			result.put(ContentModel.PROP_CREATED.getLocalName(),          getDateAsString((Date) resultSetRow.getValue(ContentModel.PROP_CREATED), DATETIME_FORMAT));
			result.put(ContentModel.PROP_MODIFIER.getLocalName(),         resultSetRow.getValue(ContentModel.PROP_MODIFIER));
			result.put(ContentModel.PROP_MODIFIED.getLocalName(),         getDateAsString((Date) resultSetRow.getValue(ContentModel.PROP_MODIFIED), DATETIME_FORMAT));
			result.put(ContentModel.PROP_LOCALE.getLocalName(),           resultSetRow.getValue(ContentModel.PROP_LOCALE));
			result.put("path",                                            nodeService.getPath(resultSetRow.getNodeRef()));

			if (resultSetRow.getValues().containsKey(ContentModel.PROP_CONTENT.toString())) {

				ContentData contentData = (ContentData) resultSetRow.getValue(ContentModel.PROP_CONTENT);

				result.put("mimetype",       contentData.getMimetype());
				result.put("size",           Long.toString(contentData.getSize()));
				result.put("encoding",       contentData.getEncoding());
				result.put("content-locale", contentData.getLocale());
			}

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
		parameters.replace(PARAMETER_DATE, getDateAsString((Date) parameters.get(PARAMETER_DATE), DATE_FORMAT));

		// New parameters values.
		Map<String, Object> newParameters = new HashMap<String, Object>();
		newParameters.put(PARAMETER_BASETYPE,  parameters.get(PARAMETER_BASETYPE));
		newParameters.put(PARAMETER_DATE,      getDateAsString(newParameterDt, DATE_FORMAT));
		newParameters.put(PARAMETER_LIMIT,     parameters.get(PARAMETER_LIMIT));
		newParameters.put(PARAMETER_SKIP,      newParameterSkip);
		
		// Model definition.
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("count",	       results.size());
		model.put("results",	   results);
		model.put("parameters",    parameters);
		model.put("newParameters", newParameters);

		return model;
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
		searchParameters.setQuery(getQuery(parameters));
		searchParameters.setSkipCount((int) parameters.get(PARAMETER_SKIP));
		searchParameters.addSort("@" + ContentModel.PROP_MODIFIED, true);
		searchParameters.addSort("@" + ContentModel.PROP_NODE_DBID, true);
		searchParameters.setUseInMemorySort(false);
		searchParameters.setLimitBy(LimitBy.FINAL_SIZE);
		searchParameters.setLimit((int) parameters.get(PARAMETER_LIMIT) + (int) parameters.get(PARAMETER_SKIP));

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
		query += "(@" + ContentModel.PROP_MODIFIED + ":[\"" + getDateAsString((Date) parameters.get(PARAMETER_DATE), DATE_FORMAT) + "T00:00:00.000Z\" TO MAX]) ";

		return query;
	}

	/**
	 * Get parameters from the request.
	 * 
	 * @param req
	 * @return
	 * @throws WrongFormatException 
	 */
	private static final Map<String, Object> getParameters(WebScriptRequest req) throws WrongFormatException {

		Map<String, Object> parameters = new HashMap<String, Object>();

		// BaseType parameter.
		String baseTypeParameter = req.getParameter(PARAMETER_BASETYPE);
		if (baseTypeParameter == null) {
			throw new NullArgumentException("Parameter '" + PARAMETER_BASETYPE + "' not specified.");
		}
		baseTypeParameter = baseTypeParameter.trim();
		if (baseTypeParameter.isEmpty()) {
			throw new NullArgumentException("Parameter '" + PARAMETER_BASETYPE + "' cannot be empty.");
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

		parameters.put(PARAMETER_BASETYPE, baseTypeParameter);
		parameters.put(PARAMETER_DATE,     dateParameterValue);
		parameters.put(PARAMETER_LIMIT,    limitParameterValue);
		parameters.put(PARAMETER_SKIP,     skipParameterValue);

		return parameters;
	}

	/**
	 * Get the string representation of the date.
	 * 
	 * @param date
	 * @param format
	 * @return
	 */
	private static final String getDateAsString(Date date, String format) {
		return (new SimpleDateFormat(format)).format(date);
	}

	public void setNodeService(NodeService nodeService) {
		this.nodeService = nodeService;
	}

	public void setSearchService(SearchService searchService) {
		this.searchService = searchService;
	}
}