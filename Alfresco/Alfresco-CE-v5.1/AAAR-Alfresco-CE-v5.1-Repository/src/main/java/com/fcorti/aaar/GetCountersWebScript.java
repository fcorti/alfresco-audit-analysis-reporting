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

import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.alfresco.service.namespace.NamespaceService;
import org.alfresco.service.namespace.QName;
import org.alfresco.model.ContentModel;
import org.alfresco.service.ServiceRegistry;
import org.alfresco.service.cmr.repository.StoreRef;
import org.alfresco.service.cmr.search.LimitBy;
import org.alfresco.service.cmr.search.PermissionEvaluationMode;
import org.alfresco.service.cmr.search.SearchParameters;
import org.alfresco.service.cmr.search.SearchService;
import org.springframework.extensions.webscripts.Cache;
import org.springframework.extensions.webscripts.DeclarativeWebScript;
import org.springframework.extensions.webscripts.Status;
import org.springframework.extensions.webscripts.WebScriptRequest;
import org.springframework.extensions.webscripts.WebScriptException;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import com.sun.star.io.WrongFormatException;

/**
 * Get the global properties for A.A.A.R. analytics.
 *
 * @author fcorti@gmail.com
 * @since 4.4
 */
public class GetCountersWebScript extends DeclarativeWebScript {

    private static final String PARAMETER_COUNTER                    = "counter";
    private static final String PARAMETER_COUNTER_ASPECTS            = "aspects";
    private static final String PARAMETER_COUNTER_AUDIT_TRAIL        = "auditTrail";
    private static final String PARAMETER_COUNTER_TYPES              = "types";
    private static final String PARAMETER_COUNTER_WORKFLOW_INSTANCES = "workflowInstances";
    private static final String PARAMETER_COUNTER_WORKFLOW_TASKS     = "workflowTasks";
    private static final String PARAMETER_APPLICATION                = "application";
    private static final String PARAMETER_CLASSES                    = "classes";
    private static final String PARAMETER_CLASSES_ASPECTS            = PARAMETER_COUNTER_ASPECTS;
    private static final String PARAMETER_CLASSES_TYPES              = PARAMETER_COUNTER_TYPES;
    private static final String DB_DRIVER                            = "db.driver";
    private static final String DB_URL                               = "db.url";
    private static final String DB_USERNAME                          = "db.username";
    private static final String DB_PASSWORD                          = "db.password";
    private static final String VALUE_FIELD                          = "value";

    private NamespaceService namespaceService;
    private Properties properties;
	private SearchService searchService;
    @SuppressWarnings("unused")
    private ServiceRegistry serviceRegistry;

    private Map<String, Object> parameters = null;

    protected Map<String, Object> executeImpl(WebScriptRequest req, Status status, Cache cache) {

        // Parameters.
        try {
            parameters = getParameters(req);
        }
        catch (Exception e) {
            throw new WebScriptException(Status.STATUS_BAD_REQUEST, e.getMessage());
        }

        // Model composition.
        Map<String, Object> model = new HashMap<String, Object>();
        model.put(PARAMETER_COUNTER,     (String) parameters.get(PARAMETER_COUNTER));
        model.put(PARAMETER_APPLICATION, (String) parameters.get(PARAMETER_APPLICATION));
        model.put(PARAMETER_CLASSES,     (String) parameters.get(PARAMETER_CLASSES));

        try {
            model.put(VALUE_FIELD, getCounter(parameters));
        }
        catch (Exception e) {
            throw new WebScriptException(Status.STATUS_BAD_REQUEST, e.getMessage());
        }

        return model;
    }

    /**
     * Get the value of the counter.
     * @param parameters
     * @return
     * @throws ClassNotFoundException 
     * @throws SQLException 
     */
    private String getCounter(Map<String, Object> parameters) throws Exception {

    	String counter = "0";

    	switch ((String) parameters.get(PARAMETER_COUNTER)) {

        case PARAMETER_COUNTER_AUDIT_TRAIL:
        case PARAMETER_COUNTER_WORKFLOW_INSTANCES:
        case PARAMETER_COUNTER_WORKFLOW_TASKS:

        	/*
        	 * TODO: The query should be defined using hibernate.
        	 */

        	Class.forName(properties.getProperty(DB_DRIVER));

            java.sql.Connection dbConnection = DriverManager.getConnection(properties.getProperty(DB_URL), properties.getProperty(DB_USERNAME), properties.getProperty(DB_PASSWORD));
            Statement dbStatement = dbConnection.createStatement();
            String dbQuery = getDatabaseQuery(parameters);
            java.sql.ResultSet dbResultSet = dbStatement.executeQuery(dbQuery);

            if (dbResultSet.next()) {
            	counter = String.valueOf(dbResultSet.getDouble(VALUE_FIELD));
            }

            if (dbResultSet.next()) {
                throw new WrongFormatException("Database query '" + dbQuery + "' with multiple results when only one is expected.");
            }

            if (dbStatement != null) dbStatement.close();
            if (dbConnection != null) dbConnection.close();

            break;

        case PARAMETER_COUNTER_ASPECTS:
        case PARAMETER_COUNTER_TYPES:

            SearchParameters searchParameters = new SearchParameters();

            searchParameters.addStore(StoreRef.STORE_REF_WORKSPACE_SPACESSTORE);
            searchParameters.setLanguage(SearchService.LANGUAGE_FTS_ALFRESCO);
            searchParameters.setPermissionEvaluation(PermissionEvaluationMode.NONE);
            searchParameters.setUseInMemorySort(false);
            searchParameters.setLimitBy(LimitBy.FINAL_SIZE);
            searchParameters.setQuery(getAlfrescoQuery(parameters));

            org.alfresco.service.cmr.search.ResultSet resultSet = searchService.query(searchParameters);
            counter = String.valueOf(resultSet.getNumberFound());

            resultSet.close();

            break;

        default:
            throw new WrongFormatException("Parameter '" + PARAMETER_COUNTER + "' with value '" + ((String) parameters.get(PARAMETER_COUNTER)) + "' not admitted.");
        }

    	return counter;

    }

    /**
     * Compose the query string for a database.
     * @param parameters
     * @return
     */
    private String getDatabaseQuery(Map<String, Object> parameters) throws WrongFormatException {

    	/*
    	 * TODO: The query should be defined using hibernate.
    	 */

    	String query = "";

        switch ((String) parameters.get(PARAMETER_COUNTER)) {

        case PARAMETER_COUNTER_AUDIT_TRAIL:

        	query = ""
                + "SELECT "
                + " count(*) AS " + VALUE_FIELD + " "
                + "FROM "
                + " alf_audit_app app,"
                + " alf_prop_value app_name,"
                + " alf_prop_string_value app_value,"
                + " alf_audit_entry entry "
                + "WHERE "
                + " app.app_name_id = app_name.id"
                + " AND app_name.long_value = app_value.id"
                + " AND app.id = entry.audit_app_id"
                + " AND app_value.string_value = '" + ((String) parameters.get(PARAMETER_APPLICATION)) + "'";

            break;

        case PARAMETER_COUNTER_WORKFLOW_INSTANCES:

            query = ""
                + "SELECT "
                + " count(*) AS " + VALUE_FIELD + " "
                + "FROM "
                + " act_hi_procinst";

            break;

        case PARAMETER_COUNTER_WORKFLOW_TASKS:

            query = ""
                + "SELECT "
                + " count(*) AS " + VALUE_FIELD + " "
                + "FROM "
                + " " + "act_hi_taskinst" + " "
                + "WHERE "
                + "act_id_ = 'start' "
                + "OR task_id_ is not null";

            break;

        default:
            throw new WrongFormatException("Parameter '" + PARAMETER_COUNTER + "' with value '" + ((String) parameters.get(PARAMETER_COUNTER)) + "' not admitted.");
        }

        return query;
    }

    /**
     * Compose the query string for Afresco.
     * @param parameters
     * @return
     */
    private String getAlfrescoQuery(Map<String, Object> parameters) throws WrongFormatException {

        String query = "";

        switch ((String) parameters.get(PARAMETER_COUNTER)) {

        case PARAMETER_COUNTER_ASPECTS:

        	// Aspect list definition.
            List<QName> aspects = null;
            try {
                JSONObject jsonTypes = new JSONObject((String) parameters.get(PARAMETER_CLASSES));
            	aspects = getQNames(jsonTypes.getJSONArray(PARAMETER_CLASSES_ASPECTS));
            } catch (JSONException e) {
                throw new WebScriptException(Status.STATUS_INTERNAL_SERVER_ERROR, e.getMessage());
            }
            if (aspects.isEmpty()) {
                throw new WebScriptException(Status.STATUS_BAD_REQUEST, "Class list empty in '" + PARAMETER_CLASSES_ASPECTS + "' parameter.");
            }

            // Query composition.
    		query += "(";
            for (int i = 0; i < aspects.size(); ++i) {

                QName aspectQName = aspects.get(i);

                query += "(ASPECT:\"{" + aspectQName.getNamespaceURI() + "}" + aspectQName.getLocalName() + "\")";

                if ((i + 1) < aspects.size()) {
                    query += " OR ";
                }
            }
    		query += ") ";

    		// Modification date filter.
    		query += "AND ";
    		query += "(@" + ContentModel.PROP_MODIFIED + ":[\"2001-01-01T00:00:00.000\" TO MAX]) ";

            break;

        case PARAMETER_COUNTER_TYPES:

        	// Type list definition.
            List<QName> types = null;
            try {
                JSONObject jsonTypes = new JSONObject((String) parameters.get(PARAMETER_CLASSES));
                types = getQNames(jsonTypes.getJSONArray(PARAMETER_COUNTER_TYPES));
            } catch (JSONException e) {
                throw new WebScriptException(Status.STATUS_INTERNAL_SERVER_ERROR, e.getMessage());
            }
            if (types.isEmpty()) {
                throw new WebScriptException(Status.STATUS_BAD_REQUEST, "Class list empty in '" + PARAMETER_CLASSES_TYPES + "' parameter.");
            }

            // Query composition.
    		query += "(";
            for (int i = 0; i < types.size(); ++i) {

                QName typeQName = types.get(i);

                query += "(TYPE:\"{" + typeQName.getNamespaceURI() + "}" + typeQName.getLocalName() + "\")";

                if ((i + 1) < types.size()) {
                    query += " OR ";
                }
            }
    		query += ") ";

    		// Modification date filter.
    		query += "AND ";
    		query += "(@" + ContentModel.PROP_MODIFIED + ":[\"2001-01-01T00:00:00.000\" TO MAX]) ";

        	break;

        default:
            throw new WrongFormatException("Parameter '" + PARAMETER_COUNTER + "' with value '" + ((String) parameters.get(PARAMETER_COUNTER)) + "' not admitted.");
        }

        return query;
	}

    /**
     * Get QNames from the parameter 'classes'.
     * 
     * @param classes
     * @return
     */
    private final List<QName> getQNames(JSONArray classes) throws JSONException {

        List<QName> result = new ArrayList<QName>();

		for (int i = 0; i < classes.length(); ++i) {
			result.add(QName.resolveToQName(namespaceService, classes.getString(i)));
		}

        return result;
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

        // Counter parameter.
        String counterParameter = req.getParameter(PARAMETER_COUNTER);
        if (counterParameter == null) {
            throw new WrongFormatException("Parameter '" + PARAMETER_COUNTER + "' not specified.");
        }
        counterParameter = counterParameter.trim();
        if (counterParameter.isEmpty()) {
            throw new WrongFormatException("Parameter '" + PARAMETER_COUNTER + "' cannot be empty.");
        }

        // Application parameter.
        String applicationParameter = req.getParameter(PARAMETER_APPLICATION);
        if (PARAMETER_COUNTER_AUDIT_TRAIL.equals(counterParameter)) {
            if (applicationParameter == null) {
                throw new WrongFormatException("Parameter '" + PARAMETER_APPLICATION + "' requested in case of '" + PARAMETER_COUNTER + "=" + PARAMETER_COUNTER_AUDIT_TRAIL + "'.");
            }
            applicationParameter = applicationParameter.trim();
            if (applicationParameter.isEmpty()) {
                throw new WrongFormatException("Parameter '" + PARAMETER_APPLICATION + "' cannot be empty in case of '" + PARAMETER_COUNTER + "=" + PARAMETER_COUNTER_AUDIT_TRAIL + "'.");
            }
        }

        // Class array parameter.
        String classesParameter = req.getParameter(PARAMETER_CLASSES);
        if (PARAMETER_COUNTER_ASPECTS.equals(counterParameter)) {
            if (classesParameter == null) {
                throw new WrongFormatException("Parameter '" + PARAMETER_CLASSES + "' requested in case of '" + PARAMETER_COUNTER + "=" + PARAMETER_COUNTER_ASPECTS + "'.");
            }
            classesParameter = classesParameter.trim();
            if (classesParameter.isEmpty()) {
                throw new WrongFormatException("Parameter '" + PARAMETER_CLASSES + "' cannot be empty in case of '" + PARAMETER_COUNTER + "=" + PARAMETER_COUNTER_ASPECTS + "'.");
            }
        }
        if (PARAMETER_COUNTER_TYPES.equals(counterParameter)) {
            if (classesParameter == null) {
                throw new WrongFormatException("Parameter '" + PARAMETER_CLASSES + "' requested in case of '" + PARAMETER_COUNTER + "=" + PARAMETER_COUNTER_TYPES + "'.");
            }
            classesParameter = classesParameter.trim();
            if (classesParameter.isEmpty()) {
                throw new WrongFormatException("Parameter '" + PARAMETER_CLASSES + "' cannot be empty in case of '" + PARAMETER_COUNTER + "=" + PARAMETER_COUNTER_TYPES + "'.");
            }
        }

        parameters.put(PARAMETER_COUNTER,     counterParameter);
        parameters.put(PARAMETER_APPLICATION, applicationParameter);
        parameters.put(PARAMETER_CLASSES,     classesParameter);

        return parameters;
    }

    public void setProperties(Properties properties) 
    {
        this.properties = properties;
    }

	public void setSearchService(SearchService searchService) {
		this.searchService = searchService;
	}

    public void setServiceRegistry(ServiceRegistry serviceRegistry) {
        this.serviceRegistry = serviceRegistry;
        this.namespaceService = serviceRegistry.getNamespaceService();
    }
}