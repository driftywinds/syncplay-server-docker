#!/bin/sh

# Construct the command dynamically based on environment variables
CMD="syncplay-server --port $PORT"

# If a password is set, add it
[ -n "$PASSWORD" ] && CMD="$CMD --password $PASSWORD"

# If a default room is set, add it
[ -n "$ROOM" ] && CMD="$CMD --room $ROOM"

# If an MOTD file exists, add it
[ -f "$MOTD_FILE" ] && CMD="$CMD --motd-file $MOTD_FILE"

# If max users is set, add it
[ "$MAX_USERS" -gt 0 ] && CMD="$CMD --max-users $MAX_USERS"

# If isolation mode is enabled, add it
[ -n "$ISOLATION_MODE" ] && CMD="$CMD --isolate-room $ISOLATION_MODE"

# Execute the command
echo "Running: $CMD"
exec $CMD
