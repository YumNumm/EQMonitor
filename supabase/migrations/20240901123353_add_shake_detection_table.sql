/*
 export const KyoshinEventTelegramSchema = v.object(
 { id: v.pipe(v.string(), v.uuid()),
 level: v.picklist(
 ["Weaker", "Weak", "Medium", "Strong", "Stronger"]
 ),
 createdAt: v.string(),
 pointCount: v.pipe(v.number(), v.integer()),
 maxIntensity: intensity,
 regions: v.array(
 v.object(
 { name: v.string(),
 maxIntensity: intensity,
 points: v.array(
 v.object(
 { location: location,
 intensity: intensity,
 code: v.string(),
 name: v.string(),
 }
 )
 ),
 }
 )
 ),
 topLeft: location,
 bottomRight: location,
 }
 )
 */
CREATE TABLE shake_detection_events (
    id SERIAL4 PRIMARY KEY NOT NULL,
    event_id uuid NOT NULL,
    serial_no integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    inserted_at timestamp with time zone NOT NULL DEFAULT NOW(),
    max_intensity JMA_INTENSITY NOT NULL,
    point_count integer NOT NULL,
    regions jsonb NOT NULL,
    top_left jsonb NOT NULL,
    bottom_right jsonb NOT NULL
);

CREATE INDEX shake_detection_events_event_id_idx ON shake_detection_events (event_id);

CREATE INDEX shake_detection_created_at_idx ON shake_detection_events (created_at);

CREATE INDEX shake_detection_inserted_at_idx ON shake_detection_events (inserted_at);

CREATE INDEX shake_detection_max_intensity_idx ON shake_detection_events (max_intensity);

-- トリガー関数を作成
CREATE OR REPLACE FUNCTION set_serial_no ()
    RETURNS TRIGGER
    AS $$
DECLARE
    max_serial_no integer;
BEGIN
    SELECT
        COALESCE(MAX(serial_no), 0) + 1 INTO max_serial_no
    FROM
        shake_detection_events
    WHERE
        event_id = NEW.event_id;
    NEW.serial_no = max_serial_no;
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

-- トリガーを作成
CREATE TRIGGER trigger_set_serial_no
    BEFORE INSERT ON shake_detection_events
    FOR EACH ROW
    EXECUTE FUNCTION set_serial_no ();

ALTER TABLE shake_detection_events ENABLE ROW LEVEL SECURITY;

CREATE POLICY shake_detection_events_policy ON shake_detection_events
    FOR SELECT
        USING (TRUE);
