/*
    [DLU]
        2023-10-20
    [DATABASE PATH]
        /private/var/mobile/Library/CoreDuet/Knowledge/knowledgeC.db
*/

SELECT

    ROW_NUMBER() OVER() AS 'RecordNo.',
    ZOBJECT.ZVALUESTRING AS 'BundleID',
    ZOBJECT.ZSTREAMNAME AS 'StreamName',
    ZSTRUCTUREDMETADATA.Z_DKAPPLICATIONMETADATAKEY__LAUNCHREASON AS 'LaunchReason',
    datetime(ZOBJECT.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'StartDateTime(UTC)',
    datetime(ZOBJECT.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'EndDateTime(UTC)',
    (ZOBJECT.ZENDDATE - ZOBJECT.ZSTARTDATE) AS 'Usage(Seconds)',
    datetime(ZOBJECT.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'EntryCreationDateTime(UTC)',
    (ZOBJECT.ZSECONDSFROMGMT / 3600) AS 'DeviceGMTOffset',
    ZOBJECT.ZUUID AS 'UUID',

    /* Source for each line of data */
    'File: /private/var/mobile/Library/CoreDuet/Knowledge/knowledgeC.db; Table: ZOBJECT(Z_PK:' || ZOBJECT.Z_PK || ')' AS 'DataSource'


FROM ZOBJECT
    LEFT JOIN ZSTRUCTUREDMETADATA ON ZOBJECT.ZSTRUCTUREDMETADATA = ZSTRUCTUREDMETADATA.Z_PK
    LEFT JOIN ZSOURCE ON ZOBJECT.ZSOURCE = ZSOURCE.Z_PK


WHERE
    (ZSTREAMNAME LIKE '%') AND ZVALUESTRING LIKE '%whatsapp%'


ORDER BY
    ZOBJECT.ZSTARTDATE DESC


--ZSTREAMNAME LIKE '/app/activity' OR
--ZSTREAMNAME LIKE '/app/inFocus' OR
--ZSTREAMNAME LIKE '/app/usage' OR
--ZSTREAMNAME LIKE '/app/intents' OR
--ZSTREAMNAME LIKE '/app/locationActivity' OR
--ZSTREAMNAME LIKE '/app/relevantShortcuts' OR
--ZSTREAMNAME LIKE '/app/webUsage'
