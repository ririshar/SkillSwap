from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from .. import models, schemas, database

router = APIRouter()

# In-memory storage for simplicity
chats = []

@router.get("/")
async def get_chat():
    """Retrieve all chat messages."""
    return {"messages": chats}

@router.post("/")
async def send_message(message: schemas.ChatMessage):
    """Send a new chat message."""
    chats.append({"sender": message.sender, "content": message.content})
    return {"message": "Message sent successfully"}