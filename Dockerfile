FROM ubuntu:22.04

RUN apt-get update && apt-get install -y openjdk-11-jdk maven

ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64
ENV MAVEN_HOME /usr/share/maven

WORKDIR /app

COPY ./src /app/src
COPY ./pom.xml /app/pom.xml

RUN mvn clean install

CMD ["java", "-jar", "target/my-app.jar"]
