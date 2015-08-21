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

import org.springframework.extensions.webscripts.Cache;
import org.springframework.extensions.webscripts.DeclarativeWebScript;
import org.springframework.extensions.webscripts.Status;
import org.springframework.extensions.webscripts.WebScriptRequest;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

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

        model.put("pentaho_protocol", (properties.containsKey(AAARProperties.pentaho_protocol) ? properties.getProperty(AAARProperties.pentaho_protocol) : AAARProperties.pentaho_protocol_default));
        model.put("pentaho_host",     (properties.containsKey(AAARProperties.pentaho_host) ? properties.getProperty(AAARProperties.pentaho_host) : AAARProperties.pentaho_host_default));
        model.put("pentaho_port",     (properties.containsKey(AAARProperties.pentaho_port) ? properties.getProperty(AAARProperties.pentaho_port) : AAARProperties.pentaho_port_default));
        model.put("pentaho_context",  (properties.containsKey(AAARProperties.pentaho_context)? properties.getProperty(AAARProperties.pentaho_context) : AAARProperties.pentaho_context_default));

        return model;
    }

	public void setProperties(Properties properties) 
	{
		this.properties = properties;
	}

}