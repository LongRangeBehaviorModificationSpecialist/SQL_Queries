/*
    [DLU]
        2023-10-20
    [DATABASE PATH]
        /private/var/mobile/Library/CoreDuet/Knowledge/knowledgeC.db
*/

SELECT

    ROW_NUMBER() OVER() AS 'RecordNo.',
    ZOBJECT.Z_PK AS 'ZOBJECT.Z_PK',
    ZOBJECT.Z_PK AS 'TableID',

    CASE ZOBJECT.ZSTARTDAYOFWEEK
        WHEN '1' THEN 'Sunday'
        WHEN '2' THEN 'Monday'
        WHEN '3' THEN 'Tuesday'
        WHEN '4' THEN 'Wednesday'
        WHEN '5' THEN 'Thursday'
        WHEN '6' THEN 'Friday'
        WHEN '7' THEN 'Saturday'
        ELSE ZOBJECT.ZSTARTDAYOFWEEK
    END AS 'DayOfWeek',

    datetime(ZOBJECT.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'StartTime(UTC)',
    datetime(ZOBJECT.ZSTARTDATE + 978307200, 'UNIXEPOCH', 'localtime') AS 'StartTime(Local)',
    datetime(ZOBJECT.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'EndTime(UTC)',
    datetime(ZOBJECT.ZENDDATE + 978307200, 'UNIXEPOCH', 'localtime') AS 'EndTime(Local)',
    (ZOBJECT.ZSECONDSFROMGMT / 3600) AS 'GMTOffset',
    (ZOBJECT.ZENDDATE - ZOBJECT.ZSTARTDATE) AS 'Usage(Seconds)',
    ROUND(((ZOBJECT.ZENDDATE - ZOBJECT.ZSTARTDATE) / 60.00), 4) AS 'Usage(Minutes)',
    ZOBJECT.ZSTREAMNAME AS 'StreamName',

    CASE ZOBJECT.ZVALUEINTEGER
        WHEN '0.0' THEN 'False'
        WHEN '1.0' THEN 'True'
        ELSE ZOBJECT.ZVALUEINTEGER
    END AS 'Value',

    datetime(ZOBJECT.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'EntryCreationDate(UTC)'
    datetime(ZOBJECT.ZCREATIONDATE + 978307200, 'UNIXEPOCH', 'localtime') AS 'EntryCreationDate(Local)',

    'File: /private/var/mobile/Library/CoreDuet/Knowledge/knowledgeC.db' AS 'DatabaseFile',
    'Table: ZOBJECT(Z_PK:' || ZOBJECT.Z_PK || ')' AS 'DataSource'


FROM ZOBJECT
    LEFT JOIN ZSTRUCTUREDMETADATA on ZOBJECT.ZSTRUCTUREDMETADATA = ZSTRUCTUREDMETADATA.Z_PK
    LEFT JOIN ZSOURCE on ZOBJECT.ZSOURCE = ZSOURCE.Z_PK


WHERE ZSTREAMNAME LIKE '/device%'

--ZSTREAMNAME LIKE '/device/batteryPercentage'
--or ZSTREAMNAME LIKE '/device/batterySaver'
--or ZSTREAMNAME LIKE '/device/isLocked'
--or ZSTREAMNAME LIKE '/device/isPluggedIn'


ORDER BY ZOBJECT.ZSTARTDATE DESC
