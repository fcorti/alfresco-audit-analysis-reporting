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

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.springframework.extensions.webscripts.Cache;
import org.springframework.extensions.webscripts.DeclarativeWebScript;
import org.springframework.extensions.webscripts.Status;
import org.springframework.extensions.webscripts.WebScriptRequest;

/**
 * Get the global properties for A.A.A.R. analytics.
 *
 * @author fcorti@gmail.com
 * @since 2.1.0
 */
public class GetPropertiesWebScript extends DeclarativeWebScript {

	protected Properties properties;

    protected Map<String, Object> executeImpl(WebScriptRequest req, Status status, Cache cache) {

		Map<String, Object> model = new HashMap<String, Object>();

        model.put("pentaho_protocol",    (properties.containsKey(AAARProperties.pentaho_protocol)    ? properties.getProperty(AAARProperties.pentaho_protocol)    : AAARProperties.pentaho_protocol_default));
        model.put("pentaho_host",        (properties.containsKey(AAARProperties.pentaho_host)        ? properties.getProperty(AAARProperties.pentaho_host)        : AAARProperties.pentaho_host_default));
        model.put("pentaho_port",        (properties.containsKey(AAARProperties.pentaho_port)        ? properties.getProperty(AAARProperties.pentaho_port)        : AAARProperties.pentaho_port_default));
        model.put("pentaho_context",     (properties.containsKey(AAARProperties.pentaho_context)     ? properties.getProperty(AAARProperties.pentaho_context)     : AAARProperties.pentaho_context_default));
        model.put("pentaho_user",        (properties.containsKey(AAARProperties.pentaho_user)        ? properties.getProperty(AAARProperties.pentaho_user)        : AAARProperties.pentaho_user_default));
        model.put("pentaho_password",    (properties.containsKey(AAARProperties.pentaho_password)    ? properties.getProperty(AAARProperties.pentaho_password)    : AAARProperties.pentaho_password_default));
        model.put("pentaho_application", (properties.containsKey(AAARProperties.pentaho_application) ? properties.getProperty(AAARProperties.pentaho_application) : AAARProperties.pentaho_application_default));

        return model;
    }

	public void setProperties(Properties properties) 
	{
		this.properties = properties;
	}
}