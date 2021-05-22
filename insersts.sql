-- Passenger

INSERT INTO airport.passenger
VALUES (DEFAULT, 'Вячеслав', 'Олегович', 'Сурков', 'Male', '2001-09-21', '2286661337', 'Российская Федерация');
INSERT INTO airport.passenger
VALUES (DEFAULT, 'Валерий', 'Дмитриевич', 'Згурский', 'Male', '2001-04-17', '1234567890 ', 'Российская Федерация');
INSERT INTO airport.passenger
VALUES (DEFAULT, 'Евгений', 'Владимирович', 'Тищенков', 'Male', '2001-07-01', '0001112223', 'Российская Федерация');
INSERT INTO airport.passenger
VALUES (DEFAULT, 'Зинаида', 'Григорьевна', 'Цветкова', 'Female', '1950-10-21', '2386664337', 'Украина');
INSERT INTO airport.passenger
VALUES (DEFAULT, 'Степанидзе', NULL, 'Браун', 'Other', '2010-01-31', '2286661337', 'Российская Федерация');
INSERT INTO airport.passenger
VALUES (DEFAULT, 'Баир', 'Михайлович', 'Михайлов', 'Male', '2001-05-17', '2286661338', 'Российская Федерация');


-- Airline

COPY airport.airline
FROM 'C:\Users\Public\airlines_inserts.csv'
DELIMITER ',' CSV HEADER;

-- Plane

COPY airport.plane
FROM 'C:\Users\Public\plane_inserts.csv'
DELIMITER ',' CSV HEADER;

-- Arrival flight

INSERT INTO airport.arrival_flight
VALUES (DEFAULT, 'KEK-555', 'DMD', '2021-05-10 18:17', '2021-05-10 18:37', 1, 1, 'baggage picking');
INSERT INTO airport.arrival_flight
VALUES (DEFAULT, 'GHGG123', 'EGO', '2021-05-10 20:00', NULL, 4, 45, 'planning');
INSERT INTO airport.arrival_flight
VALUES (DEFAULT, 'KEK-555', 'EGO', '2021-05-12 23:15', NULL, 3, 5, 'suspended');
INSERT INTO airport.arrival_flight
VALUES (DEFAULT, 'GHGG123', 'VKO', '2020-05-10 20:00', NULL, 4, 45, 'canceled');
INSERT INTO airport.arrival_flight
VALUES (DEFAULT, '123456', 'IKT', '2021-06-02 01:00', '2021-06-02 01:15', 2, 1, 'planning');

-- Departure flight

INSERT INTO airport.departure_flight
VALUES (DEFAULT, 'KEK-555', 'DMD', '2019-01-01 01:01', 1, 1, 'completed');
INSERT INTO airport.departure_flight
VALUES (DEFAULT, 'GHCC101', 'UFA', '2020-01-04 03:21', 4, 79, 'suspended');
INSERT INTO airport.departure_flight
VALUES (DEFAULT, 'KEK-555', 'DMD', '2019-01-02 01:01', 1, 1, 'completed');
INSERT INTO airport.departure_flight
VALUES (DEFAULT, 'KDK-525', 'EGO', '2016-02-17 01:01', 2, 1, 'canceled');
INSERT INTO airport.departure_flight
VALUES (DEFAULT, 'KDK-525', 'AER', '2018-05-31 21:09', 3, 5, 'completed');

-- Airline and arrival

INSERT INTO airport.airline_and_arrival
VALUES (1, 'SU', NULL);
INSERT INTO airport.airline_and_arrival
VALUES (2, 'SU', NULL);
INSERT INTO airport.airline_and_arrival
VALUES (3, 'SU', 'Перевозчик');
INSERT INTO airport.airline_and_arrival
VALUES (3, 'S7', 'Маркетинговый партнёр');
INSERT INTO airport.airline_and_arrival
VALUES (4, 'AA', 'Перевозчик');
INSERT INTO airport.airline_and_arrival
VALUES (4, 'TK', 'Маркетинговый партнёр');
INSERT INTO airport.airline_and_arrival
VALUES (5, 'UA', NULL);
INSERT INTO airport.airline_and_arrival
VALUES (6, 'UA', NULL);

-- Departure flight

INSERT INTO airport.airline_and_departure
VALUES (1, 'UA', NULL);
INSERT INTO airport.airline_and_departure
VALUES (2, 'AA', NULL);
INSERT INTO airport.airline_and_departure
VALUES (3, 'SU', NULL);
INSERT INTO airport.airline_and_departure
VALUES (4, 'S7', NULL);
INSERT INTO airport.airline_and_departure
VALUES (5, 'S7', 'Перевозчик');
INSERT INTO airport.airline_and_departure
VALUES (5, 'AA', 'Продажа билетов');
INSERT INTO airport.airline_and_departure
VALUES (6, 'UA', NULL);

-- Ticket

INSERT INTO airport.ticket
VALUES (DEFAULT, 'Departure', 1, 1, '3A', FALSE, 'sold');
INSERT INTO airport.ticket
VALUES (DEFAULT, 'Departure', 1, 2, '3B', TRUE, 'sold');
INSERT INTO airport.ticket
VALUES (DEFAULT, 'Departure', 2, 3, '12E', FALSE, 'completed');
INSERT INTO airport.ticket
VALUES (DEFAULT, 'Departure', 3, 4, '3A', FALSE, 'canceled');
INSERT INTO airport.ticket
VALUES (DEFAULT, 'Departure', 5, 4, '2A', FALSE, 'check-in completed');
INSERT INTO airport.ticket
VALUES (DEFAULT, 'Departure', 4, 6, '20F', TRUE, 'sold');
INSERT INTO airport.ticket
VALUES (DEFAULT, 'Arrival', 2, 6, '3A', TRUE, 'sold');
INSERT INTO airport.ticket
VALUES (DEFAULT, 'Arrival', 3, 5, '24T', FALSE, 'canceled');
INSERT INTO airport.ticket
VALUES (DEFAULT, 'Arrival', 4, 4, '3E', TRUE, 'completed');
INSERT INTO airport.ticket
VALUES (DEFAULT, 'Arrival', 5, 3, '1A', FALSE, 'sold');

SELECT *
FROM airport.passenger