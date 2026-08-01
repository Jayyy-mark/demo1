from flask_limiter import Limiter
from flask_limiter.util import get_remote_address

limiter = Limiter(
    key_func=get_remote_address,
    default_limits=["10000 per minute"],
    storage_uri="redis://10.23.23.93:6379",
)
