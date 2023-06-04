resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.project_name}-node-group"
  subnet_ids      = aws_subnet.private[*].id
  node_role_arn   = aws_iam_role.node.arn

  ami_type       = "AL2_x86_64"
  disk_size      = 20
  capacity_type  = "ON_DEMAND"
  instance_types = ["t2.medium"]

  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 5
  }

  update_config {
    max_unavailable = 1
  }

  provisioner "local-exec" {
    on_failure = continue
    command    = "aws eks update-kubeconfig --name Demo-EKS-cluster --region ap-south-1 --profile terraformprofile"
  }

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-node-group"
  })

  depends_on = [
    aws_iam_role_policy_attachment.node_eksworkernode
  ]
}

resource "aws_iam_role" "node" {
  name               = "${var.project_name}-node-group-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_node.json

  tags = merge(var.common_tags, {
    name = "${var.project_name}-node-group-role"
  })
}

resource "aws_iam_role_policy_attachment" "node_eksworkernode" {
  for_each   = var.eks_node_role_policies
  role       = aws_iam_role.node.name
  policy_arn = each.value
}