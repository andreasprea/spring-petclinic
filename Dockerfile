# Base Alpine Linux based image with OpenJDK JRE only
FROM openjdk:11-jre-buster
# copy application JAR (with libraries inside)
COPY target/spring-petclinic-*.jar /app.jar
# copy flight recorder parameters
COPY misc/fr_opts.txt /fr_opts.txt
# specify default command 
# CMD ["/usr/local/openjdk-11/bin/java", "-jar", "-Dcom.sun.management.jmxremote.rmi.port=9090", "-Dcom.sun.management.jmxremote=true", "-Dcom.sun.management.jmxremote.port=9090", "-Dcom.sun.management.jmxremote.ssl=false", "-Dcom.sun.management.jmxremote.authenticate=false", "-Dcom.sun.management.jmxremote.local.only=false", "-XX:StartFlightRecording=/fr_opts.txt", "-Djava.rmi.server.hostname=localhost", "/app.jar"]
# CMD /usr/local/openjdk-11/bin/java -jar -Dcom.sun.management.jmxremote.rmi.port=9090 -Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.port=9090 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.local.only=false -XX:StartFlightRecording=$(cat /fr_opts.txt) -Djava.rmi.server.hostname=localhost /app.jar
CMD /usr/local/openjdk-11/bin/java -jar /app.jar