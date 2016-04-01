A.A.A.R. - Alfresco EE v5.0
===

The latest Alfresco 5.0 version is released with the JDK Version 1.7.0 u67.
The [official release note](http://docs.alfresco.com/5.0/tasks/alfresco-sdk-install-java-home.html) contains a full description of the requested environment.

Below the commands to setup an Ubuntu platform to compile the projects (using 1.7.0 u67 instead).

    # Download from: http://app.nidc.kr/java/jdk-7u67-linux-x64.tar.gz
    # Unzip in /opt/java/jdk1.7.0_67
    sudo update-alternatives --install /usr/bin/java java /opt/java/jdk1.7.0_67/bin/java 1767
    sudo update-alternatives --install /usr/bin/javac javac /opt/java/jdk1.7.0_67/bin/javac 1767
    sudo update-alternatives --set "java" "/opt/java/jdk1.7.0_67/bin/java"
    sudo update-alternatives --set "javac" "/opt/java/jdk1.7.0_67/bin/javac"
    nano ~/.bashrc
    export JAVA_HOME=/opt/java/jdk1.7.0_67
    export PATH=$JAVA_HOME/bin:$PATH
    # Save and exit.
    source ../.bashrc

Below the commands to check the installation settings.

    echo $JAVA_HOME

With result:

    /opt/java/jdk1.7.0_67

And:

    java -version

With result:

    java version "1.7.0_67"
    Java(TM) SE Runtime Environment (build 1.7.0_67-b01)
    Java HotSpot(TM) 64-Bit Server VM (build 24.65-b04, mixed mode)

For more informations on the solution:
http://fcorti.com/alfresco-audit-analysis-reporting/
