CREATE TABLE devices_shake_detection_settings (
    id uuid REFERENCES devices (id) ON DELETE CASCADE NOT NULL,
    region_id smallint NOT NULL,
    min_jma_intensity jma_intensity NOT NULL,
    created_at timestamp with time zone DEFAULT NOW() NOT NULL
);


/* seed.sql

 INSERT INTO devices(id, fcm_token)
 VALUES
 ('00000000-0000-0000-0000-000000000000', 'dummy_device_id_A'),
 ('00000000-0000-0000-0000-000000000001', 'dummy_device_id_B'),
 ('00000000-0000-0000-0000-000000000002', 'dummy_device_id_C'),
 ('00000000-0000-0000-0000-000000000003', 'dummy_device_id_D');


 INSERT INTO devices_shake_detection_settings(id, region_id, min_jma_intensity)
 VALUES
 -- User A
 ('00000000-0000-0000-0000-000000000000', 1, '0'),
 ('00000000-0000-0000-0000-000000000000', 2, '0'),
 -- User B
 ('00000000-0000-0000-0000-000000000001', 1, '1'),
 ('00000000-0000-0000-0000-000000000001', 2, '1'),
 ('00000000-0000-0000-0000-000000000001', 3, '1'),
 -- User C
 ('00000000-0000-0000-0000-000000000002', 1, '1'),
 ('00000000-0000-0000-0000-000000000002', 2, '1'),
 -- User D
 ('00000000-0000-0000-0000-000000000003', 1, '3'),
 ('00000000-0000-0000-0000-000000000003', 2, '3'),
 ('00000000-0000-0000-0000-000000000003', 3, '3');
 */
