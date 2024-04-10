/*
Copied from https://github.com/ScottKjr3347/iOS_KnowledgeC.db_Queries/blob/main/NotificationUsage_SQLiteQuery
*/

SELECT
    /* Add a row number at the beggining of each row */
    ROW_NUMBER() OVER() AS 'Record No.',
    datetime(ZOBJECT.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'Start Date (UTC)',
    datetime(ZOBJECT.ZSTARTDATE + 978307200, 'UNIXEPOCH', 'localtime') AS 'Start Date (Local)',
    datetime(ZOBJECT.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'End Date (UTC)',
    datetime(ZOBJECT.ZENDDATE + 978307200, 'UNIXEPOCH', 'localtime') AS 'End Date (Local)',
    datetime(ZOBJECT.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'Creation Date (UTC)',
    datetime(ZOBJECT.ZLOCALCREATIONDATE + 978307200, 'UNIXEPOCH', 'localtime') AS 'Creation Date (Local)',
    ZOBJECT.ZSTREAMNAME AS 'Object StreamName',
    ZOBJECT.ZVALUESTRING AS 'Notificaion Type',
    ZSTRUCTUREDMETADATA.Z_DKNOTIFICATIONUSAGEMETADATAKEY__BUNDLEID AS 'SMD BundleID',
    ZSTRUCTUREDMETADATA.Z_DKNOTIFICATIONUSAGEMETADATAKEY__IDENTIFIER AS 'SMD ID',
    CASE ZOBJECT.ZSTARTDAYOFWEEK
        WHEN '1' THEN 'Sunday'
        WHEN '2' THEN 'Monday'
        WHEN '3' THEN 'Tuesday'
        WHEN '4' THEN 'Wednesday'
        WHEN '5' THEN 'Thursday'
        WHEN '6' THEN 'Friday'
        WHEN '7' THEN 'Saturday'
    END AS 'Start_Day_of_the_Week',
    ZOBJECT.ZSTARTSECONDOFDAY AS 'Start Second of Day',
    CASE ZOBJECT.ZENDDAYOFWEEK
        WHEN '1' THEN 'Sunday'
        WHEN '2' THEN 'Monday'
        WHEN '3' THEN 'Tuesday'
        WHEN '4' THEN 'Wednesday'
        WHEN '5' THEN 'Thursday'
        WHEN '6' THEN 'Friday'
        WHEN '7' THEN 'Saturday'
    END AS 'End_Day_of_the_Week',
    ZOBJECT.ZENDSECONDOFDAY AS 'End Second O fDay',
    ZOBJECT.ZSECONDSFROMGMT/3600 AS "GMT OFFSET",
    CASE ZOBJECT.ZHASSTRUCTUREDMETADATA
        WHEN '0' THEN 'No'
        WHEN '1' THEN 'Yes'
    END AS 'Has Structured Metadata',
    ZOBJECT.ZSTRUCTUREDMETADATA AS 'SMD ZPK',
    ZOBJECT.Z_PK AS 'ZOBJECT ZPK',
    ZOBJECT.ZVALUEINTEGER AS 'Value Interger',
    ZOBJECT.ZVALUETYPECODE AS 'Value Type Code',
    ZOBJECT.ZVALUEDOUBLE AS 'Value Double',
    ZOBJECT.ZUUID AS 'ZOBJECT UUID',
    ZSTRUCTUREDMETADATA.ZMETADATAHASH AS 'SMD MetadataHash'

FROM ZOBJECT
  LEFT JOIN ZSTRUCTUREDMETADATA ON ZSTRUCTUREDMETADATA.Z_PK = ZOBJECT.ZSTRUCTUREDMETADATA

WHERE ZSTREAMNAME IS '/notification/usage'

ORDER by ZOBJECT.ZSTARTDATE
