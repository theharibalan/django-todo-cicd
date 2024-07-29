# First stage: Build environment
FROM python3

# Set the working directory
WORKDIR /data

# Install dependencies
RUN pip install django==3.2

# Copy the application code
COPY . .

# Expose the application port
EXPOSE 8000

# Run the application directly
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
