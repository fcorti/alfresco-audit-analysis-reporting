#!/bin/bash
# Downloads the spring-loaded lib if not existing and runs the Share AMP applied to Share WAR
# Note. requires Alfresco.war to be running in another Tomcat on port 8080
springloadedfile=~/springloaded-1.2.4.RELEASE.jar

if [ ! -f $springloadedfile ]; then
mvn validate -Psetup
fi

MAVEN_OPTS="-javaagent:$springloadedfile -noverify" mvn integration-test -Pamp-to-war
