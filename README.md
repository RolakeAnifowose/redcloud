# DevOps Exercise: Hello World Microservice with Nginx and Docker on AWS Fargate

This document outlines the implementation of a "hello world" microservice using Nginx as a reverse proxy, containerized with Docker, and deployed to AWS Fargate.

## Summary

- **Microservice Architecture**: The application responds to HTTPS requests with a simple "Hello World" message, demonstrating the ability to serve basic content over HTTP.
- **Nginx as a Reverse Proxy**: Nginx handles incoming requests and proxies them to a Flask application running on port 5000.
- **Containerization with Docker**: The microservice is packaged as a Docker container, enabling easy deployment and scalability across various environments.
- **Deployment on AWS Fargate**: Utilizing AWS Fargate, the microservice runs in a serverless container environment, eliminating the need for managing server infrastructure.
- **TLS Support**: The application is secured with TLS certificates managed through AWS ACM, ensuring that all traffic is served over HTTPS and enhancing security by blocking plain HTTP calls.
- **Health Check Endpoint**: A dedicated health check endpoint (`/healthcheck`) is implemented, responding with a status indicating the service's operational health.

## Prerequisites

Before running the code, ensure you have the following:

- Python
- Docker
- AWS ACM TLS certificate
- AWS Application Load Balancer
- Flask
- AWS ECR registry & repository
- AWS ECS cluster, task definition, service

## Running the Code

1. Create a repository on GitHub.
2. Create repository secrets for the following AWS credentials:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_ACCOUNT_ID`
   - `AWS_REGION`
   - `AWS_SECRET_ACCESS_KEY`
3. Push the code to the repository (the pipeline is triggered on pushes to the master branch).

## Validation
![/api/v1](Desktop/1504.png)
![/healthcheck](Desktop/1510.png)
![/otherroute](Desktop/1156.png)

## AWS Resources Required Before Building & Running

1. **ECR Repositories**: Set up your Elastic Container Registry (ECR) repositories.
![ECR](Desktop/1459.png)

2. **ECS Cluster**: Create an ECS cluster with Fargate infrastructure.
![cluster](Desktop/1426.png)

3. **ECS Task Definition**: Create a task definition with the following specifications:
   - **Containers**:
     - Name: `flask`
     - Name: `nginx`, Port: `80`
   - **Network Mode**: `awsvpc`
   - **App Environment**: Fargate
   - **CPU**: `2 vCPU`
   - **Memory**: `3 GB`

4. **Security Groups**:

   **ALB Security Group**:
   - **Inbound Rule**:
     - Type: HTTPS
     - Protocol: TCP
     - Port Range: 443
     - Source: `0.0.0.0/0`
   - **Outbound Rule**:
     - Type: All traffic
     - Protocol: All
     - Port Range: All
     - Destination: `0.0.0.0/0`

   **ECS Security Group**:
   - **Inbound Rule**:
     - Type: HTTP
     - Protocol: TCP
     - Port Range: 80
     - Source: ALB Security Group
   - **Outbound Rule**:
     - Type: All traffic
     - Protocol: All
     - Port Range: All
     - Destination: `0.0.0.0/0`

5. **ECS Service**:
   - **Launch Type**: Fargate
   - **Application Type**: Service
   - **Task Definition Family**: Select the task definition created in step 3.
   - **Service Name**: `redcloud-hello-world-ecs-service` (can be modified if you prefer).
   - **Networking**: Select a VPC and attach the ECS security group.
   - **Load Balancing**:
     - Type: Application Load Balancer
     - Container: `nginx` (80:80)
     - Enter a name for the load balancer.
     - Listener: HTTPS, 443
     - New target group with HTTP:80 protocol and port, and HTTPS health check protocol.
     - Health Check Path: `/healthcheck`

## Conclusion

Follow these steps to set up your Hello World microservice successfully. Ensure all configurations are in place, and feel free to modify names and settings as needed.
