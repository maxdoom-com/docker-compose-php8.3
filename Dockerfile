FROM alpine:3.19

RUN apk add                     \
    bash                        \
    mc                          \
    git                         \
    apache2                     \
    apache2-ssl                 \
    apache2-proxy               \
    apache2-proxy-html          \
    mysql-client                \
    graphicsmagick              \
    php83                       \
    php83-apache2               \
    php83-pdo_mysql             \
    php83-mysqli                \
    php83-mysqlnd               \
    php83-pdo_sqlite            \
    php83-session               \
    php83-gd                    \
    php83-xml                   \
    php83-simplexml             \
    php83-xmlreader             \
    php83-xmlwriter             \
    php83-zip                   \
    php83-intl                  \
    php83-fileinfo              \
    php83-iconv                 \
    php83-tokenizer             \
    php83-phar                  \
    php83-curl                  \
    php83-posix                 \
    php83-pcntl                 \
    php83-mbstring              \
    php83-gmp                   \
    php83-bcmath                \
    php83-opcache               \
    php83-pecl-apcu             \
    php83-exif                  \
    php83-soap                  \
    php83-ldap                  \
    python3                     \
    py3-virtualenv              #

# fix a dompdf problem...
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.13/community/ gnu-libiconv=1.15-r3
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so


COPY home/you /home/you
COPY srv/ssl /srv/ssl
COPY srv/adminer /srv/adminer
# COPY etc/apache2/conf.d/vhosts.d /etc/apache2/conf.d/vhosts.d

RUN ln -s /usr/lib/libxml2.so.2 /usr/lib/libxml2.so
# Syntax error on line 13 of /etc/apache2/conf.d/proxy-html.conf:
# Cannot load /usr/lib/libxml2.so into server: Error loading shared library /usr/lib/libxml2.so: No such file or directory

ADD ["sbin/boot.sh", "/sbin/"]
ENTRYPOINT ["/bin/sh", "/sbin/boot.sh"]
