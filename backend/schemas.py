from pydantic import BaseModel
from typing import Optional

class ChatMessage(BaseModel):
    sender: str
    content: str

# Schema for chat messages
class ChatMessage(BaseModel):
    sender: str
    content: str

# Schema for creating a user
class UserCreate(BaseModel):
    name: str
    email: str
    password: str  # Assuming password is required for user creation

# Schema for updating a user
class UserUpdate(BaseModel):
    name: Optional[str] = None
    email: Optional[str] = None

# Schema for returning user data
class UserResponse(BaseModel):
    id: int
    name: str
    email: str

    class Config:
        orm_mode = True  # Enables compatibility with SQLAlchemy models 

# Schema for creating a listing
class ListingsCreate(BaseModel):
    title: str
    description: str
    price: float

# Schema for returning listing data
class ListingsResponse(BaseModel):
    id: int
    title: str
    description: str
    price: float

    class Config:
        from_attributes = True
        
class ListingsCreate(BaseModel):
    title: str
    description: str
    price: float = 0.0
    level: str = "Beginner"
    availability: str = "Flexible"
    contact: str = ""


class ListingsResponse(BaseModel):
    id: int
    title: str
    description: str
    price: float
    level: str
    availability: str
    contact: str = ""

    class Config:
        from_attributes = True

class RequestCreate(BaseModel):
    listing_id: int
    requester_name: str
    message: str | None = None


class RequestResponse(BaseModel):
    id: int
    listing_id: int
    requester_name: str
    message: str | None = None
    status: str

    class Config:
        from_attributes = True

# This file defines the Pydantic models (schemas) used for data validation and serialization in the FastAPI application. 
# These schemas are used to define the structure of the data that is sent and received through the API endpoints, ensuring that the data conforms to the expected format.