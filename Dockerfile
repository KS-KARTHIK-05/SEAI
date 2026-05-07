# Use the FULL Python image to avoid apt-get mirror issues
FROM python:3.9

# Set working directory
WORKDIR /app

# Ensure we have the latest pip
RUN pip install --upgrade pip

# Copy requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the model and all scripts
COPY . .

# Expose the application port
EXPOSE 5000

# Command to run the application
CMD ["python", "app.py"]