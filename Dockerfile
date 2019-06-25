FROM ubuntu:18.04
ENV DEBIAN_FRONTEND noninteractive
 
RUN apt-get update
RUN apt-get -y install apt-utils software-properties-common language-pack-fr wget curl cron nano
RUN add-apt-repository ppa:ondrej/php
RUN apt-get -y update
RUN apt-get -y install dialog apt-utils
RUN apt-get -y install php5.6 php5.6-mbstring php5.6-mcrypt php5.6-mysql php5.6-xml php5.6-cli php5.6-zip
RUN apt-get remove -y --purge software-properties-common
RUN apt-get -y autoremove
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget http://pear.php.net/go-pear.phar
RUN php go-pear.phar
RUN pear channel-update pear.php.net

RUN pear channel-discover phpseclib.sourceforge.net && \
    pear install phpseclib/Net_SFTP && \
    pear install Mail && \
    pear install Mail_mime && \
    pear install Net_SMTP && \
    pear install -f HTML_AJAX && \
    pear install HTML_Template_IT

RUN cp /etc/default/locale /etc/default/locale_default
RUN LC_ALL=fr_FR.UTF-8
RUN /etc/init.d/cron restart