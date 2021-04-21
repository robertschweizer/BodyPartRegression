# Test

# For more information, please refer to https://aka.ms/vscode-docker-python
FROM python:3.8-slim-buster

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# Copy files 
WORKDIR /app
COPY requirements.txt .
COPY scripts scripts/
COPY src/models/loh-ldist-l2/sigma-dataset-v11/model.pt src/models/loh-ldist-l2/sigma-dataset-v11/model.pt
COPY src/models/loh-ldist-l2/sigma-dataset-v11/config.p src/models/loh-ldist-l2/sigma-dataset-v11/config.p

# Install pip requirements
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt



# Creates a non-root user with an explicit UID and adds permission to access the /app folder
# For more info, please refer to https://aka.ms/vscode-docker-python-configure-containers
# RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app

# add root as user
USER root

# During debugging, this entry point will be overridden. For more information, please refer to https://aka.ms/vscode-docker-python-debug
#CMD ["python", "application/BodyPartRegression.py"]
