from kafka import KafkaConsumer

TOPIC_NAME = "TestTopic"

consumer = KafkaConsumer(
    TOPIC_NAME,
    bootstrap_servers=f"wex-kafka-public-wex-eventing-public.aivencloud.com:28545",
    client_id = "CONSUMER_CLIENT_ID",
    group_id = "CONSUMER_GROUP_ID",
    security_protocol="SSL",
    ssl_cafile="ca.pem",
    ssl_certfile="service.cert",
    ssl_keyfile="service.key",
)

while True:
    for message in consumer.poll().values():
        print("Got message using SSL: " + message[0].value.decode('utf-8'))