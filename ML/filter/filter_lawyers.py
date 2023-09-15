import pandas as pd
from connect_db import lawyers
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

def recommend_for_lawyers(search_text):
    data = lawyers.find()
    df = pd.DataFrame(data)
    
    tfidf_vectorizer = TfidfVectorizer(stop_words='english')
    df["name"] = df['firstName']+" "+df['middleName']+" "+df['lastName']
    content = df['name'] + " " + df['city']+" "+df['state']+" " +df['bio']
    
     
    tfidf_matrix = tfidf_vectorizer.fit_transform(content)
    user_vector = tfidf_vectorizer.transform([search_text])
    
    cosine_similarities = cosine_similarity(user_vector,tfidf_matrix).flatten()
    
    df['similarity'] = cosine_similarities
    df = df[df['similarity']>0.0]
    df = df.sort_values(by='similarity', ascending=False)
    list = []
    for index, row in df.iterrows():
        list.append({"firstName": row['firstName'],
        "middleName":row['middleName'],
        "lastName": row['lastName'],
        "city": row['city'],
        "state": row['state'],
        "postalCode":row['postalCode'] ,
        "aadharNumber": row['aadharNumber'],
        "regId": row['regId'],
        "specialization":row["specialization"],
        "isNotary":row['isNotary'],
        "notaryId":row['notaryId'],
        "courts" :row['courts'],
        "bio":row['bio'],
        })
    return list


recommend_for_lawyers('family')