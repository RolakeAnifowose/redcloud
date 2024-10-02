# # Stage 1: Build Nginx image
# FROM nginx:alpine AS nginx

# COPY Dockerfile.nginx .
# RUN ["docker", "build", "-t", "nginx:custom", "."]

# # Stage 2: Build Flask application image
# FROM python:3.9-slim

# WORKDIR /app

# COPY app.py /app

# COPY requirements.txt .
# RUN pip install -r requirements.txt

# EXPOSE 5000

# #CMD ["python", "app.py"]
# CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]

# Stage 1: Build the Python application
# FROM python:3.9-slim AS builder

# # Set working directory
# WORKDIR /app

# # Copy the application code
# COPY app.py /app

# # Install dependencies
# COPY requirements.txt .
# RUN pip install -r requirements.txt

# EXPOSE 5000

# CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]

# # Stage 2: Final image with Nginx and Python app
# FROM nginx:alpine

# # Copy Nginx configuration
# #COPY nginx.conf /etc/nginx/nginx.conf
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# # Copy the Python application from the builder stage
# COPY --from=builder /app /app

# # Expose the port Nginx will listen on
# EXPOSE 80

# # Start both Nginx and Gunicorn
# CMD ["nginx", "-g", "daemon off;"]