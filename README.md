# Курс "Базы Данных". Курсовая работа
## Логическая модель

![Логическая модель](logic.png)

## Комментарии к модели:

Таблица ```Самолёт``` будет scd2-версионной.

Таблицы ```Авиакомпания в рейсе прибытия/отправления``` созданы для реализации связи многие ко многим

Атрибут ```Статус``` в таблице ```Билет``` означает статус пассажира в рамках конкретного рейса, например: "прошел регистрацию", "отстранен от полета", "на борту".
