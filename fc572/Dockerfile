FROM python:3.10.7-slim-buster

COPY required.txt required.txt
RUN pip install -U pip && pip install -r required.txt

COPY ./app /app
COPY ./bin /app/bin
WORKDIR /app

RUN useradd demo
USER demo

EXPOSE 8080

ENTRYPOINT ["bash", "/app/bin/run.sh"]
