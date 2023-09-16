import pandas as pd
from connect_db import posts
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
def array_to_string(arr):
    return ' '.join(map(str, arr))
def recommend_for_posts(search_text):
    data = posts.find()
    
    df = pd.DataFrame(data)
    
    if(search_text == ""):
        list0 = []
        for index, row in df.iterrows():
            list0.append({
                "_id":str(row['_id']),
                "userId":row['userId'],
                "heading" :row['heading'],
                "tags":row['tags'],
                "desc":row['desc']
                 })
        return list0

    df['tagline'] = df['tags'].apply(array_to_string)
    
    tfidf_vectorizer = TfidfVectorizer(stop_words='english')
    
    tfidf_matrix = tfidf_vectorizer.fit_transform(df['heading'] + " " + df['desc'] + " "+df['tagline'])
    user_vector = tfidf_vectorizer.transform([search_text])
    
    cosine_similarities = cosine_similarity(user_vector,tfidf_matrix).flatten()
    
    df['similarity'] = cosine_similarities
    df = df[df['similarity']>0.0]
    df = df.sort_values(by='similarity', ascending=False)
    list1 = []
    for index, row in df.iterrows():
        list1.append({
                "_id":str(row['_id']),
                "userId":row['userId'],
                "heading" :row['heading'],
                "tags":row['tags'],
                "desc":row['desc']
                 })
    return list1


##recommend_for_posts('dispute')