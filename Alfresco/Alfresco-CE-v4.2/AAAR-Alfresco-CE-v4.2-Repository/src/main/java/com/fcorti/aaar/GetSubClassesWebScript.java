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

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.alfresco.service.ServiceRegistry;
import org.alfresco.service.cmr.dictionary.ClassDefinition;
import org.alfresco.service.cmr.dictionary.DictionaryService;
import org.alfresco.service.namespace.NamespaceService;
import org.alfresco.service.namespace.QName;
import org.springframework.extensions.webscripts.Cache;
import org.springframework.extensions.webscripts.DeclarativeWebScript;
import org.springframework.extensions.webscripts.Status;
import org.springframework.extensions.webscripts.WebScriptException;
import org.springframework.extensions.webscripts.WebScriptRequest;

import com.sun.star.io.WrongFormatException;

import org.apache.commons.lang.NullArgumentException;

/**
 * Get the definition of a property of a type/aspect for A.A.A.R. analytics.
 *
 * @author fcorti@gmail.com
 * @since 4.2
 */
public class GetSubClassesWebScript extends DeclarativeWebScript {

	private static final String PARAMETER_CLASS    = "class";

	private DictionaryService dictionaryService;
	private NamespaceService namespaceService;
	@SuppressWarnings("unused")
	private ServiceRegistry serviceRegistry;

	private Map<String, Object> parameters = null;

	// private static Logger logger = Logger.getLogger(GetPropertyDefinitionWebScript.class);

	protected Map<String, Object> executeImpl(WebScriptRequest req, Status status, Cache cache) {

		// Parameters.
		try {
			getParameters(req);
		}
		catch (Exception e) {
			throw new WebScriptException(Status.STATUS_BAD_REQUEST, e.getMessage());
		}

		// Class definition.
		QName typeOrAspect = QName.resolveToQName(namespaceService, (String) parameters.get(PARAMETER_CLASS));
		ClassDefinition classDefinition = dictionaryService.getClass(typeOrAspect);

		// Class list.
		Collection<QName> classes = new ArrayList<QName>();
		if (classDefinition.isAspect()) {
			classes = dictionaryService.getSubAspects(typeOrAspect, true);
		}
		else {
			classes = dictionaryService.getSubTypes(typeOrAspect, true);
		}

		// Results.
		List<Map<String, Object>> results = new ArrayList<Map<String, Object>>();
		for (QName classQName : classes) {

			Map<String, Object> result = new HashMap<String, Object>();

			result.put("class",         classQName.toString());
			result.put("prefixedClass", classQName.toPrefixString(namespaceService));
			result.put("namespaceuri",  classQName.getNamespaceURI());
			result.put("prefix",        namespaceService.getPrefixes(classQName.getNamespaceURI()).iterator().next());
			result.put("name",          classQName.getLocalName());

			results.add(result);
		}

		// Model definition.
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("count",	 String.valueOf(results.size()));
		model.put("results", results);

		return model;
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

		// Class name parameter.
		String classParameter = req.getParameter(PARAMETER_CLASS);
		if (classParameter == null) {
			throw new NullArgumentException("Parameter '" + PARAMETER_CLASS + "' must be specified.");
		}
		classParameter = classParameter.trim();
		if (classParameter.isEmpty()) {
			throw new NullArgumentException("Parameter '" + PARAMETER_CLASS + "' cannot be empty if specified.");
		}

		parameters.put(PARAMETER_CLASS, classParameter);
	}

	public void setDictionaryService(DictionaryService dictionaryService) {
		this.dictionaryService = dictionaryService;
	}

	public void setServiceRegistry(ServiceRegistry serviceRegistry) {
		this.serviceRegistry = serviceRegistry;
		this.namespaceService = serviceRegistry.getNamespaceService();
	}
}