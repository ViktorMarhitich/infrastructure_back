output "jenkins_public_ip4" {
    value = aws_instance.jenkins_main.associate_public_ip_address
}

output "jenkins_private_dns" {
    value = aws_instance.jenkins_main.private_dns
}

output "jenkins_private_ip" {
    value = aws_instance.jenkins_main.private_ip
}

output "jenkins_public_dns" {
    value = aws_instance.jenkins_main.public_dns
}

output "jenkins_public_ip" {
    value = aws_instance.jenkins_main.public_ip
}
