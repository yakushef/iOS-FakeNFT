Кашников Антон Сергеевич
<br /> Когорта: 6
<br /> Группа: 6
<br /> Эпик: Профиль
<br /> Ссылка на доску: https://github.com/users/prostokot14/projects/4/views/1
<hr>

# Profile Flow Decomposition
## Module 1 (est 450 min; fact 470 min).
### Экран Профиль:
#### Вёрстка
- Navigation-bar с кнопкой редактирования профиля (est: 30 min; fact: 30 min).
- Container-view с информацией о пользователе: фото профиля, имя и био (est: 120 min; fact: 120 min).
- TableView с 3-мя ячейками: "Мои NFT", "Избранные NFT" и "О разработчике" (est: 60 min; fact: 30 min).
`Total:` est: 210 min; fact: 180 min).
#### Логика
- Переход на экран редактирования профиля (est: 30 min; fact: 20 min).
`Total:` est: 30 min; fact: 20 min.

### Экран Редактирование профиля:
#### Вёрстка
- Кнопка закрытия экрана редактирования профиля (est: 30 min; fact: 30 min).
- Фото профиля (est: 30 min; fact: 60 min).
- Labels: Имя, Описание, Сайт (est: 60 min; fact: 40 min).
- TextFields для каждого label (est: 60 min; fact: 120 min).
`Total:` est: 180 min; fact: 250 min).
#### Логика
- Закрытие экрана редактирования профиля (est: 30 min; fact: 20 min).
`Total:` est: 30 min; fact: 20 min).

## Module 2 (est 570 min; fact x min).
### Экран Профиль:
#### Логика
- Открытие экрана с webView при нажатии на ссылку сайта (est: 60 min; fact: x min).
- Переход на экран "Мои NFT" (est: 60 min; fact: x min).
- Переход на экран "Избранные NFT" (est: 60 min; fact: x min).
- Переход на экран "О разработчике" (est: 60 min; fact: x min).
`Total:` est: 240 min; fact: x min.

### Экран Редактирование профиля:
#### Логика
- Изменение фотографии профиля (загрузка нового изображения из галереи пользователя (est: 120 min; fact: x min).
`Total:` est: 120 min; fact: x min.

### Экран Мои NFT:
#### Вёрстка
- Navigation-bar с заголовком, кнопкой "назад" и кнопкой сортировки (est: 60 min; fact: x min).
- TableView со списком NFT (est: 30 min; fact: x min).
- Переиспользуемая ячейка таблицы с иконкой NFT, названием, автором и ценой (est: 120 min; fact: x min).
`Total:` est: 210 min; fact: x min).

## Module 3 (est 840 min; fact x min).
### Экран Мои NFT:
#### Логика
- Открытие AlertController'а по нажатию на кнопку сортировки (est: 30 min; fact: x min).
- Сортировка ячеек по цене, рейтингу и названию (est: 300 min; fact: x min).
- Отображение надписи об отсутствии NFT (est: 60 min; fact: x min).
`Total:` est: 390 min; fact: x min.

### Экран Избранные NFT:
#### Вёрстка
- Navigation-bar с заголовком и кнопкой "назад" (est: 30 min; fact: x min).
- CollectionView со списком избранных NFT (est: 120 min; fact: x min).
- Переиспользуемая ячейка коллекции с иконкой NFT, сердечком, названием, рейтингом и ценой (est: 120 min; fact: x min).
`Total:` est: 270 min; fact: x min).
#### Логика
- Удаление NFT из избранного при нажатии на сердечко (est: 120 min; fact: x min).
- Отображение надписи об отсутствии избранных NFT (est: 60 min; fact: x min).
`Total:` est: 180 min; fact: x min.
<hr>

<b>
`Total:` est: 1860 min; fact: x min.
</b>
