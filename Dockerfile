FROM python:3.6
ENV PYTHONUNBUFFERED 1

ADD requirements.txt /config/
RUN pip install -r /config/requirements.txt

USER root

RUN yum -y install sqlite3 && yum clean all -y


RUN mkdir /src
WORKDIR /src
ADD ./mysite /src
# RUN ./manage.py makemigrations
# RUN ./manage.py migrate
RUN ./manage.py collectstatic --no-input

CMD gunicorn mysite.wsgi -b 0.0.0.0:3013
# CMD python manage.py runserver 0.0.0.0:3013

EXPOSE 3013
