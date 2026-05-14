from sqlalchemy import Column, Integer, String, Float
from .database import Base
from datetime import datetime
from sqlalchemy.orm import relationship


# Defines the users table
class User(Base):
    __tablename__ = "users"

    # Stores the user ID
    id = Column(Integer, primary_key=True, index=True)

    # Stores the user's name
    name = Column(String, nullable=False)

    # Stores the user's email address
    email = Column(String, nullable=False)


# Defines the listings table
class Listing(Base):
    __tablename__ = "listings"

    # Stores the listing ID
    id = Column(Integer, primary_key=True, index=True)

    # Stores the listing title
    title = Column(String, index=True, nullable=False)

    # Stores the listing description
    description = Column(String, nullable=False)

    # Stores the price of the listing
    price = Column(Float, default=0.0)

    # Stores the skill level
    level = Column(String, default="Beginner")

    # Stores the user's availability
    availability = Column(String, default="Flexible")

    # Stores the contact information
    contact = Column(String, default="")


# Defines the requests table
class Request(Base):
    __tablename__ = "requests"

    # Stores the request ID
    id = Column(Integer, primary_key=True, index=True)

    # Stores the ID of the listing being requested
    listing_id = Column(Integer, nullable=False)

    # Stores the name of the person making the request
    requester_name = Column(String, nullable=False)

    # Stores the request message
    message = Column(String, nullable=True)

    # Stores the request status
    status = Column(String, default="pending")


# This file defines the database models for the application
# Each model represents a table in the database
