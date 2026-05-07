# Use a lightweight Python base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Ensure we are the root user
USER root

# Advanced apt-get fix: Switch mirrors and add retry logic
RUN sed -i 's/deb.debian.org/ftp.us.debian.org/g' /etc/apt/sources.list && \
    apt-get update --fix-missing || apt-get update --fix-missing && \
    apt-get install -y --no-install-recommends \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the model and all scripts
COPY . .

# Expose port
EXPOSE 5000

# Command to run the application
CMD ["python", "app.py"]