# First stage: Build environment
FROM python:3.10-slim as build-env

# Set the working directory
WORKDIR /data

# Copy requirements file if available (optional step)
# COPY requirements.txt /data/

# Install dependencies
RUN pip install django==3.2

# Copy the application code
COPY . .

# Run database migrations
RUN python manage.py makemigrations
RUN python manage.py migrate

# Second stage: Distroless Python image
FROM python:3.10-slim

# Set the working directory
WORKDIR /data

# Copy only necessary files from the build stage
COPY --from=build-env /data /data

# Expose the application port
EXPOSE 8000

# Run the application directly
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
