import redis

r = redis.Redis(
    host="10.23.23.93",
    port=6379,
    decode_responses=True
)

print(r.ping())