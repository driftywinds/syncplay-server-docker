FROM alpine:latest

# Install dependencies
RUN apk add --no-cache sudo python3 py3-pip git make py3-twisted

# Copy entrypoint script before switching users
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Create a non-root user for security
RUN adduser -D syncplay && echo "syncplay ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the user
USER syncplay
WORKDIR /home/syncplay

# Clone Syncplay repository and install
RUN git clone https://github.com/Syncplay/syncplay.git && \
    cd syncplay && sudo make install

# Expose Syncplay server default port
EXPOSE 8999

# Set default environment variables
ENV PORT=8999 \
    PASSWORD="" \
    ROOM="" \
    MOTD_FILE="/motd.txt" \
    MAX_USERS=0 \
    ISOLATION_MODE=""

VOLUME ["/motd"]

# Use the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]

