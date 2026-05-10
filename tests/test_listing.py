from fastapi.testclient import TestClient
from backend.main import app

client = TestClient(app)


def test_get_listings_returns_list():
    response = client.get("/listings/")

    assert response.status_code == 200
    assert isinstance(response.json(), list)


def test_create_listing_with_valid_input():
    listing_data = {
        "title": "Python Help",
        "description": "Beginner Python support",
        "price": 0,
        "level": "Beginner",
        "availability": "Monday 10:00",
        "contact": "test@email.com",
    }

    response = client.post("/listings/", json=listing_data)

    assert response.status_code == 201
    data = response.json()
    assert data["title"] == "Python Help"
    assert data["description"] == "Beginner Python support"
    assert data["level"] == "Beginner"
    assert data["availability"] == "Monday 10:00"
    assert data["contact"] == "test@email.com"


def test_create_listing_missing_title_fails():
    listing_data = {
        "description": "Missing title test",
        "price": 0,
        "level": "Beginner",
        "availability": "Monday 10:00",
        "contact": "test@email.com",
    }

    response = client.post("/listings/", json=listing_data)

    assert response.status_code == 422


def test_delete_listing_with_valid_id():
    listing_data = {
        "title": "Delete Listing Test",
        "description": "This listing will be deleted",
        "price": 0,
        "level": "Beginner",
        "availability": "Tuesday 12:00",
        "contact": "delete@test.com",
    }

    create_response = client.post("/listings/", json=listing_data)
    listing_id = create_response.json()["id"]

    delete_response = client.delete(f"/listings/{listing_id}")

    assert delete_response.status_code == 204


def test_delete_listing_with_invalid_id_fails():
    response = client.delete("/listings/999999")

    assert response.status_code == 404
