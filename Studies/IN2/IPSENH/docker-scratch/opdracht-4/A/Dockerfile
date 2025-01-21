FROM python:3.9-alpine

WORKDIR /app

RUN apk update

RUN apk add --no-cache build-base libffi-dev \
    && pip install --upgrade pip

RUN python3 -m venv venv
RUN source venv/bin/activate

ENV PATH="/app/venv/bin:$PATH"
COPY ./app/requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY ./app /app

EXPOSE 1234

CMD ["python", "main.py"]
