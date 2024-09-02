CREATE
OR REPLACE VIEW shake_detection_latest AS
SELECT
  DISTINCT ON (created_at) *
FROM
  shake_detection_events
WHERE
  created_at > (now() - time '00:10')
ORDER BY
  created_at DESC,
  serial_no DESC;
