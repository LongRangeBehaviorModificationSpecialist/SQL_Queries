/*
    Copied from https://www.mac4n6.com/blog/2018/8/5/knowledge-is-power-using-the-knowledgecdb-database-on-macos-and-ios-to-determine-precise-user-and-application-usage

    [DLU]
        2023-10-20
    [DATABASE PATH]
        /private/var/mobile/Library/CoreDuet/Knowledge/knowledgeC.db
*/


SELECT
    ROW_NUMBER() OVER() AS 'RecordNo.',
    ZOBJECT.Z_PK AS 'ZOBJECT.Z_PK',
    ZOBJECT.ZSOURCE AS 'ZOBJECT.ZSOURCE',
    datetime(ZOBJECT.ZCREATIONDATE + 978307200, 'UNIXEPOCH', 'localtime') AS 'EntryCreation(Local)',

    CASE ZOBJECT.ZSTARTDAYOFWEEK
        WHEN '1' THEN 'Sunday'
        WHEN '2' THEN 'Monday'
        WHEN '3' THEN 'Tuesday'
        WHEN '4' THEN 'Wednesday'
        WHEN '5' THEN 'Thursday'
        WHEN '6' THEN 'Friday'
        WHEN '7' THEN 'Saturday'
    END 'DayOfWeek',

    datetime(ZOBJECT.ZSTARTDATE + 978307200, 'UNIXEPOCH', 'localtime') AS 'StartTime(Local)',
    datetime(ZOBJECT.ZENDDATE + 978307200, 'UNIXEPOCH', 'localtime') AS 'EndTime(Local)',
    (ZOBJECT.ZENDDATE-ZOBJECT.ZSTARTDATE) AS 'Usage(seconds)',
    ZSOURCE.ZDEVICEID AS 'DeviceID',
    ZOBJECT.ZSTREAMNAME AS 'StreamName',
    ZOBJECT.ZVALUESTRING AS 'ValueString',
    ZSTRUCTUREDMETADATA.Z_DKAPPLICATIONACTIVITYMETADATAKEY__ACTIVITYTYPE AS 'AcitivityType',
    ZSTRUCTUREDMETADATA.Z_DKAPPLICATIONACTIVITYMETADATAKEY__TITLE AS 'Title',
    ZSTRUCTUREDMETADATA.Z_DKAPPLICATIONACTIVITYMETADATAKEY__USERACTIVITYREQUIREDSTRING AS 'ActivityString',
    datetime(ZSTRUCTUREDMETADATA.Z_DKAPPLICATIONACTIVITYMETADATAKEY__EXPIRATIONDATE + 978307200, 'UNIXEPOCH', 'localtime') AS 'ExpirationDate(Local)',
    ZSTRUCTUREDMETADATA.Z_DKINTENTMETADATAKEY__INTENTCLASS AS 'IntentClass',
    ZSTRUCTUREDMETADATA.Z_DKINTENTMETADATAKEY__INTENTVERB AS 'IntentVerb',
    ZSTRUCTUREDMETADATA.Z_DKINTENTMETADATAKEY__SERIALIZEDINTERACTION AS 'SerializedInteraction',
    ZSOURCE.ZBUNDLEID AS 'Bundle ID',

    'File: /private/var/mobile/Library/CoreDuet/Knowledge/knowledgeC.db' AS 'DatabaseFile',
    'Table: ZOBJECT(Z_PK:' || ZOBJECT.Z_PK || ')' AS 'DataSource'

FROM ZOBJECT

    LEFT JOIN ZSTRUCTUREDMETADATA ON ZOBJECT.ZSTRUCTUREDMETADATA = ZSTRUCTUREDMETADATA.Z_PK
    LEFT JOIN ZSOURCE ON ZOBJECT.ZSOURCE = ZSOURCE.Z_PK

WHERE
    ZSTREAMNAME IS '/app/activity' OR
    ZSTREAMNAME IS '/app/inFocus' OR
    ZSTREAMNAME IS '/app/intents' AND
    ZBUNDLEID IS 'com.toyopagroup.picaboo'

ORDER BY 'START'