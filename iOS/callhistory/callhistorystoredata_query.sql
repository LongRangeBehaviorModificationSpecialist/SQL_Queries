/*
[DLU]
    17-Jul-2025

For use with the CallHistory.storedata database
located at: /private/var/mobile/Library/CallHistoryDB/CallHistory.storedata
Use 'DESC' for decending order (most recent date at the top) OR can use 'ASC' for acending order
*/


SELECT

    ROW_NUMBER() OVER() AS 'record_number',

    ZCALLRECORD.Z_PK AS 'ZCALLRECORD.z_pk',

    datetime(ZCALLRECORD.ZDATE + 978307200, 'UNIXEPOCH') AS 'ZCALLRECORD.zdate_utc',
    datetime((ZCALLRECORD.ZDATE + 978307200) + ZCALLRECORD.ZDURATION, 'UNIXEPOCH') AS 'call-end-time_utc',

    TIME(ZCALLRECORD.ZDURATION, 'UNIXEPOCH') AS 'ZCALLRECORD.zduration(seconds)',
    ZCALLRECORD.ZADDRESS AS 'ZCALLRECORD.zaddress',
    ZCALLRECORD.ZLOCATION AS 'ZCALLRECORD.zlocation',

    CASE ZCALLRECORD.ZANSWERED
        WHEN 0 THEN 'NOT Answered [0]'
        WHEN 1 THEN 'Answered [1]'
        ELSE 'Unknown Value: ' || ZCALLRECORD.ZANSWERED || ''
    END AS 'ZCALLRECORD.zanswered',

    CASE ZCALLRECORD.ZORIGINATED
        WHEN 0 THEN 'Incoming [0]'
        WHEN 1 THEN 'Outgoing [1]'
        ELSE 'Unknown Value: ' || ZCALLRECORD.ZORIGINATED || ''
    END as 'ZCALLRECORD.zoriginated',

    CASE ZCALLRECORD.ZCALLTYPE
        WHEN 1 THEN 'Standard [1]'
        WHEN 8 THEN 'Full AV FaceTime [8]'
        WHEN 16 THEN 'FaceTime Audio Only [16]'
        ELSE 'Unknown Value :' || ZCALLRECORD.ZCALLTYPE || ''
    END AS 'ZCALLRECORD.zcalltype',

    ZCALLRECORD.ZSERVICE_PROVIDER AS 'ZCALLRECORD.zservice_provider',

    /* Source for each line of data */
    'CallHistory.storedata; Table: ZCALLRECORD(Z_PK:' || ZCALLRECORD.Z_PK || ')' AS 'data_source'


FROM ZCALLRECORD


ORDER BY
    ZCALLRECORD.ZDATE DESC
