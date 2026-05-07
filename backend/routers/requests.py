from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from .. import models, schemas, database

router = APIRouter()

@router.get("/")
async def get_requests():
    return {"message": "List of requests"}

@router.post("/", response_model=schemas.RequestResponse, status_code=status.HTTP_201_CREATED)
def create_request(
    request: schemas.RequestCreate,
    db: Session = Depends(database.get_db)
):
    # Create a new request object
    new_request = models.Request(**request.dict())
    db.add(new_request)
    db.commit()
    db.refresh(new_request)
    return new_request

# ACCEPT REQUEST
@router.put("/{request_id}/accept", response_model=schemas.RequestResponse)
def accept_request(
    request_id: int,
    db: Session = Depends(database.get_db)
):
    existing_request = db.query(models.Request).filter(models.Request.id == request_id).first()
    if not existing_request:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Request not found")
    
    existing_request.status = "accepted"
    db.commit()
    db.refresh(existing_request)
    return existing_request



# REJECT REQUEST
@router.put("/{request_id}/reject", response_model=schemas.RequestResponse)
def reject_request(
    request_id: int,
    db: Session = Depends(database.get_db)
):
    existing_request = db.query(models.Request).filter(models.Request.id == request_id).first()
    if not existing_request:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Request not found")
    
    existing_request.status = "rejected"
    db.commit()
    db.refresh(existing_request)
    return existing_request


@router.delete("/{request_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_request(
    request_id: int,
    db: Session = Depends(database.get_db)
):
    existing_request = db.query(models.Request).filter(models.Request.id == request_id).first()
    if not existing_request:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Request not found")
    
    db.delete(existing_request)
    db.commit()
    return

@router.get("/{request_id}", response_model=schemas.RequestResponse)
def get_request(
    request_id: int,
    db: Session = Depends(database.get_db)
):
    existing_request = db.query(models.Request).filter(models.Request.id == request_id).first()
    if not existing_request:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Request not found")
    
    return existing_request

#list all requests for a specific listing
@router.get("/listing/{listing_id}", response_model=list[schemas.RequestResponse])
def get_requests_for_listing(
    listing_id: int,
    db: Session = Depends(database.get_db)
):
    requests = db.query(models.Request).filter(models.Request.listing_id == listing_id).all()
    return requests





