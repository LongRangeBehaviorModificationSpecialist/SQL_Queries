/*
    Copied from
        https://github.com/ScottKjr3347/iOS_KnowledgeC.db_Queries/blob/main/NotificationUsage_SQLiteQuery
    [DLU]
        2023-10-20
    [DATABASE PATH]
        /private/var/mobile/Library/CoreDuet/Knowledge/knowledgeC.db
*/

SELECT

    ROW_NUMBER() OVER() AS 'RecordNo.',
    datetime(ZOBJECT.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'StartDateTime(UTC)',
    datetime(ZOBJECT.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'EndDateTime(UTC)',
    datetime(ZOBJECT.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'CreationDateTime(UTC)',
    ZOBJECT.ZSTREAMNAME AS 'ObjectStreamName',
    ZOBJECT.ZVALUESTRING AS 'NotificaionType',
    ZSTRUCTUREDMETADATA.Z_DKNOTIFICATIONUSAGEMETADATAKEY__BUNDLEID AS 'SMDBundleID',
    ZSTRUCTUREDMETADATA.Z_DKNOTIFICATIONUSAGEMETADATAKEY__IDENTIFIER AS 'SMDID',

    CASE ZOBJECT.ZSTARTDAYOFWEEK
        WHEN '1' THEN 'Sunday'
        WHEN '2' THEN 'Monday'
        WHEN '3' THEN 'Tuesday'
        WHEN '4' THEN 'Wednesday'
        WHEN '5' THEN 'Thursday'
        WHEN '6' THEN 'Friday'
        WHEN '7' THEN 'Saturday'
    END AS 'StartDayOfWeek',

    ZOBJECT.ZSTARTSECONDOFDAY AS 'StartSecondOfDay',

    CASE ZOBJECT.ZENDDAYOFWEEK
        WHEN '1' THEN 'Sunday'
        WHEN '2' THEN 'Monday'
        WHEN '3' THEN 'Tuesday'
        WHEN '4' THEN 'Wednesday'
        WHEN '5' THEN 'Thursday'
        WHEN '6' THEN 'Friday'
        WHEN '7' THEN 'Saturday'
    END AS 'EndDayOfWeek',

    ZOBJECT.ZENDSECONDOFDAY AS 'EndSecondOfDay',
    ZOBJECT.ZSECONDSFROMGMT/3600 AS 'GMTOffset',

    CASE ZOBJECT.ZHASSTRUCTUREDMETADATA
        WHEN '0' THEN 'No'
        WHEN '1' THEN 'Yes'
    END AS 'HasStructuredMetadata',

    ZOBJECT.ZSTRUCTUREDMETADATA AS 'SMDZPK',
    ZOBJECT.Z_PK AS 'ZOBJECTZPK',
    ZOBJECT.ZVALUEINTEGER AS 'ValueInterger',
    ZOBJECT.ZVALUETYPECODE AS 'ValueTypeCode',
    ZOBJECT.ZVALUEDOUBLE AS 'ValueDouble',
    ZOBJECT.ZUUID AS 'ZOBJECTUUID',
    ZSTRUCTUREDMETADATA.ZMETADATAHASH AS 'SMDMetadataHash'

    /* Source for each line of data */
    '/private/var/mobile/Library/CoreDuet/Knowledge/knowledgeC.db; Table: ZOBJECT(Z_PK:' || ZOBJECT.Z_PK || ')' AS 'DataSource'


FROM ZOBJECT
    LEFT JOIN ZSTRUCTUREDMETADATA ON ZSTRUCTUREDMETADATA.Z_PK = ZOBJECT.ZSTRUCTUREDMETADATA


WHERE
    ZSTREAMNAME IS '/notification/usage'


ORDER BY
    ZOBJECT.ZSTARTDATE ASC
