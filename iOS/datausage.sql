/*
File located at: /private/var/wireless/Library/Databases/DataUsage.sqlite
                 /private/var/wireless/Library/Databases/CellularUsage.db
*/

SELECT
    ROW_NUMBER() OVER() AS 'RecordNo.',
    datetime(ZLIVEUSAGE.ZTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'LiveUsageTimestamp(UTC)',
    datetime(ZPROCESS.ZFIRSTTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'ProcessFirstTimestamp(UTC)',
    datetime(ZPROCESS.ZTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'ProcessTimestamp(UTC)',
    ZPROCESS.ZPROCNAME AS 'ProcessName',
    ZPROCESS.ZBUNDLENAME AS 'BundleID',
    Z_PRIMARYKEY.Z_NAME as 'Type',
    ZLIVEUSAGE.ZWIFIIN AS 'WifiIn',
    ZLIVEUSAGE.ZWIFIOUT AS 'WifiOut',
    ZLIVEUSAGE.ZWWANIN AS 'WwanIn',
    ZLIVEUSAGE.ZWWANOUT AS 'WwanOut',
    'File: /private/var/wireless/Library/Databases/DataUsage.sqlite' AS 'DatabaseFile',
    'Table: ZLIVEUSAGE(Z_PK:' || ZLIVEUSAGE.Z_PK || '), ' || 'Table: ZPROCESS(Z_PK:' || ZPROCESS.Z_PK || ')' AS 'DataSource'

FROM ZLIVEUSAGE
    LEFT JOIN ZPROCESS ON ZLIVEUSAGE.ZHASPROCESS = ZPROCESS.Z_PK
    LEFT JOIN Z_PRIMARYKEY ON ZPROCESS.Z_ENT = Z_PRIMARYKEY.Z_ENT

-- WHERE 'PROCESS NAME' LIKE '%whisper%'

ORDER BY 'TIMESTAMP' ASC
