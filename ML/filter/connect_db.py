from pymongo import MongoClient

myclient = MongoClient("mongodb://localhost:27017/")
db = myclient["sih"]
posts = db["posts"]
lawyers=db['lawyers']
## Creating a Connection to MongoDB