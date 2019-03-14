#!/bin/sh
rm ./opentheso/opentheso.war
(ls opentheso-*.war) || wget https://github.com/miledrousset/opentheso/releases/download/4.4.3/opentheso-4.4.3.war
cp opentheso-4.4.3.war ./opentheso/opentheso.war
wget https://raw.githubusercontent.com/miledrousset/opentheso/master/src/main/resources/install/opentheso_current.sql
mv opentheso_current.sql ./opentheso

rm -rf ./stretch-java/tomcat
(ls apache-tomcat-*.tar.gz) || wget http://www-us.apache.org/dist/tomcat/tomcat-9/v9.0.16/bin/apache-tomcat-9.0.16.tar.gz
tar xvf apache-tomcat-9.0.16.tar.gz
mv apache-tomcat-9.0.16 ./stretch-java/tomcat