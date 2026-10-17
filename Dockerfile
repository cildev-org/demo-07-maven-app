# syntax=docker/dockerfile:1
FROM maven:3.9.9-eclipse-temurin-21@sha256:3a4ab3276a087bf276f79cae96b1af04f53731bec53fb2e651aca79e4b10211e AS build
WORKDIR /src
COPY pom.xml ./
COPY src ./src
RUN mvn -q -B -DskipTests package

FROM eclipse-temurin:21-jre@sha256:227118764cccd3c3294617061aaa93a08309c63a395eefa83e6b35032992ea99
WORKDIR /app
COPY --from=build /src/target/app.jar ./app.jar
RUN useradd -u 10001 appu
USER appu
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
