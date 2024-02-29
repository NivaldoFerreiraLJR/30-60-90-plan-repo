provider "aiven" {
  api_token = "+ymx/sHh/90+9IHlQpJIbR6loPWjUZz4F9O6ZNg3my+CdBO47bl4HL/7WLmCsViE+ZHlRlogmLaEGPXe8GK6PMNOpmKsOLrF84Tz3DXbb5CnQ/CTrjD19VoAf1oYYW2oKkmN4yyJqt1D9vKPRBztZQ3oTVYFk+rbsxKke4agPm4v1zMeaZQjbWFMQ8Gccg/rPpHqc4j6gzT3lovSSp1otwYVmsDyGdIb4EFQEs1AG0LTVGeJmAZV2ZJCvrrcGCDHzqoZEZJdjDmaTZ0IFadVtOEX7sNdmApwU9KPBqp68VDbWT9WQ+Z2LMq/7FwldMuBRBxga5ETZXaMYLfLv/aybLBZqhBKZd1M2YAkm6SrrHdQ19J5OrZdHlIE7048gQ=="
}

data "aiven_project" "public" {
  project = "wex-eventing-public"
}

data "aiven_kafka" "kafka1" {
  project      = data.aiven_project.public.project
  service_name = "wex-kafka-public"
}

resource "aiven_kafka_topic" "mytesttopic" {
  project                = data.aiven_project.public.project
  service_name           = data.aiven_kafka.kafka1.service_name
  topic_name             = "TestTopic"
  partitions             = 5
  replication            = 3
  termination_protection = false

  config {
    flush_ms                       = 10
    cleanup_policy                 = "compact,delete"
  }


  timeouts {
    create = "1m"
    read   = "5m"
  }
}