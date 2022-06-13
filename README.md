# Vlashm_microservices
Vlashm microservices repository

## Домашнее задание 16

- Создана конфигурвция *terraform* для поднятия ВМ
- Написан плэйбук *ansible* для установки *Docker* на ВМ
- Запущен контейнер *gitlab-ce*. Пароль root для доступа получается выполнением на ВМ команды `sudo docker exec -it gitlab grep 'Password:' /etc/gitlab/initial_root_password`
- Выполнены все шаги основного ДЗ

### Задание со *

- Добавлен плэйбук для поднятия *Gitlab* на ВМ, также добавлен плэйбук для получения пароля root
- Добавлен плэйбук для запуска и регистрации *Gitlab-Runner*
- В пайплайн добавлены *build_docker_image* для сборки Docker образа с приложением и *start_docker_image* для запуска контейнера
- Настроено оповещение в Slack. https://app.slack.com/client/T6HR0TUP3/C037B9DPHS7

## Домашнее задание 15

- Выполнены задания по работе с сетями *Docker*
- Установлен *Docker-compose* и выполнена сборка образов приложения с его помощью.
- Внесены изменения в *docker-compose.yml* под кейс с множеством сетей, сетевых алиасов
- Параметризированны:
    - Логин пользователя в *Docker Hub*
    - Порт приложения
    - Версии приложений
    - Драйвер сетей
- Базовое имя проекта берется из директории, в которой находится файл *docker-compose.yml*. Изменить имя проекта можно, запустив *docker-compose* с флагом *-p* (или *--project-name*) или задав переменную окружения *COMPOSE_PROJECT_NAME*

### Задвние со *

Создан файл *docker-compose.override.yml* внесены изменения:
- Чтобы изменять код каждого из приложений, не выполняя сборку образа дректорию с кодом необходимо подключить к *volume*
- Чтобы запускать puma для руби приложений в дебаг режиме с двумя воркерами добавлена команда *command*.


## Домашнее задание 14

- Приложение разбито на несколько контейнеров
- Создан и подключен *Docker volume*

### Задание со *

Запуск контейнеров с другими сетевыми алиасами:

    docker run -d --network=reddit \
    --network-alias=post_db_new \
    --network-alias=comment_db_new \
    mongo:latest

    docker run -d --network=reddit \
    --network-alias=post_new \
    --env POST_DATABASE_HOST='post_db_new' \
    vlashm/post:1.0

    docker run -d --network=reddit \
    --network-alias=comment_new \
    --env COMMENT_DATABASE_HOST='comment_db_new' \
    vlashm/commentdocker network create reddit
docker volume create reddit_db='post_new' \
    --env COMMENT_SERVICE_HOST='comment_new' \
    -p 9292:9292 \
    vlashm/ui:1.0

### Задание со *

Оптимизированы образы в файлах *Dockerfile.1*

    REPOSITORY       TAG            IMAGE ID       CREATED          SIZE
    vlashm/post      2.0            f8b71a4b3d93   13 seconds ago   115MB
    vlashm/comment   2.0            18dd6cd8ee31   29 minutes ago   145MB
    vlashm/ui        3.0            376c75a47a2c   37 minutes ago   147MB
    vlashm/ui        2.0            6abaf03a746c   20 hours ago     463MB
    vlashm/post      1.0            568e266d7ade   20 hours ago     121MB
    vlashm/ui        1.0            e34424adecb6   20 hours ago     772MB
    vlashm/comment   1.0            18cd3816e17f   21 hours ago     770MB


## Домашнее задание 12 и 13

- Установлен Docker
- С помощью Docker machine создан Docker хост в YC
- Создан образ с приложением и базой данных.
- Из созданного образа запущен контейнер.
- Образ загружен на Docke Hub

### Задание со *

В директории *docker-monolith/infra* созданы прототипы:
- Ansible:
    - Плэйбук *install_docker.yml* для установки Docker
    - Плэйбук *install_app.yml* для запуска созданного образа
    - Подключен динамический инвентарь *yc_compute*
- Packer:
    - Создает *image* с установленным Docker
- Terraform:
    - Поднимает инстансы в заданном количестве
