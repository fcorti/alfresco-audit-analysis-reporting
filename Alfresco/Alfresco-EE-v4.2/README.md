A.A.A.R. - Alfresco EE v4.2
===

The latest Alfresco 4.2 version is released with the JDK Version 1.7.0 u12.
The [official release note](http://docs.alfresco.com/4.2/tasks/dev-extensions-maven-sdk-java-home.html) contains a full description of the requested environment.

Below the commands to setup an Ubuntu platform to compile the projects (using 1.7.0 u13 instead).

    # Download the 'jdk-7u13-linux-x64.tar.gz' file.
    # Unzip it into /opt/java/jdk1.7.0_13
    sudo update-alternatives --install /usr/bin/java java /opt/java/jdk1.7.0_13/bin/java 1713
    sudo update-alternatives --install /usr/bin/javac javac /opt/java/jdk1.7.0_13/bin/javac 1713
    sudo update-alternatives --set "java" "/opt/java/jdk1.7.0_13/bin/java"
    sudo update-alternatives --set "javac" "/opt/java/jdk1.7.0_13/bin/javac"
    nano ~/.bashrc
    export JAVA_HOME=/opt/java/jdk1.7.0_13
    # Add: export PATH=$JAVA_HOME/bin:$PATH
    # Save and exit.
    source ../.bashrc

Below the commands to check the installation settings.

    echo $JAVA_HOME

With result:

    /opt/java/jdk1.7.0_13

And:

    java -version

With result:

    java version "1.7.0_13"
    Java(TM) SE Runtime Environment (build 1.7.0_13-b20)
    Java HotSpot(TM) 64-Bit Server VM (build 23.7-b01, mixed mode)

For more informations on the solution:
http://fcorti.com/alfresco-audit-analysis-reporting/
