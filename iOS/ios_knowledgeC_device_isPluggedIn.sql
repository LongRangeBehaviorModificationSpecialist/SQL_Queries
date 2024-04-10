SELECT
    ROW_NUMBER() OVER() AS 'Record No.',
    datetime(ZOBJECT.ZCREATIONDATE + 978307200, 'UNIXEPOCH') as 'Entry Creation Date (UTC)',
    datetime(ZOBJECT.ZCREATIONDATE + 978307200, 'UNIXEPOCH', 'localtime') as 'Entry Creation Date (Local)',
    datetime(ZOBJECT.ZSTARTDATE + 978307200, 'UNIXEPOCH') as 'Start Time (UTC)',
    datetime(ZOBJECT.ZSTARTDATE + 978307200, 'UNIXEPOCH', 'localtime') as 'Start Time (Local)',
    datetime(ZOBJECT.ZENDDATE + 978307200, 'UNIXEPOCH') as 'End Time (UTC)',
    datetime(ZOBJECT.ZENDDATE + 978307200, 'UNIXEPOCH', 'localtime') as 'End Time (Local)',
    (ZOBJECT.ZENDDATE - ZOBJECT.ZSTARTDATE) as 'Usage (Seconds)',
    (ZOBJECT.ZSECONDSFROMGMT / 3600) as 'GMT Offset',
    CASE ZOBJECT.ZSTARTDAYOFWEEK
        WHEN '1' THEN 'Sunday'
        WHEN '2' THEN 'Monday'
        WHEN '3' THEN 'Tuesday'
        WHEN '4' THEN 'Wednesday'
        WHEN '5' THEN 'Thursday'
        WHEN '6' THEN 'Friday'
        WHEN '7' THEN 'Saturday'
        ELSE ZOBJECT.ZSTARTDAYOFWEEK
    END 'Day of Week',
    ZOBJECT.ZSTREAMNAME as 'Stream Name',
    CASE ZOBJECT.ZVALUEINTEGER
        WHEN '0.0' THEN 'Unplugged'
        WHEN '1.0' THEN 'Plugged In'
        ELSE ZOBJECT.ZVALUEINTEGER
    END 'Device Status'

FROM ZOBJECT

WHERE ZSTREAMNAME LIKE '/device/isPluggedIn'

ORDER BY ZOBJECT.ZSTARTDATE DESC
