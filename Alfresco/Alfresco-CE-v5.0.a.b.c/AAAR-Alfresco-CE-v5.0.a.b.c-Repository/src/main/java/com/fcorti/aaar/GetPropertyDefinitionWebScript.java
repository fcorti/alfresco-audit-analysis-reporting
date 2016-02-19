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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.alfresco.service.ServiceRegistry;
import org.alfresco.service.cmr.dictionary.ClassDefinition;
import org.alfresco.service.cmr.dictionary.DictionaryService;
import org.alfresco.service.cmr.dictionary.PropertyDefinition;
import org.alfresco.service.namespace.NamespaceService;
import org.alfresco.service.namespace.QName;
import org.springframework.extensions.webscripts.Cache;
import org.springframework.extensions.webscripts.DeclarativeWebScript;
import org.springframework.extensions.webscripts.Status;
import org.springframework.extensions.webscripts.WebScriptException;
import org.springframework.extensions.webscripts.WebScriptRequest;

import com.sun.star.io.WrongFormatException;

import freemarker.template.utility.NullArgumentException;

/**
 * Get the definition of a property of a type/aspect for A.A.A.R. analytics.
 *
 * @author fcorti@gmail.com
 * @since 4.2
 */
public class GetPropertyDefinitionWebScript extends DeclarativeWebScript {

	private static final String PARAMETER_CLASS    = "class";
	private static final String PARAMETER_PROPERTY = "property";

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
		ClassDefinition classDefinition = null;
		if (((String) parameters.get(PARAMETER_CLASS)).isEmpty()) {
			QName property = QName.resolveToQName(namespaceService, (String) parameters.get(PARAMETER_PROPERTY));
			PropertyDefinition propertyDefinition = dictionaryService.getProperty(property);
			classDefinition = propertyDefinition.getContainerClass();
		}
		else {
			QName typeOrAspect = QName.resolveToQName(namespaceService, (String) parameters.get(PARAMETER_CLASS));
			classDefinition = dictionaryService.getClass(typeOrAspect);
		}

		// Class classification.
		Boolean isAspect         = null;
		Boolean isContentSubtype = null;
		Boolean isFolderSubtype  = null;
		if (classDefinition.isAspect()) {
			isAspect         = classDefinition.isAspect();
			isContentSubtype = false;
			isFolderSubtype  = false;
		}
		else {
			isAspect         = false;
			isContentSubtype = (dictionaryService.getSubTypes(QName.resolveToQName(namespaceService, "cm:content"), true).contains(classDefinition.getName()));
			isFolderSubtype  = (dictionaryService.getSubTypes(QName.resolveToQName(namespaceService, "cm:folder"), true).contains(classDefinition.getName()));
		}

		// Property list.
		List<PropertyDefinition> properties = new ArrayList<PropertyDefinition>();
		if (((String) parameters.get(PARAMETER_PROPERTY)).isEmpty()) {
			properties.addAll(classDefinition.getProperties().values());
		}
		else {

			QName property = QName.resolveToQName(namespaceService, (String) parameters.get(PARAMETER_PROPERTY));
			PropertyDefinition propertyDefinition = classDefinition.getProperties().get(property);
			if (propertyDefinition == null) {
				throw new WebScriptException(Status.STATUS_BAD_REQUEST, "Property '" + property.toString() + "' does not exist for the class '" + classDefinition.getName().toString() + "'.");
			}

			properties.add(propertyDefinition);
		}

		// Results.
		List<Map<String, Object>> results = new ArrayList<Map<String, Object>>();
		for (PropertyDefinition property : properties) {

			Map<String, Object> result = new HashMap<String, Object>();

			result.put("property",              property.getName().toString());
			result.put("prefixedProperty",      property.getName().toPrefixString(namespaceService));
			result.put("namespaceuri",          property.getName().getNamespaceURI());
			result.put("prefix",                namespaceService.getPrefixes(property.getName().getNamespaceURI()).iterator().next());
			result.put("name",                  property.getName().getLocalName());
			result.put("dataType",              property.getDataType().getName().toString());
			result.put("prefixedDataType",      property.getDataType().getName().toPrefixString(namespaceService));
			result.put("class",                 classDefinition.getName().toString());
			result.put("prefixedClass",         classDefinition.getName().toPrefixString(namespaceService));
			result.put("classIsAspect",         (isAspect ? "true" : "false"));
			result.put("classIsContentSubtype", (isContentSubtype ? "true" : "false"));
			result.put("classIsFolderSubtype",  (isFolderSubtype ? "true" : "false"));

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
		if (classParameter != null) {
			classParameter = classParameter.trim();
			if (classParameter.isEmpty()) {
				throw new NullArgumentException("Parameter '" + PARAMETER_CLASS + "' cannot be empty if specified.");
			}
		}
		else {
			classParameter = "";
		}

		// Property parameter.
		String propertyParameter = req.getParameter(PARAMETER_PROPERTY);
		if (propertyParameter != null) {
			propertyParameter = propertyParameter.trim();
			if (propertyParameter.isEmpty()) {
				throw new NullArgumentException("Parameter '" + PARAMETER_PROPERTY + "' cannot be empty if specified.");
			}
		}
		else {
			propertyParameter = "";
		}

		if (classParameter.isEmpty() && propertyParameter.isEmpty()) {
			throw new NullArgumentException("Parameter '" + PARAMETER_CLASS + "' or '" + PARAMETER_PROPERTY + "' must be specified.");
		}

		parameters.put(PARAMETER_CLASS,    classParameter);
		parameters.put(PARAMETER_PROPERTY, propertyParameter);
	}

	public void setDictionaryService(DictionaryService dictionaryService) {
		this.dictionaryService = dictionaryService;
	}

	public void setServiceRegistry(ServiceRegistry serviceRegistry) {
		this.serviceRegistry = serviceRegistry;
		this.namespaceService = serviceRegistry.getNamespaceService();
	}
}