/*
DLU: 17-Jul-2025

For use with the CallHistory.storedata database
located at: /private/var/mobile/Library/CallHistoryDB/CallHistory.storedata
Use 'DESC' for decending order (most recent date at the top) OR can use 'ASC' for acending order
*/


SELECT

    ROW_NUMBER() OVER() AS 'RecordNo.',
    ZCALLRECORD.Z_PK AS 'ZCALLRECORD.Z_PK.',
    datetime(ZCALLRECORD.ZDATE + 978307200, 'UNIXEPOCH') AS 'ZCALLRECORD.ZDATE(UTC)',
    datetime((ZCALLRECORD.ZDATE + 978307200) + ZCALLRECORD.ZDURATION, 'UNIXEPOCH') AS 'CallEndTime(UTC)',
    TIME(ZCALLRECORD.ZDURATION, 'UNIXEPOCH') AS 'ZCALLRECORD.ZDURATION',
    ZCALLRECORD.ZADDRESS AS 'ZCALLRECORD.ZADDRESS',
    ZCALLRECORD.ZLOCATION AS 'ZCALLRECORD.ZLOCATION',

    CASE ZCALLRECORD.ZANSWERED
        WHEN 0 THEN '0 [NOT Answered]'
        WHEN 1 THEN '1 [Answered]'
        ELSE ZCALLRECORD.ZANSWERED
    END AS 'ZCALLRECORD.ZANSWERED',

    CASE ZCALLRECORD.ZORIGINATED
        WHEN 0 THEN '0 [Incoming]'
        WHEN 1 THEN '1 [Outgoing]'
        ELSE ZCALLRECORD.ZORIGINATED
    END as 'ZCALLRECORD.ZORIGINATED',

    CASE ZCALLRECORD.ZCALLTYPE
        WHEN 1 THEN '1 [Standard]'
        WHEN 8 THEN '8 [Full AV FaceTime]'
        WHEN 16 THEN '16 [FaceTime Audio Only]'
        ELSE ZCALLRECORD.ZCALLTYPE
    END AS 'ZCALLRECORD.ZCALLTYPE',

    ZCALLRECORD.ZSERVICE_PROVIDER AS 'ZCALLRECORD.ZSERVICE_PROVIDER',

    /* Source for each line of data */
    '/private/var/mobile/Library/CallHistoryDB/CallHistory.storedata; Table: ZCALLRECORD(Z_PK:' || ZCALLRECORD.Z_PK || ')' AS 'DATA_SOURCE'


FROM ZCALLRECORD


ORDER BY
    ZCALLRECORD.ZDATE DESC
