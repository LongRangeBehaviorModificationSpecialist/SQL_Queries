SELECT
    ROW_NUMBER() OVER() AS 'Record No.',
    ZOBJECT.Z_PK AS 'Table ID',
    CASE ZOBJECT.ZSTARTDAYOFWEEK
        WHEN '1' THEN 'Sunday'
        WHEN '2' THEN 'Monday'
        WHEN '3' THEN 'Tuesday'
        WHEN '4' THEN 'Wednesday'
        WHEN '5' THEN 'Thursday'
        WHEN '6' THEN 'Friday'
        WHEN '7' THEN 'Saturday'
        ELSE ZOBJECT.ZSTARTDAYOFWEEK
    END AS 'Day of Week',
    datetime(ZOBJECT.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'Start Time (UTC)',
    datetime(ZOBJECT.ZSTARTDATE + 978307200, 'UNIXEPOCH', 'localtime') AS 'Start Time (Local)',
    datetime(ZOBJECT.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'End Time (UTC)',
    datetime(ZOBJECT.ZENDDATE + 978307200, 'UNIXEPOCH', 'localtime') AS 'End Time (Local)',
    (ZOBJECT.ZSECONDSFROMGMT / 3600) AS 'Device GMT Offset',
    (ZOBJECT.ZENDDATE - ZOBJECT.ZSTARTDATE) AS 'Usage (Seconds)',
    ROUND(((ZOBJECT.ZENDDATE - ZOBJECT.ZSTARTDATE) / 60.00), 4) AS 'Usage (Minutes)',
    ZOBJECT.ZSTREAMNAME AS 'Stream Name',
    CASE ZOBJECT.ZVALUEINTEGER
        WHEN '0.0' THEN 'FALSE'
        WHEN '1.0' THEN 'TRUE'
        ELSE ZOBJECT.ZVALUEINTEGER
    END AS 'Value',
    datetime(ZOBJECT.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'Entry Creation Date (UTC)'
    datetime(ZOBJECT.ZCREATIONDATE + 978307200, 'UNIXEPOCH', 'localtime') AS 'Entry Creation Date (Local)'

FROM ZOBJECT
    LEFT JOIN ZSTRUCTUREDMETADATA on ZOBJECT.ZSTRUCTUREDMETADATA = ZSTRUCTUREDMETADATA.Z_PK
    LEFT JOIN ZSOURCE on ZOBJECT.ZSOURCE = ZSOURCE.Z_PK

WHERE ZSTREAMNAME LIKE '/device%'

--WHERE
--ZSTREAMNAME LIKE '/device/batteryPercentage'
--or ZSTREAMNAME LIKE '/device/batterySaver'
--or ZSTREAMNAME LIKE '/device/isLocked'
--or ZSTREAMNAME LIKE '/device/isPluggedIn'

ORDER BY ZOBJECT.ZSTARTDATE DESC
