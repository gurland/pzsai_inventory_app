FROM tiangolo/uwsgi-nginx-flask:python3.11

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY ./src /app
