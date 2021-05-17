/*
 1. Вывести тикеры топ 3 авиакомпаний по количеству
 совершенных рейсов в порядке убывания количества рейсов.
 2. Найти самолёты которые перевезли на борту >= 2 пассажиров из местного аэропорта.
 3. Найти пассажиров, которые летали
 */

SELECT ticker, count(*)
FROM (
    SELECT airline.ticker, airline.name
    FROM airport.airline AS airline
    INNER JOIN airport.airlineanddeparture AS ad
    ON airline.ticker = ad.airline
    INNER JOIN airport.departureflight as flight
    ON flight.id = ad.flight
    UNION ALL
    SELECT airline.ticker, airline.name
    FROM airport.airline AS airline
    INNER JOIN airport.airlineandarrival AS ad
    ON airline.ticker = ad.airline
    INNER JOIN airport.arrivalflight as flight
    ON flight.id = ad.flight
    ) AS D
GROUP BY ticker
ORDER BY count(*) DESC
FETCH first 3 ROWS ONLY;


SELECT plane.tail_num, plane.model
FROM (
         SELECT plane_tail_num
         FROM airport.passenger p
                  INNER JOIN airport.ticket t
                             ON p.id = t.passenger_id
                  INNER JOIN airport.departureflight df
                             ON df.id = t.flight_id AND t.flight_type = 'Departure'
                  INNER JOIN airport.plane plane
                             ON plane.tail_num = df.plane_tail_num AND plane.valid_to_dttm = '5999-01-01 00:00:00'
         GROUP BY plane_tail_num
         HAVING count(*) >= 2
     ) AS ids
INNER JOIN airport.plane
ON ids.plane_tail_num = airport.plane.tail_num AND plane.valid_to_dttm = '5999-01-01 00:00:00'

