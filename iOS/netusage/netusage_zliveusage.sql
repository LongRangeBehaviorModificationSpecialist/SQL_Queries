/*
File located at: \private\var\networkd\db\netusage.sqlite
*/

SELECT

    ROW_NUMBER() OVER() AS 'RecordNo.',
    datetime(ZPROCESS.ZTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'ProcessDateTimestamp(UTC)',
    datetime(ZLIVEUSAGE.ZTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'LiveUsageDateTimestamp(UTC)',
    ZPROCESS.ZBUNDLENAME AS 'BundleID',
    ZPROCESS.ZPROCNAME AS 'ProcessName',
    ZLIVEUSAGE.ZWIFIIN AS 'WifiIn',
    ZLIVEUSAGE.ZWIFIOUT AS 'WifiOut',
    ZLIVEUSAGE.ZWWANIN AS 'WwanIn',
    ZLIVEUSAGE.ZWWANOUT AS 'WwanOut',
    ZLIVEUSAGE.ZWIREDIN AS 'WiredIn',
    ZLIVEUSAGE.ZWIREDOUT AS 'WiredOut',
    ZLIVEUSAGE.ZXIN AS 'XIn',
    ZLIVEUSAGE.ZXOUT AS 'XOut',

    /* Source for each line of data */
    '/private/var/networkd/db/netusage.sqlite; Table: ZLIVEUSAGE(Z_PK: ' || ZLIVEUSAGE.Z_PK || ')' AS 'DataSource'


FROM ZLIVEUSAGE
    LEFT JOIN ZPROCESS ON ZPROCESS.Z_PK = ZLIVEUSAGE.ZHASPROCESS


WHERE
    'BUNDLE ID' LIKE '%whatsapp%'


ORDER BY
    ZLIVEUSAGE.Z_PK ASC
