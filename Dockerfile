# Step 1: Use a Maven image to build the application
FROM maven:3.8.5-openjdk-11 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the entire project into the container
COPY . .

# Build the project using Maven
RUN mvn clean package

# Step 2: Use a Tomcat image for running the application
FROM tomcat:9.0-jdk11

# Copy the WAR file from the build stage to the Tomcat webapps directory
COPY --from=build /app/webapp/target/webapp.war /usr/local/tomcat/webapps/webapp.war

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
