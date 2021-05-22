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
        WHERE t.flight_type = 'Departure'
          AND status != 'canceled'
          AND t.flight_id = complete_flight.flight_id;
    ELSIF flight_type = 'Arrival' THEN
        UPDATE airport.arrival_flight af
        SET status = 'completed'
        WHERE af.id = flight_id;
        UPDATE airport.ticket t
        SET status = 'completed'
        WHERE t.flight_type = 'Arrival'
          AND status != 'canceled'
          AND t.flight_id = complete_flight.flight_id;
    END IF;
END $$;

CALL complete_flight('Arrival', 2);

CREATE PROCEDURE change_passenger_data(last_name VARCHAR(50),
                                       passport_num VARCHAR(20),
                                       passenger_id INTEGER)
LANGUAGE plpgsql
AS $$
BEGIN
    IF last_name IS NOT NULL THEN
        UPDATE airport.passenger p
        SET last_name = change_passenger_data.last_name
        WHERE p.id = passenger_id;
    END IF;
    IF passport_num IS NOT NULL THEN
        UPDATE airport.passenger p
        SET passport_num = change_passenger_data.passport_num
        WHERE p.id = passenger_id;
    END IF;
END;
$$

