# saykindenis_infra

Homework 6

Create GCP instance with predefined app configuration specified in startup-script.sh

gcloud compute instances create reddit-app3 \
       --boot-disk-size=10GB \
       --image-family ubuntu-1604-lts \
       --image-project=ubuntu-os-cloud \
       --machine-type=g1-small \
       --tags puma-server \
       --restart-on-failure \
       --metadata startup-script-url=gs://infrabucket/startup-script.sh

Allowing port access on GCP firewall

gcloud compute firewall-rules create puma-server-tcp9292 \
      --action allow \
      --target-tags puma-server \
      --source-ranges 0.0.0.0/0 \
      --rules tcp:9292

testapp_IP = 35.204.80.241
testapp_port = 9292


Homework 5


saykindenis Infra repository

Connect with one command:
ssh -i ~/.ssh/appuser -A -t appuser@35.204.213.84 ssh 10.164.0.4




Connect with alias by editing ~/.ssh/config file:

Host bastion
	Hostname 35.204.213.84
	User appuser
	IdentityFile ~/.ssh/appuser
	ForwardAgent yes

Host someinternalhost
	Hostname 10.164.0.4
	User appuser
	ProxyCommand ssh -i ~/.ssh/appuser bastion -W %h:%p


bastion_IP = 35.204.213.84
someinternalhost_IP = 10.164.0.4
