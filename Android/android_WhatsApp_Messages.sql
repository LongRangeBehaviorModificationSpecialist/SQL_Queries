/*
Query copied from https://thebinaryhick.blog/2022/06/09/new-msgstore-who-dis-a-look-at-an-updated-whatsapp-on-android/
*/

ATTACH DATABASE "wa.db" AS 'whatsapp_db';
SELECT
	ROW_NUMBER() OVER() AS 'Record #',
	message._id AS 'Message ID',
	datetime(message.timestamp / 1000, 'UNIXEPOCH') AS 'Message Time (UTC)',
	CASE
		WHEN datetime(message.received_timestamp / 1000, 'UNIXEPOCH') = '1970-01-01 00:00:00' THEN 'n/a'
		ELSE datetime(message.received_timestamp / 1000, 'UNIXEPOCH')
	END AS 'Time Received (UTC)',
	CASE message.from_me
		WHEN 0 THEN 'Incoming'
		WHEN 1 THEN 'Outgoing'
	END AS 'Message Direction',
	CASE message.recipient_count
		WHEN 0 THEN 'No'
		WHEN 1 THEN 'Yes'
	END AS 'Is Group Message',
	CASE
		WHEN wa_contacts.wa_name IS NULL THEN 'Not Listed'
		ELSE wa_contacts.wa_name
	END AS 'Other Participant WA User Name',
	wa_contacts.display_name AS 'WA Display User Name',
	CASE message.message_type
		WHEN 0 THEN 'Text'
		WHEN 1 THEN 'Picture'
		WHEN 2 THEN 'Audio'
		WHEN 3 THEN 'Video'
		WHEN 4 THEN 'Gif'
		WHEN 5 THEN 'Static Location'
		WHEN 7 THEN 'System Message'
		WHEN 9 THEN 'Document'
		WHEN 14 THEN 'Deleted Message'
		WHEN 15 THEN 'Sticker'
		WHEN 16 THEN 'Live Location'
		ELSE message.message_type
	END AS 'Message Type',
	message.text_data AS 'Message',
	CASE
		WHEN message_media.file_path IS NULL THEN 'n/a'
		ELSE message_media.file_path
	END AS 'Local Path to Media',
	printf("%,d", message_media.file_size) AS 'Media File Size (bytes)',
	CASE
		WHEN message_media.width IS NULL THEN 'n/a'
		ELSE message_media.width
	END AS 'Media Width',
	CASE
		WHEN message_media.height IS NULL THEN 'n/a'
		ELSE message_media.height
	END AS 'Media Height',
	CASE
		WHEN message_location.latitude IS NULL THEN 'n/a'
		ELSE message_location.latitude
	END AS 'Shared/Starting Latitude (Live Location)',
	CASE
		WHEN message_location.longitude IS NULL THEN 'n/a'
		ELSE message_location.longitude
	END AS 'Shared/Starting Longitude (Live Location)',
	CASE
		WHEN message_location.live_location_share_duration IS NULL THEN 'n/a'
		ELSE message_location.live_location_share_duration
	END AS 'Duration Live Location Shared (Seconds)',
	CASE
		WHEN message_location.live_location_final_latitude IS NULL THEN 'n/a'
		ELSE message_location.live_location_final_latitude
	END AS 'Final Live Latitude',
	CASE 
		WHEN message_location.live_location_final_longitude IS NULL THEN 'n/a'
		ELSE message_location.live_location_final_longitude
	END AS 'Final Live Longitude',
	CASE
		WHEN message_location.live_location_final_timestamp IS NULL THEN 'n/a'
		ELSE datetime(message_location.live_location_final_timestamp / 1000, 'UNIXEPOCH')
	END AS 'Final Location Timestamp',
	/* Source for each line of data */
	'File: \data\data\com.whatsapp\databases\msgstore.db; Table: message(ROWID: ' || message._id || ')' AS 'Data Source'

FROM message
	JOIN chat ON chat._id = message.chat_row_id
	JOIN jid ON jid._id = chat.jid_row_id
	LEFT JOIN message_media ON message_media.message_row_id = message._id
	LEFT JOIN message_location ON message_location.message_row_id = message._id
	JOIN wa_contacts ON wa_contacts.jid = jid.raw_string

ORDER BY message.timestamp ASC
