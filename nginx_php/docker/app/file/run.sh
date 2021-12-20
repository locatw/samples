#!/bin/bash

/root/.php/8.1.1/sbin/php-fpm --daemonize
nginx -g "daemon off;"
