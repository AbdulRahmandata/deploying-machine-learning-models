# tells us we are going to use this 3.6.4 docker image from docker hub as our base image, this is a linux base image, so we will use linux syntax in the subsecant commands.
FROM python:3.6.4 

# Create the user that will run the app
RUN adduser --disabled-password --gecos '' ml-api-user

# From where any subsequent command will be run.
WORKDIR /opt/ml_api

# defining PIP_EXTRA_INDEX_URL argument that will be passed into the BUILD command that we will specify soon.
ARG PIP_EXTRA_INDEX_URL
# Speficting the FLASK_APP environment variable.
ENV FLASK_APP run.py

# Install requirements, including from Gemfury
# Using this the below ADD command we are taking all the files in ./packages/ml_api and copying them intp /opt/ml_api (which is the Container)
ADD ./packages/ml_api /opt/ml_api/

# Run our pip install commands.
RUN pip install --upgrade pip
RUN pip install -r /opt/ml_api/requirements.txt
# chmod for the run script to give it permission to run
RUN chmod +x /opt/ml_api/run.sh
RUN chown -R ml-api-user:ml-api-user ./

USER ml-api-user

# Incomming requests to our running docker container will to have to lookup for port 5000 because this is the port opened up.
EXPOSE 5000

# Here our command specifies the command that will be run when our container starts up, which is "./run.sh" script
CMD ["bash", "./run.sh"]