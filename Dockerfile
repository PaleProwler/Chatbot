FROM python:3-slim

# Install dependencies
RUN apt-get update && \
    apt-get install -y ffmpeg portaudio19-dev && \
    apt-get clean

# Set the working directory
WORKDIR /app

ARG GROQ_API_KEY
RUN echo $GROQ_API_KEY
# Copy the requirements file
COPY requirements.txt .

# Install Python dependencies
RUN python -m venv venv
RUN . venv/bin/activate
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Command to run the application
CMD ["python", "app.py"]
