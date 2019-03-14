FROM debian

# conf
ENV DEBIAN_FRONTEND noninteractive

# base packages
RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y gnupg unzip vim wget

# locales
RUN apt-get install -y locales && rm -rf /var/lib/apt/lists/* && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

# postgresql 11
RUN touch /etc/apt/sources.list.d/pgdg.list
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" >> /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update
RUN apt-get install -y --no-install-recommends postgresql-11
RUN echo postgres:coin | chpasswd
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/11/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/11/main/postgresql.conf

# java 8
RUN apt-get install -y --no-install-recommends default-jdk-headless
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-amd64
ENV JRE_HOME /usr/lib/jvm/java-1.8.0-openjdk-amd64

# apache
RUN apt-get install -y --no-install-recommends apache2 libapache2-mod-jk
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN a2enmod rewrite
RUN service apache2 stop && service apache2 start
EXPOSE 80

# tomcat 9
RUN useradd -m -U -d /opt/tomcat -s /bin/false tomcat
COPY tomcat /opt/tomcat
RUN ex -s -c '%s/<Connector port="8009" protocol="AJP\/1.3" redirectPort="8443" \/>/<Connector port="8009" URIEncoding="UTF-8" protocol="AJP\/1.3" redirectPort="8443" \/>/g|x' /opt/tomcat/conf/server.xml
RUN ex -s -c '%s/workers.tomcat_home=\/usr\/share\/tomcat8/workers.tomcat_home=\/opt\/tomcat/g|x' /etc/libapache2-mod-jk/workers.properties
COPY tomcat-users.xml /opt/tomcat/conf/
RUN ex -s -c '%s/allow="127\\.\\d+\\.\\d+\\.\\d+|::1|0:0:0:0:0:0:0:1" \/>/allow=".*" \/>/g|x' /opt/tomcat/webapps/host-manager/META-INF/context.xml
RUN ex -s -c '%s/allow="127\\.\\d+\\.\\d+\\.\\d+|::1|0:0:0:0:0:0:0:1" \/>/allow=".*" \/>/g|x' /opt/tomcat/webapps/manager/META-INF/context.xml
EXPOSE 8080