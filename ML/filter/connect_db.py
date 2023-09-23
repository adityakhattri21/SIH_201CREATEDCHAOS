from pymongo import MongoClient

myclient = MongoClient(os.getenv('DB-URI'))
db = myclient["sih"]
posts = db["posts"]
lawyers=db['lawyers']
## Creating a Connection to MongoDB