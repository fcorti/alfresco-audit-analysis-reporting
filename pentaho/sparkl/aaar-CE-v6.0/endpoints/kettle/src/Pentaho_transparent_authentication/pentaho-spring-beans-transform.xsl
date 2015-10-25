<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
	xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:b="http://www.springframework.org/schema/beans" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:pen="http://www.pentaho.com/schema/pentaho-system"
    exclude-result-prefixes="b">

	<xsl:template match="/">
		<beans 
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-2.5.xsd
http://www.pentaho.com/schema/pentaho-system http://www.pentaho.com/schema/pentaho-system.xsd" default-lazy-init="true">
			<xsl:apply-templates />
		</beans>
	</xsl:template>	
	
	<xsl:template match="b:import[@resource='applicationContext-spring-security.xml']">
			<xsl:copy-of select="." />
			<xsl:comment> Addition for pentaho-transparent-authentication - Start. </xsl:comment>
			<xsl:element name="import">
				<xsl:attribute name="resource">pentaho-transparent-authentication.xml</xsl:attribute>
			</xsl:element>
			<xsl:comment> Addition for pentaho-transparent-authentication - End. </xsl:comment>
	</xsl:template>
	
	<xsl:template match="b:import">
		<xsl:copy-of select="." />
	</xsl:template>
	
	<xsl:template match="b:bean">
		<xsl:copy-of select="." />
	</xsl:template>
	
	<!--
	<xsl:template match="/">
		<xsl:copy-of select="."/>
	</xsl:template>
	-->
	
</xsl:stylesheet>