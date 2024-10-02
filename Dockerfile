# Stage 1: Build Nginx image
FROM nginx:alpine AS nginx

COPY Dockerfile.nginx .
RUN ["docker", "build", "-t", "nginx:custom", "."]

# Stage 2: Build Flask application image
FROM python:3.9-slim

WORKDIR /app

COPY app.py /app

COPY requirements.txt .
RUN pip install -r requirements.txt

EXPOSE 5000

#CMD ["python", "app.py"]
CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]