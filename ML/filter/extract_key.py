import requests
model_id = "bert-base-uncased"
data = {
    "inputs": "Your input text goes here."
}
api_url = "https://api-inference.huggingface.co/models/{model_id}"

response = requests.post(api_url, json=data)
if response.status_code == 200:
    result = response.json()
    predictions = result['predictions']
    # Use the predictions as needed
    print(predictions)
else:
    print("Request failed with status code:", response.status_code)
