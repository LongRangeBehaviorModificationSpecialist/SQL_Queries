SELECT
    ROW_NUMBER() OVER() AS 'Record No.',
    datetime(ZOBJECT.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'Entry Creation Date (UTC)',
    datetime(ZOBJECT.ZCREATIONDATE + 978307200, 'UNIXEPOCH', 'localtime') AS 'Entry Creation Date (Local)',
    datetime(ZOBJECT.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'Start Time (UTC)',
    datetime(ZOBJECT.ZSTARTDATE + 978307200, 'UNIXEPOCH', 'localtime') AS 'Start Time (Local)',
    datetime(ZOBJECT.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'End Time (UTC)',
    datetime(ZOBJECT.ZENDDATE + 978307200, 'UNIXEPOCH', 'localtime') AS 'End Time (Local)',
    (ZOBJECT.ZENDDATE - ZOBJECT.ZSTARTDATE) AS 'Usage (Seconds)',
    (ZOBJECT.ZSECONDSFROMGMT / 3600) AS 'GMT Offset',
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
    ZOBJECT.ZSTREAMNAME AS 'Stream Name',
    ZOBJECT.ZVALUESTRING AS 'Value String',
    CASE ZOBJECT.ZVALUEINTEGER
        WHEN '0.0' THEN 'Unlocked'
        WHEN '1.0' THEN 'Locked'
        ELSE ZOBJECT.ZVALUEINTEGER
    END AS 'Lock Status'

FROM ZOBJECT

WHERE ZSTREAMNAME LIKE '/device/isLocked'

ORDER BY ZOBJECT.ZSTARTDATE DESC
