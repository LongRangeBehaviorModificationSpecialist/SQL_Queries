/*
File Path = \private\var\mobile\Library\Application Support\com.apple.remotemanagementd
File Names = RMAdminStore-Local.sqlite & RMAdminStore-Cloud.sqlite
*/

SELECT

    ROW_NUMBER() OVER() AS 'RECORD_NUMBER',

    datetime(ZUSAGEBLOCK.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'ZUSAGEBLOCK.ZSTARTDATE(UTC)',
    datetime(ZUSAGEBLOCK.ZLASTEVENTDATE + 978307200, 'UNIXEPOCH') AS 'ZUSAGEBLOCK.ZLASTEVENTDATE(UTC)',

    ZUSAGETIMEDITEM.ZTOTALTIMEINSECONDS AS 'ZUSAGETIMEDITEM.ZTOTALTIMEINSECONDS',
    ZUSAGETIMEDITEM.ZTOTALTIMEINSECONDS / 60.00 AS 'ZTOTALTIME(MINUTES)',
    ZUSAGETIMEDITEM.ZBUNDLEIDENTIFIER AS 'ZUSAGETIMEDITEM.ZBUNDLEIDENTIFIER',

    CASE ZUSAGECATEGORY.ZIDENTIFIER
        WHEN 'DH0011' THEN 'DH0011  [Unspecified 1]'
        WHEN 'DH0012' THEN 'DH0012  [Unspecified 2]'
        WHEN 'DH0013' THEN 'DH0013  [Unspecified 3]'
        WHEN 'DH1001' THEN 'DH1001  [Games]'
        WHEN 'DH1002' THEN 'DH1002  [Social Networking]'
        WHEN 'DH1003' THEN 'DH1003  [Entertainment]'
        WHEN 'DH1004' THEN 'DH1004  [Creativity]'
        WHEN 'DH1005' THEN 'DH1005  [Productivity]'
        WHEN 'DH1006' THEN 'DH1006  [Education]'
        WHEN 'DH1007' THEN 'DH1007  [Reading/Reference]'
        WHEN 'DH1008' THEN 'DH1008  [Health/Fitness]'
        WHEN 'DH1009' THEN 'DH1009  [Other]'
        ELSE ZUSAGECATEGORY.ZIDENTIFIER
    END AS 'ZUSAGECATEGORY.ZIDENTIFIER',

    ZUSAGECOUNTEDITEM.ZNUMBEROFNOTIFICATIONS AS 'ZUSAGECOUNTEDITEM.ZNUMBEROFNOTIFICATIONS',
    ZUSAGECOUNTEDITEM.ZNUMBEROFPICKUPS AS 'ZUSAGECOUNTEDITEM.ZNUMBEROFPICKUPS',
    ZUSAGEBLOCK.ZNUMBEROFPICKUPSWITHOUTAPPLICATIONUSAGE AS 'ZUSAGEBLOCK.ZNUMBEROFPICKUPSWITHOUTAPPLICATIONUSAGE',
    ZCOREDEVICE.ZNAME AS 'ZCOREDEVICE.ZNAME',
    ZCOREDEVICE.ZIDENTIFIER AS 'ZCOREDEVICE.ZIDENTIFIER',

    CASE ZCOREDEVICE.ZPLATFORM
        WHEN 0 THEN '0  [Unknown]'
        WHEN 1 THEN '1  [macOS]'
        WHEN 2 THEN '2  [iOS]'
        WHEN 4 THEN '4  [Apple Watch]'
        ELSE ZCOREDEVICE.ZPLATFORM
    END AS 'ZCOREDEVICE.ZPLATFORM',

    ZCOREUSER.ZAPPLEID AS 'ZCOREUSER.ZAPPLEID',
    ZCOREUSER.ZDSID AS 'ZCOREUSER.ZDSID',
    ZCOREUSER.ZALTDSID AS 'ZCOREUSER.ZALTDSID',
    ZCOREUSER.ZGIVENNAME || ' ' || ZCOREUSER.ZFAMILYNAME AS 'ZCOREUSER.ZGIVENNAME',
    ZCOREUSER.ZFAMILYMEMBERTYPE AS 'ZCOREUSER.ZFAMILYMEMBERTYPE',

    /* Source for each line of data */
    'Table: ZUSAGEGETIMEDITEM (Z_PK:' || ZUSAGETIMEDITEM.Z_PK || ')' AS 'DATA_SOURCE'


FROM ZUSAGETIMEDITEM
    LEFT JOIN ZUSAGECATEGORY ON ZUSAGECATEGORY.Z_PK = ZUSAGETIMEDITEM.ZCATEGORY
    LEFT JOIN ZUSAGEBLOCK ON ZUSAGEBLOCK.Z_PK = ZUSAGECATEGORY.ZBLOCK
    LEFT JOIN ZUSAGE ON ZUSAGE.Z_PK = ZUSAGEBLOCK.ZUSAGE
    LEFT JOIN ZCOREDEVICE ON ZCOREDEVICE.Z_PK = ZUSAGE.ZDEVICE
    LEFT JOIN ZCOREUSER ON ZCOREUSER.Z_PK = ZUSAGE.ZUSER
    LEFT JOIN ZUSAGECOUNTEDITEM ON ZUSAGECOUNTEDITEM.ZBLOCK = ZUSAGECATEGORY.ZBLOCK AND ZUSAGECOUNTEDITEM.ZBUNDLEIDENTIFIER = ZUSAGETIMEDITEM.ZBUNDLEIDENTIFIER


WHERE
    ZUSAGETIMEDITEM.ZBUNDLEIDENTIFIER LIKE '%whatsapp%'


ORDER BY
    ZUSAGEBLOCK.ZSTARTDATE ASC


--ZUC.ZTOTALTIMEINSECONDS AS 'Total_Time (from ZUC)',
--ZUSAGEBLOCK.ZSCREENTIMEINSECONDS AS 'Screen_Time (from ZUSAGEBLOCK)',
