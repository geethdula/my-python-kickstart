docker volume create pythonapp
docker run -d --name pythonapp --mount source=pythonapp,target=/app -p 8002:8002 geethdula1/python-test:v14
