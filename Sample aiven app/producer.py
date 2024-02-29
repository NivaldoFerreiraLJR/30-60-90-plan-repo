import time
from kafka import KafkaProducer

TOPIC_NAME = "TestTopic"

producer = KafkaProducer(
    bootstrap_servers=f"wex-kafka-public-wex-eventing-public.aivencloud.com:28545",
    security_protocol="SSL",
    ssl_cafile="ca.pem",
    ssl_certfile="service.cert",
    ssl_keyfile="service.key",
)

for i in range(1):
    message = f"Python message test!"
    producer.send(TOPIC_NAME, message.encode('utf-8'))
    print(f"Message sent: {message}")
    time.sleep(1)

producer.close()