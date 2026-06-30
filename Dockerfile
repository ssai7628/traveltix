# TravelTix - combined Python + Java single-service image
# Deployed by: Saikrishnan S
FROM eclipse-temurin:21-jdk-jammy

# Install Python
RUN apt-get update && \
    apt-get install -y --no-install-recommends python3 python3-pip python3-venv && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app

RUN chmod +x start.sh
RUN pip3 install --no-cache-dir -r python-backend/requirements.txt

# Render/Railway inject $PORT for the public-facing process (the Python site)
ENV PORT=5000
EXPOSE 5000

CMD ["./start.sh"]
