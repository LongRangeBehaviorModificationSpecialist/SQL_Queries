SELECT
    MAC AS 'MAC (as dec)',
    printf("%x", MAC) AS 'MAC (as hex)',
    CASE
        WHEN WifiLocation.MAC IS NULL THEN 'n/a'
        WHEN LENGTH(MAC) > 12 THEN CONCAT('0', MAC)
        ELSE CONCAT('', MAC)
    END AS 'Test',

    typeof(MAC),
    strftime('%Y-%m-%dT%H:%M:%SZ', datetime(timestamp + 978307200, 'UNIXEPOCH')) AS 'Timestamp (UTC)',
    Channel

FROM WifiLocation

ORDER BY timestamp DESC