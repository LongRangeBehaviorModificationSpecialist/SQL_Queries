SELECT

    ROW_NUMBER() OVER() AS 'RecordNo.',
    ZRTWIFIACCESSPOINTMO.Z_PK AS 'Z_PK',
    strftime('%Y-%m-%dT%H:%M:%SZ', datetime(ZRTWIFIACCESSPOINTMO.ZDATE + 978307200, 'UNIXEPOCH')) AS 'Timestamp(UTC)',
    strftime('%Y-%m-%d %H:%M:%S', datetime(ZRTWIFIACCESSPOINTMO.ZDATE + 978307200, 'UNIXEPOCH', 'localtime')) AS 'Timestamp(Local)',
    ZRTWIFIACCESSPOINTMO.ZCHANNEL AS 'Channel',
    ZRTWIFIACCESSPOINTMO.ZRSSI AS 'RSSI',
    UPPER(ZRTWIFIACCESSPOINTMO.ZMAC) AS 'MAC_Address'


FROM ZRTWIFIACCESSPOINTMO