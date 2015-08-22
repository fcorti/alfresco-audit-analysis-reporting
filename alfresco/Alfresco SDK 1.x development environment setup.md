A.A.A.R. - Alfresco addon - Alfresco SDK v1.x
===

In this documentation is shared the setup of the development environment with Alfresco SDK v1.x. 
The setup is useful to the projects contained in the A.A.A.R. repository and it is not written with the generic intent to discuss how to develop into Alfresco.

For the official and complete documentation, please refer to the [Alfresco SDK v1 web page](http://docs.alfresco.com/4.2/concepts/dev-extensions-maven-sdk-intro.html).

## Target

As described in the [Compatibility matrix](http://docs.alfresco.com/4.2/concepts/dev-extensions-maven-sdk-compatibility.html), **Maven SDK 1.1.x** is compatible and supports **Alfresco CE/EE v4.2.x**.
As we know, Alfresco CE/EE v4.2.x uses Java 7.
In this tutorial we are going to work on a **Ubuntu 14.04.02 LTS** distribution of Linux, supposing you are working with the bash shell.

Before starting to work, please remember to execute the commands below.

    sudo apt-get update
    sudo apt-get upgrade

In the paragraphs below is described how to define our environment based on this target.

## Installing and configuring Java 7

Starting from a vanilla installation of **Ubuntu 14.04.02 LTS** let's install **Java 7**, following [this tutorial](http://www.webupd8.org/2012/01/install-oracle-java-jdk-7-in-ubuntu-via.html)

    sudo add-apt-repository ppa:webupd8team/java
    sudo apt-get update
    sudo apt-get install oracle-java7-installer

After the installation finishes, if you wish to see if it was successful, you can run the following command:

    java -version

With the result.

    java version "1.7.0_80"
    Java(TM) SE Runtime Environment (build 1.7.0_80-b15)
    Java HotSpot(TM) 64-Bit Server VM (build 24.80-b11, mixed mode)

If for some reason, the Java version in use is not 1.7.0, you can try to run the following command:

    sudo update-java-alternatives -s java-7-oracle

Before leaving this task, let's check the JAVA_HOME variable is exported.
In a terminal, execute the command below.

    env | grep JAVA_HOME

If you don't have any result, execute `nano ~/.bashrc` and then add the line below to the end of the file.

    export JAVA_HOME=export JAVA_HOME=/usr/lib/jvm/java-7-oracle

Save it and exit (`CTRL+X` and `Y`).

    source .bashrc

## Installing Maven 3.0.3

Installing **Apache Maven** is an easy task you can find documented [here](http://maven.apache.org/install.html).
In any case, pay attention to use a version most recent than the v3.0.3, as requested from Alfresco SDK.
Before leaving this task, let's check the MAVEN_OPTS variable is exported.
In a terminal, execute the command below.

    env | grep MAVEN_OPTS

If you don't have any result, execute `nano ~/.bashrc` and then add the line below to the end of the file.

    export MAVEN_OPTS="-Xms1024m -Xmx4096m -XX:PermSize=1024m"

Save it and exit (`CTRL+X` and `Y`).

    source .bashrc

Check your configuration by running the command `mvn --version`.
This will display information similar to the following:

    Apache Maven 3.3.3 (7994120775791599e205a5524ec3e0dfe41d4a06; 2015-04-22T13:57:37+02:00)
    Maven home: /opt/maven
    Java version: 1.7.0_80, vendor: Oracle Corporation
    Java home: /usr/lib/jvm/java-7-oracle/jre
    Default locale: en_US, platform encoding: UTF-8
    OS name: "linux", version: "3.16.0-46-generic", arch: "amd64", family: "unix"

## Installing Git

If **Git** is not installed, proceed to get it using the commands below.

    sudo apt-get install git
    git --version

A result similar to this will shown.

    git version 1.9.1

## Cloning the project

Before starting to talk about cloning, we have to decide the development tool.
In this tutorial is described the command line approach but a relevant alternative is the IDE approach (in my case, using Eclipse).
To clone the project using the command line, open a terminal and execute the command below.

    cd ~
    git clone https://github.com/fcorti/alfresco-audit-analysis-reporting.git

Once the download is completed, in the `alfresco-audit-analysis-reporting` folder you can find the whole project.

## ...and now?

Now that everything is ready... go to one of the projects of the repository and follow the instructions to build the AMPs and start the services.

## Appendix 

### Installing Maven

To install **Maven** follow the steps below.

- Download Maven from the [here](http://maven.apache.org/download.cgi).
- Unzip it in `/opt/<maven folder>`.
- Execute `sudo ln -s <maven folder> maven`.
- Execute `nano ~/.profile`.
- Append `PATH="/opt/maven/bin:$PATH"`.
- Save and exit from terminal and from the user session.

Check your configuration by running the command `mvn --version`.
This will display information similar to the following:

    Apache Maven 3.3.3 (7994120775791599e205a5524ec3e0dfe41d4a06; 2015-04-22T13:57:37+02:00)
    Maven home: /opt/maven
    Java version: 1.7.0_80, vendor: Oracle Corporation
    Java home: /usr/lib/jvm/java-7-oracle/jre
    Default locale: en_US, platform encoding: UTF-8
    OS name: "linux", version: "3.16.0-46-generic", arch: "amd64", family: "unix"

### Configuring proxy on Maven

If you work with a proxy into your environment, you can follow the tutorial in [this page](https://maven.apache.org/guides/mini/guide-proxies.html).
To setup the proxy, run `nano ~/.m2/settings.xml` and then add the xml below.

    <settings>
    .
    .
    <proxies>
     <proxy>
      <id>example-proxy</id>
      <active>true</active>
      <protocol>http</protocol>
      <host>proxy.example.com</host>
      <port>8080</port>
      <username>proxyuser</username>
      <password>somepassword</password>
      <nonProxyHosts>localhost|127.0.0.1</nonProxyHosts>
     </proxy>
    </proxies>
    .
    .
    </settings>
