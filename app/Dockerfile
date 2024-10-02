FROM python:3.9-slim

WORKDIR /app

COPY app/app.py /app

COPY app/requirements.txt .
RUN pip install -r requirements.txt

EXPOSE 5000

#CMD ["python", "app.py"]
CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]