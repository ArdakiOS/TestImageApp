Опыт работа как iOS developer около 3.5 лет 

На выполнение задания ушло порядка 7 часов

Использовал библиотеку Vision для определения лица на картинке 

Использовал библиотеку Realm для создания локального хранилища 


Примечания!! 
Приложение нужно тестить на реальном устройстве т.к. библиотека Vision не работает на симуляторе

В текущем варианте фотография пользователя хранится напрямую в виде jpegData в хранилище Realm. Фактор сжатия фотографии 0.5, чтобы не было проблем при сохранений. Сделал так потому что качество сохраненного изображение не так уж и важно. Если нужно чтобы фотография сохранялась в исходном варианте, можно будет сохранять фотографию в приватной папке приложения и в БД Realm сохранять URL к этой фотографии
