CREATE FUNCTION f_plane_info_changed() RETURNS TRIGGER AS $$
DECLARE
    current_dttm TIMESTAMP(0) = CURRENT_TIMESTAMP(0);
BEGIN

    IF NEW.valid_to_dttm != '5999-01-01' THEN
        RETURN NULL;
    END IF;

    OLD.valid_to_dttm := current_dttm;

    INSERT INTO airport.plane
    VALUES (NEW.model, NEW.tail_num, NEW.issue_year,
            NEW.first_flight_date, NEW.last_technical_change_date, NEW.status,
            current_dttm, '5999-01-01');
    RETURN OLD;
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER plane_info_changed BEFORE UPDATE
ON airport.plane FOR EACH ROW EXECUTE PROCEDURE f_plane_info_changed();

UPDATE airport.plane
SET status = 'decommissioned'
WHERE tail_num = 'KEK-555';

INSERT INTO airport.plane
VALUES ('Boeing','KEK-555',2010,'2012-03-21','2020-11-11','at work', DEFAULT, DEFAULT
);

CREATE OR REPLACE FUNCTION changed_status() RETURNS TRIGGER AS $$
BEGIN
    IF OLD.status != NEW.status THEN
    RAISE NOTICE 'Статус билета % изменен с % на %', NEW.ticket_id, OLD.status, NEW.status;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER ticket_changes
BEFORE UPDATE ON airport.ticket FOR EACH ROW EXECUTE PROCEDURE changed_status();

UPDATE airport.ticket
SET status = 'canceled'
WHERE flight_id = 2 AND flight_type = 'Departure';
