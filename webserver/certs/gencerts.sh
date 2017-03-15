#!/bin/bash

openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -keyout site.key -out site.crt -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com"
