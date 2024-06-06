<h1 align="center">Hi 👋, I'm Dula</h1>
<h3 align="center">Dokcer sample for python app</h3>

<h3 align="left">Connect with me:</h3>
<p align="left">
</p>

1. docker volume create pythonapp


2. Use volumes

docker run -d --name pythonapp --mount source=pythonapp,target=/app -p 8002:8002 geethdula1/python-test:latest
   
OR

docker run -d --name pythonapp --mount type=volume,source=pythonapp,target=/app -p 8002:8002 geethdula1/python-test:latest	

3. Use Bind mounts

docker run -d --name pythonapp --mount type=bind,source=/opt/linux-class/docker,target=/app -p 8002:8002 geethdula1/python-test:latest

# More Info related to this Docker file
1. RUN python3 -m venv venv

Purpose:
This command creates a virtual environment for Python within the Docker container. A virtual environment is a self-contained directory that contains a Python installation for a specific version of Python, plus a number of additional packages.


Syntax Breakdown:
RUN: This is a Dockerfile instruction used to execute a command in the shell within the context of the container. Each RUN command creates a new layer in the Docker image.

python3: This calls the Python interpreter. It is assumed that Python 3 is already installed in the base image.

-m venv: This option tells Python to run the venv module, which is a standard module used to create virtual environments.

venv: This is the name of the directory where the virtual environment will be created. This directory will contain the Python binary and other necessary files to manage packages.

2. ENV VIRTUAL_ENV=/app/venv

Purpose:
This command sets an environment variable VIRTUAL_ENV within the Docker container. Environment variables are used to configure the environment in which the container runs.


Syntax Breakdown:
ENV: This is a Dockerfile instruction used to set environment variables in the container.

VIRTUAL_ENV: This is the name of the environment variable being set. By convention, this variable is often used to specify the location of the virtual environment.

/app/venv: This is the value of the VIRTUAL_ENV variable. It points to the directory where the virtual environment was created. Note that this assumes that the virtual environment is located at /app/venv. If the venv command in the previous step created the virtual environment in a different directory, this path should be adjusted accordingly.

3. ENV PATH="$VIRTUAL_ENV/bin:$PATH"

Purpose:
This command modifies the PATH environment variable to include the binary directory of the virtual environment. This ensures that when you run Python or pip commands, they use the versions from the virtual environment rather than the system-wide versions.


Syntax Breakdown:
ENV: As mentioned above, this instruction sets environment variables in the container.

PATH: This is a standard environment variable on Unix-like systems that specifies the directories in which executable programs are located.

"$VIRTUAL_ENV/bin:$PATH": This sets the PATH variable to include the bin directory of the virtual environment at the beginning. The $VIRTUAL_ENV/bin directory contains the Python executable and other scripts installed in the virtual environment. By placing it at the beginning, it ensures that these versions take precedence over any system-wide versions.



#Followed Articles

1. https://testdriven.io/blog/docker-best-practices/#use-multi-stage-builds

2. https://www.koyeb.com/docs/deploy/flask

3. https://snyk.io/blog/best-practices-containerizing-python-docker/

