# Vlashm_microservices
Vlashm microservices repository

## Домашнее задание 12

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
