# FROM python:3.10-slim

# WORKDIR /app-first

# COPY requirements.txt .

# RUN pip install -r requirements.txt

# COPY . .

# CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
# # CMD [ "python", "main.py" ]








FROM python:3.10 AS build

WORKDIR /pyapp

COPY requirements.txt .

RUN pip install -r requirements.txt

# RUN python3 -m venv /venv

# ENV PATH="/venv/bin/activate"


FROM python:3.10-slim

WORKDIR /pyapp

COPY requirements.txt .

RUN pip install -r requirements.txt
# RUN apt install uvicorn

# COPY --from=build /usr/lib/python3.8/ /usr/lib/python3.8/ 
COPY --from=build /pyapp /pyapp/
COPY . .

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

