SELECT

    ROW_NUMBER() OVER() AS 'RECORD_NUMBER',
    message.ROWID AS 'message.ROWID',
--     chat.service_name AS 'chat.service name',
--     handle.service AS 'handle.service',
	handle.ROWID AS 'handle.ROWID',
    handle.id AS 'handle.id',
    message.service AS 'messege.service',

    CASE message.type
        WHEN 0 THEN 'Message'
        WHEN 1 THEN 'Group_Participant_Added'
        WHEN 2 THEN 'Group_Renamed'
        WHEN 3 THEN 'GroupActionType 0=Participant_Leaves / GroupActionType 1=GroupPhotoChanged'
        WHEN 4 THEN 'Location Sharing Data'
        WHEN 5 THEN '5 [Unknown]'
        WHEN 6 THEN '6 [Unknown]'
        ELSE '[Unknown Value]: ' || message.type
    END AS 'message.type',

--     chat.room_name AS 'chat.room_name',
--     message.cache_roomnames AS 'message.cache_roomnames',
--     chat.account_login AS 'chat.account_login',
--     chat.guid AS 'chat.guid',
--     chat.chat_identifier AS 'chat.chat_identifier',
--     handle.id AS 'handle.id',

--     CASE chat_message_join.message_date
--         WHEN 0 THEN ''
--         ELSE datetime((chat_message_join.message_date / 1000000000) + 978307200, 'UNIXEPOCH')
--     END AS 'chat_message_join.message_date',

--     message.guid AS 'message_guid',
--     chat.last_addressed_handle AS 'chat.last_addressed_handle',

    CASE message.is_from_me
        WHEN 0 THEN 'Incoming'
        WHEN 1 THEN 'Outgoing'
        ELSE 'Unknown Value: ' || message.is_from_me
    END AS 'message.is_from_me',

    CASE message.date
        WHEN 0 THEN '[N/A]'
        ELSE datetime((message.date / 1000000000) + 978307200, 'UNIXEPOCH')
    END AS 'message.date',

    CASE message.date_delivered
        WHEN 0 THEN '[N/A]'
        ELSE datetime((message.date_delivered / 1000000000) + 978307200, 'UNIXEPOCH')
    END AS 'message.date_delivered',

    CASE message.date_read
        WHEN 0 THEN '[N/A]'
        ELSE datetime((message.date_read / 1000000000) + 978307200, 'UNIXEPOCH')
    END AS 'message.date_read',

--     CASE chat.last_read_message_timestamp
--         WHEN 0 THEN '0'
--         ELSE datetime((chat.last_read_message_timestamp / 1000000000) + 978307200, 'UNIXEPOCH')
--     END AS 'chat.last_read_message_timestamp',

    CASE message.was_data_detected
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE '[Unknown Value]: ' || message.was_data_detected
    END AS 'message.was_data_detected',

    message.text AS 'message.text',

    CASE message.cache_has_attachments
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE '[Unknown Value]: ' || message.cache_has_attachments
    END AS 'message.cache_has_attachments',

    CASE attachment.created_date
        WHEN 0 THEN '[N/A]'
        ELSE datetime(attachment.created_date + 978307200, 'UNIXEPOCH')
    END AS 'attachment.created_date',

    CASE attachment.start_date
        WHEN 0 THEN '[N/A]'
        ELSE datetime(attachment.start_date + 978307200, 'UNIXEPOCH')
    END AS 'attachment.start_date',

    CASE attachment.is_outgoing
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE '[Unknown Value]: ' || attachment.is_outgoing
    END AS 'attachment.is_outgoing',

    CASE attachment.hide_attachment
        WHEN 0 THEN 'Not a shared link'
        WHEN 1 THEN 'Is a shared link'
        ELSE '[Unknown Value]: ' || attachment.hide_attachment
    END AS 'attachment.hide_attachment',

    attachment.filename AS 'attachment.filename',
    attachment.transfer_name AS 'attachment.transfer_name',
--     attachment.guid AS 'attachment.guid',
    attachment.original_guid AS 'attachment.original_guid',

--     CASE chat.syndication_date
--         WHEN 0 THEN '0'
--         ELSE datetime((chat.syndication_date / 1000000000) + 978307200, 'UNIXEPOCH')
--     END AS 'chat.syndication_date',

--     CASE chat.syndication_type
--         WHEN 0 THEN 'Chat-Thread-SWY_Setting_Default-Not-Changed/Not-Supported-0'
--         WHEN 1 THEN 'Chat-Thread-SWY_Setting_ON-1'
--         WHEN 2 THEN 'Chat-Thread-SWY_Setting_OFF-2'
--         ELSE '[Unknown Value]: ' || chat.syndication_type
--     END AS 'chat.syndication_type',

    CASE attachment.ck_sync_state
        WHEN 0 THEN '0 [Unknown]'
        WHEN 3 THEN '3 [Unknown]'
        WHEN 4 THEN '4 [Unknown]'
        ELSE '[Unknown Value]: ' || attachment.ck_sync_state
    END AS 'attachment.ck_sync_state',

    attachment.ck_record_id AS 'attachment.ck_record_id',
    message.syndication_ranges AS 'message.syndication_ranges',
    message.synced_syndication_ranges AS 'message.synced_syndication_ranges',
    printf("%,d", attachment.total_bytes) AS 'attachment.total_bytes',
--     chat_handle_join.handle_id AS 'chat_handle_join.handle id',
--     chat.display_name AS 'chat.display name',
--     chat.group_id AS 'chat.group.id',
--     chat.original_group_id AS 'chat.original_group_id',
--     chat.server_change_token AS 'chat.server_change_token',
--     chat.is_blackholed AS 'chat.is_blackholed',

    CASE message.was_deduplicated
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE '[Unknown Value]: ' || message.was_deduplicated
    END AS 'message.was_deduplicated',

    attachment.mime_type AS 'attachment.mime_type',
    attachment.uti AS 'attachment.uti',
--     attachment.user_info AS 'attachment.user_info',
--     attachment.attribution_info AS 'attachment.attribution_info',

    CASE message.share_status
        WHEN 0 THEN 'Not Shared'
        WHEN 1 THEN 'Shared'
        ELSE '[Unknown Value]: ' || message.share_status
    END AS 'message.share_status',

    CASE message.share_direction
        WHEN 0 THEN 'Received'
        WHEN 1 THEN 'Sent'
        ELSE '[Unknown Value]: ' || message.share_direction
    END AS 'message.share_direction',

    CASE attachment.transfer_state
        WHEN 5 THEN '5 [Still Testing]'
        ELSE '[Unknown Value]: ' || attachment.transfer_state
    END AS 'attachment.transfer_state',

--     chat.cloudkit_record_id AS 'chat.cloudkit_record_id',
    message_attachment_join.message_id AS 'message_attachment_join.message_id',
    chat_message_join.message_id AS 'chat_message_join.message_id',
    attachment.ROWID AS 'attachment.ROWID',
    message_attachment_join.attachment_id AS 'message_attachment_join.attachment_id',
--     chat.ROWID AS 'chat_ROWID',
--     chat_handle_join.chat_id AS 'chat_handle_join.chat_id',
--     chat_message_join.chat_id AS 'chat_message_join.chat_id',
--     chat.ck_sync_state AS 'chat.ck_sync_state',

    CASE message.ck_sync_state
        WHEN 0 THEN 'Not Synced'
        WHEN 1 THEN 'Synced'
        ELSE '[Unknown Value]: ' || message.ck_sync_state
    END AS 'message.ck_sync_state',

--     message.ck_record_id AS 'message.ck_record_id',
--     message.ck_record_change_tag AS 'message.ck_record_change_tag',
--     attachment.ck_server_change_token_blob AS 'attachment.ck_server_change_token_blob',
    /* Source for each line of data */
    '/private/var/mobile/Library/SMS/sms.db; Table: message(ROWID: ' || message.ROWID || ')' AS 'DataSource'

FROM message
    LEFT JOIN message_attachment_join ON message.ROWID = message_attachment_join.message_id
    LEFT JOIN chat_message_join ON message_attachment_join.message_id = chat_message_join.message_id
    LEFT JOIN attachment ON attachment.ROWID = message_attachment_join.attachment_id
    LEFT JOIN chat ON chat_message_join.chat_id = chat.ROWID
    LEFT JOIN chat_handle_join ON chat.ROWID = chat_handle_join.chat_id
    LEFT JOIN handle ON message.handle_id = handle.ROWID


ORDER BY
    message.date
