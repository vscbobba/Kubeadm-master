resource "aws_instance" "kubeadm-master" {
  subnet_id          = data.terraform_remote_state.infrastructure.outputs.aws_pub_1
  ami                = "ami-09b0a86a2c84101e1"  # ubuntu in Mumbai
  instance_type      = "t2.medium"
  security_groups    = [data.terraform_remote_state.platform.outputs.aws_jum_sg]
  key_name           = "bobbascloud"
  
  tags = {
    name = "k8master"
  }

  # Provisioner to run remote commands
  provisioner "remote-exec" {
    inline = [
      "sudo swapoff -a; sudo sed -i '/swap/d' /etc/fstab",
      "echo -e 'overlay\nbr_netfilter' | sudo tee /etc/modules-load.d/k8s.conf",
      "sudo modprobe overlay",
      "sudo modprobe br_netfilter",
      # Write sysctl parameters using sudo
      "sudo sh -c 'echo -e \"net.bridge.bridge-nf-call-iptables = 1\\nnet.bridge.bridge-nf-call-ip6tables = 1\\nnet.ipv4.ip_forward = 1\" > /etc/sysctl.d/k8s.conf'",
      # Apply sysctl params without reboot"
      "sudo sysctl --system",
      "sudo apt update -y",
      "sudo apt-get install -y apt-transport-https ca-certificates curl",
      "curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg",
      "echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list",
      "sudo apt update -y",
      "sudo apt-get install -y kubelet kubeadm kubectl kubernetes-cni",
      "sudo apt install docker.io -y",
      "# Configuring containerd to ensure compatibility with Kubernetes",
      "sudo mkdir /etc/containerd",
      "sudo sh -c \"containerd config default > /etc/containerd/config.toml\"",
      "sudo sed -i 's/ SystemdCgroup = false/ SystemdCgroup = true/' /etc/containerd/config.toml",
      "sudo systemctl restart containerd.service",
      "sudo systemctl restart kubelet.service",
      "sudo systemctl enable kubelet.service",
      "sudo hostnamectl set-hostname K8s-Master",
      "sudo systemctl restart systemd-hostnamed",
      "sudo git clone https://github.com/vscbobba/Kubeadm-master.git"
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"  # Ensure this is correct for your AMI
      private_key = file("C:\\Users\\vbobba\\Downloads\\bobbascloud.pem")
    }
  }
}
