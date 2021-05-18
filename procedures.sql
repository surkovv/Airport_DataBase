CREATE PROCEDURE complete_flight(flight_type VARCHAR(13), flight_id INTEGER)
LANGUAGE plpgsql
AS $$
BEGIN
    IF flight_type = 'Departure' THEN
        UPDATE airport.departure_flight df
        SET status = 'completed'
        WHERE df.id = flight_id;
        UPDATE airport.ticket t
        SET status = 'completed'
        WHERE flight_type = 'Departure'
          AND status != 'canceled'
          AND t.flight_id = complete_flight.flight_id;
    ELSIF flight_type = 'Arrival' THEN
        UPDATE airport.arrival_flight af
        SET status = 'completed'
        WHERE af.id = flight_id;
        UPDATE airport.ticket t
        SET status = 'completed'
        WHERE flight_type = 'Arrival'
          AND status != 'canceled'
          AND t.flight_id = complete_flight.flight_id;
    END IF;
END $$;

CREATE PROCEDURE change_passenger_data(last_name VARCHAR(50),
                                       passport_num VARCHAR(20),
                                       passenger_id INTEGER)
LANGUAGE SQL
AS $$
    UPDATE airport.passenger
    SET last_name = change_passenger_data.last_name,
        passport_num = change_passenger_data.passport_num
    WHERE id = passenger_id
$$