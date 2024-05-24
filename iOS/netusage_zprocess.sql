SELECT
    ROW_NUMBER() OVER() AS 'RecordNo.',
    ZPROCESS.Z_PK AS 'ZPROCESS.Z_PK'
    datetime(ZPROCESS.ZTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'Timestamp(UTC)',
    datetime(ZPROCESS.ZTIMESTAMP + 978307200, 'UNIXEPOCH', 'localtime') AS 'Timestamp(Local)',
    datetime(ZPROCESS.ZFIRSTTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'ProcessFirstTimestamp(UTC)',
    datetime(ZPROCESS.ZFIRSTTIMESTAMP + 978307200, 'UNIXEPOCH', 'localtime') AS 'ProcessFirstTimestamp(Local)',
    ZPROCESS.ZPROCNAME AS 'ProcessName',
    ZPROCESS.ZBUNDLENAME AS 'BundleID',
    'File: /private/var/networkd/db/netusage.sqlite' AS 'DatabaseFile',
    'Table: ZPROCESS(Z_PK: ' || ZPROCESS.Z_PK || ')' AS 'DataSource'

FROM ZPROCESS

--WHERE 'BUNDLE ID' LIKE '%whisper%'

ORDER BY ZPROCESS.ZTIMESTAMP ASC
