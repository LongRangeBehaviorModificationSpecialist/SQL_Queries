/*
[DLU]
    09-Mar-2026
[DATABASE FILE]
    /private/var/wireless/Library/Databases/DataUsage.sqlite
*/

SELECT

    ROW_NUMBER() OVER() AS 'record_number',

    CASE
        WHEN ZLIVEUSAGE.ZTIMESTAMP IS NULL THEN NULL
        ELSE datetime(ZLIVEUSAGE.ZTIMESTAMP + 978307200, 'UNIXEPOCH')
    END AS 'liveusage_timestamp_utc',

    datetime(ZPROCESS.ZFIRSTTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'first_timestamp_utc',
    datetime(ZPROCESS.ZTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'process_timestamp_utc',

    ZPROCESS.ZPROCNAME AS 'PROCESS_NAME',
    ZPROCESS.ZBUNDLENAME AS 'BUNDLE_NAME',
    printf("%,d", ZLIVEUSAGE.ZWIFIIN) AS 'wifi_bytes_in',
    printf("%,d", ZLIVEUSAGE.ZWIFIOUT) AS 'wifi_bytes_out',
    printf("%,d", ZLIVEUSAGE.ZWWANIN) AS 'wwan_bytes_in',
    printf("%,d", ZLIVEUSAGE.ZWWANOUT) AS 'wwan_bytes_out',

    /* Source for each line of data */
    'DataUsage.sqlite; Table:ZLIVEUSAGE(Z_PK:' || ZLIVEUSAGE.Z_PK || '), ' || 'Table: ZPROCESS(Z_PK:' || ZPROCESS.Z_PK || ')' AS 'data_source'


FROM ZLIVEUSAGE
    LEFT JOIN ZPROCESS ON ZLIVEUSAGE.ZHASPROCESS = ZPROCESS.Z_PK


WHERE
    ZPROCESS.ZPROCNAME LIKE '%compress%' OR
    ZPROCESS.ZBUNDLENAME LIKE '%compress%'


ORDER BY
    ZLIVEUSAGE.ZTIMESTAMP ASC
