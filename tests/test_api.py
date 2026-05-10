from fastapi.testclient import TestClient
from backend.main import app

client = TestClient(app)


def test_root_endpoint():
    response = client.get("/")
    assert response.status_code == 200
    assert "message" in response.json()


def test_get_listings_returns_list():
    response = client.get("/listings/")
    assert response.status_code == 200
    assert isinstance(response.json(), list)


def test_create_listing_valid_input():
    listing_data = {
        "title": "Python Help",
        "description": "Beginner Python support",
        "price": 0,
        "level": "Beginner",
        "availability": "Monday 10:00",
        "contact": "test@email.com"
    }

    response = client.post("/listings/", json=listing_data)

    assert response.status_code == 201
    data = response.json()
    assert data["title"] == "Python Help"
    assert data["description"] == "Beginner Python support"
    assert data["level"] == "Beginner"
    assert data["availability"] == "Monday 10:00"


def test_create_listing_missing_title_fails():
    listing_data = {
        "description": "Missing title test",
        "price": 0,
        "level": "Beginner",
        "availability": "Monday 10:00",
        "contact": "test@email.com"
    }

    response = client.post("/listings/", json=listing_data)

    assert response.status_code == 422


def test_create_request_valid_input():
    request_data = {
        "listing_id": 1,
        "requester_name": "Test Student",
        "message": "I would like to learn this skill."
    }

    response = client.post("/requests/", json=request_data)

    assert response.status_code == 201
    data = response.json()
    assert data["requester_name"] == "Test Student"
    assert data["message"] == "I would like to learn this skill."
    assert data["status"] == "pending"


def test_get_requests_returns_list():
    response = client.get("/requests/")
    assert response.status_code == 200
    assert isinstance(response.json(), list)


def test_create_request_missing_name_fails():
    request_data = {
        "listing_id": 1,
        "message": "Missing name test"
    }

    response = client.post("/requests/", json=request_data)

    assert response.status_code == 422