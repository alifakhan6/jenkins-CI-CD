FROM python:3.8

# Install distutils
RUN apt-get update && apt-get install -y python3-distutils

WORKDIR /data

# Copy requirements.txt first to leverage caching
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Run database migrations
RUN python manage.py migrate

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
