# Build stage
FROM python:3.10-slim as build-env
WORKDIR /data
RUN pip install django==3.2 gunicorn
COPY . .
RUN python manage.py makemigrations
RUN python manage.py migrate

# Final stage
FROM python:3.10-slim
WORKDIR /data
COPY --from=build-env /data /data
RUN pip install gunicorn django==3.2
EXPOSE 8000
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "todoApp.wsgi:application"]
