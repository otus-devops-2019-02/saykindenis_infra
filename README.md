# saykindenis_infra
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
