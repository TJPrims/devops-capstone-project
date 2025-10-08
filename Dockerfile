# Step 1: Use Python 3.9 slim as the base image
FROM python:3.9-slim

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Step 4: Copy the application code into the container
COPY service/ ./service/

# Step 5: Create a non-root user called 'theia' and switch to it
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Step 6: Expose port 8080 for the service
EXPOSE 8080

# Step 7: Use gunicorn as the application server
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]
