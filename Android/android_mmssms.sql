/*
This query is for MMS messages from the mmssms.db
*/

SELECT
    /* Add a row number at the beggining of each row */
    ROW_NUMBER() OVER() AS 'RECORD_NUMBER',
    pdu._id AS 'pdu._id',
    pdu.thread_id AS 'pdu.thread_id',

    /* Date/Time of the message in UTC */
    CASE
        WHEN pdu.date > 0 THEN strftime('%Y-%m-%d %H:%M:%S', pdu.date, 'UNIXEPOCH')
        ELSE 'n/a'
    END AS 'pdu.date',

    /* Date/Time the message was sent in UTC */
    CASE
        WHEN pdu.date_sent > 0 THEN strftime('%Y-%m-%d %H:%M:%S', pdu.date_sent, 'UNIXEPOCH')
        ELSE 'n/a'
    END as 'pdu.date_sent(UTC)',

    /* Message direction (incoming/outgoing) */
    CASE pdu.msg_box
        WHEN 1 THEN '1  [Incoming]'
        WHEN 2 THEN '2  [Outgoing]'
        ELSE pdu.msg_box
    END AS 'Direction',

    /* Was the message read */
    pdu.read AS 'pdu.read',

    /* Phone number of the message sender */
    /* Removes unnecessary text at the start of the string to leave just the 10-digit phone number */
    CASE
        WHEN (SELECT SUBSTR(address,3) FROM addr WHERE pdu._id=addr.msg_id AND addr.type=137 AND addr.address LIKE '%+1%') IS NULL THEN (
            SELECT address FROM addr WHERE pdu._id=addr.msg_id AND addr.type=137)
        ELSE (SELECT SUBSTR(address,3) FROM addr WHERE pdu._id=addr.msg_id AND addr.type=137 AND addr.address LIKE '%+1%')
    END AS 'FROM',

    /* Phone number of the message recipient */
    /* Removes unnecessary text at the start of the string to leave just the 10-digit phone number */
    CASE
        WHEN (SELECT SUBSTR(address,3) FROM addr WHERE pdu._id=addr.msg_id AND addr.type=151 AND addr.address LIKE '%+1%') IS NULL THEN (
            SELECT address FROM addr WHERE pdu._id=addr.msg_id AND addr.type=151)
        ELSE (SELECT SUBSTR(address,3) FROM addr WHERE pdu._id=addr.msg_id AND addr.type=151 AND addr.address LIKE '%+1%')
    END AS 'TO',

    /* If the message was CCed to anyone, it will be listed here */
    CASE
        WHEN (SELECT address FROM addr WHERE pdu._id=addr.msg_id AND addr.type=130) IS NULL THEN 'n/a'
        ELSE (SELECT address FROM addr WHERE pdu._id=addr.msg_id AND addr.type=130)
    END AS 'CC',

    /* If the message was BCCed to anyone, it will be listed here */
    CASE
        WHEN (SELECT address FROM addr WHERE pdu._id=addr.msg_id AND addr.type=129) IS NULL THEN 'n/a'
        ELSE (SELECT address FROM addr WHERE pdu._id=addr.msg_id AND addr.type=129)
    END AS 'BCC',

    part._id AS 'part._id',
    part.seq,
    part.ct AS 'part.ct',

    /* File name of the attached file (if any) */
    CASE
        WHEN part.cl IS NULL THEN 'n/a'
        ELSE part.cl
    END AS 'part.cl',

    /* File path of the attached file (if any) */
    part._data AS 'part._data',
    /* Message content */
    part.text  AS 'part.text',
    pdu.creator AS 'pdu.creator',
    pdu.sim_imsi AS 'pdu.sim_imsi',
    pdu.correlation_tag AS 'pdu.correlation_tag',
    pdu.ct_l AS 'pdu.ct_l(URI)',

    /* Source for each line of data */
    'File: \data\data\com.android.providers.telephony\databases\mmssms.db; Table: pdu(_id: ' || pdu._id || ')' AS 'DATA_SOURCE'


FROM pdu
    LEFT JOIN part ON part.mid=pdu._id


/* Groups the messages first by the `_id` value, then by `date` and then by `part_id` */
ORDER BY pdu._id, pdu.date, part_id


------------------------------------------------------
/*
Query for just SMS messages from the mmssms.db
*/

SELECT
    /* Add a row number at the beggining of each row */
    ROW_NUMBER() OVER() AS 'Row #',
    sms._id AS 'SMS_ID',
    sms.thread_id AS 'Thread ID',
    /* Removes unnecessary text at the start of the string to leave just the 10-digit phone number */
    /* Formats string as a U.S. phone number, i.e. (###) ###-#### */
    CASE
        WHEN LENGTH(sms.address) = 12 AND sms.address LIKE '%+1%' THEN '(' || SUBSTR(sms.address,3,3) || ') ' || SUBSTR(sms.address,6,3) || '-' || SUBSTR(sms.address,9,4)
        WHEN LENGTH(sms.address) = 10 THEN '(' || SUBSTR(sms.address,1,3) || ') ' || SUBSTR(sms.address,4,3) || '-' || SUBSTR(sms.address,7,4)
        ELSE sms.address
    END AS 'Address',
    CASE
        WHEN sms.person IS NULL THEN 'n/a'
        ELSE sms.person
    END AS 'Person',
    /* Date/Time of the message */
    CASE
        WHEN sms.date > 0 THEN strftime('%Y-%m-%d %H:%M:%S', sms.date / 1000, 'UNIXEPOCH')
        ELSE 'n/a'
    END AS 'Date/Time (UTC)',
    /* Message direction (incoming/outgoing) */
    CASE sms.type
        WHEN 1 THEN 'Incoming'
        WHEN 2 THEN 'Outgoing'
        ELSE sms.type
    END AS 'Direction',
    /* Was the message read */
    CASE sms.read
        WHEN 0 THEN 'Unread'
        WHEN 1 THEN 'Read'
        ELSE sms.read
    END AS 'Message Read',
    /* Was a subject listed for the message */
    CASE
        WHEN sms.subject IS NULL THEN 'n/a'
        ELSE sms.subject
    END AS 'Subject',
    /* Message content */
    sms.body AS 'Message Text',
    /* Removes unnecessary text at the start of the string to leave just the 10-digit phone number */
    /* Formats string as a U.S. phone number, i.e. (###) ###-#### */
     CASE
        WHEN sms.service_center IS NULL THEN 'n/a'
        WHEN LENGTH(sms.service_center) = 12 AND sms.service_center LIKE '%+1%' THEN '(' || SUBSTR(sms.service_center,3,3) || ') ' || SUBSTR(sms.service_center,6,3) || '-' || SUBSTR(sms.service_center,9,4)
        ELSE sms.service_center
    END AS 'Service Center',
    sms.creator AS 'Creator',
    sms.correlation_tag AS 'Correlation Tag',
    sms.sim_imsi AS 'SIM IMSI',
    /* Source for each line of data */
    'File: \data\data\com.android.providers.telephony\databases\mmssms.db; Table: sms(_id: ' || sms._id || ')' AS 'Data Source'

FROM sms

/* Groups the messages first by the `thread_id` value and then by the `date` value */
ORDER BY sms.thread_id, sms.date
