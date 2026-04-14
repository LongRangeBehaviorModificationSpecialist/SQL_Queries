/*
[DLU]
    14-Apr-2026
[DATABASE PATH]
    /private/var/mobile/Library/Caches/com.apple.routined/Cache.sqlite
[VERSION]
    iOS 16
*/

SELECT

    ROW_NUMBER() OVER() AS 'record_number',

    /* Primary key of the record */
    ZRTCLLOCATIONMO.Z_PK AS 'Z_PK',

    /* Convert the ZTIMESTAMP value to UTC in the 'yyyy-mm-ddTHH:MM:SSZ' format */
    strftime('%Y-%m-%dT%H:%M:%SZ', datetime(ZRTCLLOCATIONMO.ZTIMESTAMP + 978307200, 'UNIXEPOCH')) AS 'Timestamp(UTC)',

    /* Convert the ZTIMESTAMP value to local time in the 'yyyy-mm-dd HH:MM:SS' format */
    strftime('%Y-%m-%d %H:%M:%S (UTC-4)', datetime(ZRTCLLOCATIONMO.ZTIMESTAMP + 978307200, 'UNIXEPOCH', 'localtime')) AS 'Timestamp(LOCAL)',

    /* Latitude value of the entry */
    ZRTCLLOCATIONMO.ZLATITUDE AS 'Latitude',

    /* Longitude value of the entry */
    ZRTCLLOCATIONMO.ZLONGITUDE AS 'Longitude',

    RTRIM(LTRIM(CONCAT(ROUND(ZRTCLLOCATIONMO.ZLATITUDE, 6), ',', ROUND(ZRTCLLOCATIONMO.ZLONGITUDE, 6)))) AS 'Lat/Long(Merged)',

    /* Display the recorded speed for the data point (round the value to four decimal places) */
    CASE ZRTCLLOCATIONMO.ZSPEED
        WHEN -1 THEN '[N/A]'
        ELSE ROUND(ZRTCLLOCATIONMO.ZSPEED, 4)
    END AS 'Speed(meters/sec)',

    /* Convert meters/second to miles/hour (round the result to four decimal places) */
    CASE ZRTCLLOCATIONMO.ZSPEED
        WHEN -1 THEN '[N/A]'
        ELSE ROUND(ZRTCLLOCATIONMO.ZSPEED * 2.23694, 4)
    END AS 'Speed(mph)',

    CASE ZRTCLLOCATIONMO.ZCOURSE
        WHEN -1 THEN '[N/A]'
        ELSE ZRTCLLOCATIONMO.ZCOURSE
    END AS 'Course',

    /* Round the ZHORIZONTALACCURACY value to four decimal places */
    ROUND(ZRTCLLOCATIONMO.ZHORIZONTALACCURACY, 4) AS 'HorizontalAccuracy(m)',

    /* Convert the ZHORIZONTALACCURACY value from meters to feet and round the value to four decimal places */
    ROUND(ZRTCLLOCATIONMO.ZHORIZONTALACCURACY * 3.281, 4) AS 'HorizontalAccuracy(feet)',

    /* Round the ZVERTICALACCURACY value to four decimal places */
    ROUND(ZRTCLLOCATIONMO.ZVERTICALACCURACY, 4) AS 'VerticalAccuracy(m)',

    /* Convert the ZVERTICALACCURACY value from meters to feet and round the value to four decimal places */
    ROUND(ZRTCLLOCATIONMO.ZVERTICALACCURACY * 3.281, 4) AS 'VerticalAccuracy(feet)',

    /* Source for each line of data */
    'Cache.sqlite; Table: ZRTCLLOCATIONMO(Z_PK:' || ZRTCLLOCATIONMO.Z_PK || ')' AS 'DataSource'


FROM ZRTCLLOCATIONMO


WHERE
    -- Use this to search for records between a certain timestamp / Comment out if not needed
    ZRTCLLOCATIONMO.ZTIMESTAMP BETWEEN 732859200 AND 732877200


ORDER BY
    -- Will sort by timestamp value first. If two entries have the same timestamp, the entries will be sorted by their Z_PK value
    ZRTCLLOCATIONMO.ZTIMESTAMP ASC,
    ZRTCLLOCATIONMO.Z_PK
