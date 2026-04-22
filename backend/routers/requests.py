from fastapi import APIRouter

router = APIRouter()

@router.get("/")
async def get_requests():
    return {"message": "List of requests"}

