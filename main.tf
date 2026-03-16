# Create a cluster
resource "kind_cluster" "default" {
    name = "test-cluster"
}