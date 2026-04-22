from fastapi import FastAPI,   HTTPException
from pydantic import BaseModel
from typing import List 
from .routers import users, listings, requests, chat

app = FastAPI(
    title = "Skills Swap",
    version = "1.0.0",
)

app.include_router(users.router, prefix="/users", tags=["users"])
app.include_router(listings.router, prefix="/listings", tags=["listings"])
app.include_router(requests.router, prefix="/requests", tags=["requests"])
app.include_router(chat.router, prefix="/chat", tags=["chat"])

@app.get("/")
async def root():
    return {"message": "Skills Swap API is still running!"}