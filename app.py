from flask import Flask
app = Flask(__name__)
 
@app.route('/')
def hello_world():
    return 'Hello from Mypythonapp'

@app.route('/health', methods=['GET'])
def health():
	# Handle here any business logic for ensuring you're application is healthy (DB connections, etc...)
    return "Healthy: OK"
 
if __name__ == "__main__":
    app.run()
