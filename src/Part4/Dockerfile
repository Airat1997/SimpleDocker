FROM nginx

WORKDIR /home

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./miniserver.c .
COPY ./run.sh .

RUN apt-get update; \ 
    apt install -y spawn-fcgi; \
    apt install -y libfcgi-dev; \
    apt install -y gcc; \
    gcc miniserver.c -o miniserver -lfcgi 
    
ENTRYPOINT ["sh", "run.sh"]