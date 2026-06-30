# TravelTix - combined Python + Java single-service image
# Deployed by: Saikrishnan S

FROM eclipse-temurin:21-jdk-jammy

# Step 1: Install Python and essential build tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends python3 python3-pip python3-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Step 2: Leverage layer caching for Python requirements
# Copy ONLY the requirements file first so dependencies aren't re-installed on every code change
COPY python-backend/requirements.txt ./python-backend/

# --break-system-packages is safe inside an isolated Docker container 
# and bypasses the modern Debian/Ubuntu PIP restriction.
RUN pip3 install --no-cache-dir --break-system-packages -r python-backend/requirements.txt

# Step 3: Copy the rest of the application code
COPY . /app

# Step 4: [Optional but Recommended] Build your Java app if it isn't pre-compiled
# Uncomment the line below that matches your project framework:
# RUN ./mvnw clean package -DskipTests
# RUN ./gradlew build -x test

# Step 5: Fix permissions for the startup script
RUN chmod +x start.sh

# Render/Railway inject $PORT for the public-facing process (the Python site)
ENV PORT=5000
EXPOSE 5000

CMD ["./start.sh"]
