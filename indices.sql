-- Ticket
-- Часто полезно понимать билеты, связанные с одним рейсом
CREATE INDEX type_index
ON airport.ticket(flight_type, flight_id);

-- Passenger
-- Быстрый поиск пассажира по имени
CREATE INDEX name_index
ON airport.passenger(first_name, last_name);

-- Airline
-- Поиск по названию в любом регистре
CREATE INDEX airline_index
ON airport.airline(lower(name));

-- Plane
-- Быстро отфильтровать актуальные данные
CREATE INDEX plane_index
ON airport.plane(valid_to_dttm);

-- Arrival Flight
CREATE INDEX arrival_index
ON airport.arrival_flight(arrival_time);

-- Departure Flight
CREATE INDEX departure_index
ON airport.departure_flight(boarding_end_time);

-- Arrival and airline
CREATE INDEX aa_index
ON airport.airline_and_arrival(flight, airline);

-- Departure and airline
CREATE INDEX ad_index
ON airport.airline_and_departure(flight, airline);