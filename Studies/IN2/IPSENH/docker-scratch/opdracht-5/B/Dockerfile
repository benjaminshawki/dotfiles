FROM python:3.9-alpine

WORKDIR /app

RUN apk update && apk add --no-cache build-base libffi-dev \
    && pip install --upgrade pip

COPY ./app/requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY ./app /app

EXPOSE 1234

CMD ["python", "main.py"]

