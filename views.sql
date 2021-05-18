CREATE SCHEMA views;

-- airline
CREATE VIEW views.v_russian_airlines AS
SELECT ticker, name, founded_year, website, main_hub
FROM airport.airline
WHERE country = 'Российская Федерация';

-- airline and arrival
CREATE VIEW views.v_airport_and_arrival_main AS
SELECT airline, flight
FROM airport.airline_and_arrival;

-- airline and departure
CREATE VIEW views.v_airport_and_departure_main AS
SELECT airline, flight
FROM airport.airline_and_departure;

-- passenger
CREATE VIEW views.v_passenger_masked AS
SELECT first_name,
       middle_name,
       last_name,
       birth_date,
       concat(substring(passport_num from 1 for 3), '****')
FROM airport.passenger;

-- plane
CREATE VIEW views.v_plane_current AS
SELECT tail_num, model, issue_year, first_flight_date, last_technical_change_date, status
FROM airport.plane
WHERE valid_to_dttm = '5999-01-01';

-- ticket
CREATE VIEW views.v_ticket_departure AS
SELECT ticket_id, flight_id, passenger_id, place, baggage_storage, status
FROM airport.ticket
WHERE flight_type = 'Departure';

CREATE VIEW views.v_ticket_arrival AS
SELECT ticket_id, flight_id, passenger_id, place, baggage_storage, status
FROM airport.ticket
WHERE flight_type = 'Arrival';

-- Complex views

/*
 1. Сводная талица. Для каждой авиакомпании посчитать, сколько суммарно пассажиров
 каждого пола участвовало в рейсах данной авиакомпании.
 */
CREATE VIEW views.v_pivot_airline_gender AS
SELECT joined.airline,
       sum(
    CASE joined.gender
    WHEN 'Male' THEN 1
    ELSE 0
    END) AS male,
       sum(
    CASE joined.gender
    WHEN 'Female' THEN 1
    ELSE 0
    END) AS female,
       sum(
    CASE joined.gender
    WHEN 'Other' THEN 1
    ELSE 0
    END) AS other
FROM (
         (SELECT p.gender, aa.airline
          FROM airport.passenger p
                   INNER JOIN views.v_ticket_arrival t
                              ON p.id = t.passenger_id
                   INNER JOIN airport.airline_and_arrival aa
                              ON t.flight_id = aa.flight)
         UNION ALL
         (SELECT p.gender, ad.airline
          FROM airport.passenger p
                   INNER JOIN views.v_ticket_departure t
                              ON p.id = t.passenger_id
                   INNER JOIN airport.airline_and_departure ad
                              ON t.flight_id = ad.flight)
     ) joined
GROUP BY joined.airline;

/*
 2. Пассажиры, у которых день рождения в день планируемого рейса-вылета.
 */
CREATE VIEW views.v_birthday AS
SELECT p.first_name, p.middle_name, p.last_name, p.birth_date, df.boarding_end_time
FROM airport.passenger p
INNER JOIN views.v_ticket_departure t
ON p.id = t.passenger_id
INNER JOIN airport.departure_flight df
ON df.id = t.flight_id
WHERE EXTRACT(month FROM p.birth_date) = EXTRACT(month FROM df.boarding_end_time)
AND EXTRACT(day FROM p.birth_date) = EXTRACT(day FROM df.boarding_end_time)
AND df.status = 'planning';

/*
 3. Пассажиропоток в каждый день
 */

CREATE VIEW views.v_workload AS
SELECT count(*), date
FROM (
         SELECT p.id, DATE(boarding_end_time) as date
         FROM airport.passenger p
                  INNER JOIN views.v_ticket_departure t
                             ON p.id = t.passenger_id
                  INNER JOIN airport.departure_flight df
                             ON df.id = t.flight_id
         WHERE df.status != 'canceled'
         UNION ALL
         SELECT p.id, DATE(arrival_time) as date
         FROM airport.passenger p
                  INNER JOIN views.v_ticket_arrival t
                             ON p.id = t.passenger_id
                  INNER JOIN airport.arrival_flight af
                             ON af.id = t.flight_id
         WHERE af.status != 'canceled'
     ) as united
GROUP BY date
ORDER BY date;