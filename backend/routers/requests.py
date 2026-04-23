from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from app import models, schemas
from app.database import get_db

router = APIRouter()

@router.get("/")
async def get_requests():
    return {"message": "List of requests"}

@router.post("/", response_model=schemas.RequestResponse, status_code=status.HTTP_201_CREATED)
def create_request(
    request: schemas.RequestCreate,
    db: Session = Depends(get_db)
):
    # Create a new request object
    new_request = models.Request(**request.dict())
    db.add(new_request)
    db.commit()
    db.refresh(new_request)
    return new_request



