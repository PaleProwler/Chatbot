FROM python:3-slim

# Install dependencies
RUN apt-get update && \
    apt-get install -y ffmpeg portaudio19-dev && \
    apt-get clean

# Set the working directory
WORKDIR /app

# Use ARG to accept build-time variables
ARG GROQ_API_KEY
# Set the environment variable at runtime
ENV GROQ_API_KEY=${GROQ_API_KEY}

# Copy the requirements file
COPY requirements.txt .

# Install Python dependencies
RUN python -m venv venv && \
    . venv/bin/activate && \
    pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Ensure environment variable is available at runtime
RUN export GROQ_API_KEY=$GROQ_API_KEY"
# Command to run the application
CMD ["python", "app.py"]
