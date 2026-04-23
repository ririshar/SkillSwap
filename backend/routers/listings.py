from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from .. import models, schemas, database


router = APIRouter()

@router.get("/")
async def get_listings():
    return {"message": "List of listings"}


@router.post("/",response_model=schemas.ListingsResponse, status_code=201)
def create_listing(listing: schemas.listingsCreate, db, current_user):
    new_listing = models.Listing(**listing.dict())
    db.add(new_listing)
    db.commit()
    db.refresh(new_listing)
    return new_listing

@router.put("/{listing_id}", response_model=schemas.ListingsResponse)
def update_listing(listing_id: int, listing: schemas.listingsCreate, db, current_user):
    existing_listing = db.query(models.Listing).filter(models.Listing.id == listing_id).first()
    if not existing_listing:
        raise HTTPException(status_code=404, detail="Listing not found")
    for key, value in listing.dict(exclude_unset=True).items():
        setattr(existing_listing, key, value)

    db.commit()
    db.refresh(existing_listing)
    return existing_listing 

@router.delete("/{listing_id}", status_code=204)
def delete_listing(listing_id: int, db, current_user):
    existing_listing = db.query(models.Listing).filter(models.Listing.id == listing_id).first()
    if not existing_listing:
        raise HTTPException(status_code=404, detail="Listing not found")
    db.delete(existing_listing)
    db.commit()
    return
    