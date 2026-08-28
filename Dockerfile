FROM ubuntu:22.04

# Install required packages
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    git \
    curl \
    unzip \
    gradle \
    && rm -rf /var/lib/apt/lists/*

# Download Android SDK
ENV ANDROID_HOME=/opt/android-sdk
RUN mkdir -p ${ANDROID_HOME} && \
    cd ${ANDROID_HOME} && \
    curl -o android-sdk.zip https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip && \
    unzip android-sdk.zip && \
    rm android-sdk.zip && \
    mkdir -p cmdline-tools/latest && \
    mv cmdline-tools/* cmdline-tools/latest/ 2>/dev/null || true

# Set Java and Android paths
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=${ANDROID_HOME}/cmdline-tools/latest/bin:${JAVA_HOME}/bin:$PATH

# Accept Android licenses
RUN yes | sdkmanager --licenses 2>/dev/null || true

# Clone and build ViMusic
RUN git clone -b rahil729-vimusic-task https://github.com/mohdrahil327/ViMusic.git /app
WORKDIR /app

# Build APK
RUN chmod +x gradlew && \
    ./gradlew clean assembleDebug --no-daemon

# Output APK
CMD ["cp", "app/build/outputs/apk/debug/app-debug.apk", "/output/app-debug.apk"]
