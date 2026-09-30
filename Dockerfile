#Etapa 1: Compilacion  
FROM maven:3.9-eclipse-temurin-21 as build
workdir /app
copy . .
run mvn -f pom.xml clean package -DskipTests

#Etapa 2: creacion de la imagen final
from eclipse-temurin:21-jre-jammy
WORKDIR /app
COPY --from=build /app/target/*.jar ./app.jar
expose 80
ENTRYPOINT ["java","-jar","app.jar"]