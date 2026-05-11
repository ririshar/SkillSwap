from fastapi.testclient import TestClient
from backend.main import app

client = TestClient(app)


def test_invalid_endpoint_returns_404():
    response = client.get("/fakeendpoint/")

    assert response.status_code == 404


def test_get_single_invalid_request_returns_404():
    response = client.get("/requests/999999")

    assert response.status_code == 404