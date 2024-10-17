/*
  DLU: 2024-10-16
  [SMS]
    FILE PATH = /private/var/mobile/Library/SMS/sms.db
  [AddressBook]
    FILE PATH = /private/var/mobile/Library/AddressBook/AddressBook.sqlitedb
*/

--ATTACH DATABASE "AddressBook.sqlitedb" AS 'AddressBook_db';

SELECT

    ROW_NUMBER() OVER() AS 'Record No.',
    message.ROWID AS 'message.ROWID',
    chat_message_join.message_id AS 'chat_message_join.message_id',

    CASE
        WHEN LENGTH(message.date) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (message.date / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(message.date) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', message.date + 978307200, 'UNIXEPOCH')
        ELSE message.date
    END AS 'message.date (UTC)',

    CASE message.is_delivered
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE message.is_delivered
    END AS 'message.is_delivered',

    CASE
        WHEN LENGTH(message.date_delivered) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (message.date_delivered / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(message.date_delivered) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', message.date_delivered + 978307200, 'UNIXEPOCH')
        WHEN message.date_delivered IS 0 THEN 'n/a'
        ELSE message.date_delivered
    END AS 'message.date_delivered (UTC)',

    CASE
        WHEN LENGTH(message.date_read) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (message.date_read / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(message.date_read) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', message.date_read + 978307200, 'UNIXEPOCH')
        WHEN message.date_read IS 0 THEN 'n/a'
        ELSE message.date_read
    END AS 'message.date_read (UTC)',

    CASE message.handle_id
        WHEN 0 THEN 'n/a'
        ELSE message.handle_id
    END AS 'message.handle_id',

    handle.ROWID AS 'handle.ROWID',

    CASE
        WHEN LENGTH(handle.id) = 14 AND handle.id LIKE '%p:+1%' THEN '(' ||  SUBSTR(handle.id, 5, 3) || ')' || SUBSTR(handle.id, 8, 3) || '-' || SUBSTR(handle.id, 11, 4)
        WHEN LENGTH(handle.id) = 12 AND handle.id LIKE '+1%' THEN '(' || SUBSTR(handle.id, 3, 3) || ')' || SUBSTR(handle.id, 6, 3) || '-' || SUBSTR(handle.id, 9, 4)
        WHEN LENGTH(handle.id) = 11 AND handle.id LIKE '1%' THEN '(' ||  SUBSTR(handle.id, 2, 3) || ')' || SUBSTR(handle.id, 5, 3) || '-' || SUBSTR(handle.id, 8, 4)
        WHEN LENGTH(handle.id) = 10 THEN '(' || SUBSTR(handle.id, 1, 3) || ')' || SUBSTR(handle.id, 4, 3) || '-' || SUBSTR(handle.id, 7, 4)
        WHEN handle.id IS NULL THEN 'n/a'
        ELSE handle.id
    END AS 'handle.id',

    CASE chat.style
        WHEN '43' THEN 'GroupChat'
        WHEN '45' THEN 'P2P'
        ELSE chat.style
    END AS 'ChatStyle',

    chat_message_join.chat_id AS 'chat_message_join.chat_id',

    CASE message.is_from_me
        WHEN 0 THEN 'Incoming'
        WHEN 1 THEN 'Outgoing'
        ELSE message.is_from_me
    END AS 'message.is_from_me',

    CASE message.type
        WHEN 0 THEN 'Message'
        WHEN 1 THEN 'GroupParticipantAdded'
        WHEN 2 THEN 'GroupRenamed'
        WHEN 3 THEN 'GroupActionType-0=Participant_Leaves / GroupActionType-1=GroupPhotoChanged-3'
        WHEN 4 THEN 'LocationSharingData'
        WHEN 5 THEN 'Unknown'
        WHEN 6 THEN 'Unknown'
        ELSE message.type
    END AS 'message.type',

    message.service AS 'MessageService',

    CASE
        WHEN LENGTH(message.account) = 14 AND message.account LIKE '%p:+1%' THEN '(' || SUBSTR(message.account, 5, 3) || ')' || SUBSTR(message.account, 8, 3) || '-' || SUBSTR(message.account, 11, 4)
        WHEN LENGTH(message.account) = 12 AND message.account LIKE '+1%' THEN '(' || SUBSTR(message.account, 3, 3) || ')' || SUBSTR(message.account, 6, 3) || '-' || SUBSTR(message.account, 9, 4)
        WHEN LENGTH(message.account) = 11 AND message.account LIKE '1%' THEN '(' || SUBSTR(message.account, 2, 3) || ')' || SUBSTR(message.account, 5, 3) || '-' || SUBSTR(message.account, 8, 4)
        WHEN LENGTH(message.account) = 10 THEN '(' || SUBSTR(message.account, 1, 3) || ')' || SUBSTR(message.account, 4, 3) || '-' || SUBSTR(message.account, 7, 4)
        WHEN message.account IS NULL THEN 'n/a'
        ELSE message.account
    END AS 'message.account',

    message.cache_roomnames AS 'message.cache_roomnames',

    CASE
        WHEN message.text IS NOT NULL THEN message.text
        WHEN message.text IS NULL THEN '**NO TEXT**'
    END AS 'message.text',

    CASE
        WHEN chat.display_name IS NULL THEN 'n/a'
        ELSE chat.display_name
    END AS 'chat.display_name',

    CASE message.cache_has_attachments
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE message.cache_has_attachments
    END AS 'message.cache_has_attachments',

    CASE attachment.is_outgoing
        WHEN 0 THEN 'Incoming'
        WHEN 1 THEN 'Outgoing'
        ELSE attachment.is_outgoing
    END AS 'attachment.is_outgoing',

    attachment.ROWID AS 'attachment.ROWID',
    attachment.mime_type AS 'attachment.mime_type',
    attachment.filename AS 'attachment.filename',
    attachment.transfer_name AS 'attachment.transfer_name',
    printf("%,d", attachment.total_bytes) AS 'attachment.total_bytes',
    attachment.original_guid AS 'attachment.original_guid',

    /* Date the attachment was created */
    CASE
        WHEN LENGTH(attachment.created_date) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (attachment.created_date / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(attachment.created_date) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', attachment.created_date + 978307200, 'UNIXEPOCH')
        WHEN attachment.created_date IS NULL THEN 'n/a'
        ELSE 'ContactExaminer'
    END AS 'AttachmentCreatedDate(UTC)',

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
    END AS 'Chat.ChatIdentifier',

    CASE
        WHEN LENGTH(chat.last_addressed_handle) = 14 AND chat.last_addressed_handle LIKE '%p:+1%' THEN '(' || SUBSTR(chat.last_addressed_handle, 5, 3) || ')' || SUBSTR(chat.last_addressed_handle, 8, 3) || '-' || SUBSTR(chat.last_addressed_handle, 11, 4)
        WHEN LENGTH(chat.last_addressed_handle) = 12 AND chat.last_addressed_handle LIKE '+1%' THEN '(' || SUBSTR(chat.last_addressed_handle, 3, 3) || ')' || SUBSTR(chat.last_addressed_handle, 6, 3) || '-' || SUBSTR(chat.last_addressed_handle, 9, 4)
        WHEN LENGTH(chat.last_addressed_handle) = 11 AND chat.last_addressed_handle LIKE '1%' THEN '(' || SUBSTR(chat.last_addressed_handle, 2, 3) || ')' || SUBSTR(chat.last_addressed_handle, 5, 3) || '-' || SUBSTR(chat.last_addressed_handle, 8, 4)
        WHEN LENGTH(chat.last_addressed_handle) = 10 THEN '(' || SUBSTR(chat.last_addressed_handle, 1, 3) || ')' || SUBSTR(chat.last_addressed_handle, 4, 3) || '-' || SUBSTR(chat.last_addressed_handle, 7, 4)
        WHEN chat.last_addressed_handle IS NULL THEN 'n/a'
        ELSE chat.last_addressed_handle
    END AS 'chat.last_addressed_handle',

    CASE message.was_data_detected
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE message.was_data_detected
    END AS 'message.was_data_detected',

    message.item_type AS 'message.item_type',

    CASE message.is_empty
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE message.is_empty
    END AS 'message.is_empty',

    CASE message.is_archive
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE message.is_archive
    END AS 'message.is_archive',

    CASE message.is_finished
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE message.is_finished
    END AS 'message.is_finished',

    CASE message.is_audio_message
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE message.is_audio_message
    END AS 'message.is_audio_message',

    CASE message.is_delayed
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE message.is_delayed
    END AS 'message.is_delayed',

    CASE message.is_emote
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE message.is_emote
    END AS 'message.is_emote',

    message.guid AS 'message.guid',
    chat.account_id AS 'chat.account_id',
    chat.group_id AS 'chat.group_id',
    chat.guid AS 'chat.guid',

    --Source for each line of data
    '/private/var/mobile/Library/SMS/sms.db' AS 'DatabaseFile',
    'Table: messages(ROWID: ' || message.ROWID || ')' AS 'DataSource'


FROM message

    LEFT JOIN message_attachment_join ON message.ROWID = message_attachment_join.message_id
    LEFT JOIN chat_message_join ON message_attachment_join.message_id = chat_message_join.message_id
    LEFT JOIN attachment ON attachment.ROWID = message_attachment_join.attachment_id
    LEFT JOIN chat ON chat_message_join.chat_id = chat.ROWID
    LEFT JOIN handle ON message.handle_id = handle.ROWID OR message.other_handle = handle.ROWID


--To filter between date/time points
WHERE

    message.date BETWEEN 750312000000000000 AND 750449160000000000


ORDER BY message.date ASC, message.ROWID