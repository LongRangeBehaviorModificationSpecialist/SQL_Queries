/*
Query copied from https://thebinaryhick.blog/2022/06/09/new-msgstore-who-dis-a-look-at-an-updated-whatsapp-on-android/
*/

ATTACH DATABASE 'file:F:\26-03686_ADAMSON\EVIDENCE\EXPORTS\com.whatsapp\msgstore[dot]db\wa.db?mode=ro' AS whatsapp_db;


SELECT
    ROW_NUMBER() OVER(ORDER BY message._id) AS 'RecordNo.',
    message._id AS 'MessageID',

    CASE message.from_me
        WHEN 0 THEN '0 [Incoming]'
        WHEN 1 THEN '1 [Outgoing]'
    END AS 'MessageFromMe',

    datetime(message.timestamp / 1000, 'UNIXEPOCH') AS 'MessageTimestamp(UTC)',

    CASE
        WHEN datetime(message.received_timestamp / 1000, 'UNIXEPOCH') = '1970-01-01 00:00:00' THEN NULL
        ELSE datetime(message.received_timestamp / 1000, 'UNIXEPOCH')
    END AS 'message.received_timestamp(UTC)',

    CASE
        WHEN datetime(message.receipt_server_timestamp / 1000, 'UNIXEPOCH') = '1970-01-01 00:00:00' THEN NULL
        ELSE datetime(message.receipt_server_timestamp / 1000, 'UNIXEPOCH')
    END AS 'ReceiptServerTimestamp(UTC)',

    CASE
        WHEN datetime(receipt_device.receipt_device_timestamp / 1000, 'UNIXEPOCH') = '1970-01-01 00:00:00' THEN NULL
        ELSE datetime(receipt_device.receipt_device_timestamp / 1000, 'UNIXEPOCH')
    END AS 'ReceiptDeviceTimestamp(UTC)',

    CASE
        WHEN datetime(receipt_user.read_timestamp / 1000, 'UNIXEPOCH') = '1970-01-01 00:00:00' THEN NULL
        ELSE datetime(receipt_user.read_timestamp / 1000, 'UNIXEPOCH')
    END AS 'ReadTimestamp(UTC)',

    CASE message.recipient_count
        WHEN 0 THEN '0 [No]'
        WHEN 1 THEN '1 [Yes]'
    END AS 'MessageRecipientCount',

    CASE
        WHEN wa_contacts.wa_name IS NULL THEN 'NotListed'
        ELSE wa_contacts.wa_name
    END AS 'OtherParticipantWAUserName',

    jid.raw_string AS 'JidRawString',

    wa_contacts.number AS 'ContactNumber',

    wa_contacts.display_name AS 'WADisplayUserName',

    CASE message.message_type
        WHEN 0 THEN '0  [Text]'
        WHEN 1 THEN '1  [Picture]'
        WHEN 2 THEN '2  [Audio]'
        WHEN 3 THEN '3  [Video]'
        WHEN 4 THEN '4  [Gif]'
        WHEN 5 THEN '5  [Static Location]'
        WHEN 7 THEN '7  [System Message]'
        WHEN 9 THEN '9  [Document]'
        WHEN 14 THEN '14  [Deleted Message]'
        WHEN 15 THEN '15  [Sticker]'
        WHEN 16 THEN '16  [Live Location]'
        ELSE message.message_type
    END AS 'MessageType',

    message.text_data AS 'MessageTextData',

    CASE message.status
        WHEN 0 THEN 'ReceivedMessage/ReadByLocalUser'
        WHEN 6 THEN 'SentUnsuccessful(NoResponseFromServer)'
        WHEN 13 THEN 'SentSuccessful'
    END AS 'MessageStatus',

    CASE
        WHEN message_media.file_path IS NULL THEN NULL
        ELSE message_media.file_path
    END AS 'MessageMediaFilePath',

    message_media.message_url AS 'MessageMediaURL',

    printf("%,d", message_media.file_size) AS 'MessageMediaFileSize(bytes)',

    CASE
        WHEN message_media.mime_type IS NULL THEN NULL
        ELSE message_media.mime_type
    END AS 'MessageMediaMimeType',

    CASE
        WHEN datetime(message_media.media_key_timestamp / 1000, 'UNIXEPOCH') = '1970-01-01 00:00:00' THEN NULL
        ELSE datetime(message_media.media_key_timestamp / 1000, 'UNIXEPOCH')
    END AS 'MessageMediaTimestamp(UTC)',

    CASE
        WHEN message_media.width IS NULL THEN NULL
        ELSE message_media.width
    END AS 'MessageMediaWidth',

    CASE
        WHEN message_media.height IS NULL THEN NULL
        ELSE message_media.height
    END AS 'MessageMediaHeight',

    CASE
        WHEN message_media.media_duration IS NULL THEN NULL
        ELSE message_media.media_duration
    END AS 'MessageMediaDuration',

    CASE
        WHEN message_location.latitude IS NULL THEN NULL
        ELSE message_location.latitude
    END AS 'MessageLocationLatitude',

    CASE
        WHEN message_location.longitude IS NULL THEN NULL
        ELSE message_location.longitude
    END AS 'MessageLocationLongitude',

    CASE
        WHEN message_location.live_location_share_duration IS NULL THEN NULL
        ELSE message_location.live_location_share_duration
    END AS 'MessageLocationLiveLocationShareDuration(seconds)',

    CASE
        WHEN message_location.live_location_final_latitude IS NULL THEN NULL
        ELSE message_location.live_location_final_latitude
    END AS 'FinalLiveLatitude',

    CASE
        WHEN message_location.live_location_final_longitude IS NULL THEN NULL
        ELSE message_location.live_location_final_longitude
    END AS 'FinalLiveLongitude',

    CASE
        WHEN message_location.live_location_final_timestamp IS NULL THEN NULL
        ELSE datetime(message_location.live_location_final_timestamp / 1000, 'UNIXEPOCH')
    END AS 'FinalLocationTimestamp',

    /* Source for each line of data */
    'File: /data/data/com.whatsapp/databases/msgstore.db; Table: message(ROWID:' || message._id || ')' AS 'DataSource'


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
