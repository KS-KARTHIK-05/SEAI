# Use a lightweight Python base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install system dependencies for OpenCV/Keras if needed
RUN apt-get update && apt-get install -y libgl1-mesa-glx libglib2.0-0 && rm -rf /var/lib/apt/lists/*

# Copy requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the model and all scripts
COPY . .

# Expose the port your Flask/FastAPI app runs on (usually 5000 or 8000)
EXPOSE 5000

# Command to run the application
CMD ["python", "app.py"]