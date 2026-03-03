from fastapi import FastAPI,   HTTPExceptions
from pydantic import BaseModel
from typing import List 


app = FastAPI(
    title = "Skills Swap",
    version = "1.0.0",
)


@app.get("/")
async def root():
    return {"message": "Welcome to Skills Swap API!"}