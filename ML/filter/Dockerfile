FROM python:3

WORKDIR /app

COPY . .
RUN pip install flask scikit-learn pandas numpy pymongo

COPY . .

CMD [ "python", "server.py" ]