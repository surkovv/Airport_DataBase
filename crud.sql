-- passenger

INSERT INTO airport.passenger
VALUES (DEFAULT, 'Максим', 'Евгенъевич', 'Гапонов', 'Male', '2002/04/01', '0101010101', 'Киргизия');

UPDATE airport.passenger
SET middle_name = 'Евгеньевич'
WHERE passport_num = '0101010101';

SELECT last_name
FROM airport.passenger
WHERE gender = 'Male';

-- airline

INSERT INTO airport.airline
VALUES ('DL', 'Delta Airlines', 'США', 1924, 'www.delta.com', 'ATL');

DELETE FROM airport.airline
WHERE main_hub = 'ATL';

-- arrival_flight

UPDATE airport.arrivalflight
SET status = 'canceled'
WHERE baggage_pick_time >= '2021-05-10 18:37:00';

INSERT INTO airport.arrivalflight
VALUES (DEFAULT, 'GHCC101', 'UFA', '2021-12-04 03:21:00', NULL,  4, 50, 'planning');

-- departure_flight

UPDATE airport.departureflight
SET boarding_end_time = boarding_end_time + INTERVAL '1 HOUR'
WHERE id = 2;

-- airline_and_arrival

DELETE FROM airport.airlineandarrival
WHERE airline = 'AA';

UPDATE airport.airlineandarrival
SET airline_role = NULL
WHERE flight = 4 AND airline = 'TK';

-- airline_and_departure

UPDATE airport.airlineanddeparture
SET airline_role = 'Продажа билетов'
WHERE airline = 'AA' AND airline_role IS NULL;

SELECT SUM(
    CASE airline_role
        WHEN 'Продажа билетов' THEN 1
        ELSE 0
    END
           )
FROM airport.airlineanddeparture
WHERE airline = 'AA';

-- plane

INSERT INTO airport.plane
VALUES('Boeing','KEK-555',2010,'2012-03-21','2020-09-21', 'at work', DEFAULT, DEFAULT);

SELECT *
FROM airport.plane
WHERE valid_to_dttm = '5999-01-01 00:00:00';

UPDATE airport.plane
SET valid_to_dttm = (
    SELECT max(valid_from_dttm)
    FROM airport.plane
    WHERE tail_num = 'KEK-555'
    )
WHERE tail_num = 'KEK-555' AND
      valid_to_dttm = '5999-01-01 00:00:00' AND
      valid_from_dttm = '2019-11-12 00:00:00';

-- ticket

INSERT INTO airport.ticket
VALUES (DEFAULT, 'Departure', 2, 7, '8D', FALSE, 'sold');

DELETE FROM airport.ticket
WHERE passenger_id = 7;