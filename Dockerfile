# Build stage
# FROM python:3.10-slim as build-env
# WORKDIR /data
# RUN pip install django==3.2 gunicorn
# COPY . .
# RUN python manage.py makemigrations
# RUN python manage.py migrate

# # Final stage
# FROM python:3.10-slim
# WORKDIR /data
# COPY --from=build-env /data /data
# RUN pip install gunicorn django==3.2
# EXPOSE 8000
# CMD ["gunicorn", "--bind", "0.0.0.0:8000", "todoApp.wsgi:application"]


FROM python:3 

# Assign the working directory
WORKDIR /data

# Install the dependencies
RUN pip install django==3.2

# Copy file to runnable path  - from and to 
COPY . .

# run the commands to execute
RUN python manage.py migrate

#expose the port to the world
EXPOSE 8000

# final runnable commands are enclosed with paranthesis and seperated with " ". " "
CMD ["python","manage.py","runserver","0.0.0.0:8000"]