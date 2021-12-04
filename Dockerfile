FROM openjdk:11-jre-slim
VOLUME /tmp
ARG JAVA_OPTS
ENV JAVA_OPTS=$JAVA_OPTS
# COPY build/libs/pravega-sensor-collector-0.0.1.jar psc.jar
ADD pravega-sensor-collector/build/distributions/pravega-sensor-collector-0.2.12.tgz /opt
COPY pravega-sensor-collector/build/libs/pravega-sensor-collector-0.2.12.jar pravegasensorcollector.jar
# EXPOSE 9090
ENTRYPOINT exec java $JAVA_OPTS -jar pravegasensorcollector.jar
# For Spring-Boot project, use the entrypoint below to reduce Tomcat startup time.
#ENTRYPOINT exec java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar psc.jar
