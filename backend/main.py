# Imports FastAPI and the tools needed for the backend
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

# Imports the route files
from .routers import users, listings, requests, chat

# Imports the database models and engine
from . import models
from .database import engine

# Imports text so raw SQL commands can be used
from sqlalchemy import text


# Creates the database tables if they do not already exist
models.Base.metadata.create_all(bind=engine)


# Checks if the listings table has a contact column
with engine.connect() as connection:
    result = connection.execute(text("PRAGMA table_info(listings)"))
    columns = [row[1] for row in result]

    # Adds the contact column if it is missing
    if "contact" not in columns:
        connection.execute(text("ALTER TABLE listings ADD COLUMN contact VARCHAR DEFAULT ''"))
        connection.commit()


# Creates the FastAPI app
app = FastAPI(
    title="Skills Swap",
    version="1.0.0",
)


# Allows the frontend to connect to the backend
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


# Adds the route files to the main app
app.include_router(users.router, prefix="/users", tags=["users"])
app.include_router(listings.router, prefix="/listings", tags=["listings"])
app.include_router(requests.router, prefix="/requests", tags=["requests"])
app.include_router(chat.router, prefix="/chat", tags=["chat"])


# Test route to check if the API is running
@app.get("/")
async def root():
    return {"message": "Skills Swap API is still running!"}
