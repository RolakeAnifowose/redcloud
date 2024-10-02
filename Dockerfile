# Stage 1: Build Nginx image
FROM nginx:alpine AS nginx

COPY Dockerfile.nginx .
RUN ["docker", "build", "-t", "nginx:custom", "."]

# Stage 2: Build Flask application image
FROM python:3.11-slim-buster

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .
COPY --from=nginx /usr/share/nginx/html/  # Copy static files from Nginx image

CMD ["python", "app.py"]