## Overview

LegalEdge is a platform designed to assist users in finding relevant legal information and connecting with experienced lawyers. One of the key features of the app is the recommendation system, which uses cosine similarity to suggest relevant posts and lawyers based on user input.

## How Cosine Similarity Works

Cosine similarity is a mathematical technique used to measure the similarity between two vectors, often employed in natural language processing (NLP) tasks. In our app, cosine similarity is utilized to:

1. **Recommend Posts**: When a user provides a description of their legal problem or query, the app calculates the cosine similarity between the user's input and the content of various legal posts. The posts with the highest cosine similarity scores are recommended to the user.

2. **Recommend Lawyers**: Similarly, the app uses cosine similarity to suggest lawyers who specialize in areas related to the user's legal needs. This ensures that users are connected with lawyers who are most relevant to their specific situation.

## Usage

To use the recommendation system in the Legal Onboarding Services App:

1. **User Input**: The user provides input in the form of a description of their legal issue or query. This input can be in the form of a title, content, or a combination of both.

2. **Cosine Similarity Calculation**: The app preprocesses the user's input and calculates its TF-IDF vector representation. It also computes the TF-IDF vectors for the content and titles of available posts and lawyers' profiles.

3. **Recommendation Generation**: Cosine similarity is applied to compare the user's input vector with the vectors of posts and lawyers. The top-rated posts and lawyers, based on similarity scores, are recommended to the user.

4. **User Interaction**: The recommended posts and lawyers are presented to the user within the app's interface. The user can then explore the recommended content or choose to connect with a recommended lawyer.


## Dependencies

The recommendation system in the Legal Onboarding Services App relies on the following libraries and tools:

- Python: The app uses Python for data preprocessing, TF-IDF vectorization, and cosine similarity calculations.

- Scikit-learn: Scikit-learn is used for TF-IDF vectorization and cosine similarity computations.

- Flask - Backend Server 

## API Endpoints

* ```GET /posts?search=queryString```
Response is in JSON form with post information


* ```GET /lawyers?search=queryString```
Response is in JSON form with lawyer's necessary information

## Installation

```
virtualenv env
```
```
pip install flask scikit-learn pandas
```
```
cd filter
```
```
python server
```