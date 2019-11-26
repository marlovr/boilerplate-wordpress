FROM richarvey/nginx-php-fpm

# Copy the bedrock directory into /var/www/html

COPY ./bedrock /var/www/html

# Set the environment variable WEBROOT to be the web directory of bedrock

ENV WEBROOT /var/www/html/web

# Install the Elementor plugin
RUN composer require wpackagist-plugin/elementor \
    # Install the plugin Media Cloud formerly known as ILab Media Tools.
    wpackagist-plugin/ilab-media-tools