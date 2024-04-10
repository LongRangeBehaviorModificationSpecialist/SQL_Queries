/*
Query copied from https://thebinaryhick.blog/2022/06/09/new-msgstore-who-dis-a-look-at-an-updated-whatsapp-on-android/

This query is slightly different as an examiner would also need the group/conversation name along with the party sending the message(s) within the group
*/

SELECT
	ROW_NUMBER() OVER() AS 'Record #',
	--ATTACH DATABASE "F:\23-07663_GUYTON\EVIDENCE\ALL_CHAT_MESSAGES\WHATSAPP_DATA\wa_database\wa.db" AS 'whatsapp_db';
	message._id AS 'Message ID',
	datetime(message.timestamp / 1000, 'UNIXEPOCH') AS 'Message Time (UTC)',
	CASE
		WHEN datetime(message.received_timestamp / 1000, 'UNIXEPOCH') = '1970-01-01 00:00:00' THEN 'N/A'
		ELSE datetime(message.received_timestamp / 1000, 'UNIXEPOCH')
	END AS 'Time Message Received (UTC)',
	chat.subject AS 'Conversation Name',
	CASE
		WHEN message.from_me = 1 THEN 'Self'
		ELSE wa_contacts.wa_name
	END AS 'Sending Party',
	CASE
		WHEN message.from_me = 0 THEN 'Incoming'
		WHEN message.from_me = 1 THEN 'Outgoing'
	END AS 'Message Direction',
	CASE message.message_type
		WHEN 0 THEN 'Text'
		WHEN 1 THEN 'Picture'
		WHEN 2 THEN 'Audio'
		WHEN 3 THEN 'Video'
		WHEN 5 THEN 'Static Location'
		WHEN 7 THEN 'System Message'
		WHEN 9 THEN 'Document'
		WHEN 16 THEN 'Live Location'
		ELSE message.message_type
	END AS 'Message Type',
	message.text_data AS 'Message',
	message_media.file_path AS 'Local Path to Media',
	printf("%,d", message_media.file_size) AS 'Media File Size (bytes)',
	message_media.width AS 'Media Width',
	message_media.height AS 'Media Height',
	CASE
		WHEN message_location.latitude IS NULL THEN 'n/a'
		ELSE message_location.latitude
	END AS 'Shared Latitude/Starting Latitude (Live Location)',
	message_location.longitude AS 'Shared Longitude/Starting Longitude (Live Location)',
	message_location.live_location_share_duration AS 'Duration Live Location Shared (Seconds)',
	message_location.live_location_final_latitude AS 'Final Live Latitude',
	message_location.live_location_final_longitude AS 'Final Live Longitude',
	datetime(message_location.live_location_final_timestamp / 1000, 'UNIXEPOCH') AS 'Final Location Timestamp'

FROM message
	JOIN chat ON chat._id = message.chat_row_id
	LEFT JOIN jid ON jid._id = message.sender_jid_row_id
	LEFT JOIN message_media ON message_media.message_row_id = message._id
	LEFT JOIN message_location ON message_location.message_row_id = message._id
	LEFT JOIN wa_contacts ON wa_contacts.jid = jid.raw_string

/* Will indicate whether the message is a group message */
WHERE message.recipient_count >= 1

ORDER BY message.timestamp ASC
