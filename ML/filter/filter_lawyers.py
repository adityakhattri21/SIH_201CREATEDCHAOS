import pandas as pd
from connect_db import lawyers
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
def array_to_string(arr):
    return ' '.join(map(str, arr))
def recommend_for_lawyers(search_text):
    data = lawyers.find()
    df = pd.DataFrame(data)
    df.fillna(' ')
    if(search_text == ''):
            list0 = []
            for index, row in df.iterrows():
                list0.append({"firstName": row['firstName'],
                 "middleName":row['middleName'],
                "lastName": row['lastName'],
                "city": row['city'],
                "state": row['state'],
                "postalCode":row['postalCode'] ,
                "aadharNumber": row['aadharNumber'],
                "specialization":row["specialization"],
                 "isNotary":row['isNotary'],
                "courts" :row['courts'],
                 "bio":row['bio'],
                })
            return list0
    
    df['tagline'] = df['specialization'].apply(array_to_string)
    print(df)
    tfidf_vectorizer = TfidfVectorizer(stop_words='english')
    df["name"] = df['firstName']+" "+" "+df['lastName']
    content = df['name'] + " " + df['city']+" "+df['state']+" " +df['bio']+" "+df['tagline']
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
        "specialization":row["specialization"],
        "isNotary":row['isNotary'],
        "courts" :row['courts'],
        "bio":row['bio'],
         })
    return list


##recommend_for_lawyers('family')