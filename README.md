# automation-t2
Тестовое задание по автоматизации.


## Дано
Необходимо создать три веб сервера: один FrontEnd и два BackEnd.  
На FrontEnd Веб страничка, запрашивающая ввести два числа, и кнопка «Посчитать».  
Веб сервера на NGINX или Apache, страничка на PHP и/или Python, может что-нибудь своё, главное результат.


## Задание
1. При нажатии кнопки «Посчитать», FrontEnd сервер должен через первый BackEnd посчитать сумму чисел, а через второй их перемножение и отобразить результат.
2. На страничке необходимо отобразить имена серверов, на которых осуществлялись вычисления, причем имя сервера должен сообщить именно BackEnd.


## Условия реализации
1. Собрать докер образы для FrontEnd и BackEnd с "голой" ОС Linux.
2. Запустить контейнеры так, чтобы ими можно было управлять через Ansible.
3. Удаленно настроить сервера средствами Ansible.
4. Всё должно развернуться автоматически средствами Jenkins при пуше в GitHub.

## Решение

### Настройка связки GitHub, Jenkins, Docker, Ansible
1. Установил Jenkins, Docker и Ansible.
2. Связал Jenkins со своей учётной записью GitHub (создал *Personal access tokens* в GitHub и использовал его в Jenkins).
3. Создал SSH ключи для Ansible и добавил приватный ключ в Jenkins.
4. Задал путь к Ansible в Jenkins.
5. В Jenkins создал Job automation-t2 и настроил на этот репозиторий в GitHub.
6. Запуск задачи начинается с [Jenkinsfile](Jenkinsfile) файла, в котором используются команды для Docker-compose и Ansible.


### Создание Docker образа с "голой" ОС Linux и запуск контейнеров
Создан [Dockerfile](Dockerfile) с Debian 11, OpenSSH сервером, python3 и публичным ssh ключом Ansible.  
Также был создан [Docker-compose](docker-compose.yml) файл, в котором происходит сборка необходимых контейнеров и запуск SSH сервера.

### Настройка серверов с помощью Ansible
Настройка происходит посредством [плейбука](deploy.yml).  
Для FrontEnd сервера был использован Nginx с [конфигом и сайтом](front) из проекта [automation-t1](https://github.com/fogmorn/automation-t1).  
Для BackEnd серверов использовался [php-fpm](back/site.j2).

### Конечный результат
Выполнение задачи состоит из стадий описанных в [Jenkinsfile](Jenkinsfile) файле:
1. *Prebuild* - остановка существующих контейнеров и удаление volume.
2. *Build* - сборка контейнеров с использованием docker-compose.yml.
3. *Test* - используется [плейбук ping.yml](ping.yml) для проверки доступности серверов и возможности выполнения команд Ansible.
4. *Deploy* - настройка серверов средствами Ansible.


<details><summary>Веб страничка</summary>
  <img src="https://user-images.githubusercontent.com/49227124/147823885-0cf63be1-82cb-443a-addc-d64dcbf6ac6c.png" alt="automation-t1_result"/>
</details>

<details><summary>Добавление ключа в Jenkins</summary>
  <img src="https://user-images.githubusercontent.com/49227124/147830348-98a75786-6a45-4363-93b5-e5329812b4ce.png" alt="Jenkins_ansible_ssh_key"/>
</details>

<details><summary>Стадии сборки в Jenkins</summary>
  <img src="https://user-images.githubusercontent.com/49227124/147831683-8c2cb98b-67ba-49d6-85ec-04e5778c8c9d.png" alt="Jenkins_stage_view"/>
</details>
