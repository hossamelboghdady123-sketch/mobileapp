resource "aws_eks_cluster" "taskflow" {
  name     = "taskflow-prod"
  role_arn = "arn:aws:iam::141899078985:role/eksctl-taskflow-prod-cluster-ServiceRole-N7y41ZKck2kS"
  version  = "1.34"

  vpc_config {
    subnet_ids = [
      "subnet-021934e918c2541c6",
      "subnet-023d3fac7e9b4d349",
      "subnet-03f9a4ff76077b92a",
      "subnet-05f55ff0dc93d66d3",
      "subnet-0812e0d3aba4bbfcc",
      "subnet-0eab3260fc685a0c0"
    ]

    security_group_ids = [
      "sg-0b2aaaaec1a75c20e"
    ]

    endpoint_private_access = false
    endpoint_public_access  = true

    public_access_cidrs = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name                                          = "eksctl-taskflow-prod-cluster/ControlPlane"
    "alpha.eksctl.io/cluster-name"                = "taskflow-prod"
    "alpha.eksctl.io/cluster-oidc-enabled"        = "false"
    "alpha.eksctl.io/eksctl-version"              = "0.229.0"
    "eksctl.cluster.k8s.io/v1alpha1/cluster-name" = "taskflow-prod"
  }
}

resource "aws_eks_node_group" "workers" {
  cluster_name    = "taskflow-prod"
  node_group_name = "taskflow-workers"
  node_role_arn   = "arn:aws:iam::141899078985:role/eksctl-taskflow-prod-nodegroup-tas-NodeInstanceRole-kVbbOzSBeYn2"

  subnet_ids = [
    "subnet-0812e0d3aba4bbfcc",
    "subnet-03f9a4ff76077b92a",
    "subnet-021934e918c2541c6"
  ]

  instance_types = ["t3.micro"]

  scaling_config {
    desired_size = 3
    min_size     = 3
    max_size     = 3
  }

  labels = {
    "alpha.eksctl.io/cluster-name"   = "taskflow-prod"
    "alpha.eksctl.io/nodegroup-name" = "taskflow-workers"
  }

  tags = {
    "alpha.eksctl.io/cluster-name"                = "taskflow-prod"
    "alpha.eksctl.io/eksctl-version"              = "0.229.0"
    "alpha.eksctl.io/nodegroup-name"              = "taskflow-workers"
    "alpha.eksctl.io/nodegroup-type"              = "managed"
    "eksctl.cluster.k8s.io/v1alpha1/cluster-name" = "taskflow-prod"
  }

  launch_template {
    id      = "lt-0b507b14aa6d375a5"
    version = "1"
  }
}

resource "aws_eks_node_group" "workers_small" {
  cluster_name    = "taskflow-prod"
  node_group_name = "taskflow-workers-small"
  node_role_arn   = "arn:aws:iam::141899078985:role/eksctl-taskflow-prod-nodegroup-tas-NodeInstanceRole-dyPhgAXUlEyg"

  subnet_ids = [
    "subnet-021934e918c2541c6",
    "subnet-03f9a4ff76077b92a",
    "subnet-0812e0d3aba4bbfcc"
  ]

  instance_types = ["t3.small"]

  scaling_config {
    desired_size = 3
    min_size     = 3
    max_size     = 3
  }

  labels = {
    "alpha.eksctl.io/cluster-name"   = "taskflow-prod"
    "alpha.eksctl.io/nodegroup-name" = "taskflow-workers-small"
  }

  tags = {
    "alpha.eksctl.io/cluster-name"                = "taskflow-prod"
    "alpha.eksctl.io/eksctl-version"              = "0.229.0"
    "alpha.eksctl.io/nodegroup-name"              = "taskflow-workers-small"
    "alpha.eksctl.io/nodegroup-type"              = "managed"
    "eksctl.cluster.k8s.io/v1alpha1/cluster-name" = "taskflow-prod"
  }

  launch_template {
    id      = "lt-0a699e7bbff412c39"
    version = "1"
  }
}
