SELECT
    ROW_NUMBER() OVER() AS 'Row #',
    datetime(ZLIVEROUTEPERF.ZTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'Live Route Pref Timestamp',
    datetime(ZNETWORKATTACHMENT.ZFIRSTTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'First Network Attachment',
    datetime(ZNETWORKATTACHMENT.ZTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'Network Attachment Timestamp',
    CASE ZLIVEROUTEPERF.ZKIND
        WHEN 1 THEN 'WI-FI'
        WHEN 2 THEN 'CELLULAR'
        ELSE ZLIVEROUTEPERF.ZKIND
    END 'NETWORK TYPE',
    ZLIVEROUTEPERF.ZBYTESIN AS 'BYTES IN',
    ZLIVEROUTEPERF.ZBYTESOUT AS 'BYTES OUT',
    ZLIVEROUTEPERF.ZPACKETSIN AS 'PACKETS IN',
    ZLIVEROUTEPERF.ZPACKETSOUT AS 'PACKETS OUT',
    ZLIVEROUTEPERF.ZCONNATTEMPTS AS 'CONNECTION ATTEMPTS',
    ZLIVEROUTEPERF.ZCONNSUCCESSES AS 'CONNECTION SUCCESSES',
    ZNETWORKATTACHMENT.ZIDENTIFIER AS 'NETWORK IDENTIFIER',
    ZNETWORKATTACHMENT.ZISKNOWNGOOD AS 'IS KNOWN GOOD',
    HEX(ZNETWORKATTACHMENT.ZNETSIGNATURE) AS 'NET SIGNATURE (HEX)',
    ZNETWORKATTACHMENT.ZOVERALLSTAYMEAN AS 'OVERALL STAY MEAN (NETWORK ATTACHMENT)',
    ZNETWORKATTACHMENT.ZOVERALLSTAYVAR AS 'OVERALL STAY VAR (NETWORK ATTACHMENT)',
    ZLIVEROUTEPERF.ZOVERALLSTAY AS 'OVERALL STAY MEAN (LIVE ROUTE PERF)',
    ZLIVEROUTEPERF.ZOVERALLSTAYM2 AS 'OVERALL STAY M2 (LIVE ROUTE PERF)',
    'Table: ZZLIVEROUTEPERF(Z_PK: ' || ZLIVEROUTEPERF.Z_PK || ')' AS 'Data Source'

FROM ZLIVEROUTEPERF
    LEFT JOIN
        ZNETWORKATTACHMENT ON ZLIVEROUTEPERF.ZHASNETWORKATTACHMENT = ZNETWORKATTACHMENT.Z_PK

ORDER BY 'Live Route Pref Timestamp' ASC