SELECT
    ROW_NUMBER() OVER() AS 'RecordNo.',
    message.ROWID AS 'MessageROWID',

    CASE
        WHEN LENGTH(message.date) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (message.date / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(message.date) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', message.date + 978307200, 'UNIXEPOCH')
        ELSE message.date
    END AS 'MessageDateTime(UTC)',

    chat_message_join.chat_id AS 'ChatMessageJoinChatId',
    COALESCE(chat_message_join.chat_id, 'DELETED MESSAGE') AS 'WasDeleted',
    message.is_from_me AS 'MessageDirection',
    message.text AS 'MessageText',

    CASE message.is_delivered
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE message.is_delivered
    END AS 'MessageIsDelivered',

    -- Date conversions for `message.date_delivered`, `message.date_read`, `message.date_edited`, etc.
    -- Followed by similar CASE and formatting logic as above if essential

    message.handle_id AS 'MessageHandleId',
    handle.ROWID AS 'HandleROWID',
    handle.id AS 'HandleId',
    chat.style AS 'ChatStyle',
    message.type AS 'MessageType',
    message.service AS 'MessageService',
    message.account AS 'MessageAccount',
    message.cache_roomnames AS 'MessageCacheRoomNames',
    COALESCE(chat.display_name, 'n/a') AS 'ChatDisplayName',
    message.balloon_bundle_id AS 'BalloonBundleID',
    message.cache_has_attachments AS 'MessageCacheHasAttachments',
    attachment.ROWID AS 'AttachmentROWID',
    attachment.mime_type AS 'AttachmentMimeType',
    attachment.filename AS 'AttachmentFilename',

    /* Minimized attachment fields */
    printf("%,d", attachment.total_bytes) AS 'AttachmentTotalBytes',
    attachment.original_guid AS 'AttachmentOriginalGUID',
    chat.room_name AS 'ChatRoomName',
    chat.chat_identifier AS 'ChatIdentifier',
    chat.last_addressed_handle AS 'LastAddressedHandle',

    -- Data from chat table
    chat.account_id AS 'ChatAccountId',
    chat.group_id AS 'ChatGroupId',
    chat.guid AS 'ChatGUID',
    '/private/var/mobile/Library/SMS/sms.db; Table: messages(ROWID: ' || message.ROWID || ')' AS 'DataSource'


FROM message
    LEFT JOIN message_attachment_join ON message.ROWID = message_attachment_join.message_id
    LEFT JOIN chat_recoverable_message_join ON message.ROWID = chat_recoverable_message_join.message_id
    LEFT JOIN chat_message_join ON message.ROWID = chat_message_join.message_id
    LEFT JOIN attachment ON attachment.ROWID = message_attachment_join.attachment_id
    LEFT JOIN chat ON chat_message_join.chat_id = chat.ROWID
    LEFT JOIN handle ON message.handle_id = handle.ROWID


WHERE
    message.date BETWEEN 750312000000000000 AND 750449160000000000


ORDER BY message.date ASC, message.ROWID;