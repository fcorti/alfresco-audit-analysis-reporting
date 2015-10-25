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

import org.alfresco.service.cmr.security.MutableAuthenticationService;
import org.apache.commons.net.util.Base64;
import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.extensions.webscripts.Cache;
import org.springframework.extensions.webscripts.DeclarativeWebScript;
import org.springframework.extensions.webscripts.Status;
import org.springframework.extensions.webscripts.WebScriptRequest;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;

/**
 * Get a ticket from Pentaho server representing a valid session.
 *
 * @author fcorti@gmail.com
 * @since 2.1.0
 */
public class GetPentahoTicketWebScript extends DeclarativeWebScript {

	public static String REST_path                   = "/Login";
	public static String REST_ticket_id              = "ticketId";
	public static String property_authorization      = "Authorization";
	public static String property_content_type       = "Content-Type";
	public static String property_content_type_value = "application/x-www-form-urlencoded";
	public static String request_method                 = "POST";
	public static String parameter_action            = "generate-ticket";
	public static String parameter_action_value      = "1";
	public static String parameter_application       = "app";
	public static String parameter_user              = "username";

	private static Logger logger = Logger.getLogger(GetPentahoTicketWebScript.class);

	private MutableAuthenticationService authenticationService;
	protected Properties properties;

    protected Map<String, Object> executeImpl(WebScriptRequest req, Status status, Cache cache) {

        // Get ticket.
        JSONObject restResult = getRESTCall();

        // Define the model.
        Map<String, Object> model = new HashMap<String, Object>();
        model.put("pentaho_ticket", restResult.get(REST_ticket_id));

        return model;
    }

    /**
     * Invoke the REST service and get the result.
     * @return JSONObject
     */
	private final JSONObject getRESTCall() {

    	// Get properties.
        String protocol    = (properties.containsKey(AAARProperties.pentaho_protocol)    ? properties.getProperty(AAARProperties.pentaho_protocol)    : AAARProperties.pentaho_protocol_default);
        String host        = (properties.containsKey(AAARProperties.pentaho_host)        ? properties.getProperty(AAARProperties.pentaho_host)        : AAARProperties.pentaho_host_default);
        String port        = (properties.containsKey(AAARProperties.pentaho_port)        ? properties.getProperty(AAARProperties.pentaho_port)        : AAARProperties.pentaho_port_default);
        String context     = (properties.containsKey(AAARProperties.pentaho_context)     ? properties.getProperty(AAARProperties.pentaho_context)     : AAARProperties.pentaho_context_default);
        String user        = (properties.containsKey(AAARProperties.pentaho_user)        ? properties.getProperty(AAARProperties.pentaho_user)        : AAARProperties.pentaho_user_default);
        String password    = (properties.containsKey(AAARProperties.pentaho_password)    ? properties.getProperty(AAARProperties.pentaho_password)    : AAARProperties.pentaho_password_default);
        String application = (properties.containsKey(AAARProperties.pentaho_application) ? properties.getProperty(AAARProperties.pentaho_application) : AAARProperties.pentaho_application_default);

        JSONObject result = new JSONObject();

    	// REST connection.
        HttpURLConnection connection;
		try {
	        String url = protocol + "://" + host + ":" + port + "/" + context + REST_path;
	        URL urlObj = new URL(url);
	        connection = (HttpURLConnection) urlObj.openConnection();
        }
        catch (MalformedURLException e) {
        	logger.error(e);
    		return result;
        } 
		catch (IOException e) {
        	logger.error(e);
    		return result;
		}

		// Authorization.
		String authorization = "Basic " + (new String(new Base64().encode((user + ":" + password).getBytes())));

		// REST properties.
		try {
			connection.setDoOutput(true);
			connection.setRequestMethod(request_method);
			connection.setRequestProperty(property_authorization, authorization);
			connection.setRequestProperty(property_content_type, property_content_type_value);
		} catch (ProtocolException e) {
        	logger.error(e);
    		return result;
		}

		// Body.
        String body = "";
		body += parameter_action + "=" + parameter_action_value + "&";
		body += parameter_application + "=" + application + "&";
		body += parameter_user + "=" + authenticationService.getCurrentUserName() + "&";

		OutputStream os;
		try {
			os = connection.getOutputStream();
			os.write(body.getBytes());
			os.flush();
		} catch (IOException e) {
        	logger.error(e);
    		return result;
		}

		// Get result.
		String resultAsString = "";
		try {
			BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream()));
			resultAsString = br.readLine();
	    	br.close();
		} catch (IOException e) {
        	logger.error(e);
    		return result;
		}

		// Release of resources.
		try {
			os.close();
		} catch (IOException e) {
        	logger.error(e);
    		return result;
		}
		connection.disconnect();

		// Check result to be a JSON.
		try {
            JSONParser jsonParser = new JSONParser();
            result = (JSONObject) jsonParser.parse(resultAsString);
		} catch (ParseException e) {
        	logger.error(e);
    		return result;
		}

    	return result;
	}

	public void setProperties(Properties properties) 
	{
		this.properties = properties;
	}

	public void setAuthenticationService(MutableAuthenticationService authenticationService) {
		this.authenticationService = authenticationService;
	}
}