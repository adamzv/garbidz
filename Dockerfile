FROM eclipse-temurin:21.0.2_13-jre-alpine

ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
COPY apm/opentelemetry-javaagent.jar opentelemetry-javaagent.jar
ENTRYPOINT ["java","-jar","/app.jar"]