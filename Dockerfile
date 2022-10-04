FROM arm64v8/openjdk:20

ARG ELASTICMQ_VERSION=1.3.11

RUN curl -s -o /elasticmq-server.jar https://s3-eu-west-1.amazonaws.com/softwaremill-public/elasticmq-server-${ELASTICMQ_VERSION}.jar && \
    chmod +x /elasticmq-server.jar 

COPY elasticmq.conf /etc/elasticmq/elasticmq.conf

EXPOSE 9324

VOLUME /etc/elasticmq
ENV ELASTICMQ_OPTS="-Dconfig.file=/etc/elasticmq/elasticmq.conf"

CMD ["java", "-Djava.net.preferIPv4Stack=true", "-Dconfig.file=/etc/elasticmq/elasticmq.conf", "-Dlogback.configurationFile=/etc/elasticmq/logback.xml", "-jar", "/elasticmq-server.jar"]