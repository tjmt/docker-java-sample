#build stage
FROM tjmt/java:builder as build
ARG JAR_FILE=target/
VOLUME /tmp
ENTRYPOINT ["mvnw","clean","package"]
COPY ${JAR_FILE}/docker-java-sample-0.1.0.jar /app/app.jar

#final stage
FROM tjmt/java:runtime as final
COPY --from=build /app /app
WORKDIR /app
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","app.jar"]



