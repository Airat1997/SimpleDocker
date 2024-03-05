[Part 1. Готовый докер](#part-1-готовый-докер)\
[Part 2. Операции с контейнером](#part-2-операции-с-контейнером)\
[Part 3. Мини веб-сервер](#part-3-мини-веб-сервер)\
[Part 4. Свой докер](#part-4-свой-докер)\
[Part 5. Dockle](#part-5-dockle)\
[Part 6. Базовый Docker Compose](#part-6-базовый-docker-compose)
## Part 1. Готовый докер
- Скачиваем докер-образ :whale: nginx с докер-хаба командой ***docker pull nginx***:\
![Part1](images/Part1.1.png)
- Проверяем наличие докер-образа :whale: через команду ***docker images***:\
![Part1](images/Part1.2.png)
- Запускаем докер-образ :whale: через команду ***docker run -d [image_id|repository]***(ввод полного id необязателен достаточно вести первые несколько символов):\
![Part1](images/Part1.3.png)
- Проверяю, что образ запустился через ***docker ps***:\
![Part1](images/Part1.4.png)
- Смотрю информацию о контейнере через ***docker inspect [container_id|container_name]***:\
![Part1](images/Part1.5.png)
![Part1](images/Part1.6.png)
![Part1](images/Part1.7.png)
- Размер контейнера:\
![Part1](images/Part1.8.png)
- Список замапленных портов:\
![Part1](images/Part1.9.png)
- ip контейнера:\
![Part1](images/Part1.10.png)
- Останавливаем докер образ через ***docker stop [container_id|container_name]*** :grin: :\
![Part1](images/Part1.11.png)
- Проверяем остановку докер образа командой ***docker ps*** :joy: :\
![Part1](images/Part1.12.png)
- Запускаем докер с портами 80 и 443 в контейнере, замапленными на такие же порты на локальной машине, через команду ***docker run -p 80:80 -p 443:443 nginx***:
![Part1](images/Part1.13.png)
- Проверяем, что в браузере по адресу localhost:80 доступна стартовая страница nginx:
![Part1](images/Part1.14.png)
- Перезапускаем докер контейнер через ***docker restart [container_id|container_name]***:
![Part1](images/Part1.15.png)
- Проверяю, что образ запустился через ***docker ps***:\
![Part1](images/Part1.16.png)
## Part 2. Операции с контейнером
- Читаем конфигурационный файл nginx.conf внутри докер контейнера через команду ***docker exec id cat /etc/nginx/nginx.conf***:
![Part2](images/Part2.1.png)
- Создаем на локальной машине файл ***vim nginx.conf***(взял файл nginx.conf с контейнера):
![Part2](images/Part2.2.png)
- Настриваем в нем по пути /status отдачу страницы статуса сервера nginx:\
![Part2](images/Part2.3.png)
- Копируем созданный файл nginx.conf внутрь докер-образа через команду ***docker cp***:
![Part2](images/Part2.4.png)
- Перезапускаем nginx внутри докер-образа через команду exec:
![Part2](images/Part2.5.png)
- Проверяем, что по адресу localhost:80/status отдается страничка со статусом сервера nginx:
![Part2](images/Part2.6.png)
- Экспортируем контейнер в файл container.tar через команду ***docker export id > container.tar***:
![Part2](images/Part2.7.png)
- Останавливаем контейнер:\
![Part2](images/Part2.8.png)
- Удаляем образ через ***docker rmi [image_id|repository]***, не удаляя перед этим контейнеры:
![Part2](images/Part2.9.png)
- Удаляю остановленный контейнер:\
![Part2](images/Part2.10.png)
- Импортирую контейнер обратно через команду ***docker import -c 'CMD ["nginx", "-g", "daemon off;"]' container.tar nginx_import***:
![Part2](images/Part2.11.png)
- Запускаем импортированный контейнер ***docker run -d -p 80:80 -p 443:443 nginx_import***:
![Part2](images/Part2.12.png)
- Проверяем, что по адресу localhost:80/status отдается страничка со статусом сервера nginx:
![Part2](images/Part2.13.png)
- Содержимое nginx.conf:
![Part2](images/Part2.14.png)
## Part 3. Мини веб-сервер
- Скачиваю образ nginx:
![Part3](images/Part3.1.png)
- Запускаем образ с прослушкой 81 порта:
![Part3](images/Part3.2.png)
- Копируем nginx.conf в /etc/nginx
![Part3](images/Part3.3.png)
- Переходим в контейнер ***docker exec -it 6039 bash***:\
![Part3](images/Part3.4.png)
- Обновляем репозиторий:
![Part3](images/Part3.5.png)
- Устанавливаем gcc:\
![Part3](images/Part3.6.png)
- Устанавливаем spawn-fcgi:
![Part3](images/Part3.7.png)
- Устанавливаем libfcgi:
![Part3](images/Part3.8.png)
- Копируем наш файл miniserver.c в контейнер:
![Part3](images/Part3.9.png)
- Компилируем наш файл miniserver.c:
![Part3](images/Part3.10.png)
- Запускаем написанный мини-сервер через spawn-fcgi на порту 8080 и перезапускаем nginx:
![Part3](images/Part3.11.png)
- Проверяем, что в браузере по localhost:81 отдается запись Hello World!:\
![Part3](images/Part3.12.png)
## Part 4. Свой докер
- Создаю докер образ на основе nginx. Cобираю исходники мини сервера на FastCgi из Части 3 и помещаю их в папку /home. Помещаю скрипт run.sh в папку /home.
- Устанавливаю нужные утилиты для запуска минисервера.
- Командой ENTRYPOINT(этой командой я указываю на первую команду которая будет выполнятся при запуске контейнера) запускаю скрипт run.sh. Данный скрипт запускает минисервер на 8080 порту и запускает nginx также запускает утилиту tail которая предотвратит закрытие контейнера после запуска.
- Содержимое полученного докерфайла:
![Part4](images/Part4.1.png)
- Собираем образ командой ***docker build -t part4*** :hammer: :
![Part4](images/Part4.2.png)
- Проверяем через ***docker images***, что все собралось корректно:
![Part4](images/Part4.3.png)
- Запускаем собранный докер-образ с маппингом 81 порта на 80 на локальной машине и маппингом папки ./nginx внутрь контейнера по адресу, где лежат конфигурационные файлы nginx'а :hammer: :
![Part4](images/Part4.4.png)
- Проверяем, что по localhost:80 доступна страничка написанного мини сервера :ok_hand: :
![Part4](images/Part4.5.png)
- Дописываем :black_nib: в ./nginx/nginx.conf(нужно установить vim) проксирование странички /status, по которой надо отдавать статус сервера nginx:\
![Part4](images/Part4.6.png)
- Перезапускаем докер-образ:\
![Part4](images/Part4.7.1.png)
- Теперь проверяем, что по localhost:80/status отдается страничка со статусом nginx :ok_hand: :
![Part4](images/Part4.8.png)
- Содержимое run.sh:\
![Part4](images/Part4.9.png)
## Part 5. Dockle
- Устанавливаем ***brew install goodwithtech/r/dockle***:
![Part5](images/Part5.1.png)
- Сканируем образ из предыдущего задания через ***dockle [image_id|repository]***:
![Part5](images/Part5.2.png)
- Чтобы исправить WARN - DKL-DI-0006 нужно при билдинге образа добавить версию образа ***docker build -t tag part4:1***
- Чтобы исправить WARN - DKL-DI-0003 нужно в докерфайле заменить apt-get на apt
- Чтобы исправить WARN - CIS-DI-0001 нужно в докерфайле добавить пользователя для контейнера(последний пользователь не должен быть рутом)
- Чтобы исправить FATAL	- DKL-DI-0005 нужно в докерфайле добавить команду для очистки кэша
- Чтобы исправить FATAL	- CIS-DI-0010 нужно проверять образ с флагами которые будут игнорировать NGINX_GPGKEY и NGINX_GPGKEY_PATH ***dockle -ak NGINX_GPGKEY -ak NGINX_GPGKEY_PATH part4:1***
- Ошибок и предупреждений нету:
![Part5](images/Part5.3.png)
- Исправленный докерфайл:
![Part5](images/Part5.4.png)
## Part 6. Базовый Docker Compose
- Написал docker-compose.
- Здесь поднимается докер-контейнер из Части 5\
![Part6](images/Part6.1.png)
- Здесь поднимается  докер-контейнер с nginx. Там же замапливаю порты 8080 порт контейнера на 80 порт локальной машины
![Part6](images/Part6.2.png)
- Добовляю настройку в nginx.conf для того чтобы проксировать все запросы с 8080 порта на 81 порт первого контейнера:
![Part6](images/Part6.3.png)
- Остановил все запущенные контейнеры:
![Part6](images/Part6.4.png)
- Собираю и запускаю проект с помощью команд ***docker-compose build*** и ***docker-compose up***:
![Part6](images/Part6.5.png)
- По localhost:80 отдается написанная мной страничка, как и ранее:
![Part6](images/Part6.6.png)