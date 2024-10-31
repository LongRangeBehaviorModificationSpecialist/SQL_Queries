SELECT

    m.ROWID AS 'Message.ROWID',

    CASE
        WHEN LENGTH(m.date) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (m.date / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(m.date) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', m.date + 978307200, 'UNIXEPOCH')
        ELSE m.date
    END AS 'MessageDate(UTC)',

    cmj.message_id AS 'cmj.MessageID',
    m.service AS 'MessageService',
    m.account AS 'MessageAccount',
    c.ROWID AS 'ChatROWID',
    c.guid AS 'ChatGUID',

    CASE
        WHEN cmj.chat_id IS NULL THEN 'DELETED MESSAGE'
        ELSE 'No'
    END AS 'WasDeleted',

    CASE m.is_delivered
        WHEN 1 THEN 'Yes'
        WHEN 0 THEN 'No'
        ELSE 'Unknown-Value: ' || m.is_delivered
    END AS 'MessageIsDelivered',

    CASE m.is_delayed
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE 'Unknown-Value : ' || m.is_delayed
    END AS 'MessageIsDelayed',

    CASE m.is_empty
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE 'Unknown-Value : ' || m.is_empty
    END AS 'MessageIsEmpty',

    CASE m.is_archive
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE 'Unknown-Value : ' || m.is_archive
    END AS 'MessageIsArchive',

    CASE m.is_finished
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE 'Unknown-Value : ' || m.is_finished
    END AS 'MessageIsFinished',

    CASE m.is_audio_message
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE 'Unknown-Value : ' || m.is_audio_message
    END AS 'MessageIsAudioMessage',

    CASE m.is_emote
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE 'Unknown-Value : ' || m.is_emote
    END AS 'MessageIsEmote',

    m.guid AS 'MessageGUID',
    m.associated_message_guid AS 'AssociatedMessageGUID',

    CASE m.handle_id
        WHEN 0 THEN 'N/A'
        ELSE m.handle_id
    END AS 'MessageHandleID',

    CASE
        WHEN LENGTH(m.date_delivered) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (m.date_delivered / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(m.date_delivered) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', m.date_delivered + 978307200, 'UNIXEPOCH')
        WHEN m.date_delivered IS 0 THEN 'N/A'
        ELSE m.date_delivered
    END AS 'MessageDateDelivered(UTC)',

    CASE
        WHEN LENGTH(m.date_read) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (m.date_read / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(m.date_read) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', m.date_read + 978307200, 'UNIXEPOCH')
        WHEN m.date_read IS 0 THEN 'N/A'
        ELSE m.date_read
    END AS 'MessageDateRead(UTC)',

    CASE
        WHEN LENGTH(m.date_edited) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (m.date_edited / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(m.date_edited) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', m.date_edited + 978307200, 'UNIXEPOCH')
        WHEN m.date_edited IS 0 THEN 'N/A'
        ELSE m.date_edited
    END AS 'MessageDateEdited(UTC)',

    CASE
        WHEN LENGTH(handle.id) = 14 AND handle.id LIKE '%p:+1%' THEN '(' || SUBSTR(handle.id, 5, 3) || ') ' || SUBSTR(handle.id, 8, 3) || '-' || SUBSTR(handle.id, 11, 4)
        WHEN LENGTH(handle.id) = 12 AND handle.id LIKE '+1%' THEN '(' || SUBSTR(handle.id, 3, 3) || ') ' || SUBSTR(handle.id, 6, 3) || '-' || SUBSTR(handle.id, 9, 4)
        WHEN LENGTH(handle.id) = 11 AND handle.id LIKE '1%' THEN '(' || SUBSTR(handle.id, 2, 3) || ') ' || SUBSTR(handle.id, 5, 3) || '-' || SUBSTR(handle.id, 8, 4)
        WHEN LENGTH(handle.id) = 10 THEN '(' || SUBSTR(handle.id,1,3) || ') ' || SUBSTR(handle.id, 4, 3) || '-' || SUBSTR(handle.id, 7, 4)
        WHEN handle.id IS NULL THEN 'N/A'
        ELSE handle.id
    END AS 'HandleID',

    CASE c.style
        WHEN '43' THEN 'GroupChat'
        WHEN '45' THEN 'P2P'
    END AS 'ChatStyle',

    cmj.chat_id AS 'ChatMessageJoinChatID',

    CASE m.is_from_me
        WHEN 0 THEN 'Incoming'
        WHEN 1 THEN 'Outgoing'
        ELSE 'Unknown-Value : ' || m.is_from_me
    END AS 'MessageIsFromMe',

    CASE m.type
        WHEN 0 THEN 'Message'
        WHEN 1 THEN 'GroupParticipantAdded'
        WHEN 2 THEN 'GroupRenamed'
        WHEN 3 THEN 'GroupActionType-0=Participant_Leaves/GroupActionType-1=GroupPhotoChanged-3'
        WHEN 4 THEN 'LocationSharingData'
        WHEN 5 THEN 'Unknown'
        WHEN 6 THEN 'Unknown'
        ELSE 'Unknown-Value : ' || m.type
    END AS 'MessageType',

    CASE
        WHEN m.text IS NULL THEN '**NO TEXT**'
        ELSE m.text
    END AS 'MessageText',

    CASE m.is_read
        WHEN 0 THEN 'Unread'
        WHEN 1 THEN 'Read'
        ELSE 'Unknown-Value : ' || m.is_read
    END AS 'MessageIsRead',

    CASE c.display_name
        WHEN NULL THEN 'N/A'
        ELSE c.display_name
    END AS 'ChatDisplayName',

    CASE a.is_outgoing
        WHEN 0 THEN 'Incoming'
        WHEN 1 THEN 'Outgoing'
        ELSE 'Unknown-Value : ' || a.is_outgoing
    END AS 'AttachmentDirection',

    maj.attachment_id AS 'AttachmentID',
    a.filename AS 'AttachmentFileName',
    a.transfer_name AS 'AttachmentTransferName',
    printf("%,d", a.total_bytes) AS 'AttachmentFileSize(bytes)',
    a.mime_type AS 'AttachmentMimeType',
    a.uti AS 'AttachmentUTI',
    /* Date the attachment was created */
    CASE
        WHEN LENGTH(a.created_date) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (a.created_date / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(a.created_date) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', a.created_date + 978307200, 'UNIXEPOCH')
        WHEN a.created_date IS NULL THEN 'N/A'
        ELSE a.created_date
    END AS 'AttachmentCreatedDate(UTC)',

    /* Source for each line of data */
    '/private/var/mobile/Library/SMS/sms.db; Table: messages(ROWID: ' || m.ROWID || ')' AS 'DataSource'


FROM message m

    LEFT JOIN message_attachment_join maj ON m.ROWID = maj.message_id
    LEFT JOIN attachment a ON maj.attachment_id = a.ROWID
    LEFT JOIN chat_message_join cmj ON m.ROWID = cmj.message_id
    LEFT JOIN chat c ON cmj.chat_id = c.ROWID
    LEFT JOIN handle ON m.handle_id = handle.ROWID


-- WHERE m.ROWID IS '128689'


ORDER BY m.ROWID