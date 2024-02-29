provider "kubernetes" {
  config_path = "~/.kube/config"
  config_context_cluster = "minikube"
}


resource "kubernetes_stateful_set" "kafka" {
  metadata {
    name = "kafka"
  }
  
  spec {
    replicas = 3
    service_name = "kubernetes_stateful_set.kafka.metadata.0.labels"


    selector {
      match_labels = {
        app = "kafka"
      }
    }

    template {
      metadata {
        labels = {
          app = "kafka"
        }
      }
      spec {
        container {
          name  = "kafka"
          image = "confluentinc/cp-kafka:latest"
          
          port {
            container_port = 9092
          }
          env {
            name  = "KAFKA_ADVERTISED_LISTENERS"
            value = "PLAINTEXT://$(POD_IP):9092"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "kafka" {
  metadata {
    name = "kafka"
  }
  spec {
    
    port {
      port        = 9092
      target_port = 9092
    }
  }
}

