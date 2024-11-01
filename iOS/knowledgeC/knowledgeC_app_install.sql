/*
    [DLU]
        2023-10-20
    [DATABASE PATH]
        /private/var/mobile/Library/CoreDuet/Knowledge/knowledgeC.db
*/

SELECT

    ROW_NUMBER() OVER() AS 'RecordNo.',
    ZOBJECT.Z_PK AS 'ZOBJECT.Z_PK',
    datetime(ZOBJECT.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'EntryCreationDateTime(UTC)',
    datetime(ZOBJECT.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'StartDateTime(UTC)',
    datetime(ZOBJECT.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'EndDateTime(UTC)',
    (ZOBJECT.ZENDDATE - ZOBJECT.ZSTARTDATE) AS 'Usage(Seconds)',
    (ZOBJECT.ZSECONDSFROMGMT / 3600) AS 'GMTOffset',

    CASE ZOBJECT.ZSTARTDAYOFWEEK
        WHEN '1' THEN 'Sunday'
        WHEN '2' THEN 'Monday'
        WHEN '3' THEN 'Tuesday'
        WHEN '4' THEN 'Wednesday'
        WHEN '5' THEN 'Thursday'
        WHEN '6' THEN 'Friday'
        WHEN '7' THEN 'Saturday'
        ELSE ZOBJECT.ZSTARTDAYOFWEEK
    END 'DayOfWeek',

    ZOBJECT.ZSTREAMNAME AS 'StreamName',
    ZOBJECT.ZVALUESTRING AS 'ValueString',

    /* Source for each line of data */
    '/private/var/mobile/Library/CoreDuet/Knowledge/knowledgeC.db; Table: ZOBJECT(Z_PK:' || ZOBJECT.Z_PK || ')' AS 'DataSource'


FROM ZOBJECT
    LEFT JOIN ZSTRUCTUREDMETADATA on ZOBJECT.ZSTRUCTUREDMETADATA = ZSTRUCTUREDMETADATA.Z_PK
    LEFT JOIN ZSOURCE on ZOBJECT.ZSOURCE = ZSOURCE.Z_PK


WHERE
    ZSTREAMNAME IS '/app/install'


ORDER BY
    ZOBJECT.ZSTARTDATE
