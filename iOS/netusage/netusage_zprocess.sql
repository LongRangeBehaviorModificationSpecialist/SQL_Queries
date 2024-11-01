SELECT

    ROW_NUMBER() OVER() AS 'RecordNo.',
    ZPROCESS.Z_PK AS 'ZPROCESS.Z_PK'
    datetime(ZPROCESS.ZTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'ProcessDateTime(UTC)',
    datetime(ZPROCESS.ZFIRSTTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'ProcessFirstDateTime(UTC)',
    ZPROCESS.ZPROCNAME AS 'ProcessName',
    ZPROCESS.ZBUNDLENAME AS 'BundleID',

    /* Source for each line of data */
    '/private/var/networkd/db/netusage.sqlite; Table: ZPROCESS(Z_PK: ' || ZPROCESS.Z_PK || ')' AS 'DataSource'


FROM ZPROCESS


WHERE
    ZPROCESS.ZBUNDLENAME LIKE '%whisper%'


ORDER BY
    ZPROCESS.ZTIMESTAMP ASC
