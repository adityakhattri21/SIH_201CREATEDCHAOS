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
    
    print(cosine_similarities)
    results = pd.DataFrame({'PostID': df['_id'], 'Similarity': cosine_similarities})
    results = results.sort_values(by='Similarity', ascending=False)
    print(results)

recommend_for_posts('university')