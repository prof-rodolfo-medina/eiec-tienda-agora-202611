import pytest

from app.config import get_environment, is_enabled
from app.version import get_commit, get_version

pytestmark = pytest.mark.unit


def test_flag_disabled_by_default(monkeypatch):
    monkeypatch.delenv("FEATURE_DISCOUNT_CODES", raising=False)

    assert is_enabled("discount_codes") is False


@pytest.mark.parametrize("value", ["true", "1", "yes", "ON"])
def test_flag_enabled_values(monkeypatch, value):
    monkeypatch.setenv("FEATURE_DISCOUNT_CODES", value)

    assert is_enabled("discount_codes") is True


def test_environment_defaults_to_local(monkeypatch):
    monkeypatch.delenv("APP_ENV", raising=False)

    assert get_environment() == "local"


def test_version_and_commit_come_from_environment(monkeypatch):
    monkeypatch.setenv("APP_VERSION", "1.2.3")
    monkeypatch.setenv("GIT_SHA", "abcdef1234567")

    assert get_version() == "1.2.3"
    assert get_commit() == "abcdef1"


def test_build_info_file_is_used_when_env_is_missing(monkeypatch, tmp_path):
    from app import version

    info = tmp_path / "build_info.json"
    info.write_text('{"version": "2.0.0", "commit": "1234567890"}', encoding="utf-8")
    monkeypatch.setattr(version, "BUILD_INFO", info)
    monkeypatch.delenv("APP_VERSION", raising=False)
    monkeypatch.delenv("GIT_SHA", raising=False)

    assert version.get_version() == "2.0.0"
    assert version.get_commit() == "1234567"
