FROM nikolaik/python-nodejs:python3.10-nodejs19

# Set timezone
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Update Node.js and npm to the latest version of Node.js 19
RUN curl -fssL https://deb.nodesource.com/setup_19.x | bash - && \
    apt-get install -y nodejs && \
    npm i -g npm

# Install other dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        neofetch \
        git \
        curl \
        wget \
        mediainfo \
        ffmpeg && \
    apt-get autoremove --purge -y && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /Ult

# Copy the application code
COPY . .

RUN pip3 install --no-cache-dir -r reqs.txt
RUN pip3 install -U pip
RUN pip3 install -U redis

RUN pip3 install --no-cache-dir -r addons.txt
RUN pip3 install --no-cache-dir -r requirements.txt
RUN pip3 install --no-cache-dir -r res*/st*/op*

# Set appropriate permissions
RUN chown -R 1000:0 /Ult \
    && chown -R 1000:0 . \
    && chmod 777 . \
    && chmod 777 /usr \
    && chown -R 1000:0 /usr \
    && chmod -R 755 /Ult \
    && chmod +x /Ult/start.sh

# Install FFmpeg
RUN wget https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz && \
    wget https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz.md5 && \
    md5sum -c ffmpeg-git-amd64-static.tar.xz.md5 && \
    tar xvf ffmpeg-git-amd64-static.tar.xz && \
    mv ffmpeg-git*/ffmpeg ffmpeg-git*/ffprobe /usr/local/bin/

# Expose port
EXPOSE 7860

# Start the application with the changed command
CMD ["bash", "-c", "python3 server.py & python3 -m AnonXMusic"]
