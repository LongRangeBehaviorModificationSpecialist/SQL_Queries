SELECT
    ROW_NUMBER() OVER() AS 'Record No.',
    UPPER(substr(printf("%0!.12x", MAC), 1, 2) || ':' ||
        substr(printf("%0!.12x", MAC), 3, 2) || ':' ||
        substr(printf("%0!.12x", MAC), 5, 2) || ':' ||
        substr(printf("%0!.12x", MAC), 7, 2) || ':' ||
        substr(printf("%0!.12x", MAC), 9, 2) || ':' ||
        substr(printf("%0!.12x", MAC), 11, 2)) AS 'MAC Address',
    Channel AS 'Channel',
    strftime('%Y-%m-%dT%H:%M:%SZ', datetime(timestamp + 978307200, 'UNIXEPOCH')) AS 'Timestamp (UTC)',
    strftime('%Y-%m-%d %H:%M:%S', datetime(timestamp + 978307200, 'UNIXEPOCH', 'localtime')) AS 'Timestamp (Local)',
    Latitude AS 'Latitude',
    Longitude AS 'Longitude',
    HorizontalAccuracy AS 'HorizontalAccuracy',
    Altitude AS 'Altitude',
    Confidence AS 'Confidence'

FROM WifiLocation

ORDER BY timestamp DESC