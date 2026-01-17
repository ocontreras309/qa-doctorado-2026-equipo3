#!/bin/bash
# Startup script for Chatbot application

echo "Starting Chatbot app..."

SUT_DIR="./ChatBotProject"

if [ -d "$SUT_DIR" ]; then
    echo "Updating ChatBot project..."
    cd ./ChatBotProject
    git pull origin master
else
    echo "Downloading ChatBot project..."
    git clone https://github.com/ocontreras309/ChatBotProject.git
    cd ./ChatBotProject
fi

read -p "OpenAI Key: " KEY

if [ ! -d "./venv" ]; then
    python3 -m venv venv
fi

source venv/bin/activate
pip install -r requirements.txt
export OPENAI_API_KEY=$KEY
gunicorn backend:app --daemon --pid chatbot.pid

echo "Chatbot application started!"
echo "You can go to http://localhost:8000 to see the UI"
