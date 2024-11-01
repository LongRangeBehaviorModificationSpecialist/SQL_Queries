/*
    [DLU]
        2024-10-23
    [DATABASE FILE]
        /private/var/wireless/Library/Databases/DataUsage.sqlite
*/

SELECT

    ROW_NUMBER() OVER() AS 'RecordNo.',
    datetime(ZLIVEUSAGE.ZTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'LiveUsageDateTimestamp(UTC)',
    datetime(ZPROCESS.ZFIRSTTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'ProcessFirstDateTimestamp(UTC)',
    datetime(ZPROCESS.ZTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'ProcessDateTimestamp(UTC)',
    ZPROCESS.ZPROCNAME AS 'ProcessName',
    ZPROCESS.ZBUNDLENAME AS 'BundleID',
    Z_PRIMARYKEY.Z_NAME as 'Type',
    ZLIVEUSAGE.ZWIFIIN AS 'WifiIn',
    ZLIVEUSAGE.ZWIFIOUT AS 'WifiOut',
    ZLIVEUSAGE.ZWWANIN AS 'WwanIn',
    ZLIVEUSAGE.ZWWANOUT AS 'WwanOut',

    /* Source for each line of data */
    '/private/var/wireless/Library/Databases/DataUsage.sqlite; Table: ZLIVEUSAGE(Z_PK:' || ZLIVEUSAGE.Z_PK || '), ' || 'Table: ZPROCESS(Z_PK:' || ZPROCESS.Z_PK || ')' AS 'DataSource'


FROM ZLIVEUSAGE
    LEFT JOIN ZPROCESS ON ZLIVEUSAGE.ZHASPROCESS = ZPROCESS.Z_PK
    LEFT JOIN Z_PRIMARYKEY ON ZPROCESS.Z_ENT = Z_PRIMARYKEY.Z_ENT


WHERE
    ZPROCESS.ZPROCNAME LIKE '%whisper%'


ORDER BY
    ZLIVEUSAGE.ZTIMESTAMP ASC
