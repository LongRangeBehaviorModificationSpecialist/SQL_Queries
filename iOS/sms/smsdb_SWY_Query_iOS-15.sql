/*
Query copied from https://github.com/ScottKjr3347/iOS_sms.db_queries/blob/main/iOS15/iOS15_SWY_smsdb_Query.txt
*/

SELECT
    ROW_NUMBER() OVER() AS 'RecordNo.',

    CASE message.date
        WHEN 0 THEN '0'
        ELSE datetime((message.date / 1000000000) + 978307200, 'UNIXEPOCH')
    END AS 'message-date received-on-device',

    message.guid AS 'message-guid',
    message."text" AS 'message-text or object-notice',

    CASE attachment.created_date
        WHEN 0 THEN '0'
        ELSE datetime(attachment.created_date + 978307200, 'UNIXEPOCH')
    END AS 'attachment-created date',

    CASE attachment.start_date
        WHEN 0 THEN '0'
        ELSE datetime(attachment.start_date + 978307200, 'UNIXEPOCH')
    END AS 'attachment-start date',

    CASE message.date_delivered
        WHEN 0 THEN '0'
        ELSE datetime((message.date_delivered / 1000000000) + 978307200, 'UNIXEPOCH')
    END AS 'message-date_delivered',

    CASE message.date_read
        WHEN 0 THEN '0'
        ELSE datetime((message.date_read / 1000000000) + 978307200, 'UNIXEPOCH')
    END AS 'message-date_read',

    CASE chat.last_read_message_timestamp
        WHEN 0 THEN '0'
        ELSE datetime((chat.last_read_message_timestamp / 1000000000) + 978307200, 'UNIXEPOCH')
    END AS 'chat-last read message timestamp',

    CASE chat.syndication_date
        WHEN 0 THEN '0'
        ELSE datetime((chat.syndication_date / 1000000000) + 978307200, 'UNIXEPOCH')
    END AS 'chat-syndication date',

    attachment.filename AS 'attachment-filename',
    attachment.transfer_name AS 'attachment-transfer_name',
    attachment.guid AS 'attachment-guid',
    attachment.original_guid AS 'attachment-original guid',

    CASE chat.syndication_type
        WHEN 0 THEN 'Chat-Thread-SWY_Setting_Default-Not-Changed/Not-Supported-0'
        WHEN 1 THEN 'Chat-Thread-SWY_Setting_ON-1'
        WHEN 2 THEN 'Chat-Thread-SWY_Setting_OFF-2'
        ELSE 'Unknown-New-Value!: ' || chat.syndication_type || ''
    END AS 'chat-syndication type',

    CASE attachment.sr_ck_sync_state
        WHEN 0 THEN '0-StillTesting-0'
        WHEN 1 THEN '0-StillTesting-1'
        ELSE 'Unknown-New-Value!: ' || attachment.sr_ck_sync_state || ''
    END AS 'attahcment-sr-ck_sync_state',

    CASE attachment.ck_sync_state
        WHEN 0 THEN '0-STILLTESTING-0'
        WHEN 3 THEN '3-STILLTESTING-3'
        WHEN 4 THEN '4-STILLTESTING-4'
        ELSE 'Unknown-New-Value!: ' || attachment.ck_sync_state || ''
    END AS 'attachment-ck_sync_state',

    attachment.ck_record_id AS 'attachment-ck record id',
    message.syndication_ranges AS 'message-syndication_ranges',
    message.synced_syndication_ranges AS 'message-synced_syndication_ranges',
    attachment.total_bytes AS 'attachment-total_bytes',
    chat.service_name AS 'chat-service name',
    handle.service AS 'handle-service',
    message.service AS 'messege-service',
    chat.room_name AS 'chat-room name',
    message.cache_roomnames AS 'message.cache_roomnames',
    chat.account_login AS 'chat-account login',
    chat.guid AS 'chat-guid',
    chat.chat_identifier AS 'chat-chat identifier',
    handle.id AS 'handle-id',

    CASE chat_message_join.message_date
        WHEN 0 THEN '0'
        ELSE datetime((chat_message_join.message_date / 1000000000) + 978307200, 'UNIXEPOCH')
    END AS 'chat_message_join-message date',

    chat.last_addressed_handle AS 'chat-last addressed handle',

    CASE message.was_data_detected
        WHEN 0 THEN 'No-0'
        WHEN 1 THEN 'Yes-1'
        ELSE 'Unknown-New-Value!: ' || message.was_data_detected || ''
    END AS 'message-was data detected',

    CASE message.cache_has_attachments
        WHEN 0 THEN 'No-0'
        WHEN 1 THEN 'Yes-1'
        ELSE 'Unknown-New-Value!: ' || message.cache_has_attachments || ''
    END AS 'message-cache has attachments',

    CASE attachment.is_outgoing
        WHEN 0 THEN 'No-0'
        WHEN 1 THEN 'Yes-1'
        ELSE 'Unknown-New-Value!: ' || attachment.is_outgoing || ''
    END AS 'attachment-is_outgoing',

    CASE attachment.hide_attachment
        WHEN 0 THEN 'Not a shared link-0'
        WHEN 1 THEN 'Is a shared link-1'
        ELSE 'Unknown-New-Value!: ' || attachment.hide_attachment || ''
    END AS 'attachment-hide_attachment',

    handle."ROWID" AS 'handle-row id',
    chat_handle_join.handle_id AS 'chat_handle_join-handle id',
    chat.display_name AS 'chat-display name',
    chat.group_id AS 'chat-group id',
    chat.original_group_id AS 'chat-original group id',
    chat.server_change_token AS 'chat-server change token',
    chat.is_blackholed AS 'chat-is blackholed',

    CASE message.was_deduplicated
        WHEN 0 THEN 'No-0'
        WHEN 1 THEN 'Yes-1'
        ELSE 'Unknown-New-Value!: ' || message.was_deduplicated || ''
    END AS 'message-was deduplicated',

    attachment.mime_type AS 'attachment-mime type',
    attachment.uti AS 'attachment-uti',
    attachment.user_info AS 'attachment-user_info',
    attachment.attribution_info AS 'attachment-attribution_info',

    CASE message.share_status
        WHEN 0 THEN '0-STILLTESTING-0_NotShared-0'
        WHEN 1 THEN '1-STILLTESTING-1_Shared-1'
        ELSE 'Unknown-New-Value!: ' || message.share_status || ''
    END AS 'message-share status',

    CASE message.share_direction
        WHEN 0 THEN '0-STILLTESTING-0_Received-0'
        WHEN 1 THEN '1-STILLTESTING-1_Sent-1'
        ELSE 'Unknown-New-Value!: ' || message.share_direction || ''
    END AS 'message-share direction',

    CASE attachment.transfer_state
        WHEN 5 THEN 'STILLTESTING-5'
        ELSE 'Unknown-New-Value!: ' || attachment.transfer_state || ''
    END AS 'attachment.transfer_state',

    chat.cloudkit_record_id AS 'chat-cloudkit record id',
    chat.sr_cloudkit_record_id AS 'chat-sr cloudkit record id',
    chat.sr_server_change_token AS 'chat-sr server change token',
    message."ROWID" AS 'message-ROWID2-PK',
    message_attachment_join.message_id AS 'message_attachment_join-message id',
    chat_message_join.message_id AS 'chat_message_join-message id',
    attachment."ROWID" AS 'attachment-ROWID-PK',
    message_attachment_join.attachment_id AS 'message_attachment_join-attachment id',
    chat."ROWID" AS 'chat-row id',
    chat_handle_join.chat_id AS 'chat_handle_join-chat id',
    chat_message_join.chat_id AS 'chat_message_join-chat id',
    chat.sr_ck_sync_state AS 'chat-sr ck sync token',
    chat.ck_sync_state AS 'chat-ck sync state',

    CASE message.ck_sync_state
        WHEN 0 THEN 'Not Synced-0'
        WHEN 1 THEN 'Synced-1'
        ELSE 'Unknown-New-Value!: ' || message.ck_sync_state || ''
    END AS 'message-ck_sync_state',

    message.ck_record_id AS 'message-cloud-kit record-id',
    message.ck_record_change_tag AS 'message-ck_record_change_tag',
    attachment.sr_ck_record_id AS 'attachment-sr ck record id',
    attachment.ck_server_change_token_blob AS 'attachment-ck server change token blob'


FROM message
    LEFT JOIN message_attachment_join ON message."ROWID" = message_attachment_join.message_id
    LEFT JOIN chat_message_join ON message_attachment_join.message_id = chat_message_join.message_id
    LEFT JOIN attachment ON attachment."ROWID" = message_attachment_join.attachment_id
    LEFT JOIN chat ON chat_message_join.chat_id = chat."ROWID"
    LEFT JOIN chat_handle_join ON chat."ROWID" = chat_handle_join.chat_id
    LEFT JOIN handle ON handle."ROWID" = chat_handle_join.handle_id


ORDER BY
    message.date
