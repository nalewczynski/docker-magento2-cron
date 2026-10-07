FROM php:8.3-cli
LABEL maintainer="Maciej Nalewczynski <maciej.nalewczynski@gmail.com>"

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    cron \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libonig-dev \
    libpng-dev \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    libzip-dev \
    rsyslog \
    unzip \
    zip \
    $PHPIZE_DEPS \
  && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install \
    bcmath \
    ftp \
    gd \
    intl \
    mbstring \
    pdo_mysql \
    soap \
    sockets \
    xsl \
    zip

COPY crontab /crontab.www-data
COPY start.sh /start.sh

RUN crontab -u www-data /crontab.www-data \
  && chmod +x /start.sh \
  && touch /var/log/syslog /var/log/cron.log

CMD ["/start.sh"]

