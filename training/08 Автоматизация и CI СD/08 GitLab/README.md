# Домашнее задание к занятию «GitLab»

---

### Задание 1

**Что нужно сделать:**

1. Разверните GitLab локально, используя Vagrantfile и инструкцию, описанные в [этом репозитории](https://github.com/netology-code/sdvps-materials/tree/main/gitlab).   
2. Создайте новый проект и пустой репозиторий в нём.
3. Зарегистрируйте gitlab-runner для этого проекта и запустите его в режиме Docker. Раннер можно регистрировать и запускать на той же виртуальной машине, на которой запущен GitLab.

В качестве ответа в репозиторий шаблона с решением добавьте скриншоты с настройками раннера в проекте.

Установка Gitlab CE на голую систему:

```bash
sudo apt update && sudo apt upgrade -y
sudo apt-get install -y curl openssh-server ca-certificates tzdata perl
cd /tmp
curl -LO https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh
sudo bash script.deb.sh
sudo apt install gitlab-ce
# после установки заходим и редактируем
sudo nano /etc/gitlab/gitlab.rb
# external_url ‘http:// ip или доменное имя’
sudo gitlab-ctl reconfigure
```

Входим http:// ip  
Логин: root  
Пасс находится по адресу /etc/gitlab/initial_root_password  
Зарегистрируйте gitlab-runner для этого проекта и запустите его в режиме Docker.  
Сброс пароля:  
```
sudo gitlab-rake "gitlab:password:reset"
```
Полезные команды:  
```bash
gitlab-ctl stop
gitlab-ctl reconfigure
gitlab-ctl restart
gitlab-ctl status
sudo gitlab-ctl tail postgresql
```
Подготовку задания докера по [инструкции](https://github.com/AlkoHead/Neto/blob/main/training/08%20Автоматизация%20и%20CI%20СD/08%20GitLab/GITLAB.md)   

Общие моменты  
Установка gitlab-runner:  
```bash
curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | sudo bash
sudo apt install gitlab-runner
sudo gitlab-runner register
```
![runner_reg01](img/runner_reg01.JPG)  

**Из докера**
```bash
docker run -d --name gitlab-runner --restart always \
  -v /srv/gitlab-runner/config:/etc/gitlab-runner \
  -v /var/run/docker.sock:/var/run/docker.sock \
  gitlab/gitlab-runner:latest

docker ps
# заходим в контейнер
sudo docker exec -ti gitlab-runner bash
# регестрируемся
```
![runner_reg02](img/runner_reg02.JPG)  
Из GitLab  
![runner_gitlab](img/runner_gitlab.JPG)

---

### Задание 2

**Что нужно сделать:**

1. Запушьте [репозиторий](https://github.com/netology-code/sdvps-materials/tree/main/gitlab) на GitLab, изменив origin. Это изучалось на занятии по Git.
2. Создайте .gitlab-ci.yml, описав в нём все необходимые, на ваш взгляд, этапы.

В качестве ответа в шаблон с решением добавьте: 
   
 * файл gitlab-ci.yml для своего проекта или вставьте код в соответствующее поле в шаблоне; 
 * скриншоты с успешно собранными сборками.
 
```bash
git clone https://github.com/netology-code/sdvps-materials.git
# преходим в клонированную папку
cd sdvps-materials/
git status
git remote -v
# изменяем origin 
git remote add my_gitlab http://192.168.1.116/root/my_project.git
git remote -v
```
![new_remote](img/new_remote.JPG)  
```bash
git push my_gitlab
```
![push_project](img/push_project.JPG)  

![add_gitlab-ci](img/add_gitlab-ci.JPG)  

![pipelines_create](img/Pipelines_create.JPG)  

---

## Дополнительные задания* (со звёздочкой)

Их выполнение необязательное и не влияет на получение зачёта по домашнему заданию. Можете их решить, если хотите лучше разобраться в материале.

---

### Задание 3*

Измените CI так, чтобы:

 - этап сборки запускался сразу, не дожидаясь результатов тестов;
 - тесты запускались только при изменении файлов с расширением *.go.

В качестве ответа добавьте в шаблон с решением файл gitlab-ci.yml своего проекта или вставьте код в соответсвующее поле в шаблоне.
