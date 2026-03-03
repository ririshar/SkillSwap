from fastapi import FastAPI,   HTTPException
from pydantic import BaseModel
from typing import List 
from routers import users, listings, requests, chat


app = FastAPI(
    title = "Skills Swap",
    version = "1.0.0",
)

app.include_router(users.router, prefix="/users", tags=["Users"])
app.include_router(listings.router, prefix="/listings", tags=["Listings"])
app.include_router(requests.router, prefix="/requests", tags=["Requests"])
app.include_router(chat.router, prefix="/chat", tags=["Chat"])

@app.get("/")
async def root():
    return {"Skills Swap API is still running!"}