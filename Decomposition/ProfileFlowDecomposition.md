Кашников Антон Сергеевич
<br /> Когорта: 6
<br /> Группа: 6
<br /> Эпик: Профиль
<br /> Ссылка на доску: https://github.com/users/prostokot14/projects/4/views/1
<hr>

# Profile Flow Decomposition
## Экран Профиль (est 480 min; fact x min).
### Module 1:
#### Вёрстка
- Navigation-bar с кнопкой редактирования профиля (est: 30 min; fact: x min).
- Container-view с информацией о пользователе: фото профиля, имя и био (est: 120 min; fact: x min).
- TableView с 3-мя ячейками: "Мои NFT", "Избранные NFT" и "О разработчике" (est: 60 min; fact: x min).

`Total:` est: 210 min; fact: x min).

#### Логика
- Переход на экран редактирования профиля (est: 30 min; fact: x min).
- Открытие экрана с webView при нажатии на ссылку сайта (est: 60 min; fact: x min).
- Переход на экран "Мои NFT" (est: 60 min; fact: x min).
- Переход на экран "Избранные NFT" (est: 60 min; fact: x min).
- Переход на экран "О разработчике" (est: 60 min; fact: x min).

`Total:` est: 270 min; fact: x min.

## Экран Редактирование профиля (est 300 min; fact x min).
### Module 2:
#### Вёрстка
- Кнопка закрытия экрана редактирования профиля (est: 30 min; fact: x min).
- Фото профиля (est: 30 min; fact: x min).
- TableView с 3-мя секциями: Имя, Описание, Сайт (est: 60 min; fact: x min).
- Текстовые поля для каждой секции (est: 60 min; fact: x min).

`Total:` est: 180 min; fact: x min).

#### Логика
- Изменение фотографии профиля (загрузка нового изображения из галереи пользователя (est: 120 min; fact: x min).

`Total:` est: 120 min; fact: x min.

## Экран Мои NFT (est 540 min; fact x min).
### Module 3:
#### Вёрстка
- Navigation-bar с заголовком, кнопкой "назад" и кнопкой сортировки (est: 60 min; fact: x min).
- TableView со списком NFT (est: 30 min; fact: x min).
- Переиспользуемая ячейка таблицы с иконкой NFT, названием, автором и ценой (est: 120 min; fact: x min).

`Total:` est: 150 min; fact: x min).

#### Логика
- Открытие AlertController'а по нажатию на кнопку сортировки (est: 30 min; fact: x min).
- Сортировка ячеек по цене, рейтингу и названию (est: 300 min; fact: x min).
- Отображение надписи об отсутствии NFT (est: 60 min; fact: x min).

`Total:` est: 390 min; fact: x min.

## Экран Избранные NFT (est 450 min; fact x min).
### Module 4:
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
`Total:` est: 1770 min; fact: x min.
</b>
