# Include base image

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

# final runnable commands are enclosed with paranthesis and seperate

CMD ["python","manage.py","runserver","0.0.0.0:8000"]


