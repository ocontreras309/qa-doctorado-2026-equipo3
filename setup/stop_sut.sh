#!/bin/bash
# Stop Chatbot app

PID_FILE="./ChatBotProject/chatbot.pid"

if [ ! -f "$PID_FILE" ]; then
    echo "PID file not available."
    exit 1
fi

echo "Stopping Chatbot app..."

kill $(cat $PID_FILE)

echo "Application stopped."