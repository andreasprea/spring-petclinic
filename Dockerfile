# Base Alpine Linux based image with OpenJDK JRE only
FROM openjdk:11-jre-buster
# copy application WAR (with libraries inside)
COPY target/spring-petclinic-*.jar /app.jar
# specify default command
CMD ["/usr/local/openjdk-11/bin/java", "-jar", "-Dcom.sun.management.jmxremote.rmi.port=9090", "-Dcom.sun.management.jmxremote=true", "-Dcom.sun.management.jmxremote.port=9090", "-Dcom.sun.management.jmxremote.ssl=false", "-Dcom.sun.management.jmxremote.authenticate=false", "-Dcom.sun.management.jmxremote.local.only=false", "-XX:+FlightRecorder", "-Djava.rmi.server.hostname=localhost", "/app.jar"]

#"-XX:+UnlockCommercialFeatures",
