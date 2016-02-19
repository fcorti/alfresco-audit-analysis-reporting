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
import org.alfresco.service.cmr.dictionary.DictionaryService;
import org.alfresco.service.namespace.NamespaceService;
import org.alfresco.service.namespace.QName;
import org.springframework.extensions.webscripts.Cache;
import org.springframework.extensions.webscripts.DeclarativeWebScript;
import org.springframework.extensions.webscripts.Status;
import org.springframework.extensions.webscripts.WebScriptException;
import org.springframework.extensions.webscripts.WebScriptRequest;

import com.sun.star.io.WrongFormatException;

/**
 * Get the definition of a property of a type/aspect for A.A.A.R. analytics.
 *
 * @author fcorti@gmail.com
 * @since 4.2
 */
public class GetClassesWebScript extends DeclarativeWebScript {

	private static final String PARAMETER_CLASS_TYPE           = "classType";
	private static final String PARAMETER_CLASS_TYPE_ASPECTS   = "aspects";
	private static final String PARAMETER_CLASS_TYPE_DOCUMENTS = "documents";
	private static final String PARAMETER_CLASS_TYPE_FOLDERS   = "folders";

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

		// Class list.
		Collection<QName> classes = new ArrayList<QName>();
		if (((String) parameters.get(PARAMETER_CLASS_TYPE)).equals(PARAMETER_CLASS_TYPE_ASPECTS)) {
			classes = dictionaryService.getAllAspects();
		}
		else if (((String) parameters.get(PARAMETER_CLASS_TYPE)).equals(PARAMETER_CLASS_TYPE_DOCUMENTS)) {
			QName contentBaseType = QName.resolveToQName(namespaceService, "cm:content");
			classes = dictionaryService.getSubTypes(contentBaseType, true);
		}
		else if (((String) parameters.get(PARAMETER_CLASS_TYPE)).equals(PARAMETER_CLASS_TYPE_FOLDERS)) {
			QName folderBaseType = QName.resolveToQName(namespaceService, "cm:folder");
			classes = dictionaryService.getSubTypes(folderBaseType, true);
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
		String classTypeParameter = req.getParameter(PARAMETER_CLASS_TYPE);
		if (classTypeParameter == null) {
			throw new WrongFormatException("Parameter '" + PARAMETER_CLASS_TYPE + "' must be specified.");
		}
		classTypeParameter = classTypeParameter.trim().toLowerCase();
		if (classTypeParameter.compareTo(PARAMETER_CLASS_TYPE_ASPECTS) != 0 &&
			classTypeParameter.compareTo(PARAMETER_CLASS_TYPE_DOCUMENTS) != 0 &&
			classTypeParameter.compareTo(PARAMETER_CLASS_TYPE_FOLDERS) != 0) {
			throw new IllegalArgumentException("Parameter '" + PARAMETER_CLASS_TYPE + "' can be '" + PARAMETER_CLASS_TYPE_ASPECTS + "', '" + PARAMETER_CLASS_TYPE_DOCUMENTS + "' or '" + PARAMETER_CLASS_TYPE_FOLDERS + "'.");
		}

		parameters.put(PARAMETER_CLASS_TYPE, classTypeParameter);
	}

	public void setDictionaryService(DictionaryService dictionaryService) {
		this.dictionaryService = dictionaryService;
	}

	public void setServiceRegistry(ServiceRegistry serviceRegistry) {
		this.serviceRegistry = serviceRegistry;
		this.namespaceService = serviceRegistry.getNamespaceService();
	}
}