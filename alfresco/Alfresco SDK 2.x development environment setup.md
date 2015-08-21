A.A.A.R. - Alfresco addon - Alfresco SDK v1.x
===

In this documentation is shared the setup of the development environment with Alfresco SDK v1.x. 
The setup is useful to the projects contained in the AAAR repository and it is not written with the generic intent to discuss how to develop into Alfresco.

For the official and complete documentation, please refer to the [Alfresco SDK v1 web page](http://docs.alfresco.com/4.2/concepts/dev-extensions-maven-sdk-intro.html).

# Target

As described in the [Compatibility matrix](http://docs.alfresco.com/4.2/concepts/dev-extensions-maven-sdk-compatibility.html), **Maven SDK 1.1.x** is compatible and supports **Alfresco CE/EE v4.2x**.
As we know, Alfresco CE/EE v4.2.x uses Java 7.
Below is described how to define a working environment based on this target.

# Prerequisites

Starting from a vanilla installation of **Ubuntu 14.04.02 LTS** let's update the environment.

    sudo apt-get update
    sudo apt-get upgrade

The first task is to install **Java 7**, following [this tutorial](http://www.webupd8.org/2012/01/install-oracle-java-jdk-7-in-ubuntu-via.html)

    sudo add-apt-repository ppa:webupd8team/java
    sudo apt-get update
    sudo apt-get install oracle-java7-installer

After the installation finishes, if you wish to see if it was successful, you can run the following command:

    java -version

java -version
