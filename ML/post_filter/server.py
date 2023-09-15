from flask import Flask
from flask import request
import connect_db
import pandas as pd
from filter_posts import recommend_for_posts
app = Flask(__name__)
recommend_for_posts('dispute')

@app.route('/posts')
def query_example():
    search_text = request.args['search']
    result = recommend_for_posts(search_text)
    return result
# main driver function
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)