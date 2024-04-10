/*
Copied from https://github.com/ScottKjr3347/iOS_KnowledgeC.db_Queries/blob/main/NotificationUsage_SQLiteQuery
*/

SELECT
    /* Add a row number at the beggining of each row */
    ROW_NUMBER() OVER() AS 'Row #',
    datetime(ZOBJECT.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'Start_Date',
    datetime(ZOBJECT.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'End_Date',
    datetime(ZOBJECT.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'Creation_Date',
    datetime(ZOBJECT.ZLOCALCREATIONDATE + 978307200, 'UNIXEPOCH', 'localtime') AS 'Local_Creation_Date',
    ZOBJECT.ZSTREAMNAME AS 'Object_StreamName',
    ZOBJECT.ZVALUESTRING AS 'Notificaion_Type',
    ZSTRUCTUREDMETADATA.Z_DKNOTIFICATIONUSAGEMETADATAKEY__BUNDLEID AS 'SMD_BundleID',
    ZSTRUCTUREDMETADATA.Z_DKNOTIFICATIONUSAGEMETADATAKEY__IDENTIFIER AS 'SMD_ID',
    CASE ZOBJECT.ZSTARTDAYOFWEEK
        WHEN '1' THEN 'Sunday'
        WHEN '2' THEN 'Monday'
        WHEN '3' THEN 'Tuesday'
        WHEN '4' THEN 'Wednesday'
        WHEN '5' THEN 'Thursday'
        WHEN '6' THEN 'Friday'
        WHEN '7' THEN 'Saturday'
    END AS 'Start_Day_of_the_Week',
    ZOBJECT.ZSTARTSECONDOFDAY AS 'StartSecondofDay',
    CASE ZOBJECT.ZENDDAYOFWEEK
        WHEN '1' THEN 'Sunday'
        WHEN '2' THEN 'Monday'
        WHEN '3' THEN 'Tuesday'
        WHEN '4' THEN 'Wednesday'
        WHEN '5' THEN 'Thursday'
        WHEN '6' THEN 'Friday'
        WHEN '7' THEN 'Saturday'
    END AS 'End_Day_of_the_Week',
    ZOBJECT.ZENDSECONDOFDAY AS 'EndSecondOfDay',
    ZOBJECT.ZSECONDSFROMGMT/3600 AS "GMT OFFSET",
    CASE ZOBJECT.ZHASSTRUCTUREDMETADATA
        WHEN '0' THEN 'No'
        WHEN '1' THEN 'Yes'
    END AS 'Has_Structured_Metadata',
    ZOBJECT.ZSTRUCTUREDMETADATA AS 'SMD_ZPK',
    ZOBJECT.Z_PK AS 'ZOBJECT_ZPK',
    ZOBJECT.ZVALUEINTEGER AS 'ValueInterger',
    ZOBJECT.ZVALUETYPECODE AS 'ValueTypeCode',
    ZOBJECT.ZVALUEDOUBLE AS 'ValueDouble',
    ZOBJECT.ZUUID AS 'ZOBJECT_UUID',
    ZSTRUCTUREDMETADATA.ZMETADATAHASH AS 'SMD_MetadataHash'

FROM ZOBJECT
  LEFT JOIN ZSTRUCTUREDMETADATA ON ZSTRUCTUREDMETADATA.Z_PK = ZOBJECT.ZSTRUCTUREDMETADATA

WHERE ZSTREAMNAME IS '/notification/usage'

ORDER by ZOBJECT.ZSTARTDATE
