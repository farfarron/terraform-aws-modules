########################################
# MÓDULO: ECS con Fargate y ALB
# Recursos incluidos:
# - ECS Cluster
# - ALB con SG vacío
# - Target Group en puerto 80
# - Task Definition tipo Fargate
# - ECS Service que conecta al ALB
# - Listener del ALB en puerto 80
########################################

# IAM Role para permitir a ECS Task Definitions usar recursos de AWS
resource "aws_iam_role" "ecs_execution" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

# Política administrada de AWS para el execution role
resource "aws_iam_role_policy_attachment" "ecs_execution_attach" {
  role       = aws_iam_role.ecs_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


# ECS Cluster lógico 
resource "aws_ecs_cluster" "this" {
  name = var.cluster_name
}

# Security Group para el ALB, permite tráfico HTTP desde cualquier parte (0.0.0.0/0)
resource "aws_security_group" "alb_sg" {
  name        = "alb-ecs-sg"
  description = "Security Group para ALB - Permite HTTP (puerto 80) desde cualquier IP"
  vpc_id      = var.vpc_id

  ingress {
    description = "Permitir trafico HTTP desde cualquier lugar (modificar para produccion)"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Permitir todo el trafico de salida"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# Application Load Balancer
resource "aws_lb" "alb" {
  name               = "ecs-alb"
  internal           = true     # Cambiar a false si se quiere de tipo internet facing
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.subnet_ids
}

# Target Group que recibirá tráfico en puerto 80
resource "aws_lb_target_group" "ecs_tg" {
  name        = "ecs-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Listener del ALB en puerto 80 apuntando al Target Group
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg.arn
  }
}

# Task Definition para ECS Fargate
resource "aws_ecs_task_definition" "app" {
  family                   = "fargate-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory = var.memory
  execution_role_arn       = aws_iam_role.ecs_execution.arn

  container_definitions = jsonencode([
    {
      name      = "web"
      image     = var.ecr_image_url
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
    }
  ])
}

# Servicio ECS con Fargate, asociado al Target Group
resource "aws_ecs_service" "app" {
  name            = "fargate-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.app.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets         = var.subnet_ids
    security_groups = [aws_security_group.alb_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs_tg.arn
    container_name   = "web"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.http]
}


