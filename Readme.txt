Infra setup:

git clone https://github.com/vscbobba/Kubeadm-master.git

cd Kubeadm-master/Infrastructure/
terraform init -backend-config=dev-infra.config
terraform apply -var-file=dev-infra.tfvars -auto-approve

cd ../Platform
terraform init -backend-config=dev-platform.config
terraform apply -var-file=dev-platform.tfvars -auto-approve

cd ../Application
terraform init -backend-config=dev-app.config
terraform apply -var-file=dev-app.tfvars -auto-approve

Login to K8-Master: run commands in k8master.txt file, copy join/token cmd 
login to K8-worker: run the join/token cmd

again from K8-Master: got to git repo clong directory and run 
                           kubectl apply -f '*.yaml'

http://<public Ip of Worker or Master>:30000
