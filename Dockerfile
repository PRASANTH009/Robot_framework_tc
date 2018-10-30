FROM debian:9

RUN apt update
RUN apt  install net-tools -y
RUN apt install python -y
RUN apt install python-pip -y
RUN apt install -y apache2 
Run pip install robotframework
RUN pip install robotframework-rammbock


EXPOSE 80

CMD apachectl -D FOREGROUND
