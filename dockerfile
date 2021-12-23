FROM nginxinc/nginx-unprivileged:1-alpine
LABEL maintainer="deepak-putta.com"

COPY ./default.conf.tpl /etc/nginx/default.conf.tpl
COPY ./uwsgi_params /etc/nginx/uwsgi_params

ENV LISTEN_PORT=8000
ENV APP_HOST=app
ENV APP_PORT=9000

# PREPARATION : creates new dir and changing permission on the docker image
USER root   

# -p indicates to /vol if not exist, create static within vol
RUN mkdir -p /vol/static
# setting permission 755 owner can do everything, group and public can read and execute (not write)
# serve static files from this dir, we want nginx user to read this files
RUN chmod 755 /vol/static
RUN touch /etc/nginx/conf.d/default.conf
# change ownership usr:grp, run substite, take tpl file replace default env and ouput to /default.conf
RUN chown nginx:nginx /etc/nginx/conf.d/default.conf

COPY ./entrypoint.sh /entrypoint.sh
# make the file executable, even .sh is present
RUN chmod +x /entrypoint.sh

USER nginx

CMD ["/entrypoint.sh"]
