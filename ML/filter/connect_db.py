from pymongo import MongoClient

myclient = MongoClient("mongodb+srv://manishmadan101:QqXwEgB7VhIzPSsh@cluster0.wtpmj5h.mongodb.net/")
db = myclient["sih"]
posts = db["posts"]
lawyers=db['lawyers']
## Creating a Connection to MongoDB