/*
For use with the CallHistory.storedata database
located at: /private/var/mobile/Library/CallHistoryDB/CallHistory.storedata
Use 'DESC' for decending order (most recent date at the top) OR can use 'ASC' for acending order
*/

SELECT
    ROW_NUMBER() OVER() AS 'RecordNo.',
    ZCALLRECORD.Z_PK AS 'CallSequenceNo.',
    datetime(ZCALLRECORD.ZDATE + 978307200, 'UNIXEPOCH') AS 'CallStartTime(UTC)',
    datetime(ZCALLRECORD.ZDATE + 978307200, 'UNIXEPOCH', 'localtime') AS 'CallStartTime(Local)',
    datetime((ZCALLRECORD.ZDATE + 978307200) + ZCALLRECORD.ZDURATION, 'UNIXEPOCH') AS 'CallEndTime(UTC)',
    datetime((ZCALLRECORD.ZDATE + 978307200) + ZCALLRECORD.ZDURATION, 'UNIXEPOCH', 'localtime') AS 'CallEndTime(Local)',
    TIME(ZCALLRECORD.ZDURATION, 'UNIXEPOCH') AS 'CallDuration',
    ZCALLRECORD.ZADDRESS AS 'ContactNumber',
    ZCALLRECORD.ZLOCATION AS 'Location',
    CASE ZCALLRECORD.ZANSWERED
        WHEN 0 THEN 'CallNOTAnswered'
        WHEN 1 THEN 'CallAnswered'
        ELSE ZCALLRECORD.ZANSWERED
    END AS 'CallAnsweredStatus',
    CASE ZCALLRECORD.ZORIGINATED
        WHEN 0 THEN 'IncomingCall'
        WHEN 1 THEN 'OutgoingCall'
        ELSE ZCALLRECORD.ZORIGINATED
    END as 'CallDirection',
    CASE ZCALLRECORD.ZCALLTYPE
        WHEN 1 THEN 'StandardCall'
        WHEN 8 THEN 'FullAVFacetimeCall'
        WHEN 16 THEN 'FacetimeAudioOnlyCall'
        ELSE ZCALLRECORD.ZCALLTYPE
    END AS 'CallType',
    ZCALLRECORD.ZSERVICE_PROVIDER AS 'Service Provider',
    /* Source for each line of data */
    'File: /private/var/mobile/Library/CallHistoryDB/CallHistory.storedata' AS 'DatabaseFile',
    'Table: ZCALLRECORD(Z_PK:' || ZCALLRECORD.Z_PK || ')' AS 'DataSource'

FROM ZCALLRECORD

ORDER BY ZCALLRECORD.ZDATE DESC
