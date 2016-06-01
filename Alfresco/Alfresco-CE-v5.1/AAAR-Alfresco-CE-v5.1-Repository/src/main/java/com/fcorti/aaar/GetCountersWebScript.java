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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.alfresco.service.namespace.NamespaceService;
import org.alfresco.service.namespace.QName;
import org.alfresco.service.ServiceRegistry;
import org.springframework.extensions.webscripts.Cache;
import org.springframework.extensions.webscripts.DeclarativeWebScript;
import org.springframework.extensions.webscripts.Status;
import org.springframework.extensions.webscripts.WebScriptRequest;
import org.springframework.extensions.webscripts.WebScriptException;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import com.sun.star.io.WrongFormatException;

import jdk.nashorn.internal.runtime.JSONFunctions;

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
    @SuppressWarnings("unused")
    private ServiceRegistry serviceRegistry;

    private Map<String, Object> parameters = null;

    protected Map<String, Object> executeImpl(WebScriptRequest req, Status status, Cache cache) {

        // Parameters.
        Map<String, Object> parameters = null;
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

        // Alfresco database enquery.
        try {

            Class.forName(properties.getProperty(DB_DRIVER));

            java.sql.Connection dbConnection = DriverManager.getConnection(properties.getProperty(DB_URL), properties.getProperty(DB_USERNAME), properties.getProperty(DB_PASSWORD));
            Statement dbStatement = dbConnection.createStatement();
            String dbQuery = getQuery(parameters);
            ResultSet dbResultSet = dbStatement.executeQuery(dbQuery);

            if (dbResultSet.next()) {
                model.put(VALUE_FIELD, String.valueOf(dbResultSet.getDouble(VALUE_FIELD)));
            }

            if (dbResultSet.next()) {
                throw new WrongFormatException("Query '" + dbQuery + "' with multiple results when only one is expected.");
            }

            if (dbStatement != null) dbStatement.close();
            if (dbConnection != null) dbConnection.close();

        }
        catch (Exception e) {
            throw new WebScriptException(Status.STATUS_BAD_REQUEST, e.getMessage());
        }

        return model;
    }

    /**
     * Compose the query string.
     * @param parameters
     * @return
     */
    private String getQuery(Map<String, Object> parameters) throws WrongFormatException {

    	/*
    	 * TODO: The query should be defined using hibernate.
    	 */

    	String query = "";

        switch ((String) parameters.get(PARAMETER_COUNTER)) {

        case PARAMETER_COUNTER_ASPECTS:

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

            query = ""
                + "SELECT "
                + " count(*) AS " + VALUE_FIELD + " "
                + "FROM "
                + " alf_node nodes,"
                + " alf_node_aspects aspects,"
                + " alf_qname aspect_names,"
                + " alf_qname names,"
                + " alf_namespace namespaces "
                + "WHERE"
                + " nodes.id = aspects.node_id"
                + " AND aspects.qname_id = aspect_names.id"
                + " AND nodes.type_qname_id = names.id"
                + " AND aspect_names.ns_id = namespaces.id"
                + " AND ("
                + "  (namespaces.uri = 'http://www.alfresco.org/model/content/1.0' AND (names.local_name = 'content' OR names.local_name = 'folder'))"
                + " )"
                + " AND (";

            for (int i = 0; i < aspects.size(); ++i) {

                QName aspectQName = aspects.get(i);

                query += "(namespaces.uri = '" + aspectQName.getNamespaceURI() + "' ";
                query += "AND aspect_names.local_name = '" + aspectQName.getLocalName() + "')";

                if ((i + 1) < aspects.size()) {
                    query += " OR ";
                }
            }

            query += ")";

            break;

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

        case PARAMETER_COUNTER_TYPES:

            List<QName> types   = null;
            try {
                JSONObject jsonTypes = new JSONObject((String) parameters.get(PARAMETER_CLASSES));
                types = getQNames(jsonTypes.getJSONArray(PARAMETER_COUNTER_TYPES));
            } catch (JSONException e) {
                throw new WebScriptException(Status.STATUS_INTERNAL_SERVER_ERROR, e.getMessage());
            }
            if (types.isEmpty()) {
                throw new WebScriptException(Status.STATUS_BAD_REQUEST, "Class list empty in '" + PARAMETER_CLASSES_TYPES + "' parameter.");
            }

            query = ""
                + "SELECT "
              	+ " count(*) AS " + VALUE_FIELD + " "
                + "FROM "
                + " alf_node nodes,"
                + " alf_qname names,"
                + " alf_namespace namespaces "
                + "WHERE "
                + " nodes.type_qname_id = names.id"
                + " AND names.ns_id = namespaces.id"
                + " AND (";

            for (int i = 0; i < types.size(); ++i) {

                QName typeQName = types.get(i);

                query += "(namespaces.uri = '" + typeQName.getNamespaceURI() + "' ";
                query += "AND names.local_name = '" + typeQName.getLocalName() + "')";

                if ((i + 1) < types.size()) {
             	    query += " OR ";
                }
            }

            query += ")";

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
                + " act_hi_taskinst";

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

    public void setServiceRegistry(ServiceRegistry serviceRegistry) {
        this.serviceRegistry = serviceRegistry;
        this.namespaceService = serviceRegistry.getNamespaceService();
    }
}