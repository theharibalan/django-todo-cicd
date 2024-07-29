# First stage: Build environment
FROM python:3.10-slim as build-env

# Set the working directory
WORKDIR /data

# Install dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy the application code
COPY . .

# Run database migrations
RUN python manage.py makemigrations
RUN python manage.py migrate

# Second stage: Distroless Python image
FROM gcr.io/distroless/python3

# Set the working directory
WORKDIR /data

# Copy only necessary files from the build stage
COPY --from=build-env /data /data

# Expose the application port
EXPOSE 8000

# Run the application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
