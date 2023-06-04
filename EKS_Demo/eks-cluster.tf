resource "aws_eks_cluster" "main" {
  name     = "${var.project_name}-cluster"
  role_arn = aws_iam_role.cluster.arn
  version  = "1.27"

  vpc_config {
    subnet_ids              = flatten([aws_subnet.public[*].id, aws_subnet.private[*].id])
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    name = "${var.project_name}-cluster"
  })

  depends_on = [
    aws_iam_role_policy_attachment.cluster_poicy_attachment
  ]
}

resource "aws_iam_role" "cluster" {
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  name               = "${var.project_name}-cluster-role"
  tags = merge(var.common_tags, {
    name = "${var.project_name}-cluster-role"
  })
}

resource "aws_iam_role_policy_attachment" "cluster_poicy_attachment" {
  role       = aws_iam_role.cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

/* flatten function combines multiple list of multiple objects into a single list */