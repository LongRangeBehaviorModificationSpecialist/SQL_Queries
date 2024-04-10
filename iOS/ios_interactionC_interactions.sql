SELECT
    ROW_NUMBER() OVER() AS 'Record No.',
    ZINTERACTIONS.ZBUNDLEID AS 'Bundle_ID',
    ZINTERACTIONS.ZDOMAINIDENTIFIER AS 'Domain_Identifier',
    ZINTERACTIONS.ZNSUSERNAME AS 'Username',
    datetime(ZINTERACTIONS.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'Start Date/Time (UTC)',
    datetime(ZINTERACTIONS.ZSTARTDATE + 978307200, 'UNIXEPOCH', 'localtime') AS 'Start Date/Time (Local)',
    datetime(ZINTERACTIONS.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'End Date/Time (UTC)',
    datetime(ZINTERACTIONS.ZENDDATE + 978307200, 'UNIXEPOCH', 'localtime') AS 'End Date/Time (Local)',
    datetime(ZINTERACTIONS.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'Creation Date/Time (UTC)',
    datetime(ZINTERACTIONS.ZCREATIONDATE + 978307200, 'UNIXEPOCH', 'localtime') AS 'Creation Date/Time (Local)',
    'Table: ZINTERACTIONS(Z_PK: ' || ZINTERACTIONS.Z_PK || ')' AS 'Data Source'

FROM ZINTERACTIONS

-- WHERE ZBUNDLEID LIKE '%whatsapp%'

ORDER BY ZINTERACTIONS.ZSTARTDATE ASC
