/*
[DLU]
    17-Jul-2025

For use with the CallHistory.storedata database
located at: /private/var/mobile/Library/CallHistoryDB/CallHistory.storedata
Use 'DESC' for decending order (most recent date at the top) OR can use 'ASC' for acending order
*/


SELECT

    ROW_NUMBER() OVER() AS 'Row No.',

    ZCALLRECORD.Z_PK AS 'z_pk',

    ZCALLRECORD.ZADDRESS AS 'Partner(s)',
    ZCALLRECORD.ZLOCATION AS 'ZLOCATION',

    datetime(ZCALLRECORD.ZDATE + 978307200, 'UNIXEPOCH') AS 'Call Date/Time (UTC)',
    datetime((ZCALLRECORD.ZDATE + 978307200) + ZCALLRECORD.ZDURATION, 'UNIXEPOCH') AS 'Call End Date/Time (UTC)',
    TIME(ZCALLRECORD.ZDURATION, 'UNIXEPOCH') AS 'Call Duration',

    CASE ZCALLRECORD.ZANSWERED
        WHEN 0 THEN 'NOT Answered  [0]'
        WHEN 1 THEN 'Answered  [1]'
        ELSE 'Unknown Value: ' || ZCALLRECORD.ZANSWERED || ''
    END AS 'Call Status',

    CASE ZCALLRECORD.ZORIGINATED
        WHEN 0 THEN 'Incoming  [0]'
        WHEN 1 THEN 'Outgoing  [1]'
        ELSE 'Unknown Value: ' || ZCALLRECORD.ZORIGINATED || ''
    END as 'Call Direction',

    CASE ZCALLRECORD.ZCALLTYPE
        WHEN 1 THEN 'Standard  [1]'
        WHEN 8 THEN 'Full AV FaceTime  [8]'
        WHEN 16 THEN 'FaceTime Audio Only  [16]'
        ELSE 'Unknown Value :' || ZCALLRECORD.ZCALLTYPE || ''
    END AS 'Call Type',

    ZCALLRECORD.ZSERVICE_PROVIDER AS 'Service Provider',

    /* Source for each line of data */
    'CallHistory.storedata; Table: ZCALLRECORD(Z_PK:' || ZCALLRECORD.Z_PK || ')' AS 'Data Source'


FROM ZCALLRECORD


ORDER BY
    ZCALLRECORD.ZDATE DESC
