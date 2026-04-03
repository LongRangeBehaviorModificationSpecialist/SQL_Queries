/*
    [DLU]
        09-Mar-2026
    [DATABASE FILE]
        \private\var\networkd\db\netusage.sqlite
*/

SELECT

    ROW_NUMBER() OVER() AS 'record_number',
    ZLIVEROUTEPERF.Z_PK AS 'live_route_perf_z_pk',
    ZNETWORKATTACHMENT.Z_PK AS 'network_attachment_z_pk',

    datetime(ZLIVEROUTEPERF.ZTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'live_out_eperf_timestamp_utc',
    datetime(ZNETWORKATTACHMENT.ZFIRSTTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'network_attachment_first_timestamp_utc',
    datetime(ZNETWORKATTACHMENT.ZTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'network_attachment_timestamp_utc',

    CASE ZLIVEROUTEPERF.ZKIND
        WHEN 1 THEN '1 [wi-fi]'
        WHEN 2 THEN '2 [cellular]'
        ELSE ZLIVEROUTEPERF.ZKIND
    END 'live_route_perf_kind',

    printf("%,d", ZLIVEROUTEPERF.ZBYTESIN) AS 'bytes_in',
    printf("%,d", ZLIVEROUTEPERF.ZBYTESOUT) AS 'bytes_out',
    ZLIVEROUTEPERF.ZPACKETSIN AS 'packets_in',
    ZLIVEROUTEPERF.ZPACKETSOUT AS 'packets_out',
    ZLIVEROUTEPERF.ZCONNATTEMPTS AS 'conn_attempts',
    ZLIVEROUTEPERF.ZCONNSUCCESSES AS 'conn_successes',
    ZNETWORKATTACHMENT.ZIDENTIFIER AS 'identifier',
    ZNETWORKATTACHMENT.ZISKNOWNGOOD AS 'is_known_good',

    hex(ZNETWORKATTACHMENT.ZNETSIGNATURE) AS 'net_signature(hex)',

    ZNETWORKATTACHMENT.ZOVERALLSTAYMEAN AS 'overall_stay_mean',
    ZNETWORKATTACHMENT.ZOVERALLSTAYVAR AS 'overall_stay_var',
    ZLIVEROUTEPERF.ZOVERALLSTAY AS 'overall_stay',
    ZLIVEROUTEPERF.ZOVERALLSTAYM2 AS 'overall_stay_m2',

    /* Source for each line of data */
    'netusage.sqlite; Table:ZZLIVEROUTEPERF(Z_PK:' || ZLIVEROUTEPERF.Z_PK || ')' AS 'data_source'


FROM ZLIVEROUTEPERF
    LEFT JOIN ZNETWORKATTACHMENT ON ZLIVEROUTEPERF.ZHASNETWORKATTACHMENT = ZNETWORKATTACHMENT.Z_PK


ORDER BY
    ZLIVEROUTEPERF.ZTIMESTAMP ASC