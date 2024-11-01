/*
Query copied from https://github.com/ScottKjr3347/iOS_sms.db_queries/blob/main/iOS15/iOS15_smsdb_Query.txt
*/

SELECT

    ROW_NUMBER() OVER() AS 'RecordNo.',
    message.ROWID AS 'message.ROWID',
    handle.ROWID AS 'handle.ROWID',
    handle.id AS 'handle.id',
    chat.service_name AS 'chat.service_name',
    handle.service AS 'handle.service',
    message.service AS 'messege.service',

    CASE message.type
        WHEN 0 THEN 'Message'
        WHEN 1 THEN 'Group_Participant_Added'
        WHEN 2 THEN 'Group_Renamed'
        WHEN 3 THEN 'GroupActionType-0=Participant_Leaves / GroupActionType-1=GroupPhotoChanged'
        WHEN 4 THEN 'Location Sharing Data'
        WHEN 5 THEN 'StillTesting'
        WHEN 6 THEN 'StillTesting'
        ELSE message.type
    END AS 'message.type',

    chat.room_name AS 'chat.room_name',
    message.cache_roomnames AS 'message.cache_roomnames',
    chat.account_login AS 'chat.account _login',
    chat.guid AS 'chat.guid',
    chat.chat_identifier AS 'chat.chat_identifier',
    handle.id AS 'handle.id',

    CASE chat_message_join.message_date
        WHEN 0 THEN '0'
        ELSE datetime((chat_message_join.message_date / 1000000000) + 978307200, 'UNIXEPOCH')
    END AS 'chat_message_join.message_date',

    message.guid AS 'message.guid',
    chat.last_addressed_handle AS 'chat.last_addressed_handle',

    CASE message.date
        WHEN 0 THEN '0'
        ELSE datetime((message.date / 1000000000) + 978307200, 'UNIXEPOCH')
    END AS 'message.date (Received on device)',

    CASE message.date_delivered
        WHEN 0 THEN '0'
        ELSE datetime((message.date_delivered / 1000000000) + 978307200, 'UNIXEPOCH')
    END AS 'message.date_delivered',

    CASE message.date_read
        WHEN 0 THEN '0'
        ELSE datetime((message.date_read / 1000000000) + 978307200, 'UNIXEPOCH')
    END AS 'message.date_read',

    CASE chat.last_read_message_timestamp
        WHEN 0 THEN '0'
        ELSE datetime((chat.last_read_message_timestamp / 1000000000) + 978307200, 'UNIXEPOCH')
    END AS 'chat.last_read_message_timestamp',

    CASE message.was_data_detected
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE message.was_data_detected
    END AS 'message.was_data_detected',

    CASE message.cache_has_attachments
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE message.cache_has_attachments
    END AS 'message.cache_has_attachments',

    CASE attachment.created_date
        WHEN 0 THEN '0'
        ELSE datetime(attachment.created_date + 978307200, 'UNIXEPOCH')
    END AS 'attachment.created_date',

    CASE attachment.start_date
        WHEN 0 THEN '0'
        ELSE datetime(attachment.start_date + 978307200, 'UNIXEPOCH')
    END AS 'attachment.start_date',

    message.text AS 'message.text',

    CASE attachment.is_outgoing
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE attachment.is_outgoing
    END AS 'attachment.is_outgoing',

    CASE attachment.hide_attachment
        WHEN 0 THEN 'Not a shared link'
        WHEN 1 THEN 'Is a shared link'
        ELSE attachment.hide_attachment
    END AS 'attachment.hide_attachment',

    attachment.filename AS 'attachment.filename',
    attachment.transfer_name AS 'attachment.transfer_name',
    attachment.guid AS 'attachment.guid',
    attachment.original_guid AS 'attachment.original guid',

    CASE chat.syndication_date
        WHEN 0 THEN '0'
        ELSE datetime((chat.syndication_date / 1000000000) + 978307200, 'UNIXEPOCH')
    END AS 'chat.syndication_date',

    CASE chat.syndication_type
        WHEN 0 THEN 'Chat-Thread-SWY_Setting_Default-Not-Changed/Not-Supported'
        WHEN 1 THEN 'Chat-Thread-SWY_Setting_ON'
        WHEN 2 THEN 'Chat-Thread-SWY_Setting_OFF'
        ELSE chat.syndication_type
    END AS 'chat.syndication_type',

    CASE attachment.sr_ck_sync_state
        WHEN 0 THEN 'Attachment_Not_Synced_with_SWY'
        WHEN 1 THEN 'Attachment_Synced_with_SWY'
        ELSE attachment.sr_ck_sync_state
    END AS 'attahcment.sr_ck_sync_state',

    CASE attachment.ck_sync_state
        WHEN 0 THEN 'STILLTESTING-0'
        WHEN 3 THEN 'STILLTESTING-3'
        WHEN 4 THEN 'STILLTESTING-4'
        ELSE attachment.ck_sync_state
    END AS 'attachment.ck_sync_state',

    attachment.ck_record_id AS 'attachment.ck_record_id',
    message.syndication_ranges AS 'message.syndication_ranges',
    message.synced_syndication_ranges AS 'message.synced_syndication_ranges',
    attachment.total_bytes AS 'attachment.total_bytes',
    handle.ROWID AS 'handle.rowid',
    chat_handle_join.handle_id AS 'chat_handle_join.handle_id',
    chat.display_name AS 'chat.display_name',
    chat.group_id AS 'chat.group_id',
    chat.original_group_id AS 'chat.original_group_id',
    chat.server_change_token AS 'chat.server_change_token',
    chat.is_blackholed AS 'chat.is_blackholed',

    CASE message.was_deduplicated
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE message.was_deduplicated
    END AS 'message.was_deduplicated',

    attachment.mime_type AS 'attachment.mime_type',
    attachment.uti AS 'attachment.uti',
    attachment.user_info AS 'attachment.user_info',
    attachment.attribution_info AS 'attachment.attribution_info',

    CASE message.share_status
        WHEN 0 THEN 'STILLTESTING-0_NotShared'
        WHEN 1 THEN 'STILLTESTING-1_Shared'
        ELSE message.share_status
    END AS 'message.share_status',

    CASE message.share_direction
        WHEN 0 THEN 'Received'
        WHEN 1 THEN 'Sent'
        ELSE message.share_direction
    END AS 'message.share_direction',

    CASE attachment.transfer_state
        WHEN 5 THEN 'STILLTESTING-5'
        ELSE attachment.transfer_state
    END AS 'attachment.transfer_state',

    chat.cloudkit_record_id AS 'chat.cloudkit_record_idd',
    chat.sr_cloudkit_record_id AS 'chat.sr_cloudkit_record_id',
    chat.sr_server_change_token AS 'chat.sr_server_change_token',
    message_attachment_join.message_id AS 'message_attachment_join.message_id',
    chat_message_join.message_id AS 'chat_message_join.message_id',
    attachment.ROWID AS 'attachment.ROWID',
    message_attachment_join.attachment_id AS 'message_attachment_join.attachment id',
    chat.ROWID AS 'chat.ROWID',
    chat_handle_join.chat_id AS 'chat_handle_join.chat_id',
    chat_message_join.chat_id AS 'chat_message_join.chat_id',
    chat.sr_ck_sync_state AS 'chat.sr_ck_sync_state',
    chat.ck_sync_state AS 'chat.ck_sync_state',

    CASE message.ck_sync_state
        WHEN 0 THEN 'Not Synced'
        WHEN 1 THEN 'Synced'
        ELSE message.ck_sync_state
    END AS 'message.ck_sync_state',

    message.ck_record_id AS 'message.ck_record_id',
    message.ck_record_change_tag AS 'message.ck_record_change_tag',
    attachment.sr_ck_record_id AS 'attachment.sr_ck_record_id',
    attachment.ck_server_change_token_blob AS 'attachment.ck_server_change_token_blob',

    /* Source for each line of data */
    '/private/var/mobile/Library/SMS/sms.db; Table: messages(ROWID: ' || message.ROWID || ')' AS 'DataSource'

FROM message
    LEFT JOIN message_attachment_join ON message.ROWID = message_attachment_join.message_id
    LEFT JOIN chat_message_join ON message_attachment_join.message_id = chat_message_join.message_id
    LEFT JOIN attachment ON attachment.ROWID = message_attachment_join.attachment_id
    LEFT JOIN chat ON chat_message_join.chat_id = chat.ROWID
    LEFT JOIN chat_handle_join ON chat.ROWID = chat_handle_join.chat_id
    LEFT JOIN handle ON handle.ROWID = chat_handle_join.handle_id


ORDER BY
    message.date
