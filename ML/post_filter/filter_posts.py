import pandas as pd
from connect_db import posts
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
import json
def recommend_for_posts(search_text):
    data = posts.find()
    df = pd.DataFrame(data)
    
    tfidf_vectorizer = TfidfVectorizer(stop_words='english')
    
    tfidf_matrix = tfidf_vectorizer.fit_transform(df['heading'] + " " + df['desc'])
    user_vector = tfidf_vectorizer.transform([search_text])
    
    cosine_similarities = cosine_similarity(user_vector,tfidf_matrix).flatten()
    
    df['similarity'] = cosine_similarities
    df = df[df['similarity']>0.0]
    df = df.sort_values(by='similarity', ascending=False)
    list = []
    for index, row in df.iterrows():
        list.append({
                "_id":str(row['_id']),
                "userId":row['userId'],
                "heading" :row['heading'],
                "tags":row['tags'],
                "desc":row['desc']
                 })
    return list


##recommend_for_posts('dispute')