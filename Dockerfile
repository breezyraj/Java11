FROM openjdk

ADD target/pipeline-0.0.1-SNAPSHOT.jar pipeline-0.0.1-SNAPSHOT.jar

ENTRYPOINT ["java", "-jar","pipeline-0.0.1-SNAPSHOT.jar"],"com.example.javamavenjunithelloworld.HelloApp"

EXPOSE 8080