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
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.alfresco.model.ContentModel;
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
public class GetNodeIdsModifiedBeforeWebScript extends DeclarativeWebScript {

	private static final String PARAMETER_BASETYPE		= "baseType";
	private static final String PARAMETER_DATE			= "dt";
	private static final String PARAMETER_LIMIT			= "limit";
	private static final int    PARAMETER_LIMIT_DEFAULT = 10000;
	private static final String PARAMETER_SKIP			= "skip";
	private static final int    PARAMETER_SKIP_DEFAULT	= 0;
	private static final String DATE_FORMAT             = "yyyy-MM-dd";

	private SearchService searchService;

	protected Map<String, Object> executeImpl(WebScriptRequest req, Status status, Cache cache) {

		// Parameters.
		Map<String, String> parameters = null;
		try {
			parameters = getParameters(req);
		}
		catch (Exception e) {
			throw new WebScriptException(Status.STATUS_BAD_REQUEST, e.getMessage());
		}

		// Query execution.
		ResultSet resultSet = searchService.query(getSearchParameters(parameters));

		// New parameter values.
		String newParameterDt = parameters.get(PARAMETER_DATE);
		int newParameterSkip = Integer.parseInt(parameters.get(PARAMETER_SKIP));

		// Result composition.
		Iterator<ResultSetRow> resultIterator = resultSet.iterator();
		List<Long> results = new ArrayList<Long>();
		while (resultIterator.hasNext()) {

			ResultSetRow resultSetRow = resultIterator.next();
			resultSetRow.getValues();

			results.add((Long) resultSetRow.getValue(ContentModel.PROP_NODE_DBID));

			++newParameterSkip;
		}

		resultSet.close();

		// New parameters values.
		Map<String, String> newParameters = new HashMap<String, String>();
		newParameters.put(PARAMETER_BASETYPE, parameters.get(PARAMETER_BASETYPE));
		newParameters.put(PARAMETER_DATE,     newParameterDt);
		newParameters.put(PARAMETER_LIMIT,    parameters.get(PARAMETER_LIMIT));
		newParameters.put(PARAMETER_SKIP,     Integer.toString(newParameterSkip));

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
	private static final SearchParameters getSearchParameters(Map<String, String> parameters) {

		SearchParameters searchParameters = new SearchParameters();

		searchParameters.addStore(StoreRef.STORE_REF_WORKSPACE_SPACESSTORE);
		searchParameters.setLanguage(SearchService.LANGUAGE_FTS_ALFRESCO);
		searchParameters.setQuery(getQuery(parameters));
		searchParameters.setSkipCount(Integer.parseInt(parameters.get(PARAMETER_SKIP)));
		searchParameters.addSort("@" + ContentModel.PROP_NODE_DBID, true);
		searchParameters.setUseInMemorySort(false);
		searchParameters.setLimitBy(LimitBy.FINAL_SIZE);
		searchParameters.setLimit(Integer.parseInt(parameters.get(PARAMETER_LIMIT)));

		return searchParameters;
	}

	/**
	 * Get the query string.
	 * 
	 * @param parameters
	 * @return
	 */
	private static final String getQuery(Map<String, String> parameters) {

		String query = "";

		// Base type filter.
		query += "(TYPE:\"" + parameters.get(PARAMETER_BASETYPE) + "\") ";

		// Date filter.
		query += "AND ";
		query += "(@" + ContentModel.PROP_MODIFIED + ":[MIN TO \"" + parameters.get(PARAMETER_DATE) + "T00:00:00.000Z\">) ";

		return query;
	}

	/**
	 * Get parameters from the request.
	 * 
	 * @param req
	 * @return
	 * @throws WrongFormatException 
	 */
	private static final Map<String, String> getParameters(WebScriptRequest req) throws WrongFormatException {

		Map<String, String> parameters = new HashMap<String, String>();

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
	    try {
		    (new SimpleDateFormat(DATE_FORMAT)).parse(dateParameter);
	    }
	    catch (Exception e) {
	        throw new WrongFormatException("Parameter '" + PARAMETER_DATE + "' with a wrong format. Request '" + DATE_FORMAT + "'.");
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
		Long skipParameterValue = Long.parseLong(skipParameter);
		if (skipParameterValue < 0) {
			throw new OutOfRangeException(skipParameterValue, 0, Long.MAX_VALUE);			
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
		Integer limitParameterValue = Integer.parseInt(limitParameter);
		if (limitParameterValue <= 0) {
			throw new OutOfRangeException(limitParameterValue, 0, Integer.MAX_VALUE);			
		}

		parameters.put(PARAMETER_BASETYPE,   baseTypeParameter);
		parameters.put(PARAMETER_DATE,       dateParameter);
		parameters.put(PARAMETER_SKIP,       skipParameter);
		parameters.put(PARAMETER_LIMIT,      limitParameter);

		return parameters;
	}

	public void setSearchService(SearchService searchService) {
		this.searchService = searchService;
	}
}