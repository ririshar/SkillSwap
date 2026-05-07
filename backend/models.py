from sqlalchemy import Column, Integer, String, Float
from .database import Base
from datetime import datetime
from sqlalchemy.orm import relationship



class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    email = Column(String, nullable=False)


class Listing(Base):
    __tablename__ = "listings"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, index=True, nullable=False)
    description = Column(String, nullable=False)
    price = Column(Float, default=0.0)
    level = Column(String, default="Beginner")
    availability = Column(String, default="Flexible")


class Request(Base):
    __tablename__ = "requests"

    id = Column(Integer, primary_key=True, index=True)
    listing_id = Column(Integer, nullable=False)
    requester_name = Column(String, nullable=False)
    message = Column(String, nullable=True)
    status = Column(String, default="pending")