CREATE TYPE origin_time_precision AS ENUM (
  'month',
  /* xxxx年xx月 */
  'day',
  /* xxxx/xx/xx */
  'hour',
  /* xxxx/xx/xx xx時 */
  'minute',
  /* xxxx/xx/xx xx:xx */
  'second',
  /* xxxx/xx/xx xx:xx:xx */
  'millisecond'
  /* xxxx/xx/xx xx:xx:xx.x */
);

CREATE TABLE earthquake_early (
  id TEXT PRIMARY KEY NOT NULL,
  origin_time TIMESTAMPTZ NOT NULL,
  origin_time_precision origin_time_precision NOT NULL,
  name TEXT NOT NULL,
  latitude DOUBLE PRECISION,
  longitude DOUBLE PRECISION,
  depth INTEGER,
  magnitude DOUBLE PRECISION,
  max_intensity jma_intensity NULL
);

CREATE INDEX earthquake_early_origin_time_idx ON earthquake_early (origin_time);

CREATE INDEX earthquake_early_origin_time_precision_idx ON earthquake_early (origin_time_precision);

CREATE INDEX earthquake_early_lat_lon_idx ON earthquake_early (latitude, longitude);

CREATE INDEX earthquake_early_depth_idx ON earthquake_early (depth);

CREATE INDEX earthquake_early_magnitude_idx ON earthquake_early (magnitude);

CREATE INDEX earthquake_early_max_intensity_idx ON earthquake_early (max_intensity);

ALTER TABLE earthquake_early ENABLE ROW LEVEL SECURITY;

CREATE POLICY select_earthquake_early ON earthquake_early FOR
SELECT
  USING (true);
