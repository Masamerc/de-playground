import uuid
import random

for i in range(1_000_000):
    name = uuid.uuid4().hex
    age = random.randint(1, 720)
    print('{},'.format((name,age)))
