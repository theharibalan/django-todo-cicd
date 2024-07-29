# Include base image
FROM python:3 AS build-env

# Assign the working directory
WORKDIR /data

# Install the dependencies
RUN pip install django==3.2

# Copy file to runnable path  - from and to 
COPY . .

# run the commands to execute
RUN python manage.py migrate


# multi stage build using distroless image 

FROM gcr.io/distroless/python3
COPY --from=build-env . .
WORKDIR /data


#expose the port to the world
EXPOSE 8000

# final runnable commands are enclosed with paranthesis and seperated with " ". " "
CMD ["python","manage.py","runserver","0.0.0.0:8000"]


# COPY . /app
# WORKDIR /app

# FROM gcr.io/distroless/python3
# COPY --from=build-env /app /app
# WORKDIR /app
# CMD ["hello.py", "/etc"]