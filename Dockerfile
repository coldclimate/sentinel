# taken from https://docker-fastapi-projects.readthedocs.io/en/latest/uvicorn.html
# single build at the moment, would swap to create a multistage build for a
# better output object

FROM python:3.10.2

# Our Debian with python is now installed.
# Imagine we have folders /sys, /tmp, /bin etc. there
# like we would install this system on our laptop.

RUN mkdir build

# We create folder named build for our stuff.

WORKDIR /build

# Basic WORKDIR is just /
# Now we just want to our WORKDIR to be /build

COPY . .

# FROM [path to files from the folder we run docker run]
# TO [current WORKDIR]
# We copy our files (files from .dockerignore are ignored)
# to the WORKDIR

RUN pip install --no-cache-dir -r requirements.txt
RUN poetry install

# OK, now we pip install our requirements

EXPOSE 80

# Instruction informs Docker that the container listens on port 80

WORKDIR /build/sentinel

CMD python -m uvicorn sentinel.api:app --host 0.0.0.0 --port 80 --reload
