/*
 1. Вывести тикеры топ 3 авиакомпаний по количеству
 совершенных рейсов в порядке убывания количества рейсов.
 2. Найти самолёты которые перевезли на борту >= 2 пассажиров из местного аэропорта.
 3. Найти пассажиров, которые должны сейчас получить багаж.
 Отсортировать по времени выдачи багажа.
 4. Для каждого года найти, сколько зарегистрировано (полёты с любым статусом) вылетов и прилетов суммарно в каждом году.
 5. Найти записи в таблице plane, в которых поменялась дата последней технической проверки по сравнению с предыдущей записью для каждого самолета
 */

SELECT ticker, count(*)
FROM (
    SELECT airline.ticker, airline.name
    FROM airport.airline AS airline
    INNER JOIN airport.airline_and_departure AS ad
    ON airline.ticker = ad.airline
    INNER JOIN airport.departure_flight as flight
    ON flight.id = ad.flight AND flight.status = 'completed'
    UNION ALL
    SELECT airline.ticker, airline.name
    FROM airport.airline AS airline
    INNER JOIN airport.airline_and_arrival AS ad
    ON airline.ticker = ad.airline
    INNER JOIN airport.arrival_flight as flight
    ON flight.id = ad.flight AND flight.status = 'completed'
    ) AS D
GROUP BY ticker
ORDER BY count(*) DESC
LIMIT 3;


SELECT plane.tail_num, plane.model
FROM (
     SELECT plane_tail_num
     FROM airport.passenger p
          INNER JOIN airport.ticket t
                 ON p.id = t.passenger_id
          INNER JOIN airport.departure_flight df
                 ON df.id = t.flight_id AND t.flight_type = 'Departure' AND df.status = 'completed'
          INNER JOIN airport.plane plane
                 ON plane.tail_num = df.plane_tail_num AND plane.valid_to_dttm = '5999-01-01 00:00:00'
     GROUP BY plane_tail_num
     HAVING count(*) >= 2
     ) AS ids
INNER JOIN airport.plane
ON ids.plane_tail_num = airport.plane.tail_num AND plane.valid_to_dttm = '5999-01-01 00:00:00';

SELECT p.first_name, p.middle_name, p.last_name, af.baggage_pick_time
FROM airport.passenger p
INNER JOIN airport.ticket t
ON p.id = t.passenger_id
INNER JOIN airport.arrival_flight af
ON af.id = t.flight_id AND t.flight_type = 'Arrival'
WHERE af.status = 'baggage picking'
AND t.baggage_storage = TRUE
AND af.baggage_pick_time IS NOT NULL
ORDER BY af.baggage_pick_time;

SELECT year, sum(cnt)
FROM (
    SELECT EXTRACT(year FROM af.arrival_time) AS year, count(*) as cnt
    FROM airport.arrival_flight af
    GROUP BY EXTRACT(year FROM af.arrival_time)
    UNION ALL
    SELECT EXTRACT(year FROM df.boarding_end_time) AS year, count(*) as cnt
    FROM airport.departure_flight df
    GROUP BY EXTRACT(year FROM df.boarding_end_time)
) as cnts
GROUP BY year;

SELECT count(*), EXTRACT(year FROM flight_time) AS year
FROM (
         SELECT DISTINCT coalesce(boarding_end_time, arrival_time) flight_time,
                         coalesce(af.id, df.id) id,
                         t.flight_type
         FROM airport.ticket t
                  FULL JOIN airport.arrival_flight af
                            ON t.flight_type = 'Arrival' AND t.flight_id = af.id
                  FULL JOIN airport.departure_flight df
                            ON t.flight_type = 'Departure' AND t.flight_id = df.id
     ) joined
GROUP BY EXTRACT(year FROM flight_time);

SELECT model, tail_num, last_technical_change_date, status, valid_from_dttm, valid_to_dttm
FROM (
     SELECT *,
            CASE
            WHEN lag(last_technical_change_date, 1, '5999/01/01')
            OVER (PARTITION BY tail_num ORDER BY valid_from_dttm) != plane.last_technical_change_date
            THEN TRUE
            ELSE FALSE
            END AS changed
     FROM airport.plane as plane
) AS plane_add
WHERE plane_add.changed