from pydantic import BaseModel
from typing import Optional


# Schema for chat messages
class ChatMessage(BaseModel):
    sender: str
    content: str


# This ChatMessage schema is repeated, so one version can be removed
class ChatMessage(BaseModel):
    sender: str
    content: str


# Schema used when creating a new user
class UserCreate(BaseModel):
    name: str
    email: str
    password: str


# Schema used when updating an existing user
class UserUpdate(BaseModel):
    name: Optional[str] = None
    email: Optional[str] = None


# Schema used when returning user data from the API
class UserResponse(BaseModel):
    id: int
    name: str
    email: str

    class Config:
        # Allows the schema to work with database model objects
        orm_mode = True


# Basic schema for creating a listing
# This is repeated later with more fields, so this version can be removed
class ListingsCreate(BaseModel):
    title: str
    description: str
    price: float


# Basic schema for returning listing data
# This is repeated later with more fields, so this version can be removed
class ListingsResponse(BaseModel):
    id: int
    title: str
    description: str
    price: float

    class Config:
        # Allows the schema to read data from model attributes
        from_attributes = True


# Schema used when creating a new listing
class ListingsCreate(BaseModel):
    title: str
    description: str
    price: float = 0.0
    level: str = "Beginner"
    availability: str = "Flexible"
    contact: str = ""


# Schema used when returning listing data from the API
class ListingsResponse(BaseModel):
    id: int
    title: str
    description: str
    price: float
    level: str
    availability: str
    contact: str = ""

    class Config:
        # Allows the schema to work with SQLAlchemy model objects
        from_attributes = True


# Schema used when creating a lesson request
class RequestCreate(BaseModel):
    listing_id: int
    requester_name: str
    message: str | None = None


# Schema used when returning request data from the API
class RequestResponse(BaseModel):
    id: int
    listing_id: int
    requester_name: str
    message: str | None = None
    status: str

    class Config:
        # Allows the schema to work with SQLAlchemy model objects
        from_attributes = True


# This file defines the Pydantic schemas used for data validation in the API
# These schemas control the structure of data sent to and returned from the backend
