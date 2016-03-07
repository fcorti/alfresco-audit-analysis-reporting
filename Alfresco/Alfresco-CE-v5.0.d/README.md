A.A.A.R. - Alfresco CE v5.0.d
===

The latest Alfresco 5.0.d version is released with the JDK Version 1.8.0 u31.
The [official release note](https://wiki.alfresco.com/wiki/Alfresco_Community_5.0.d_Release_Notes) contains a full description of the requested environment.

Below the commands to setup an Ubuntu platform to compile the projects.

    # Download the 'jdk-8u31-linux-x64.tar.gz' file.
    # Unzip it into /opt/java/jdk1.8.0_31
    sudo update-alternatives --install /usr/bin/java java /opt/java/jdk1.8.0_31/bin/java 1831
    sudo update-alternatives --install /usr/bin/javac javac /opt/java/jdk1.8.0_31/bin/javac 1831
    sudo update-alternatives --set "java" "/opt/java/jdk1.8.0_31/bin/java"
    sudo update-alternatives --set "javac" "/opt/java/jdk1.8.0_31/bin/javac"
    nano ~/.bashrc
    export JAVA_HOME=/opt/java/jdk1.8.0_31
    # Add: export PATH=$JAVA_HOME/bin:$PATH
    # Save and exit.
    source ../.bashrc

Below the commands to check the installation settings.

    echo $JAVA_HOME

With result:

    /opt/java/jdk1.8.0_31

And:

    java -version

With result:

    java version "1.8.0_31"
    Java(TM) SE Runtime Environment (build 1.8.0_31-b13)
    Java HotSpot(TM) 64-Bit Server VM (build 25.31-b07, mixed mode)

For more informations on the solution:
http://fcorti.com/alfresco-audit-analysis-reporting/
