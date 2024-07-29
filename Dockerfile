# First stage: Build environment
FROM python:3-slim as build-env

# Set the working directory
WORKDIR /data

# Install dependencies
RUN pip install django==3.2

# Copy the application code
COPY . .

# Run database migrations
RUN python manage.py makemigrations
RUN python manage.py migrate

# Second stage: Use slim image for debugging
FROM python:3-slim

# Set the working directory
WORKDIR /data

# Copy only necessary files from the build stage
COPY --from=build-env /data /data

# Expose the application port
EXPOSE 8000

# Run the application directly
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
