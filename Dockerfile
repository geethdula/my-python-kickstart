FROM python:3.12.2-slim as builder

#Setup working directory inside dockcer
WORKDIR /app

#PYTHONDONTWRITEBYTECODE is an environment variable that disables the writing of Python bytecode files when modules are loaded. By setting this environment variable during our CI runs, we can reduce the overall CI time with no loss of functionality.
ENV PYTHONDONTWRITEBYTECODE 1
#Setting PYTHONUNBUFFERED to a non-empty value different from 0 ensures that the python output i.e. the stdout and stderr streams are sent straight to terminal (e.g. your container log) without being first buffered and that you can see the output of your application (e.g. django logs) in real time.

#This also ensures that no partial output is held in a buffer somewhere and never written in case the python application crashes.
ENV PYTHONUNBUFFERED 1


RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc curl

RUN python3 -m venv venv
ENV VIRTUAL_ENV=/app/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
#copying module requirements to docker image to build with depenedencies
COPY requirements.txt .
RUN pip install -r requirements.txt


# final stage
FROM python:3.12.2-slim as runner
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl
WORKDIR /app

#Use Unprivileged Containers - Security step
#remove shell access and ensure there's no home directory as well
RUN addgroup --gid 1001 --system app && \
    adduser --no-create-home --shell /bin/false --disabled-password --uid 1001 --system --group app

USER app

COPY --from=builder /app/venv venv
COPY app.py app.py

ENV VIRTUAL_ENV=/app/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
ENV FLASK_APP=app/app.py

EXPOSE 8002

HEALTHCHECK CMD curl --fail http://localhost:8002/health || exit 1
CMD ["gunicorn", "--bind" , ":8002", "--workers", "2", "app:app"]

#HEALTHCHECK CMD curl --fail http://localhost:8080/health || exit 1

