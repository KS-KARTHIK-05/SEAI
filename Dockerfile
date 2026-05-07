# Use a lightweight Python base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Ensure we are the root user to avoid permission-based 'exit code 100'
USER root

# Combine update and install, and add retry logic/fix-missing flags
# exit code 100 often occurs due to stale indexes or repository sync issues
RUN apt-get update --fix-missing && \
    apt-get install -y --no-install-recommends libgl1-mesa-glx libglib2.0-0 && \
    rm -rf /var/lib/apt/lists/*

# Copy requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the model and all scripts
COPY . .

# Expose the port (FastAPI/Uvicorn default is often 8000, update if using 5000)
EXPOSE 5000

# Command to run the application
CMD ["python", "app.py"]