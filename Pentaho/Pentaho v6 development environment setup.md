A.A.A.R. - Pentaho Sparkl Application - Pentaho v6.0, v6.1
===

In this documentation is shared the setup of the development environment with Pentaho v6.0, v6.1.
The setup is useful to the projects contained in the A.A.A.R. repository and it is not written with the generic intent to discuss how to develop into Pentaho.

For the official and complete documentation, please refer to the [Pentaho web page](http://www.pentaho.com).

## Target

As detailed by the Company, **Pentaho v6.0+** uses Java 8.
In this tutorial we are going to work on a **Ubuntu 15.04** distribution of Linux, supposing you are working with the bash shell.

Before starting to work, please remember to execute the commands below.

    sudo apt-get update
    sudo apt-get upgrade

In the paragraphs below is described how to define our environment based on this target.

## Installing and configuring Java 8

Starting from a vanilla installation of **Ubuntu 16.04** let's install **Java 8**, following [this tutorial](http://www.webupd8.org/2012/09/install-oracle-java-8-in-ubuntu-via-ppa.html).

    sudo add-apt-repository ppa:webupd8team/java
    sudo apt-get update
    sudo apt-get install oracle-java8-installer

After the installation finishes, if you wish to see if it was successful, you can run the following command:

    java -version

With the result.

    java version "1.8.0_60"
    Java(TM) SE Runtime Environment (build 1.8.0_60-b27)
    Java HotSpot(TM) 64-Bit Server VM (build 25.60-b23, mixed mode)

If for some reason, the Java version in use is not 1.8.0, you can try to run the following command:

    sudo update-java-alternatives -s java-8-oracle

Before leaving this task, let's check the JAVA_HOME variable is exported.
In a terminal, execute the command below.

    env | grep JAVA_HOME

If you don't have any result, execute `nano ~/.bashrc` and then add the line below to the end of the file.

    export JAVA_HOME=/usr/lib/jvm/java-8-oracle

Save it and exit (`CTRL+X` and `Y`).

    source .bashrc

## Installing Pentaho Data Integration

Installing **Pentaho Data Integration** is an easy task you can find documented [here](http://fcorti.com/2014/01/03/how-to-install-pentaho-data-integration-5-kettle/).
In any case, pay attention to use the right version (in our case v6.0).

Please always remember to execute a first start, executing `spoon.sh` and closing after its first launch.

## Installing Pentaho BA Server

Installing **Pentaho BA Server** is an easy task you can find documented [here](http://fcorti.com/2014/01/07/how-to-install-pentaho-business-analytics-platform-5/).
In any case, pay attention to use the right version (in our case v6.0).

Before considering completed this task, you have to follow the instructions detailed [here](http://fcorti.com/alfresco-audit-analysis-reporting/aaar-how-to-install/aaar-get/).

In this tutorial I would like not to repeat the tasks described but at the end you should have:
- Installed Saiku Analytics plugin from the marketplace.
- Installed Pivot4J plugin from the marketplace.
- Configured the file `<bi-server>/pentaho-solutions/system/importExport.xml`.
- Configured the file `<bi-server>/pentaho-solutions/system/ImportHandlerMimeTypeDefinitions.xml`.
- Restarted the Pentaho BA server.

After this, your Pentaho BA Server is available at `http://localhost:8080/pentaho` address.

## Installing PostgreSql

If **PostgreSql** is not installed you can proceed with the tasks below, according with the official documentation described [here](https://help.ubuntu.com/community/PostgreSQL). This is requested if you want to test the A.A.A.R. development with PostgreSql but alternatively you can use MySql (described later in the documentation).
If you already have PostgreSql installed, for example because an Alfresco instance is up and running, you can use it for your development purpose.

To install PostgreSql open a terminal and execute the commands below.
Together with PostgreSql we are going to install also PgAdmin3 to administer it.

    sudo apt-get install postgresql postgresql-contrib pgadmin3
    sudo -u postgres psql postgres
    \password postgres
    // Digit 'postgres' (two times) to setup the postgres's password.
    \q
    sudo nano /etc/postgresql/9.5/main/pg_hba.conf

Change the line described below, setting `peer` to `md5`.

    # Database administrative login by Unix domain socket
    local   all             postgres                                md5

To complete the installation, reload the database service eceting the command below.

    sudo /etc/init.d/postgresql reload

Last, but not least, execute `pgadmin3` and add the `localhost` connection to administer the database instances.

## Installing MySql

This is requested if you want to test the A.A.A.R. development with MySql but alternatively you can use PostgreSql (described above in the documentation). To install MySql proceed to get it using the commands below.

    sudo apt-get install mysql-server mysql-workbench

This commend will install also MySql Workbench for administration.
During the installation process, the definition of the root password will be requested. Sei it (in my case, root will be used also as password).

Last, but not least, execute `mysql-workbench` and add the `localhost` connection to administer the database instances.

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

Now that everything is ready... go to one of the projects of the repository and follow the instructions to install A.A.A.R. Sparkl Application.

## Appendix 

### Running Pentaho BA Server on port 8082

This customization could be required of you have an Alfresco instance up and running on the default port (8080).
Also if you setup a development environment, with an Alfresco Share instance up and running on the port 8081, you should consider to have you Pentaho BA Server instance running on the port 8082.

First of all locate `server.xml` file in `<Tomcat installation folder>\conf` folder.
Edit the `server.xml` file and replace all the instances of strings described below.
- Find and replace all the instances of `8080` with `8082`(or the port you prefer).
- Find and replace all the instances of `8009` with `8011`(or the port you prefer).
- Find and replace all the instances of `8443` with `8445`(or the port you prefer).

Please, always remember that to make the changes available you have to restart the Pentaho BA Server.

### Running Pentaho BA Server with a proxy

According to [Pedro Alves's article](http://pedroalves-bi.blogspot.it/2014/07/using-pentaho-marketplace-over-proxy-or.html), to make the Pentaho Marketplace working through a proxy, we have to change the `start-pentaho.sh` script.
The mentioned script is stored in the Pentaho BA Server's installation folder.

To correctly setup the configuration, open the `start-pentaho.sh` script and add the settings in the way described below.

    ... -Dhttp.proxyHost=<IP of the proxy> -Dhttp.proxyPort=<port of the proxy> -Dhttp.nonProxyHosts="localhost|127.0.0.1|10.*.*.*" 

Restart Pentaho BA Server to make the changes available in the running instance.
