/*
File located at: \private\var\networkd\db\netusage.sqlite
*/

SELECT
    ROW_NUMBER() OVER() AS 'Record No.',
    datetime(ZPROCESS.ZTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'Process Timestamp (UTC)',
    datetime(ZPROCESS.ZTIMESTAMP + 978307200, 'UNIXEPOCH', 'localtime') AS 'Process Timestamp (Local)',
    datetime(ZLIVEUSAGE.ZTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'Live Usage Timestamp (UTC)',
    datetime(ZLIVEUSAGE.ZTIMESTAMP + 978307200, 'UNIXEPOCH', 'localtime') AS 'Live Usage Timestamp (Local)',
    ZPROCESS.ZBUNDLENAME AS 'Bundle ID',
    ZPROCESS.ZPROCNAME AS 'Process Name',
    ZLIVEUSAGE.ZWIFIIN AS 'WIFI IN',
    ZLIVEUSAGE.ZWIFIOUT AS 'WIFI OUT',
    ZLIVEUSAGE.ZWWANIN AS 'WWAN IN',
    ZLIVEUSAGE.ZWWANOUT AS 'WWAN OUT',
    ZLIVEUSAGE.ZWIREDIN AS 'WIRED IN',
    ZLIVEUSAGE.ZWIREDOUT AS 'WIRED OUT',
    ZLIVEUSAGE.ZXIN AS 'X IN',
    ZLIVEUSAGE.ZXOUT AS 'X OUT',
    'File: /private/var/networkd/db/netusage.sqlite; Table: ZLIVEUSAGE(Z_PK: ' || ZLIVEUSAGE.Z_PK || ')' AS 'Data Source'

FROM ZLIVEUSAGE
    LEFT JOIN ZPROCESS ON ZPROCESS.Z_PK = ZLIVEUSAGE.ZHASPROCESS

-- WHERE 'BUNDLE ID' LIKE '%whatsapp%'

ORDER BY ZLIVEUSAGE.Z_PK ASC
