/*
Query copied from https://thebinaryhick.blog/2022/06/09/new-msgstore-who-dis-a-look-at-an-updated-whatsapp-on-android/
*/

ATTACH DATABASE 'file:.\wa.db?mode=ro' AS whatsapp_db;


SELECT
    ROW_NUMBER() OVER(ORDER BY message._id) AS 'record_number',

    message._id AS 'message._id',

    CASE message.from_me
        WHEN 0 THEN 'Incoming [0]'
        WHEN 1 THEN 'Outgoing [1]'
    END AS 'message.from_me',

    datetime(message.timestamp / 1000, 'UNIXEPOCH') AS 'message.timestamp_utc',

    CASE
        WHEN datetime(message.received_timestamp / 1000, 'UNIXEPOCH') = '1970-01-01 00:00:00' THEN NULL
        ELSE datetime(message.received_timestamp / 1000, 'UNIXEPOCH')
    END AS 'message.received_timestamp_utc',

    CASE
        WHEN datetime(message.receipt_server_timestamp / 1000, 'UNIXEPOCH') = '1970-01-01 00:00:00' THEN NULL
        ELSE datetime(message.receipt_server_timestamp / 1000, 'UNIXEPOCH')
    END AS 'message.receipt_server_timestamp_utc',

    CASE
        WHEN datetime(receipt_device.receipt_device_timestamp / 1000, 'UNIXEPOCH') = '1970-01-01 00:00:00' THEN NULL
        ELSE datetime(receipt_device.receipt_device_timestamp / 1000, 'UNIXEPOCH')
    END AS 'receipt_device.receipt_device_timestamp_utc',

    CASE
        WHEN datetime(receipt_user.read_timestamp / 1000, 'UNIXEPOCH') = '1970-01-01 00:00:00' THEN NULL
        ELSE datetime(receipt_user.read_timestamp / 1000, 'UNIXEPOCH')
    END AS 'receipt_user.read_timestamp_utc',

    CASE message.recipient_count
        WHEN 0 THEN 'No [0]'
        WHEN 1 THEN 'Yes [1]'
    END AS 'message.recipient_count',

    CASE wa_contacts.wa_name
        WHEN NULL THEN NULL
        ELSE wa_contacts.wa_name
    END AS 'wa_contacts.wa_name',

    jid.raw_string AS 'jid.raw_string',
    wa_contacts.number AS 'wa_contacts.number',
    wa_contacts.display_name AS 'wa_contacts.display_name',

    CASE message.message_type
        WHEN 0 THEN '0 [Text]'
        WHEN 1 THEN '1 [Picture]'
        WHEN 2 THEN '2 [Audio]'
        WHEN 3 THEN '3 [Video]'
        WHEN 4 THEN '4 [Gif]'
        WHEN 5 THEN '5 [Static Location]'
        WHEN 7 THEN '7 [System Message]'
        WHEN 9 THEN '9 [Document]'
        WHEN 14 THEN '14 [Deleted Message]'
        WHEN 15 THEN '15 [Sticker]'
        WHEN 16 THEN '16 [Live Location]'
        ELSE message.message_type
    END AS 'message.message_type',

    message.text_data AS 'message.text_data',

    CASE message.status
        WHEN 0 THEN 'Received Message / Read By Local User [0]'
        WHEN 6 THEN 'Sent Unsuccessful (No Response From Server) [6]'
        WHEN 13 THEN 'Sent Successful [13]'
    END AS 'message.status',

    CASE message_media.file_path
        WHEN NULL THEN NULL
        ELSE message_media.file_path
    END AS 'message_media.file_path',

    message_media.message_url AS 'message_media.message_url',
    printf("%,d", message_media.file_size) AS 'message_media.file_size_bytes',

    CASE message_media.mime_type
        WHEN NULL THEN NULL
        ELSE message_media.mime_type
    END AS 'message_media.mime_type',

    CASE
        WHEN datetime(message_media.media_key_timestamp / 1000, 'UNIXEPOCH') = '1970-01-01 00:00:00' THEN NULL
        ELSE datetime(message_media.media_key_timestamp / 1000, 'UNIXEPOCH')
    END AS 'message_media.media_key_timestamp_utc',

    CASE message_media.width
        WHEN NULL THEN NULL
        ELSE message_media.width
    END AS 'message_media.width',

    CASE message_media.height
        WHEN NULL THEN NULL
        ELSE message_media.height
    END AS 'message_media.height',

    CASE message_media.media_duration
        WHEN NULL THEN NULL
        ELSE message_media.media_duration
    END AS 'message_media.media_duration',

    CASE message_location.latitude
        WHEN NULL THEN NULL
        ELSE message_location.latitude
    END AS 'message_location.latitude',

    CASE message_location.longitude
        WHEN NULL THEN NULL
        ELSE message_location.longitude
    END AS 'message_location.longitude',

    CASE message_location.live_location_share_duration
        WHEN NULL THEN NULL
        ELSE message_location.live_location_share_duration
    END AS 'message_location.live_location_share_duration_seconds',

    CASE message_location.live_location_final_latitude
        WHEN NULL THEN NULL
        ELSE message_location.live_location_final_latitude
    END AS 'message_location.live_location_final_latitude',

    CASE message_location.live_location_final_longitude
        WHEN NULL THEN NULL
        ELSE message_location.live_location_final_longitude
    END AS 'message_location.live_location_final_longitude',

    CASE message_location.live_location_final_timestamp
        WHEN NULL THEN NULL
        ELSE datetime(message_location.live_location_final_timestamp / 1000, 'UNIXEPOCH')
    END AS 'message_location.live_location_final_timestamp',

    /* Source for each line of data */
    'File: /data/data/com.whatsapp/databases/msgstore.db; Table:message(ROWID:' || message._id || ')' AS 'data_source'


FROM message
    JOIN chat ON chat._id = message.chat_row_id
    LEFT JOIN jid ON jid._id = message.sender_jid_row_id
    LEFT JOIN receipt_device ON receipt_device.message_row_id = message._id
    LEFT JOIN receipt_user ON receipt_user.message_row_id = message._id
    LEFT JOIN message_media ON message_media.message_row_id = message._id
    LEFT JOIN message_location ON message_location.message_row_id = message._id
    LEFT JOIN wa_contacts ON wa_contacts.jid = jid.raw_string


ORDER BY message.timestamp ASC;


DETACH DATABASE whatsapp_db;
