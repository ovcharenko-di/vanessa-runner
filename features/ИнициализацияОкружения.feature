# language: ru

Функционал: Инициализация репозитория и рабочего каталога проекта 1С
    Как разработчик
    Я хочу иметь возможность инициализировать репозиторий и рабочий каталог проекта 1С
    Чтобы выполнять коллективную разработку проекта 1С

Контекст:
    # Подготовка репозитория и рабочего каталога проекта 1С
    Допустим  я включаю отладку лога с именем "oscript.app.vanessa-runner"
    # Допустим  я включаю отладку лога с именем "bdd"
    Допустим Я создаю временный каталог и сохраняю его в контекст
    И Я устанавливаю временный каталог как рабочий каталог
    И Я инициализирую репозиторий git в рабочем каталоге

    Допустим Я создаю каталог "build/out" в рабочем каталоге
    И Я копирую файл "file.txt" из каталога "tests/fixtures" проекта в подкаталог "build/out" рабочего каталога
    И Я копирую файл "fixture.epf" из каталога "tests/fixtures" проекта в подкаталог "build/out" рабочего каталога
    И Я копирую каталог "cf" из каталога "tests/fixtures" проекта в рабочий каталог

    И Я установил рабочий каталог как текущий каталог

Сценарий: Проверка репозитория git
    Тогда В рабочем каталоге существует каталог ".git"

Сценарий: Инициализация рабочей базы по умолчанию в ./build/ib
    Когда Я сохраняю каталог проекта в контекст
    # Тогда Я показываю каталог проекта
    # И Я показываю рабочий каталог
    # И Я показываю текущий каталог
    
    Когда Я выполняю команду "oscript" с параметрами "<КаталогПроекта>/src/main.os init-dev --src ./cf --nocacheuse"
    И Я сообщаю вывод команды "oscript"
    Тогда Вывод команды "oscript" содержит "Обновление конфигурации базы данных успешно завершено"
    И Код возврата команды "oscript" равен 0
    И Файл "build/ib/1Cv8.1CD" существует
    И Файл "build/ibservice/1Cv8.1CD" не существует
    
    # И Файл "cf/Ext/OrdinaryApplicationModule.bsl" содержит 'Сообщить("Обычное приложение");'

Сценарий: Инициализация сервисной базы по умолчанию в ./build/ibservice
    
    Когда Я выполняю команду "oscript" с параметрами "<КаталогПроекта>/src/main.os init-dev --src ./cf --dev --nocacheuse"
    И Я сообщаю вывод команды "oscript"
    Тогда Вывод команды "oscript" не содержит "Обновление конфигурации базы данных"
    И Код возврата команды "oscript" равен 0
    И Файл "build/ibservice/1Cv8.1CD" существует
    И Файл "build/ib/1Cv8.1CD" не существует

Сценарий: Инициализация рабочей базы в отдельном каталоге
    
    Когда Я выполняю команду "oscript" с параметрами "<КаталогПроекта>/src/main.os init-dev --src ./cf --ibconnection /Fbuild/base1 --nocacheuse"
    И Я сообщаю вывод команды "oscript"
    Тогда Вывод команды "oscript" содержит "Обновление конфигурации базы данных успешно завершено"
    И Код возврата команды "oscript" равен 0
    И Файл "build/base1/1Cv8.1CD" существует
    И Файл "build/ib/1Cv8.1CD" не существует
    И Файл "build/ibservice/1Cv8.1CD" не существует
    
Сценарий: Инициализация сервисной базы в отдельном каталоге
    
    Когда Я выполняю команду "oscript" с параметрами "<КаталогПроекта>/src/main.os init-dev --src ./cf --dev  --ibconnection /Fbuild/base2 --nocacheuse"
    И Я сообщаю вывод команды "oscript"
    Тогда Вывод команды "oscript" не содержит "Обновление конфигурации базы данных"
    И Код возврата команды "oscript" равен 0
    И Файл "build/base2/1Cv8.1CD" существует
    И Файл "build/ibservice/1Cv8.1CD" не существует
    И Файл "build/ib/1Cv8.1CD" не существует

Сценарий: Инициализация рабочей базы и добавления ее в список баз пользователя.

    Когда Я выполняю команду "oscript" с параметрами "<КаталогПроекта>/src/main.os init-dev --src ./cf"
    И Я сообщаю вывод команды "oscript"
    Тогда Вывод команды "oscript" содержит "Обновление конфигурации базы данных успешно завершено"
    И Код возврата команды "oscript" равен 0
    И Файл "build/ib/1Cv8.1CD" существует
    И Файл "build/ibservice/1Cv8.1CD" не существует
    И В списке баз есть база по пути "<РабочийКаталог>/./build/ib"
    И В списке баз нахожу базу для проекта "<РабочийКаталог>"

Сценарий: Инициализация рабочей базы в каталоге вне репозитория git и добавление ее в список баз пользователя
    Допустим Я создаю временный каталог и сохраняю его в контекст
    И Я устанавливаю временный каталог как рабочий каталог
    Когда Я выполняю команду "oscript" с параметрами "<КаталогПроекта>/src/main.os init-dev --src ./cf"
    И Я сообщаю вывод команды "oscript"
    Тогда Вывод команды "oscript" содержит "Обновление конфигурации базы данных успешно завершено"
    И Код возврата команды "oscript" равен 0
    И Файл "build/ib/1Cv8.1CD" существует
    И Файл "build/ibservice/1Cv8.1CD" не существует
    И В списке баз есть база по пути "<РабочийКаталог>/./build/ib"
    И В списке баз нахожу базу для проекта "<РабочийКаталог>"

Сценарий: Инициализация рабочей базы по умолчанию с en языком в ./build/ib
    Когда Я сохраняю каталог проекта в контекст
    И Я выполняю команду "oscript" с параметрами "<КаталогПроекта>/src/main.os init-dev --src ./cf --nocacheuse --language en"
    И Я сообщаю вывод команды "oscript"
    Тогда Вывод команды "oscript" содержит "Database configuration successfully updated"
    И Код возврата команды "oscript" равен 0
    И Файл "build/ib/1Cv8.1CD" существует
    И Файл "build/ibservice/1Cv8.1CD" не существует

Сценарий: Обновление dev-базы ./build/ibservice на сервере в режиме реструктуризации -v2
    Когда Я сохраняю каталог проекта в контекст
    Когда Я выполняю команду "oscript" с параметрами "<КаталогПроекта>/src/main.os init-dev --src ./cf --nocacheuse --dev --v2"
    И Я сообщаю вывод команды "oscript"
    Тогда Вывод команды "oscript" содержит "Обновление конфигурации базы данных успешно завершено"
    И Код возврата команды "oscript" равен 0
