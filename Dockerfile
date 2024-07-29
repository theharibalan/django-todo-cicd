# First stage: Build environment
FROM python:3.10-slim as build-env

# Set the working directory
WORKDIR /data

# Install dependencies
RUN pip install django==3.2 gunicorn

# Copy the application code
COPY . .

# Run database migrations
RUN python manage.py makemigrations
RUN python manage.py migrate

# Second stage: Minimal image
FROM python:3.10-slim

# Set the working directory
WORKDIR /data

# Install Gunicorn
RUN pip install gunicorn

# Copy only necessary files from the build stage
COPY --from=build-env /data /data

# Expose the application port
EXPOSE 8000

# Run the application using Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "myapp.wsgi:application"]
