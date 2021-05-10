-- Passenger

INSERT INTO airport.passenger
VALUES (DEFAULT, 'Вячеслав', 'Олегович', 'Сурков', 'Male', '2001-09-21', '2286661337', 'Российская Федерация')
INSERT INTO airport.passenger
VALUES (DEFAULT, 'Валерий', 'Дмитриевич', 'Згурский', 'Male', '2001-04-17', '1234567890 ', 'Российская Федерация')
INSERT INTO airport.passenger
VALUES (DEFAULT, 'Евгений', 'Владимирович', 'Тищенков', 'Male', '2001-07-01', '0001112223', 'Российская Федерация')
INSERT INTO airport.passenger
VALUES (DEFAULT, 'Зинаида', 'Григорьевна', 'Цветкова', 'Female', '1950-10-21', '2386664337', 'Украина')
INSERT INTO airport.passenger
VALUES (DEFAULT, 'Степанидзе', NULL, 'Браун', 'Other', '2010-01-31', '2286661337', 'Российская Федерация')

-- Airline

COPY airport.airline
FROM 'C:\Users\Public\airlines_inserts.csv'
DELIMITER ';' CSV HEADER;

COPY airport.plane
FROM 'C:\Users\Public\plane_inserts.csv'
DELIMITER ',' CSV HEADER;