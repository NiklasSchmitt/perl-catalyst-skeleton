FROM ubuntu:latest

RUN apt update && apt install -y libcatalyst-perl libcatalyst-modules-extra-perl libcatalyst-modules-perl libcatalyst-view-tt-perl libcatalyst-devel-perl apache2 libapache2-mod-fcgid curl

# add here your downloads/copy/stuff to get the app into the container
RUN cd /opt && catalyst.pl pollenflug
COPY vhost-pollenflug.conf /etc/apache2/sites-available/pollenflug.conf

COPY startup.sh /startup.sh

RUN mkdir /var/log/apache2/pollenflug && a2enmod proxy && a2enmod proxy_fcgi && a2enmod rewrite && a2dissite 000-default.conf && a2ensite pollenflug

HEALTHCHECK CMD curl --fail http://localhost || exit 1

EXPOSE 80/tcp

ENV PROCESSES 2

CMD /startup.sh ${PROCESSES}
