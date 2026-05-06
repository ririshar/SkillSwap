from sqlalchemy import Column, Integer, String, Float
from sqlalchemy.orm import declarative_base
from datetime import datetime
from sqlalchemy.orm import relationship

Base = declarative_base()

class Listing(Base):
    __tablename__ = "listings"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, index=True)
    description = Column(String)
    price = Column(Float)