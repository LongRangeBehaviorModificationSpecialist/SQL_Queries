/*
[DLU]
    05-Sep-2025
[VERSION]
    Tested on iOS 18
[SMS]
    FILE PATH = /private/var/mobile/Library/SMS/sms.db
[AddressBook]
    FILE PATH = /private/var/mobile/Library/AddressBook/AddressBook.sqlitedb
*/

SELECT

    ROW_NUMBER() OVER() AS 'RECORD_NUMBER',
    message.ROWID AS 'message.ROWID',
    message.guid AS 'message.guid',

    CASE message.handle_id
        WHEN 0 THEN NULL
        ELSE message.handle_id
    END AS 'message.handle_id',

    chat_message_join.message_id AS 'chat_message_join.message_id',

    CASE message.account
        WHEN NULL THEN NULL
        ELSE message.account
    END AS 'message.account',

    chat.ROWID AS 'chat.ROWID',
    chat.guid AS 'chat.guid',
    message.service AS 'message.service',

    CASE
        WHEN LENGTH(message.date) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (message.date / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(message.date) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', message.date + 978307200, 'UNIXEPOCH')
        WHEN message.date IS 0 THEN NULL
        ELSE message.date
    END AS 'message.date(UTC)',

    CASE
        WHEN LENGTH(message.date_delivered) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (message.date_delivered / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(message.date_delivered) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', message.date_delivered + 978307200, 'UNIXEPOCH')
        WHEN message.date_delivered IS 0 THEN NULL
        ELSE message.date_delivered
    END AS 'message.date_delivered(UTC)',

    CASE
        WHEN LENGTH(message.date_read) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (message.date_read / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(message.date_read) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', message.date_read + 978307200, 'UNIXEPOCH')
        WHEN message.date_read IS 0 THEN NULL
        ELSE message.date_read
    END AS 'message.date_read(UTC)',

    CASE
        WHEN LENGTH(message.date_edited) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (message.date_edited / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(message.date_edited) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', message.date_edited + 978307200, 'UNIXEPOCH')
        WHEN message.date_edited IS 0 THEN NULL
        ELSE message.date_edited
    END AS 'message.date_edited(UTC)',

    CASE
        WHEN chat_message_join.chat_id IS NULL THEN '*DELETED MESSAGE*'
        ELSE '0 [No]'
    END AS 'WasDeleted',

    CASE message.is_from_me
        WHEN 0 THEN '0 [Received]'
        WHEN 1 THEN '1 [Sent]'
        ELSE 'Unknown Value : ' || message.is_from_me || ''
    END AS 'message.is_from_me',

    CASE message.is_delayed
        WHEN 0 THEN '0 [No]'
        WHEN 1 THEN '1 [Yes]'
        ELSE 'Unknown Value : ' || message.is_delayed || ''
    END AS 'message.is_delayed',

    CASE message.is_empty
        WHEN 0 THEN '0 [No]'
        WHEN 1 THEN '1 [Yes]'
        ELSE 'Unknown Value : ' || message.is_empty || ''
    END AS 'message.is_empty',

    CASE message.is_archive
        WHEN 0 THEN '0 [No]'
        WHEN 1 THEN '1 [Yes]'
        ELSE 'Unknown Value : ' || message.is_archive || ''
    END AS 'message.is_archive',

    CASE message.is_finished
        WHEN 0 THEN '0 [No]'
        WHEN 1 THEN '1 [Yes]'
        ELSE 'Unknown Value : ' || message.is_finished || ''
    END AS 'message.is_finished',

    CASE message.is_audio_message
        WHEN 0 THEN '0 [No]'
        WHEN 1 THEN '1 [Yes]'
        ELSE 'Unknown Value : ' || message.is_audio_message || ''
    END AS 'message.is_audio_message',

    CASE message.is_played
        WHEN 0 THEN '0 [No]'
        WHEN 1 THEN '1 [Yes]'
        ELSE 'Unknown Value : ' || message.is_played || ''
    END AS 'message.is_played',

    CASE
        WHEN LENGTH(message.date_played) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (message.date_played / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(message.date_played) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', message.date_played + 978307200, 'UNIXEPOCH')
        WHEN message.date_played IS 0 THEN NULL
        ELSE message.date_played
    END AS 'message.date_played(UTC)',

    CASE message.is_emote
        WHEN 0 THEN '0 [No]'
        WHEN 1 THEN '1 [Yes]'
        ELSE 'Unknown Value : ' || message.is_emote || ''
    END AS 'message.is_emote',

    CASE message.is_forward
        WHEN 0 THEN '0 [No]'
        WHEN 1 THEN '1 [Yes]'
        ELSE 'Unknown Value : ' || message.is_forward || ''
    END AS 'message.is_forward',

    CASE message.is_auto_reply
        WHEN 0 THEN '0 [No]'
        WHEN 1 THEN '1 [Yes]'
        ELSE 'Unknown Value : ' || message.is_auto_reply || ''
    END AS 'message.is_auto_reply',

    CASE message.is_system_message
        WHEN 0 THEN '0 [No]'
        WHEN 1 THEN '1 [Yes]'
        ELSE 'Unknown Value : ' || message.is_system_message || ''
    END AS 'message.is_system_message',

    CASE message.is_service_message
        WHEN 0 THEN '0 [No]'
        WHEN 1 THEN '1 [Yes]'
        ELSE 'Unknown Value : ' || message.is_service_message || ''
    END AS 'message.is_service_message',

    CASE message.is_spam
        WHEN 0 THEN '0 [No]'
        WHEN 1 THEN '1 [Yes]'
        ELSE 'Unknown Value : ' || message.is_spam || ''
    END AS 'message.is_spam',

    CASE message.was_data_detected
        WHEN 1 THEN '1 [Yes]'
        WHEN 0 THEN '0 [No]'
        ELSE 'Unknown Value: ' || message.was_data_detected || ''
    END AS 'message.was_data_detected',

    CASE message.ck_sync_state
        WHEN 0 THEN '0 [Not Synced]'
        WHEN 1 THEN '1 [Synced]'
        ELSE 'Unknown Value: ' || message.ck_sync_state || ''
    END AS 'message.ck_sync_state',

    CASE
        WHEN LENGTH(handle.id) = 14 AND handle.id LIKE '%p:+1%' THEN '(' || SUBSTR(handle.id, 5, 3) || ') ' || SUBSTR(handle.id, 8, 3) || '-' || SUBSTR(handle.id, 11, 4)
        WHEN LENGTH(handle.id) = 12 AND handle.id LIKE '+1%' THEN '(' || SUBSTR(handle.id, 3, 3) || ') ' || SUBSTR(handle.id, 6, 3) || '-' || SUBSTR(handle.id, 9, 4)
        WHEN LENGTH(handle.id) = 11 AND handle.id LIKE '1%' THEN '(' || SUBSTR(handle.id, 2, 3) || ') ' || SUBSTR(handle.id, 5, 3) || '-' || SUBSTR(handle.id, 8, 4)
        WHEN LENGTH(handle.id) = 10 THEN '(' || SUBSTR(handle.id, 1, 3) || ') ' || SUBSTR(handle.id, 4, 3) || '-' || SUBSTR(handle.id, 7, 4)
        WHEN handle.id IS NULL THEN NULL
        ELSE handle.id
    END AS 'handle.id',

    CASE chat.style
        WHEN '43' THEN '43 [GroupChat]'
        WHEN '45' THEN '45 [P2P]'
    END AS 'chat.style',

    chat_message_join.chat_id AS 'chat_message_join.chat_id',

    CASE message.item_type
        WHEN 0 THEN '0 [Message]'
        WHEN 1 THEN '1 [GroupParticipantAdded]'
        WHEN 2 THEN '2 [GroupRenamed]'
        WHEN 3 THEN '3 [GroupActionType-0=Participant_Leaves/GroupActionType-1=GroupPhotoChanged-3]'
        WHEN 4 THEN '4 [LocationSharingData]'
        WHEN 5 THEN '5 [Unknown]'
        WHEN 6 THEN '6 [Unknown]'
        ELSE 'Unknown Value : ' || message.item_type || ''
    END AS 'message.item_type',

    CASE message.subject
        WHEN 0 THEN NULL
        ELSE message.subject
    END AS 'message.subject',

    CASE message.text
        WHEN NULL THEN NULL
        ELSE message.text
    END AS 'message.text',

    message.reply_to_guid AS ' message.reply_to_guid',

    SUBSTR(message.associated_message_guid, 5, 36) AS 'message.associated_message_guid',

    CASE message.associated_message_type
        WHEN 0 THEN NULL
        WHEN 2 THEN '2 [Apple Payment Sent]'
        WHEN 3 THEN '3 [Apple Payment Requested]'
        WHEN 2000 THEN '2000 [LOVED Reaction]'
        WHEN 2001 THEN '2001 [LIKED Reaction]'
        WHEN 2002 THEN '2002 [DISLIKED Reaction]'
        WHEN 2003 THEN '2003 [LAUGHED Reaction]'
        WHEN 2004 THEN '2004 [EMPHASIZED Reaction]'
        WHEN 2005 THEN '2005 [QUESTIONED Reaction]'
        WHEN 3000 THEN '3000 [Removed LOVED Reaction]'
        WHEN 3001 THEN '3001 [Removed LIKE Reaction]'
        WHEN 3002 THEN '3002 [Removed DISLIKE Reaction]'
        WHEN 3003 THEN '3003 [Removed LAUGH Reaction]'
        WHEN 3004 THEN '3004 [Removed EXCLAMATION Reaction]'
        WHEN 3005 THEN '3005 [Removed QUESTION Reaction]'
        ELSE 'Unknown Value : ' || message.associated_message_type || ''
    END AS 'message.associated_message_type',

    message.balloon_bundle_id AS 'message.balloon_bundle_id',

    CASE message.was_delivered_quietly
        WHEN '0' THEN '0 [No]'
        WHEN '1' THEN '1 [Yes]'
        ELSE 'Unknown Value : '  || message.was_delivered_quietly || ''
    END AS 'WasDeliveredQuietly',

    CASE message.expressive_send_style_id
        WHEN 'comessage.apple.messages.effect.CKSpotlightEffect' THEN 'SpotlightEffect'
        WHEN 'comessage.apple.messages.effect.CKSparklesEffect' THEN 'SparklesEffect'
        WHEN 'comessage.apple.messages.effect.CKLasersEffect' THEN 'LaserEffect'
        WHEN 'comessage.apple.messages.effect.CKHeartEffect' THEN 'HeartEffect'
        WHEN 'comessage.apple.messages.effect.CKHappyBirthdayEffect' THEN 'HappyBirthdayEffect'
        WHEN 'comessage.apple.messages.effect.CKFireworksEffect' THEN 'FireworksEffect'
        WHEN 'comessage.apple.messages.effect.CKEchoEffect' THEN 'EchoEffect'
        WHEN 'comessage.apple.messages.effect.CKConfettiEffect' THEN 'ConfettiEffect'
        WHEN 'comessage.apple.MobileSMS.expressivesend.loud' THEN 'SMSExpressiveSendLoud'
        WHEN 'comessage.apple.MobileSMS.expressivesend.invisibleink' THEN 'SMSExpressiveSendInvisibleInk'
        WHEN 'comessage.apple.MobileSMS.expressivesend.impact' THEN 'SMSExpressiveSendImpact'
        WHEN 'comessage.apple.MobileSMS.expressivesend.gentle' THEN 'SMSExpressiveSendGentle'
        ELSE message.expressive_send_style_id
    END AS 'message.expressive_send_style_id',

    CASE message.is_read
        WHEN 0 THEN '0 [No]'
        WHEN 1 THEN '1 [Yes]'
        ELSE 'Unknown Value : ' || message.is_read || ''
    END AS 'message.is_read',

    CASE message.share_status
        WHEN 0 THEN '0 [Not Shared]'
        WHEN 1 THEN '1 [Shared]'
        ELSE message.share_status
    END AS 'message.share_status',

    CASE message.share_direction
        WHEN 0 THEN '0 [Received]'
        WHEN 1 THEN '1 [Sent]'
        ELSE message.share_direction
    END AS 'message.share_direction',

    CASE chat.display_name
        WHEN '' THEN NULL
        ELSE chat.display_name
    END AS 'chat.display_name',

    CASE attachment.is_outgoing
        WHEN 0 THEN '0 [No - Incoming]'
        WHEN 1 THEN '1 [Yes - Outgoing]'
        ELSE 'Unknown Value : ' || attachment.is_outgoing || ''
    END AS 'attachment.is_outgoing',

    message_attachment_join.attachment_id AS 'message_attachment_join.attachment_id',
    attachment.filename AS 'attachment.filename',
    attachment.transfer_name AS 'attachment.transfer_name',

    CASE
        WHEN attachment.total_bytes > 0 THEN printf("%,d", attachment.total_bytes)
        WHEN attachment.total_bytes IS 0 THEN '0'
        ELSE NULL
    END AS 'attachment.total_bytes',

    attachment.mime_type AS 'attachment.mime_type',
    attachment.uti AS 'attachment.uti',

    -- Date the attachment was created
    CASE
        WHEN LENGTH(attachment.created_date) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (attachment.created_date / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(attachment.created_date) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', attachment.created_date + 978307200, 'UNIXEPOCH')
        WHEN attachment.created_date IS NULL THEN NULL
        ELSE attachment.created_date
    END AS 'attachment.created_date(UTC)',

    -- Source for each line of data
    'sms.db; Table: messages(ROWID: ' || message.ROWID || ')' AS 'DATA_SOURCE'


FROM message
    LEFT JOIN message_attachment_join ON message.ROWID = message_attachment_join.message_id
    --LEFT JOIN attachment ON message_attachment_join.attachment_id = attachment.ROWID
    LEFT JOIN attachment ON attachment.ROWID = message_attachment_join.attachment_id
    LEFT JOIN chat_message_join ON message.ROWID = chat_message_join.message_id
    LEFT JOIN chat ON chat_message_join.chat_id = chat.ROWID
    LEFT JOIN handle ON message.handle_id = handle.ROWID


-- WHERE
--     message.associated_message_type IS NOT '0'
    -- message.expressive_send_style_id IS NOT NULL

    /*
    To filter between date/time points
    Between 10-11-2024 00:00:00 ET and 10-12-2024 at 14:06:00 ET
    */
    -- message.date BETWEEN 750312000000000000 AND 750449160000000000

    /*
    When `chat_message_join.chat_id` is NULL, that means that the message was deleted,
    but there is still a record of the message in the message table.
    It is likely that the vacuum functions has not run to delete the message from the table
    */
    --chat_message_join.chat_id IS NULL


ORDER BY
    message.ROWID ASC