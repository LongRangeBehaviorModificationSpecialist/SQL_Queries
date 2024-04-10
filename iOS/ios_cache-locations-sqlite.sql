/*
File Location in iOS: \private\var\mobile\Library\Caches\com.apple.routined\Cache.sqlite
iOS version: 16
*/

SELECT
    /* This is a useless row that is needed for the index value for the Python pandas data frame object */
    ROW_NUMBER() OVER() AS 'forDF',
    ROW_NUMBER() OVER() AS 'Record',
    /* Primary key of the record */
    ZRTCLLOCATIONMO.Z_PK AS 'Z_PK',
    -- ZRTCLLOCATIONMO.ZTIMESTAMP AS 'Timestamp (Original)',
    /* Convert the ZTIMESTAMP value to UTC in the `yyyy-mm-ddTHH:MM:SSZ` format */
    strftime('%Y-%m-%dT%H:%M:%SZ', datetime(ZRTCLLOCATIONMO.ZTIMESTAMP + 978307200, 'UNIXEPOCH')) AS 'Timestamp (UTC)',
    /* Convert the ZTIMESTAMP value to local time in the `yyyy-mm-dd HH:MM:SS` format */
    strftime('%Y-%m-%d %H:%M:%S (UTC-4)', datetime(ZRTCLLOCATIONMO.ZTIMESTAMP + 978307200, 'UNIXEPOCH', 'localtime')) AS 'Timestamp (Local)',
    /* Latitude value of the entry */
    ZRTCLLOCATIONMO.ZLATITUDE AS 'LATITUDE',
    /* Longitude value of the entry */
    ZRTCLLOCATIONMO.ZLONGITUDE AS 'LONGITUDE',
    /* Display the recorded speed for the data point (round the value to four decimal places) */
    CASE ZRTCLLOCATIONMO.ZSPEED
        WHEN -1 THEN 'n/a'
        ELSE ROUND(ZRTCLLOCATIONMO.ZSPEED, 4)
    END AS 'Speed (meters/sec)',
    /* Convert meters/second to miles/hour (round the value to four decimal places) */
    CASE ZRTCLLOCATIONMO.ZSPEED
        WHEN -1 THEN 'n/a'
        ELSE ROUND(ZRTCLLOCATIONMO.ZSPEED * 2.23694, 4)
    END AS 'Speed (mph)',
    CASE ZRTCLLOCATIONMO.ZCOURSE
        WHEN -1 THEN 'n/a'
        ELSE ZRTCLLOCATIONMO.ZCOURSE
    END AS 'Course',
    /* Round the ZHORIZONTALACCURACY value to four decimal places */
    ROUND(ZRTCLLOCATIONMO.ZHORIZONTALACCURACY, 4) AS 'Horiz Accuracy (m)',
    /* Convert the ZHORIZONTALACCURACY value from meters to feet and round the value to four decimal places */
    ROUND(ZRTCLLOCATIONMO.ZHORIZONTALACCURACY * 3.281, 4) AS 'Horiz Accuracy (feet)',
    /* Round the ZVERTICALACCURACY value to four decimal places */
    ROUND(ZRTCLLOCATIONMO.ZVERTICALACCURACY, 4) AS 'Vertical Accuracy (m)',
    /* Convert the ZVERTICALACCURACY value from meters to feet and round the value to four decimal places */
    ROUND(ZRTCLLOCATIONMO.ZVERTICALACCURACY * 3.281, 4) AS 'Vertical Accuracy (feet)',
    '\private\var\mobile\Library\Caches\com.apple.routined\Cache.sqlite [ZRTCLLOCATIONMO(Z_PK: ' || ZRTCLLOCATIONMO.Z_PK || ')]' AS 'Data Source'

FROM ZRTCLLOCATIONMO

/*
Use this to search for records between a certain timestamp
Comment out if not needed
*/
WHERE ZRTCLLOCATIONMO.ZTIMESTAMP BETWEEN 732859200 AND 732877200

/* Will sort by timestamp value first. If two entries have the same timestamp, the entries will be sorted by their Z_PK value */
ORDER BY ZRTCLLOCATIONMO.ZTIMESTAMP ASC, ZRTCLLOCATIONMO.Z_PK

/*
NOTE:
732859200 = 2024-03-24 04:00:00 (UTC) [2024-03-24 00:00:00 (EDT)]
732877200 = 2024-03-24 09:00:00 (UTC) [2024-03-24 05:00:00 (EDT)]
*/
