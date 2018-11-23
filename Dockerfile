#build stage
FROM tjmt/java:builder as build
ARG SKIP_TEST
COPY . .
RUN ./mvnw  clean package -Dmaven.test.skip=${SKIP_TEST}

#final stage
FROM tjmt/java:runtime as final
COPY --from=build target/docker-java-sample-0.1.0.jar /app/app.jar
WORKDIR /app
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","app.jar"]



