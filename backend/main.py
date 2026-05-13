from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from .routers import users, listings, requests, chat
from . import models
from .database import engine
from sqlalchemy import text

models.Base.metadata.create_all(bind=engine)

with engine.connect() as connection:
    result = connection.execute(text("PRAGMA table_info(listings)"))
    columns = [row[1] for row in result]

    if "contact" not in columns:
        connection.execute(text("ALTER TABLE listings ADD COLUMN contact VARCHAR DEFAULT ''"))
        connection.commit()


app = FastAPI(
    title="Skills Swap",
    version="1.0.0",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(users.router, prefix="/users", tags=["users"])
app.include_router(listings.router, prefix="/listings", tags=["listings"])
app.include_router(requests.router, prefix="/requests", tags=["requests"])
app.include_router(chat.router, prefix="/chat", tags=["chat"])


@app.get("/")
async def root():
    return {"message": "Skills Swap API is still running!"}
# starts the backend API, connects the database models