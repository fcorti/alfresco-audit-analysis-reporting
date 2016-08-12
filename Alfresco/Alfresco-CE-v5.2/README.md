A.A.A.R. - Alfresco CE v5.2
===

The latest Alfresco 5.2 version is released with the JDK Version 1.8.0.
The [official release note](https://wiki.alfresco.com/wiki/Alfresco_Community_Edition_5.2) contains a full description of the requested environment.

Below the commands to setup an Ubuntu platform to compile the projects.

    # Download the 'jdk-8u74-linux-x64.tar.gz' file.
    # Unzip it into /opt/java/jdk1.8.0_74
    sudo update-alternatives --install /usr/bin/java java /opt/java/jdk1.8.0_74/bin/java 1874
    sudo update-alternatives --install /usr/bin/javac javac /opt/java/jdk1.8.0_74/bin/javac 1874
    sudo update-alternatives --set "java" "/opt/java/jdk1.8.0_74/bin/java"
    sudo update-alternatives --set "javac" "/opt/java/jdk1.8.0_74/bin/javac"
    nano ~/.bashrc
    export JAVA_HOME=/opt/java/jdk1.8.0_74
    # Add: export PATH=$JAVA_HOME/bin:$PATH
    # Save and exit.
    source ../.bashrc

Below the commands to check the installation settings.

    echo $JAVA_HOME

With result:

    /opt/java/jdk1.8.0_74

And:

    java -version

With result:

    java version "1.8.0_74"
    Java(TM) SE Runtime Environment (build 1.8.0_74-b02)
    Java HotSpot(TM) 64-Bit Server VM (build 25.74-b02, mixed mode)

For more informations on the solution:
http://fcorti.com/alfresco-audit-analysis-reporting/
