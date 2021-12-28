FROM centos:7

WORKDIR /var/www/html/

RUN yum -y install httpd wget unzip

RUN yum -y install epel-release

RUN yum -y install php php-fpm php-mysqlnd php-opcache php-gd php-xml php-mbstring php-zip php-pecl-xdebug

RUN yum -y install supervisor

COPY supervisord.ini /etc/supervisord.d/
COPY xdebug.ini /etc/php.d/

RUN wget https://www.formalms.org/download/all-downloads.html\?task\=download.send\&id\=16\&catid\=2\&m\=0 -O formalms.zip

RUN unzip formalms
COPY config.php formalms/
RUN chown apache:apache formalms/config.php
RUN chown apache:apache -R formalms/files
RUN chown apache:apache formalms/plugins

ENTRYPOINT [ "/usr/bin/supervisord", "--nodaemon" ]
