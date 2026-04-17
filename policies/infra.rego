package terraform.policies

# 1. Denegar si hay un Security Group con SSH abierto al mundo (0.0.0.0/0)
deny[msg] {
    resource := input.resource_changes[_]
    resource.type == "aws_security_group"
    ingress := resource.change.after.ingress[_]
    ingress.from_port == 22
    ingress.to_port == 22
    ingress.cidr_blocks[_] == "0.0.0.0/0"
    
    msg := "Violacion de Seguridad: No se permite el puerto 22 (SSH) abierto a 0.0.0.0/0"
}

# 2. Denegar si se intenta crear una EC2 que no sea t2.micro
deny[msg] {
    resource := input.resource_changes[_]
    resource.type == "aws_instance"
    resource.change.after.instance_type != "t2.micro"
    
    msg := "Violacion de Costos: Solo se permiten instancias de tipo t2.micro"
}
