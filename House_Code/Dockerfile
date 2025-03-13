# Use an official Python runtime as a base image
FROM python:3.11-slim

# Set environment variables to prevent Python from writing .pyc files and to enable unbuffered output
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install Node.js for accessibility tools
RUN apt-get update && apt-get install -y \
    nodejs \
    npm \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file and install dependencies
COPY requirements.txt /app/requirements.txt
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Install accessibility testing tools
RUN npm install -g pa11y axe-core

# Copy the entire application code into the container
COPY . /app

# Expose port 5000 for the Flask application
EXPOSE 5000

# Define the command to run the Flask app
CMD ["python", "app.py"]
