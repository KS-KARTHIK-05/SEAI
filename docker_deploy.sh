#!/bin/bash
# 1. Build the image
docker build -t your-dockerhub-username/leafguard-ai:v1 .

# 2. Log in (Make sure you are logged in via CLI)
# docker login

# 3. Push to DockerHub
docker push karthikks007/leafguard-ai:v1

echo "Deployment to DockerHub complete!"