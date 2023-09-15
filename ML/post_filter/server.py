from flask import Flask
from flask import request
import connect_db
import pandas as pd
app = Flask(__name__)
 

@app.route('/')
# ‘/’ URL is bound with hello_world() function.
def hello_world(): 
    return "Server is running"
 
# main driver function
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)