#FROM openjdk:17
#
#ADD target/universitymanagement-0.0.1-SNAPSHOT.jar universitymanagement-0.0.1-SNAPSHOT.jar
#
#EXPOSE 8080
#
#ENTRYPOINT ["java","-jar","universitymanagement-0.0.1-SNAPSHOT.jar"]

FROM openjdk:17 AS build
ENV HOME=/usr/app
RUN mkdir -p $HOME
WORKDIR $HOME
ADD . $HOME
RUN --mount=type=cache,target=/root/.m2 ./mvnw -f $HOME/pom.xml clean package

#
# Giai đoạn đóng gói
#
FROM openjdk:17 
ARG JAR_FILE=/usr/app/target/*.jar
COPY --from=build $JAR_FILE /app/*.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/*.jar"]

# Build stage
#
#FROM openjdk:17 AS build
#ENV HOME=/usr/app
#RUN mkdir -p $HOME
#WORKDIR $HOME
#ADD . $HOME
#RUN --mount=type=cache,target=/root/.m2 ./mvnw -f $HOME/pom.xml clean package
#
##
## Package stage
##
#FROM openjdk:17
#ARG JAR_FILE=/usr/app/target/*.jar
#COPY --from=build $JAR_FILE /app/runner.jar
#EXPOSE 8080
#ENTRYPOINT java -jar /app/runner.jar
