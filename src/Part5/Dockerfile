FROM nginx

WORKDIR /home

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./miniserver.c .
COPY ./run.sh .

RUN apt update && apt install -y gcc spawn-fcgi libfcgi-dev \
    && gcc miniserver.c -o miniserver -lfcgi \
    && rm -rf /var/lib/apt/lists
    
RUN chown -R nginx:nginx /usr; \
    chown -R nginx:nginx /etc/nginx/nginx.conf; \    
    chown -R nginx:nginx /var/cache/nginx; \
    chown -R nginx:nginx /home; \    
    touch /var/run/nginx.pid; \
    chown -R nginx:nginx /var/run/nginx.pid; 

USER nginx
ENTRYPOINT ["sh", "run.sh"]