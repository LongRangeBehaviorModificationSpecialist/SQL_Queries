SELECT
    ROW_NUMBER() OVER() AS 'Record',
    PLAPPTIMESERVICE_AGGREGATE_APPRUNTIME.BundleID AS 'Bundle_ID',
    PLAPPTIMESERVICE_AGGREGATE_APPRUNTIME.ScreenOnTime AS 'Focus (Seconds)',
    PLAPPTIMESERVICE_AGGREGATE_APPRUNTIME.BackgroundTime AS 'Background (Seconds)',
    datetime (PLAPPTIMESERVICE_AGGREGATE_APPRUNTIME.timestamp, 'UNIXEPOCH') AS 'Timestamp',
    'Table: PLAPPTIMESERVICE_AGGREGATE_APPRUNTIME(ID: ' || PLAPPTIMESERVICE_AGGREGATE_APPRUNTIME.ID || ')' AS 'Source'

FROM PLAPPTIMESERVICE_AGGREGATE_APPRUNTIME

WHERE BundleID LIKE '%whatsapp%'

ORDER BY PLAPPTIMESERVICE_AGGREGATE_APPRUNTIME.timestamp ASC
