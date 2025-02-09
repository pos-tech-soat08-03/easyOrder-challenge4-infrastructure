resource "aws_eks_node_group" "node-group" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "node-group-${var.clusterName}"

  node_role_arn = data.aws_iam_role.labrole.arn
  subnet_ids    = module.vpc.private_subnets

  instance_types = [var.instanceType]

  # t3.medium tem 2 vcpu e 4gb de ram cada.
  # Equivale a 2000m (milicores)
  # banco está configurado de 500m a 1000m
  # Cada app tem 250m a 500m
  # Temos 3 apps e 3 banco
  scaling_config {
    desired_size = 3 #(500*3)+(250*3) = 2250m = 2.25 vcpu
    max_size     = 5 #(1000*3)+(500*3) = 4500m = 4.5 vcpu
    min_size     = 2 #(500*3)+(250*3) = 2250m = 2.25 vcpu
  }

  depends_on = [aws_eks_cluster.eks-cluster]

}


