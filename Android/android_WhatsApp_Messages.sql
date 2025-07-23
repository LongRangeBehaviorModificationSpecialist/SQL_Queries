/*
Query copied from https://thebinaryhick.blog/2022/06/09/new-msgstore-who-dis-a-look-at-an-updated-whatsapp-on-android/
*/

ATTACH DATABASE "wa.db" AS 'whatsapp_db';


SELECT
    ROW_NUMBER() OVER() AS 'RECORD_NUMBER',
    message._id AS 'message._id',

    datetime(message.timestamp / 1000, 'UNIXEPOCH') AS 'message.timestamp(UTC)',

    CASE
        WHEN datetime(message.received_timestamp / 1000, 'UNIXEPOCH') = '1970-01-01 00:00:00' THEN '[N/A]'
        ELSE datetime(message.received_timestamp / 1000, 'UNIXEPOCH')
    END AS 'message.received_timestamp(UTC)',

    CASE message.from_me
        WHEN 0 THEN '0  [Incoming]'
        WHEN 1 THEN '1  [Outgoing]'
    END AS 'message.from_me',

    CASE message.recipient_count
        WHEN 0 THEN '0  [No]'
        WHEN 1 THEN '1  [Yes]'
    END AS 'message.recipient_count',

    CASE
        WHEN wa_contacts.wa_name IS NULL THEN '[N/A]'
        ELSE wa_contacts.wa_name
    END AS 'wa_contacts.wa_name',

    wa_contacts.display_name AS 'wa_contacts.display_name',

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
    END AS 'message.message_type',

    message.text_data AS 'message.text_data',

    CASE
        WHEN message_media.file_path IS NULL THEN '[N/A]'
        ELSE message_media.file_path
    END AS 'message_media.file_path',

    printf("%,d", message_media.file_size) AS 'message_media.file_size(bytes)',

    CASE
        WHEN message_media.width IS NULL THEN '[N/A]'
        ELSE message_media.width
    END AS 'message_media.width',

    CASE
        WHEN message_media.height IS NULL THEN '[N/A]'
        ELSE message_media.height
    END AS 'message_media.height',

    CASE
        WHEN message_location.latitude IS NULL THEN '[N/A]'
        ELSE message_location.latitude
    END AS 'message_location.latitude',

    CASE
        WHEN message_location.longitude IS NULL THEN '[N/A]'
        ELSE message_location.longitude
    END AS 'message_location.longitude',

    CASE
        WHEN message_location.live_location_share_duration IS NULL THEN '[N/A]'
        ELSE message_location.live_location_share_duration
    END AS 'message_location.live_location_share_duration',

    CASE
        WHEN message_location.live_location_final_latitude IS NULL THEN '[N/A]'
        ELSE message_location.live_location_final_latitude
    END AS 'message_location.live_location_final_latitude',

    CASE
        WHEN message_location.live_location_final_longitude IS NULL THEN '[N/A]'
        ELSE message_location.live_location_final_longitude
    END AS 'message_location.live_location_final_longitude',

    CASE
        WHEN message_location.live_location_final_timestamp IS NULL THEN '[N/A]'
        ELSE datetime(message_location.live_location_final_timestamp / 1000, 'UNIXEPOCH')
    END AS 'message_location.live_location_final_timestamp',

    /* Source for each line of data */
    'File: \data\data\com.whatsapp\databases\msgstore.db; Table: message(ROWID: ' || message._id || ')' AS 'DATA_SOURCE'


FROM message
    JOIN chat ON chat._id = message.chat_row_id
    JOIN jid ON jid._id = chat.jid_row_id
    LEFT JOIN message_media ON message_media.message_row_id = message._id
    LEFT JOIN message_location ON message_location.message_row_id = message._id
    JOIN wa_contacts ON wa_contacts.jid = jid.raw_string


ORDER BY message.timestamp ASC
