#!/bin/bash
# Check Chatbot application status

echo "Checking whether Chatbot application is running..."
PID_FILE="./ChatBotProject/chatbot.pid"

if [ ! -f "$PID_FILE" ]; then
    echo "❌ Chatbot application is not running."
    exit 1
fi

# Check if a basic request returns http status 200
echo "Application health check..."
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8000/)

if [ "$HTTP_STATUS" -eq 200 ]; then
    echo "✅ Chatbot is running correctly"
    echo "📊 App is currently active"
    echo "🌐 Endpoint: http://localhost:8000"
    exit 0
else
    echo "❌ Chatbot is not running (HTTP $HTTP_STATUS)"
    exit 1
fi