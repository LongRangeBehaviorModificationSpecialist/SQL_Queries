/*
[DLU]
    05-Sep-2025
[FILE PATH]
    /private/var/mobile/Library/SMS/sms.db
[FILE PATH]
    /private/var/mobile/Library/AddressBook/AddressBook.sqlitedb
*/

-- ATTACH DATABASE 'AddressBook.sqlitedb' AS 'AddressBook_db';

SELECT

    /* Add a row number at the beggining of each row */
    ROW_NUMBER() OVER() AS 'RECORD_NUMBER',
    message.ROWID AS 'message.ROWID',
    chat_message_join.message_id AS 'chat_message_join.message_id',

    /* When `chat_message_join.chat_id` is NULL, that means the message was deleted,
    but there is still a record of the message in the message table.
    It is likely that the vacuum functions has not run to delete the message from the table */
    chat_message_join.chat_id AS 'chat_message_join.chat_id',

    CASE
        WHEN LENGTH(message.date) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (message.date / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(message.date) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', message.date + 978307200, 'UNIXEPOCH')
        ELSE message.date
    END AS 'message.date(UTC)',

    CASE message.is_delivered
        WHEN 0 THEN '0 [No]'
        WHEN 1 THEN '1 [Yes]'
        ELSE '[Unknown Value: ' || message.is_delivered || ']'
    END AS 'message.is_delivered',

    CASE
        WHEN LENGTH(message.date_delivered) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (message.date_delivered / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(message.date_delivered) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', message.date_delivered + 978307200, 'UNIXEPOCH')
        WHEN message.date_delivered IS 0 THEN '[N/A]'
        ELSE message.date_delivered
    END AS 'message.date_delivered(UTC)',

    CASE
        WHEN LENGTH(message.date_read) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (message.date_read / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(message.date_read) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', message.date_read + 978307200, 'UNIXEPOCH')
        WHEN message.date_read IS 0 THEN '[N/A]'
        ELSE message.date_read
    END AS 'message.date_read(UTC)',

    CASE
        WHEN LENGTH(message.date_edited) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (message.date_edited / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(message.date_edited) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', message.date_edited + 978307200, 'UNIXEPOCH')
        WHEN message.date_edited IS 0 THEN '[N/A]'
        ELSE message.date_edited
    END AS 'message.date_edited(UTC)',

    CASE
        WHEN LENGTH(message.date_retracted) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (message.date_retracted / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(message.date_retracted) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', message.date_retracted + 978307200, 'UNIXEPOCH')
        WHEN message.date_retracted IS 0 THEN '[N/A]'
        ELSE message.date_retracted
    END AS 'message.date_retracted(UTC)',

    CASE
        WHEN LENGTH(chat_recoverable_message_join.delete_date) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (chat_recoverable_message_join.delete_date / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(chat_recoverable_message_join.delete_date) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', chat_recoverable_message_join.delete_date + 978307200, 'UNIXEPOCH')
        WHEN chat_recoverable_message_join.delete_date IS 0 THEN '[N/A]'
        ELSE chat_recoverable_message_join.delete_date
    END AS 'chat_recoverable_message_join.delete_date(UTC)',

    CASE message.share_status
        WHEN 0 THEN '0 [Not Shared]'
        WHEN 1 THEN '1 [Shared]'
        ELSE '[Unknown Value : ' || message.share_status || ']'
    END AS 'message.share_status',

    CASE message.share_direction
        WHEN 0 THEN '0 [Received]'
        WHEN 1 THEN '1 [Sent]'
        ELSE '[Unknown Value : ' || message.share_direction || ']'
    END AS 'message.share_direction',


    handle.ROWID AS 'handle.ROWID',

    /*
    Handle ID of the message
    Removes unnecessary text at the start of the string to leave just the 10-digit phone number
    Formats string as a U.S. phone number, i.e. (###) ###-####
    */
    CASE
        WHEN LENGTH(handle.id) = 14 AND handle.id LIKE '%p:+1%' THEN '(' || SUBSTR(handle.id, 5, 3) || ') ' || SUBSTR(handle.id, 8, 3) || '-' || SUBSTR(handle.id, 11, 4)
        WHEN LENGTH(handle.id) = 12 AND handle.id LIKE '+1%' THEN '(' || SUBSTR(handle.id, 3, 3) || ') ' || SUBSTR(handle.id, 6, 3) || '-' || SUBSTR(handle.id, 9, 4)
        WHEN LENGTH(handle.id) = 11 AND handle.id LIKE '1%' THEN '(' || SUBSTR(handle.id, 2, 3) || ') ' || SUBSTR(handle.id, 5, 3) || '-' || SUBSTR(handle.id, 8, 4)
        WHEN LENGTH(handle.id) = 10 THEN '(' || SUBSTR(handle.id,1,3) || ') ' || SUBSTR(handle.id, 4, 3) || '-' || SUBSTR(handle.id, 7, 4)
        WHEN handle.id IS NULL THEN '[N/A]'
        ELSE handle.id
    END AS 'handle.id',

    CASE chat.style
        WHEN '43' THEN '43 [Group Chat]'
        WHEN '45' THEN '45 [P2P]'
    END AS 'chat.style',

    CASE message.is_from_me
        WHEN 0 THEN '0 [Incoming]'
        WHEN 1 THEN '1 [Outgoing]'
        ELSE '[Unknown Value : ' || message.is_from_me || ']'
    END AS 'message.is_from_me',

    CASE message.type
        WHEN 0 THEN '0 [Message]'
        WHEN 1 THEN '1 [Group Participant Added]'
        WHEN 2 THEN '2 [Group Renamed]'
        WHEN 3 THEN '3 [GroupActionType 0=Participant_Leaves/GroupActionType 1=GroupPhotoChanged]'
        WHEN 4 THEN '4 [Location Sharing Data]'
        WHEN 5 THEN '5 [Unknown]'
        WHEN 6 THEN '6 [Unknown]'
        ELSE '[Unknown Value : ' || message.type || ']'
    END AS 'message.type',

    message.service AS 'message.service',

    /*
    Message account
    Removes unnecessary text at the start of the string to leave just the 10-digit phone number
    Formats string as a U.S. phone number, i.e. (###) ###-####
    */
    CASE
        WHEN LENGTH(message.account) = 14 AND message.account LIKE '%p:+1%' THEN '(' || SUBSTR(message.account, 5, 3) || ') ' || SUBSTR(message.account, 8, 3) || '-' || SUBSTR(message.account, 11, 4)
        WHEN LENGTH(message.account) = 12 AND message.account LIKE '+1%' THEN '(' || SUBSTR(message.account, 3, 3) || ') ' || SUBSTR(message.account, 6, 3) || '-' || SUBSTR(message.account, 9, 4)
        WHEN LENGTH(message.account) = 11 AND message.account LIKE '1%' THEN '(' || SUBSTR(message.account, 2, 3) || ') ' || SUBSTR(message.account, 5, 3) || '-' || SUBSTR(message.account, 8, 4)
        WHEN LENGTH(message.account) = 10 THEN '(' || SUBSTR(message.account, 1, 3) || ') ' || SUBSTR(message.account, 4, 3) || '-' || SUBSTR(message.account, 7, 4)
        WHEN message.account IS NULL THEN '[N/A]'
        ELSE message.account
    END AS 'message.account',

    message.cache_roomnames AS 'message.cache_roomnames',

    CASE
        WHEN message.text IS NOT NULL THEN message.text
        WHEN message.text IS NULL THEN '**NO TEXT**'
    END AS 'message.text',

    CASE
        WHEN chat.display_name IS NULL THEN '[N/A]'
        ELSE chat.display_name
    END AS 'chat.display_name',

    CASE message.cache_has_attachments
        WHEN 0 THEN '0 [No]'
        WHEN 1 THEN '1 [Yes]'
        ELSE '[Unknown Value : ' || message.cache_has_attachments || ']'
    END AS 'message.cache_has_attachments',

    CASE attachment.is_outgoing
        WHEN 0 THEN '0 [Incoming]'
        WHEN 1 THEN '1 [Outgoing]'
        ELSE '[Unknown Value : ' || attachment.is_outgoing || ']'
    END AS 'attachment.is_outgoing',

    attachment.ROWID AS 'attachment.ROWID',
    attachment.filename AS 'attachment.filename',
    attachment.transfer_name AS 'attachment.transfer_name',
    printf("%,d", attachment.total_bytes) AS 'attachment.total_bytes(bytes)',
    attachment.mime_type AS 'attachment.mime_type',
    attachment.guid AS 'attachment.guid',
    attachment.attribution_info AS 'attachment.attribution_info',

    /* Date the attachment was created */
    CASE
        WHEN LENGTH(attachment.created_date) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (attachment.created_date / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(attachment.created_date) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', attachment.created_date + 978307200, 'UNIXEPOCH')
        WHEN attachment.created_date IS NULL THEN '[N/A]'
        ELSE attachment.created_date
    END AS 'attachment.created_date(UTC)',

    attachment.uti AS 'attachment.uti',
    -- observed values 5 (temp folder) & 6 (Library)
    attachment.transfer_state AS 'attachment.transfer_state',
    hex(attachment.user_info) AS 'attachment.user_info(bplist)',
    chat.room_name AS 'chat.room_name',

    CASE
        WHEN LENGTH(chat.chat_identifier) = 14 AND chat.chat_identifier LIKE '%p:+1%' THEN '(' || SUBSTR(chat.chat_identifier, 5, 3) || ') ' || SUBSTR(chat.chat_identifier, 8, 3) || '-' || SUBSTR(chat.chat_identifier, 11, 4)
        WHEN LENGTH(chat.chat_identifier) = 12 AND chat.chat_identifier LIKE '+1%' THEN '(' || SUBSTR(chat.chat_identifier, 3, 3) || ') ' || SUBSTR(chat.chat_identifier, 6, 3) || '-' || SUBSTR(chat.chat_identifier, 9, 4)
        WHEN LENGTH(chat.chat_identifier) = 11 AND chat.chat_identifier LIKE '1%' THEN '(' || SUBSTR(chat.chat_identifier, 2, 3) || ') ' || SUBSTR(chat.chat_identifier, 5, 3) || '-' || SUBSTR(chat.chat_identifier, 8, 4)
        WHEN LENGTH(chat.chat_identifier) = 10 THEN '(' || SUBSTR(chat.chat_identifier, 1, 3) || ') ' || SUBSTR(chat.chat_identifier, 4, 3) || '-' || SUBSTR(chat.chat_identifier, 7, 4)
        WHEN chat.chat_identifier IS NULL THEN '[N/A]'
        ELSE chat.chat_identifier
    END AS 'chat.chat_identifier',

    CASE
        WHEN LENGTH(chat.last_addressed_handle) = 14 AND chat.last_addressed_handle LIKE '%p:+1%' THEN '(' || SUBSTR(chat.last_addressed_handle, 5, 3) || ') ' || SUBSTR(chat.last_addressed_handle, 8, 3) || '-' || SUBSTR(chat.last_addressed_handle, 11, 4)
        WHEN LENGTH(chat.last_addressed_handle) = 12 AND chat.last_addressed_handle LIKE '+1%' THEN '(' || SUBSTR(chat.last_addressed_handle, 3, 3) || ') ' || SUBSTR(chat.last_addressed_handle, 6, 3) || '-' || SUBSTR(chat.last_addressed_handle, 9, 4)
        WHEN LENGTH(chat.last_addressed_handle) = 11 AND chat.last_addressed_handle LIKE '1%' THEN '(' || SUBSTR(chat.last_addressed_handle, 2, 3) || ') ' || SUBSTR(chat.last_addressed_handle, 5, 3) || '-' || SUBSTR(chat.last_addressed_handle, 8, 4)
        WHEN LENGTH(chat.last_addressed_handle) = 10 THEN '(' || SUBSTR(chat.last_addressed_handle, 1, 3) || ') ' || SUBSTR(chat.last_addressed_handle, 4, 3) || '-' || SUBSTR(chat.last_addressed_handle, 7, 4)
        WHEN chat.last_addressed_handle IS NULL THEN '[N/A]'
        ELSE chat.last_addressed_handle
    END AS 'chat.last_addressed_handle',

    CASE message.was_data_detected
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE '[Unknown Value : ' || message.was_data_detected || ']'
    END AS 'message.was_data_detected',

    message.item_type AS 'message.item_type',

    CASE message.is_empty
        WHEN 0 THEN '0 [No]'
        WHEN 1 THEN '1 [Yes]'
        ELSE '[Unknown Value : ' || message.is_empty || ']'
    END AS 'message.is_empty',

    CASE message.is_archive
        WHEN 0 THEN '0 [No]'
        WHEN 1 THEN '1 [Yes]'
        ELSE '[Unknown Value : ' || message.is_archive || ']'
    END AS 'message.is_archive',

    CASE message.is_finished
        WHEN 0 THEN '0 [No]'
        WHEN 1 THEN '1 [Yes]'
        ELSE '[Unknown Value : ' || message.is_finished || ']'
    END AS 'message.is_finished',

    CASE message.is_audio_message
        WHEN 0 THEN '0 [No]'
        WHEN 1 THEN '1 [Yes]'
        ELSE '[Unknown Value : ' || message.is_audio_message || ']'
    END AS 'message.is_audio_message',

    CASE message.is_delayed
        WHEN 0 THEN '0 [No]'
        WHEN 1 THEN '1 [Yes]'
        ELSE '[Unknown Value : ' || message.is_delayed || ']'
    END AS 'message.is_delayed',

    CASE message.is_emote
        WHEN 0 THEN '0 [No]'
        WHEN 1 THEN '1 [Yes]'
        ELSE '[Unknown Value : ' || message.is_emote || ']'
    END AS 'message.is_emote',

    message.guid AS 'message.guid',
    chat.account_id AS 'chat.account_id',
    chat.group_id AS 'chat.group_id',
    chat.guid AS 'chat.guid',

    /* Source for each line of data */
    'sms.db; Table: messages(ROWID:' || message.ROWID || ')' AS 'DATA_SOURCE'


FROM message
    LEFT JOIN message_attachment_join ON message.ROWID = message_attachment_join.message_id
    LEFT JOIN chat_recoverable_message_join ON message.ROWID = chat_recoverable_message_join.message_id
    LEFT JOIN chat_message_join ON message.ROWID = chat_message_join.message_id
    LEFT JOIN attachment ON attachment.ROWID = message_attachment_join.attachment_id
    LEFT JOIN chat ON chat_message_join.chat_id = chat.ROWID
    LEFT JOIN handle ON message.handle_id = handle.ROWID
    -- LEFT JOIN handle ON message.handle_id = handle.ROWID OR message.other_handle = handle.ROWID


-- WHERE
--     message.date BETWEEN 694224000000000000 AND 707616000000000000


ORDER BY
    message.date ASC,
    message.ROWID
