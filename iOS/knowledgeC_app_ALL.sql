/*
File located at: \private\var\mobile\Library\CoreDuet\Knowledge\knowledgeC.db

DLU = 2023-10-20
*/

SELECT
    ROW_NUMBER() OVER() AS 'Record No.',
    ZOBJECT.ZVALUESTRING AS 'Bundle ID',
    ZOBJECT.ZSTREAMNAME AS 'Stream Name',
    ZSTRUCTUREDMETADATA.Z_DKAPPLICATIONMETADATAKEY__LAUNCHREASON AS 'Launch Reason',
    datetime(ZOBJECT.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'Start Time (UTC)',
    datetime(ZOBJECT.ZSTARTDATE + 978307200, 'UNIXEPOCH', 'localtime') AS 'Start Time (Local)',
    datetime(ZOBJECT.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'End Time (UTC)',
    datetime(ZOBJECT.ZENDDATE + 978307200, 'UNIXEPOCH', 'localtime') AS 'End Time (Local)',
    (ZOBJECT.ZENDDATE - ZOBJECT.ZSTARTDATE) AS 'Usage (Seconds)',
    datetime(ZOBJECT.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'Entry Creation Date (UTC)',
    datetime(ZOBJECT.ZCREATIONDATE + 978307200, 'UNIXEPOCH', 'localtime') AS 'Entry Creation Date (Local)',
    (ZOBJECT.ZSECONDSFROMGMT / 3600) AS 'Device GMT Offset',
    ZOBJECT.ZUUID AS 'UUID',
    'File: /private/var/mobile/Library/CoreDuet/Knowledge/knowledgeC.db; Table: ZOBJECT(Z_PK: ' || ZOBJECT.Z_PK || ')' AS 'Data Source'

FROM ZOBJECT
    LEFT JOIN ZSTRUCTUREDMETADATA ON ZOBJECT.ZSTRUCTUREDMETADATA = ZSTRUCTUREDMETADATA.Z_PK
    LEFT JOIN ZSOURCE ON ZOBJECT.ZSOURCE = ZSOURCE.Z_PK

WHERE (ZSTREAMNAME LIKE '%') AND ZVALUESTRING LIKE '%whatsapp%'

ORDER BY ZOBJECT.ZSTARTDATE DESC


--ZSTREAMNAME LIKE '/app/activity' OR
--ZSTREAMNAME LIKE '/app/inFocus' OR
--ZSTREAMNAME LIKE '/app/usage' OR
--ZSTREAMNAME LIKE '/app/intents' OR
--ZSTREAMNAME LIKE '/app/locationActivity' OR
--ZSTREAMNAME LIKE '/app/relevantShortcuts' OR
--ZSTREAMNAME LIKE '/app/webUsage'
