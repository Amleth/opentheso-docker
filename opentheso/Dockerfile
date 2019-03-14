FROM stretch-java

# opentheso files
COPY opentheso.war /opt/tomcat/webapps/
COPY preferences.properties /opt/tomcat/webapps/opentheso/WEB-INF/classes/
COPY hikari.properties /opt/tomcat/webapps/opentheso/WEB-INF/classes/
COPY opentheso_current.sql /

# postgresql 11
USER postgres
RUN /etc/init.d/postgresql start && psql --command "CREATE USER opentheso WITH SUPERUSER PASSWORD 'coin';" && createdb -O opentheso opentheso
RUN /etc/init.d/postgresql start && psql opentheso < /opentheso_current.sql
USER root

# apache
COPY opentheso.conf /etc/apache2/sites-enabled/

CMD apache2ctl start && /opt/tomcat/bin/startup.sh && bash