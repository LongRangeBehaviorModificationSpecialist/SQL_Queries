SELECT
    ROW_NUMBER() OVER() AS 'RecordNo.',
    ZINTERACTIONS.ZBUNDLEID AS 'BundleID',
    ZINTERACTIONS.ZDOMAINIDENTIFIER AS 'DomainIdentifier',
    ZINTERACTIONS.ZNSUSERNAME AS 'Username',
    datetime(ZINTERACTIONS.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'StartDateTime(UTC)',
    datetime(ZINTERACTIONS.ZSTARTDATE + 978307200, 'UNIXEPOCH', 'localtime') AS 'StartDateTime(Local)',
    datetime(ZINTERACTIONS.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'EndDateTime(UTC)',
    datetime(ZINTERACTIONS.ZENDDATE + 978307200, 'UNIXEPOCH', 'localtime') AS 'EndDateTime(Local)',
    datetime(ZINTERACTIONS.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'CreationDate/Time(UTC)',
    datetime(ZINTERACTIONS.ZCREATIONDATE + 978307200, 'UNIXEPOCH', 'localtime') AS 'CreationDateTime(Local)',
    'Table: ZINTERACTIONS(Z_PK: ' || ZINTERACTIONS.Z_PK || ')' AS 'DataSource'

FROM ZINTERACTIONS

-- WHERE ZBUNDLEID LIKE '%whatsapp%'

ORDER BY ZINTERACTIONS.ZSTARTDATE ASC
