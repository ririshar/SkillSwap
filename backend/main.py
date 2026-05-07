from fastapi import FastAPI
from .routers import users, listings, requests, chat
from . import models
from .database import engine

models.Base.metadata.create_all(bind=engine)

app = FastAPI(
    title="Skills Swap",
    version="1.0.0",
)

app.include_router(users.router, prefix="/users", tags=["users"])
app.include_router(listings.router, prefix="/listings", tags=["listings"])
app.include_router(requests.router, prefix="/requests", tags=["requests"])
app.include_router(chat.router, prefix="/chat", tags=["chat"])


@app.get("/")
async def root():
    return {"message": "Skills Swap API is still running!"}