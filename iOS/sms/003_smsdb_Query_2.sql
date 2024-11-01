/*
  DLU: 2024-10-17
  [VERSION]
    Tested on iOS 18
  [SMS]
    FILE PATH = /private/var/mobile/Library/SMS/sms.db
  [AddressBook]
    FILE PATH = /private/var/mobile/Library/AddressBook/AddressBook.sqlitedb
*/

--ATTACH DATABASE "AddressBook.sqlitedb" AS 'AddressBook_db';

SELECT

    ROW_NUMBER() OVER() AS 'RecordNo.',
    message.ROWID AS 'MessageROWID',

    CASE
        WHEN LENGTH(message.date) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (message.date / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(message.date) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', message.date + 978307200, 'UNIXEPOCH')
        ELSE message.date
    END AS 'MessageDateTime(UTC)',

    chat_message_join.chat_id AS 'ChatMessageJoinChatId',

    CASE
        WHEN chat_message_join.chat_id IS NULL THEN 'DELETED MESSAGE'
        ELSE 'No'
    END AS 'WasDeleted',

    CASE
        WHEN LENGTH(chat_recoverable_message_join.delete_date) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (chat_recoverable_message_join.delete_date / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(chat_recoverable_message_join.delete_date) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', chat_recoverable_message_join.delete_date + 978307200, 'UNIXEPOCH')
        ELSE chat_recoverable_message_join.delete_date
    END AS 'DeletedDateTime(UTC)',

    CASE message.is_from_me
        WHEN 0 THEN 'Incoming'
        WHEN 1 THEN 'Outgoing'
        ELSE message.is_from_me
    END AS 'MessageDirection',

    CASE
        WHEN message.text IS NOT NULL THEN message.text
        ELSE NULL
    END AS 'MessageText',

    CASE message.is_delivered
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE message.is_delivered
    END AS 'MessageIsDelivered',

    CASE
        WHEN LENGTH(message.date_delivered) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (message.date_delivered / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(message.date_delivered) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', message.date_delivered + 978307200, 'UNIXEPOCH')
        WHEN message.date_delivered IS 0 THEN NULL
        ELSE message.date_delivered
    END AS 'MessageDeliveredDateTime(UTC)',

    CASE
        WHEN LENGTH(message.date_read) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (message.date_read / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(message.date_read) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', message.date_read + 978307200, 'UNIXEPOCH')
        WHEN message.date_read IS 0 THEN NULL
        ELSE message.date_read
    END AS 'MessageReadDateTime(UTC)',

    CASE
        WHEN LENGTH(message.date_edited) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (message.date_edited / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(message.date_edited) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', message.date_edited + 978307200, 'UNIXEPOCH')
        WHEN message.date_edited IS 0 THEN NULL
        ELSE message.date_edited
    END AS 'MessageEditedDateTime(UTC)',

    CASE
        WHEN LENGTH(message.date_retracted) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (message.date_retracted / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(message.date_retracted) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', message.date_retracted + 978307200, 'UNIXEPOCH')
        WHEN message.date_retracted IS 0 THEN NULL
        ELSE message.date_retracted
    END AS 'MessageRetractedDateTime(UTC)',

    CASE message.handle_id
        WHEN 0 THEN 'n/a'
        ELSE message.handle_id
    END AS 'MessageHandleId',

    handle.ROWID AS 'HandleROWID',

    CASE
        WHEN LENGTH(handle.id) = 14 AND handle.id LIKE '%p:+1%' THEN '(' || SUBSTR(handle.id, 5, 3) || ')' || SUBSTR(handle.id, 8, 3) || '-' || SUBSTR(handle.id, 11, 4)
        WHEN LENGTH(handle.id) = 12 AND handle.id LIKE '+1%' THEN '(' || SUBSTR(handle.id, 3, 3) || ')' || SUBSTR(handle.id, 6, 3) || '-' || SUBSTR(handle.id, 9, 4)
        WHEN LENGTH(handle.id) = 11 AND handle.id LIKE '1%' THEN '(' || SUBSTR(handle.id, 2, 3) || ')' || SUBSTR(handle.id, 5, 3) || '-' || SUBSTR(handle.id, 8, 4)
        WHEN LENGTH(handle.id) = 10 THEN '(' || SUBSTR(handle.id, 1, 3) || ')' || SUBSTR(handle.id, 4, 3) || '-' || SUBSTR(handle.id, 7, 4)
        WHEN handle.id IS NULL THEN 'n/a'
        ELSE handle.id
    END AS 'HandleId',

    CASE chat.style
        WHEN '43' THEN 'GroupChat'
        WHEN '45' THEN 'P2P'
        ELSE chat.style
    END AS 'ChatStyle',

    CASE message.type
        WHEN 0 THEN 'Message'
        WHEN 1 THEN 'GroupParticipantAdded'
        WHEN 2 THEN 'GroupRenamed'
        WHEN 3 THEN 'GroupActionType-0=Participant_Leaves / GroupActionType-1=GroupPhotoChanged-3'
        WHEN 4 THEN 'LocationSharingData'
        WHEN 5 THEN 'Unknown'
        WHEN 6 THEN 'Unknown'
        ELSE message.type
    END AS 'MessageType',

    message.service AS 'MessageService',

    CASE
        WHEN LENGTH(message.account) = 14 AND message.account LIKE '%p:+1%' THEN '(' || SUBSTR(message.account, 5, 3) || ')' || SUBSTR(message.account, 8, 3) || '-' || SUBSTR(message.account, 11, 4)
        WHEN LENGTH(message.account) = 12 AND message.account LIKE '+1%' THEN '(' || SUBSTR(message.account, 3, 3) || ')' || SUBSTR(message.account, 6, 3) || '-' || SUBSTR(message.account, 9, 4)
        WHEN LENGTH(message.account) = 11 AND message.account LIKE '1%' THEN '(' || SUBSTR(message.account, 2, 3) || ')' || SUBSTR(message.account, 5, 3) || '-' || SUBSTR(message.account, 8, 4)
        WHEN LENGTH(message.account) = 10 THEN '(' || SUBSTR(message.account, 1, 3) || ')' || SUBSTR(message.account, 4, 3) || '-' || SUBSTR(message.account, 7, 4)
        WHEN message.account IS NULL THEN 'n/a'
        ELSE message.account
    END AS 'MessageAccount',

    message.cache_roomnames AS 'MessageCacheRoomNames',

    CASE
        WHEN chat.display_name IS NULL THEN 'n/a'
        ELSE chat.display_name
    END AS 'ChatDisplayName',

    message.balloon_bundle_id AS 'BalloonBundleID',

    CASE message.cache_has_attachments
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE message.cache_has_attachments
    END AS 'MessageCacheHasAttachments',

    CASE attachment.is_outgoing
        WHEN 0 THEN 'Incoming'
        WHEN 1 THEN 'Outgoing'
        ELSE attachment.is_outgoing
    END AS 'AttachmentDirection',

    attachment.ROWID AS 'AttachmentROWID',
    attachment.mime_type AS 'AttachmentMimeType',
    attachment.filename AS 'AttachmentFilename',
    attachment.transfer_name AS 'AttachmentTransferName',
    printf("%,d", attachment.total_bytes) AS 'AttachmentTotalBytes',
    attachment.original_guid AS 'AttachmentOriginalGUID',

    /* Date the attachment was created */
    CASE
        WHEN LENGTH(attachment.created_date) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (attachment.created_date / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(attachment.created_date) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', attachment.created_date + 978307200, 'UNIXEPOCH')
        WHEN attachment.created_date IS NULL THEN NULL
        ELSE attachment.created_date
    END AS 'AttachmentCreatedDateTime(UTC)',

    attachment.uti AS 'AttachmentUTI',
    -- observed values 5 (temp folder) & 6 (Library)
    attachment.transfer_state AS 'AttachmentTransferState',
    attachment.user_info AS 'AttachmentUserInfo(bplist)',
    chat.room_name AS 'ChatRoomName',

    CASE
        WHEN LENGTH(chat.chat_identifier) = 14 AND chat.chat_identifier LIKE '%p:+1%' THEN '(' || SUBSTR(chat.chat_identifier, 5, 3) || ')' || SUBSTR(chat.chat_identifier, 8, 3) || '-' || SUBSTR(chat.chat_identifier, 11, 4)
        WHEN LENGTH(chat.chat_identifier) = 12 AND chat.chat_identifier LIKE '+1%' THEN '(' || SUBSTR(chat.chat_identifier, 3, 3) || ')' || SUBSTR(chat.chat_identifier, 6, 3) || '-' || SUBSTR(chat.chat_identifier, 9, 4)
        WHEN LENGTH(chat.chat_identifier) = 11 AND chat.chat_identifier LIKE '1%' THEN '(' || SUBSTR(chat.chat_identifier, 2, 3) || ')' || SUBSTR(chat.chat_identifier, 5, 3) || '-' || SUBSTR(chat.chat_identifier, 8, 4)
        WHEN LENGTH(chat.chat_identifier) = 10 THEN '(' || SUBSTR(chat.chat_identifier, 1, 3) || ')' || SUBSTR(chat.chat_identifier, 4, 3) || '-' || SUBSTR(chat.chat_identifier, 7, 4)
        WHEN chat.chat_identifier IS NULL THEN 'n/a'
        ELSE chat.chat_identifier
    END AS 'ChatIdentifier',

    CASE
        WHEN LENGTH(chat.last_addressed_handle) = 14 AND chat.last_addressed_handle LIKE '%p:+1%' THEN '(' || SUBSTR(chat.last_addressed_handle, 5, 3) || ')' || SUBSTR(chat.last_addressed_handle, 8, 3) || '-' || SUBSTR(chat.last_addressed_handle, 11, 4)
        WHEN LENGTH(chat.last_addressed_handle) = 12 AND chat.last_addressed_handle LIKE '+1%' THEN '(' || SUBSTR(chat.last_addressed_handle, 3, 3) || ')' || SUBSTR(chat.last_addressed_handle, 6, 3) || '-' || SUBSTR(chat.last_addressed_handle, 9, 4)
        WHEN LENGTH(chat.last_addressed_handle) = 11 AND chat.last_addressed_handle LIKE '1%' THEN '(' || SUBSTR(chat.last_addressed_handle, 2, 3) || ')' || SUBSTR(chat.last_addressed_handle, 5, 3) || '-' || SUBSTR(chat.last_addressed_handle, 8, 4)
        WHEN LENGTH(chat.last_addressed_handle) = 10 THEN '(' || SUBSTR(chat.last_addressed_handle, 1, 3) || ')' || SUBSTR(chat.last_addressed_handle, 4, 3) || '-' || SUBSTR(chat.last_addressed_handle, 7, 4)
        WHEN chat.last_addressed_handle IS NULL THEN 'n/a'
        ELSE chat.last_addressed_handle
    END AS 'LastAddressedHandle',

    CASE message.was_data_detected
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE message.was_data_detected
    END AS 'WasDataDetected',

    message.item_type AS 'ItemType',

    CASE message.is_empty
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE message.is_empty
    END AS 'IsEmpty',

    CASE message.is_archive
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE message.is_archive
    END AS 'IsArchive',

    CASE message.is_finished
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE message.is_finished
    END AS 'IsFinished',

    CASE message.is_audio_message
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE message.is_audio_message
    END AS 'IsAudioMessage',

    CASE message.is_delayed
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE message.is_delayed
    END AS 'IsDelayed',

    CASE message.is_emote
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE message.is_emote
    END AS 'IsEmote',

    message.guid AS 'MessageGUID',
    chat.account_id AS 'ChatAccountId',
    chat.group_id AS 'ChatGroupId',
    chat.guid AS 'ChatGUID',

    /* Source for each line of data */
    '/private/var/mobile/Library/SMS/sms.db; messages(ROWID: ' || message.ROWID || ')' AS 'DataSource'


FROM message
    LEFT JOIN message_attachment_join ON message.ROWID = message_attachment_join.message_id
    LEFT JOIN chat_recoverable_message_join ON message.ROWID = chat_recoverable_message_join.message_id
    LEFT JOIN chat_message_join ON message.ROWID = chat_message_join.message_id
    LEFT JOIN attachment ON attachment.ROWID = message_attachment_join.attachment_id
    LEFT JOIN chat ON chat_message_join.chat_id = chat.ROWID
    LEFT JOIN handle ON message.handle_id = handle.ROWID OR message.other_handle = handle.ROWID


WHERE
    --To filter between date/time points
    --Between 10-11-2024 00:00:00 ET and 10-12-2024 at 14:06:00 ET
    message.date BETWEEN 750312000000000000 AND 750449160000000000
    /* When `chat_message_join.chat_id` is NULL, that means that the message was deleted,
    but there is still a record of the message in the message table.
    It is likely that the vacuum functions has not run to delete the message from the table */
    -- AND chat_message_join.chat_id IS NULL


ORDER BY
    message.date ASC, message.ROWID