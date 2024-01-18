#FROM openjdk:17
#
#ADD target/universitymanagement-0.0.1-SNAPSHOT.jar universitymanagement-0.0.1-SNAPSHOT.jar
#
#EXPOSE 8080
#
#ENTRYPOINT ["java","-jar","universitymanagement-0.0.1-SNAPSHOT.jar"]

# FROM openjdk:17 AS build
# ENV HOME=/usr/app
# RUN mkdir -p $HOME
# WORKDIR $HOME
# ADD . $HOME
# RUN ./mvnw -f $HOME/pom.xml clean package

# FROM openjdk:17 
# COPY --from=build /usr/app/target/*.jar /app/*.jar
# EXPOSE 8080
# ENTRYPOINT ["java", "-jar", "/app/*.jar"]

Build stage

# FROM openjdk:17 AS build
# ENV HOME=/usr/app
# RUN mkdir -p $HOME
# WORKDIR $HOME
# ADD . $HOME
# RUN --mount=type=cache,target=/root/.m2 ./mvnw -f $HOME/pom.xml clean package

# #
# # Package stage
# #
# FROM openjdk:17
# ARG JAR_FILE=/usr/app/target/*.jar
# COPY --from=build $JAR_FILE /app/runner.jar
# EXPOSE 8080
# ENTRYPOINT java -jar /app/runner.jar
#
# Build stage
#
FROM maven:3.6.0-jdk-17-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM openjdk:17
COPY --from=build /home/app/target/*.jar  /usr/local/lib/*.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/*.jar"]
