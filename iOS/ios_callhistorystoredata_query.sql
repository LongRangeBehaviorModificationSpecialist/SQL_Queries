/*
For use with the CallHistory.storedata database 
located at: \private\var\mobile\Library\CallHistoryDB\CallHistory.storedata
Use 'DESC' for decending order (most recent date at the top) OR can use 'ASC' for acending order
*/

SELECT
    ROW_NUMBER() OVER() AS 'Record #',
    ZCALLRECORD.Z_PK AS 'Call Sequence #',
    datetime(ZCALLRECORD.ZDATE + 978307200, 'UNIXEPOCH') AS 'Call Start Time (UTC)',
    datetime((ZCALLRECORD.ZDATE + 978307200) + ZCALLRECORD.ZDURATION, 'UNIXEPOCH') AS 'Call End Time (UTC)',
    TIME(ZCALLRECORD.ZDURATION, 'UNIXEPOCH') AS 'Call Duration',
    ZCALLRECORD.ZADDRESS AS 'Contact Number',
    ZCALLRECORD.ZLOCATION AS 'Location',
    CASE ZCALLRECORD.ZANSWERED
        WHEN 0 THEN 'Call NOT Answered'
        WHEN 1 THEN 'Call Answered'
        ELSE ZCALLRECORD.ZANSWERED
    END AS 'Call Answered Status',
    CASE ZCALLRECORD.ZORIGINATED
        WHEN 0 THEN 'Incoming Call'
        WHEN 1 THEN 'Outgoing Call'
        ELSE ZCALLRECORD.ZORIGINATED
    END as 'Call Direction',
    CASE ZCALLRECORD.ZCALLTYPE
        WHEN 1 THEN 'Standard Call'
        WHEN 8 THEN 'Full AV Facetime Call'
        WHEN 16 THEN 'Facetime Audio Only Call'
        ELSE ZCALLRECORD.ZCALLTYPE
    END AS 'Call Type',
    ZCALLRECORD.ZSERVICE_PROVIDER AS 'Service Provider',
    /* Source for each line of data */
    'File: \private\var\mobile\Library\CallHistoryDB\CallHistory.storedata; Table: ZCALLRECORD(Z_PK: ' || ZCALLRECORD.Z_PK || ')' AS 'Data Source'

FROM ZCALLRECORD

ORDER BY ZCALLRECORD.ZDATE DESC
