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
import java.util.Date;
import java.util.HashMap;
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
import com.sun.star.io.WrongFormatException;
import freemarker.template.utility.NullArgumentException;

/**
 * Get the global properties for A.A.A.R. analytics.
 *
 * @author fcorti@gmail.com
 * @since 4.4
 */
public class GetCountersWebScript extends DeclarativeWebScript {

	private static final String PARAMETER_BASETYPE = "baseType";
	private static final String DB_DRIVER          = "db.driver";
	private static final String DB_URL             = "db.url";
	private static final String DB_USERNAME        = "db.username";
	private static final String DB_PASSWORD        = "db.password";
	private static final String URI_FIELD          = "uri";
	private static final String TYPE_FIELD         = "type";
	private static final String NUMBER_FIELD       = "number";

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

    	// Check the param to be a valid type in format {uri}type or {prefix}type.
		QName baseTypeParameter = QName.resolveToQName(namespaceService, (String) parameters.get(PARAMETER_BASETYPE));

        // Model composition.
        Map<String, Object> model = new HashMap<String, Object>();

        try {

    		Class.forName(properties.getProperty(DB_DRIVER));

    		java.sql.Connection dbConnection = DriverManager.getConnection(properties.getProperty(DB_URL), properties.getProperty(DB_USERNAME), properties.getProperty(DB_PASSWORD));
    		Statement dbStatement = dbConnection.createStatement();
    		ResultSet dbResultSet = dbStatement.executeQuery(getQuery(baseTypeParameter.getNamespaceURI(), baseTypeParameter.getLocalName()));

            while (dbResultSet.next()) {
                model.put("class", (String) parameters.get(PARAMETER_BASETYPE));
                model.put("count", dbResultSet.getDouble(NUMBER_FIELD));
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
     * Compose the query.
     * @param query
     * @return
     */
    private String getQuery(String uri, String type) {

        String query = "";

        query = ""
            + "SELECT "
            + " namespaces.uri AS " + URI_FIELD + ","
            + " names.local_name AS " + TYPE_FIELD + ","
            + " count(*) AS " + NUMBER_FIELD + " "
            + "FROM"
            + " alf_node nodes,"
            + " alf_qname names,"
            + " alf_namespace namespaces "
            + "WHERE"
            + " nodes.type_qname_id = names.id"
            + " AND names.ns_id = namespaces.id"
            + " AND namespaces.uri = '" + uri + "'"
            + " AND names.local_name = '" + type + "'"
            + " GROUP BY"
            + " namespaces.uri,"
            + " names.local_name";

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

		parameters.put(PARAMETER_BASETYPE, baseTypeParameter);

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