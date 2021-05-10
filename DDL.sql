CREATE SCHEMA Airport

CREATE TABLE Airport.Passenger (
    id SERIAL UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(20) NOT NULL CHECK ( gender in ('Male', 'Female', 'Other') ),
    birth_date DATE,
    passport_num CHAR(10) NOT NULL,
    citizenship VARCHAR(30) NOT NULL
);

CREATE TABLE Airport.Ticket (
    ticket_num SERIAL UNIQUE NOT NULL,
    flight_type VARCHAR(13) NOT NULL,
    flight_id INTEGER NOT NULL,
    passenger_id INTEGER NOT NULL,
    place VARCHAR(7) NOT NULL,
    baggage_storage BOOLEAN NOT NULL,
    status VARCHAR(20) NOT NULL,
    CONSTRAINT flight_type_values
        CHECK (flight_type IN ('Arrival', 'Departure')),
    CONSTRAINT status_values
        CHECK (status IN ('sold', 'check-in completed', 'canceled', 'completed'))
);

CREATE TABLE Airport.ArrivalFlight (
    id SERIAL UNIQUE NOT NULL,
    plane_tail_num VARCHAR(40) NOT NULL,
    airport_departure VARCHAR(5) NOT NULL,
    arrival_time TIMESTAMP NOT NULL,
    baggage_pick_time TIMESTAMP,
    terminal INTEGER NOT NULL ,
    entrance_num INTEGER NOT NULL,
    status VARCHAR(20),
    CONSTRAINT terminal_numbers
        CHECK (terminal BETWEEN 1 AND 4),
    CONSTRAINT entrance_numbers
        CHECK (entrance_num BETWEEN 1 and 50),
    CONSTRAINT status_values
        CHECK (status IN ('planning', 'suspended', 'canceled', 'baggage picking', 'completed'))
);

CREATE TABLE Airport.DepartureFlight (
    id SERIAL UNIQUE NOT NULL,
    plane_tail_num VARCHAR(40) NOT NULL,
    airport_destination VARCHAR(5) NOT NULL,
    boarding_end_time TIMESTAMP NOT NULL,
    terminal INTEGER NOT NULL,
    gate_num INTEGER NOT NULL,
    status VARCHAR(20),
    CONSTRAINT terminal_numbers
        CHECK (terminal BETWEEN 1 AND 4),
    CONSTRAINT entrance_numbers
        CHECK (gate_num BETWEEN 1 and 80),
    CONSTRAINT status_values
        CHECK (status IN ('planning', 'suspended', 'canceled', 'completed'))
);

CREATE TABLE Airport.Airline (
    ticker VARCHAR(5) UNIQUE NOT NULL,
    name VARCHAR(50) NOT NULL,
    country VARCHAR(50),
    founded_year INTEGER CHECK ( founded_year >= 1800 ),
    website VARCHAR(100),
    main_hub VARCHAR(5)
);

CREATE TABLE Airport.Plane (
  model VARCHAR(50) NOT NULL,
  tail_num VARCHAR(40) NOT NULL,
  issue_year INTEGER NOT NULL CHECK (issue_year >= 1900),
  first_flight_date DATE CHECK ( first_flight_date >= '1900-01-01' ),
  last_technical_change_date DATE CHECK ( last_technical_change_date >= '1900-01-01' ),
  status VARCHAR(30) NOT NULL,
  valid_from_dttm TIMESTAMP NOT NULL,
  valid_to_dttm TIMESTAMP NOT NULL DEFAULT '5999-01-01',
  CONSTRAINT status_values
    CHECK ( status in ('decommissioned', 'at work') )
);

CREATE TABLE Airport.AirlineAndArrival (
    flight INTEGER NOT NULL,
    airline VARCHAR(5) NOT NULL,
    airline_role VARCHAR(30)
);

CREATE TABLE Airport.AirlineAndDeparture (
    flight INTEGER NOT NULL,
    airline VARCHAR(5) NOT NULL,
    airline_role VARCHAR(30)
);