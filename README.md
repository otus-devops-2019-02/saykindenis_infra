# saykindenis_infra
Домашняя работа 12
Плейбуки перенесены в отдельные роли
Описаны два окружения (stage&prod)
Использована комьюнити роль nginx, настроено обратное проксирование.
Настроен Ansible Vault для обоих окружений

Домашняя работа 11
Использованы плейбуки, хендлеры и шаблоны для конфигурации окружения и деплоя тестового приложения.
Изменен провижн образов Packer с bash на Ansible

Домашняя работа 10
Познакомился с базовым функционалом ansible.

Выполнение плейбука вернется со статусом changed=0, если директория уже существует. Удаление директории и последующий запуск плэйбука завершается с changed=1


Домашняя работа 8

Создан инстанс с помощью Terraform
После выполнения terraform apply добавленные вручную в web-интерфейсе ключи удаляются.
terraform fmt форматирует конфигурационные файлы


Домашняя работа 7

С помощью packer создан и размещен в GCP образ Reddit-base
Создан и размещен образ Reddit-full с использованием параметризированного шаблона immutable.json
Создан скрипт автоматического развертывания инстанса из образа Reddit-full
Все сто раз поперетестировано и узнано много интересного.


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
