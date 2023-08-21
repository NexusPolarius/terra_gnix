# terra_gnix

ДЗ первый терраформ скрипт.

## На вашей выполняющей машине(с ОС Linux Ubunta) должны быть выполнены следующие действия:
* установить terraform
* установить ansible
* подготовить Yndex Cloud к работе и установить интерфейс командной строки YC  
* выполнить команду "ssh-keygen -t ed25519 -f ~/.ssh/gnix"
* выполнить команду "export YC_TOKEN=$(yc iam create-token)"
* выполнить команду "export TF_VAR_yc_token=$YC_TOKEN"
* выполнить команду "git clone "
* перейти в каталог склонированного проекта
* выполнить команду "terraform plan"
* выполнить команду "terraform aplay" и подтвердить выполнение командой "yes"
* перейти в браузере по адресу указанному в Outputs параметре "external_ip_address_instance"
