FROM arm64v8/openjdk:11

ARG ELASTICMQ_VERSION=1.3.1

RUN wget -q -O /elasticmq-server.jar https://s3-eu-west-1.amazonaws.com/softwaremill-public/elasticmq-server-${ELASTICMQ_VERSION}.jar

COPY elasticmq.conf /etc/elasticmq/elasticmq.conf

EXPOSE 9324

VOLUME /etc/elasticmq
ENV ELASTICMQ_OPTS="-Dconfig.file=/etc/elasticmq/elasticmq.conf"

CMD ["java", "-Djava.net.preferIPv4Stack=true", "-Dconfig.file=/etc/elasticmq/elasticmq.conf", "-Dlogback.configurationFile=/etc/elasticmq/logback.xml", "-jar", "/elasticmq-server.jar"]