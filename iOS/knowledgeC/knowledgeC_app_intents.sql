/*
    [DLU]
        2023-10-20
    [DATABASE PATH]
        /private/var/mobile/Library/CoreDuet/Knowledge/knowledgeC.db
*/

SELECT

    ROW_NUMBER() OVER() AS 'RecordNo.',
    ZOBJECT.Z_PK AS 'ZOBJECT.Z_PK',
    ZOBJECT.ZVALUESTRING AS 'IntentType',
    ZSTRUCTUREDMETADATA.Z_DKINTENTMETADATAKEY__INTENTCLASS AS 'IntentClass',
    ZSTRUCTUREDMETADATA.Z_DKINTENTMETADATAKEY__INTENTVERB AS 'IntentAction',
    ZSOURCE.ZBUNDLEID AS 'BundleID',
    datetime(ZOBJECT.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'RecordedDateTime(UTC)',
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
    END AS 'DayOfWeek',

    ZSOURCE.ZSOURCEID as 'SourceID',

    /* Source for each line of data */
    '/private/var/mobile/Library/CoreDuet/Knowledge/knowledgeC.db; Table: ZOBJECT(Z_PK:' || ZOBJECT.Z_PK || ')' AS 'DataSource'


FROM ZOBJECT

    LEFT JOIN ZSTRUCTUREDMETADATA ON ZOBJECT.ZSTRUCTUREDMETADATA = ZSTRUCTUREDMETADATA.Z_PK
    LEFT JOIN ZSOURCE ON ZOBJECT.ZSOURCE = ZSOURCE.Z_PK


WHERE

    ZBUNDLEID LIKE '%whatsapp%' AND ZSOURCEID LIKE 'intents'


ORDER BY ZOBJECT.ZCREATIONDATE ASC
