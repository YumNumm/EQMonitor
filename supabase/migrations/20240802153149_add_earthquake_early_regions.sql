CREATE TABLE earthquake_early_regions (
    id text NOT NULL REFERENCES earthquake_early (id),
    region_id text NOT NULL CHECK (region_id ~ '^[0-9]{2}$'),
    max_intensity jma_intensity NOT NULL,
    PRIMARY KEY (id, region_id)
);

CREATE INDEX earthquake_early_regions_max_intensity_region_idx ON earthquake_early_regions (max_intensity, region_id);

ALTER TABLE earthquake_early_regions ENABLE ROW LEVEL SECURITY;

CREATE POLICY select_earthquake_early_regions ON earthquake_early_regions
    FOR SELECT
        USING (TRUE);
