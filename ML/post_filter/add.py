
import pymongo

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = myclient["sih"]
mycol = mydb["lawyers"]


mydict = [{"firstName": "Vishwa",
    "middleName":'Kalyan',
    "lastName": 'Rath',
    "city": 'Meerut',
    "state": 'Uttar Pradesh',
    "postalCode":"280005" ,
    "aadharNumber": "123456789012",
    "regId": '123',
    "specialization":['Criminal defense'],
    "isNotary":False,
    "notaryId":"qwerty123",
    
    "courts" :[
        'Allahabad High Court',
        'Meerut District court'
    ],
    "bio":'master in critical cases, making bail possible for criminals',
}]




for element in mydict:
    x = mycol.insert_one(element)