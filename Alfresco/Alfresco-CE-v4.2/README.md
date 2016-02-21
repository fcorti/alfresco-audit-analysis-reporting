A.A.A.R. - Alfresco CE v4.2
===

The latest Alfresco 4.2.f version is released with the JDK Version 1.7.0 u25.
The [official release note](https://wiki.alfresco.com/wiki/Alfresco_Community_4.2.f_Release_Notes) contains a full description of the requested environment.

Below the commands to setup an Ubuntu platform to compile the projects.

    # Download the 'jdk-7u25-linux-x64.tar.gz' file.
    # Unzip it into /opt/java/jdk1.7.0_25
    sudo update-alternatives --install /usr/bin/java java /opt/java/jdk1.7.0_25/bin/java 1725
    sudo update-alternatives --install /usr/bin/javac javac /opt/java/jdk1.7.0_25/bin/javac 1725
    sudo update-alternatives --set "java" "/opt/java/jdk1.7.0_25/bin/java"
    sudo update-alternatives --set "javac" "/opt/java/jdk1.7.0_25/bin/javac"
    nano ~/.bashrc
    export JAVA_HOME=/opt/java/jdk1.7.0_25
    # Add: export PATH=$JAVA_HOME/bin:$PATH
    # Save and exit.
    source ../.bashrc

Below the commands to check the installation settings.

    echo $JAVA_HOME

With result:

    /opt/java/jdk1.7.0_25

And:

    java -version

With result:

    java version "1.7.0_25"
    Java(TM) SE Runtime Environment (build 1.7.0_25-b15)
    Java HotSpot(TM) 64-Bit Server VM (build 23.25-b01, mixed mode)

For more informations on the solution:
http://fcorti.com/alfresco-audit-analysis-reporting/
