from fastapi.testclient import TestClient
from backend.main import app

client = TestClient(app)


def test_get_requests_returns_list():
    response = client.get("/requests/")

    assert response.status_code == 200
    assert isinstance(response.json(), list)


def test_create_request_with_valid_input():
    request_data = {
        "listing_id": 1,
        "requester_name": "Test Student",
        "message": "I would like to learn this skill.",
    }

    response = client.post("/requests/", json=request_data)

    assert response.status_code == 201
    data = response.json()
    assert data["listing_id"] == 1
    assert data["requester_name"] == "Test Student"
    assert data["message"] == "I would like to learn this skill."
    assert data["status"] == "pending"


def test_create_request_missing_name_fails():
    request_data = {
        "listing_id": 1,
        "message": "Missing name test",
    }

    response = client.post("/requests/", json=request_data)

    assert response.status_code == 422


def test_accept_request_changes_status():
    request_data = {
        "listing_id": 1,
        "requester_name": "Accept Test Student",
        "message": "Please accept this request.",
    }

    create_response = client.post("/requests/", json=request_data)
    request_id = create_response.json()["id"]

    accept_response = client.put(f"/requests/{request_id}/accept")

    assert accept_response.status_code == 200
    assert accept_response.json()["status"] == "accepted"


def test_reject_request_changes_status():
    request_data = {
        "listing_id": 1,
        "requester_name": "Reject Test Student",
        "message": "Please reject this request.",
    }

    create_response = client.post("/requests/", json=request_data)
    request_id = create_response.json()["id"]

    reject_response = client.put(f"/requests/{request_id}/reject")

    assert reject_response.status_code == 200
    assert reject_response.json()["status"] == "rejected"


def test_delete_request_with_valid_id():
    request_data = {
        "listing_id": 1,
        "requester_name": "Delete Test Student",
        "message": "Delete this request.",
    }

    create_response = client.post("/requests/", json=request_data)
    request_id = create_response.json()["id"]

    delete_response = client.delete(f"/requests/{request_id}")

    assert delete_response.status_code == 204