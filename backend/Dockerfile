FROM openjdk:11-jre-slim
RUN addgroup --system spring && adduser --system --group spring
USER spring:spring
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
COPY apm/opentelemetry-javaagent.jar opentelemetry-javaagent.jar
ENTRYPOINT ["java","-jar","/app.jar"]