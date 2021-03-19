# Ios Gallery version 1
- [Description in English](#Description-in-English)
    - [About the project](#About-the-project)
    - [Features](#Features)
    - [Further development](#Further-development)
- [Описание на русском](#Описание-на-русском)
  - [О проекте](#О-проекте)
  - [Особенности](#Особенности)
  - [Дальнейшее развитие](#Дальнейшее-развитие)

## Description in English
### About the project
**Ios Gallery version 1** - is the first test and demonstration project for my Github account. It is a photo gallery for the iOS mobile OS with *the following features:*
- [x] Sign up
- [x] Login the account
- [x] Viewing the gallery
- [x] Search option
- [x] localization
- [x] Uploading new images 
- [x] Viewing User images
- [x] Account Settings
- [x] Changing the color theme
- [x] **And others**
### Features
This [**API**](http://gallery.dev.webant.ru/api) was used for development. In case it is unavailable, there is a login button as the test user and switching to local test images in **debug** mode.
The feature of the first version is **Clean + MVP** architecture and the use of a little-known library for working with the network [RxNetworkApiClient](https://github.com/Starmel/RxNetworkApiClient).
The CocoaPods dependency manager was used to install the dependencies. To install them use the command
```ruby
pod install
```
in the main project folder.
**Podfile** consists of:
| Dependency | Link |
| ------ | ------ |
| RxNetworkApiClient | https://github.com/Starmel/RxNetworkApiClient |
| Kingfisher | https://github.com/onevcat/Kingfisher |
| R.swift | https://github.com/mac-cain13/R.swift |
| DITranquillity | https://github.com/ivlevAstef/DITranquillity |
| IQKeyboardManager | https://github.com/hackiftekhar/IQKeyboardManager |
| CocoaDebug | https://github.com/CocoaDebug/CocoaDebug |
| DBDebugToolkit | https://github.com/dbukowski/DBDebugToolkit |
### Further development
I have plans to continue working on this project because it allows me to improve my skills, but this will be in the next versions of Ios Gallery. In the beginning, I wanted to make a branch from this project and redo everything on a more popular framework for interacting with the network or in general on URLSession, but I realized that I would have to redo almost everything. During my time working with this project, I have improved my skills on real tasks and rethought many of the things done in it.

## Описание на русском
### О проекте
**Ios Gallery version 1** - первый тестовый и показательный проект для моего Github аккаунта. Он представляет собой галерею фотографий, для мобильной ОС IOS *с возможностью:*
- [x] Регистрации
- [x] Входа в аккаунт
- [x] Просмотр галереи
- [x] Поиска
- [x] Локализации
- [x] Загрузке новых изображений 
- [x] Просмотр изображений пользователя
- [x] Настроек аккаунта
- [x] Смены темы
-  **И другие**
### Особенности
Для разработки использовалось это [**API**](http://gallery.dev.webant.ru/api). В случае его недоступности в **debug** режиме присутствует кнопка входа под тестовым пользователем и переключение на локальные тестовые изображения.
Особенность первой версии заключается в архитектуре **Clean + MVP** и использовании малоизвестной библиотеки для работы с сетью [RxNetworkApiClient](https://github.com/Starmel/RxNetworkApiClient).
Для установки зависимостей использовался менеджер зависимостей [CocoaPods](https://cocoapods.org). Чтобы установить их используйте команду
```ruby
pod install
```
в главной папке проекта.
**Podfile** состоит из:
| Dependency | Link |
| ------ | ------ |
| RxNetworkApiClient | https://github.com/Starmel/RxNetworkApiClient |
| Kingfisher | https://github.com/onevcat/Kingfisher |
| R.swift | https://github.com/mac-cain13/R.swift |
| DITranquillity | https://github.com/ivlevAstef/DITranquillity |
| IQKeyboardManager | https://github.com/hackiftekhar/IQKeyboardManager |
| CocoaDebug | https://github.com/CocoaDebug/CocoaDebug |
| DBDebugToolkit | https://github.com/dbukowski/DBDebugToolkit |
### Дальнейшее развитие
У меня в планах и дальше заниматься эим проектом потому что он позволяет мне прокачивать свои навыки, однако уже в следующих версиях Ios Gallery. В начале я хотел сделать ветку от этого проекта и переделать все на более популярном фреймворке для взаимодействи с сетью или вообще на URLsession, но я осознал, что переделывать прийдется почти все. За время работы с этим проектом я прокачал свои навыки на реальных задачах и переосмыслил многие вещи, сделанные в нем.
