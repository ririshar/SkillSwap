from pydantic import BaseModel
from typing import Optional


# Defines the structure of a chat message
class ChatMessage(BaseModel):
    sender: str
    content: str


# Defines the structure of a chat message
class ChatMessage(BaseModel):
    sender: str
    content: str


# Defines the data needed to create a user
class UserCreate(BaseModel):
    name: str
    email: str
    password: str


# Defines the data that can be updated for a user
class UserUpdate(BaseModel):
    name: Optional[str] = None
    email: Optional[str] = None


# Defines the user data returned by the API
class UserResponse(BaseModel):
    id: int
    name: str
    email: str

    class Config:
        # Allows the schema to work with database models
        orm_mode = True


# Defines the data needed to create a listing
class ListingsCreate(BaseModel):
    title: str
    description: str
    price: float


# Defines the listing data returned by the API
class ListingsResponse(BaseModel):
    id: int
    title: str
    description: str
    price: float

    class Config:
        # Allows the schema to read data from model objects
        from_attributes = True


# Defines the data needed to create a listing
class ListingsCreate(BaseModel):
    title: str
    description: str
    price: float = 0.0
    level: str = "Beginner"
    availability: str = "Flexible"
    contact: str = ""


# Defines the listing data returned by the API
class ListingsResponse(BaseModel):
    id: int
    title: str
    description: str
    price: float
    level: str
    availability: str
    contact: str = ""

    class Config:
        # Allows the schema to read data from model objects
        from_attributes = True


# Defines the data needed to create a lesson request
class RequestCreate(BaseModel):
    listing_id: int
    requester_name: str
    message: str | None = None


# Defines the request data returned by the API
class RequestResponse(BaseModel):
    id: int
    listing_id: int
    requester_name: str
    message: str | None = None
    status: str

    class Config:
        # Allows the schema to read data from model objects
        from_attributes = True


# Defines the data structures used by the API
# These schemas help check data that is sent to and returned from the backend
