/*
  DLU: 2024-10-31
  [VERSION]
    Tested on iOS 18
  [SMS]
    FILE PATH = /private/var/mobile/Library/SMS/sms.db
  [AddressBook]
    FILE PATH = /private/var/mobile/Library/AddressBook/AddressBook.sqlitedb
*/

SELECT

    m.ROWID AS 'Message.ROWID',

    CASE
        WHEN LENGTH(m.date) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (m.date / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(m.date) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', m.date + 978307200, 'UNIXEPOCH')
        WHEN m.date IS 0 THEN NULL
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

    CASE m.handle_id
        WHEN 0 THEN NULL
        ELSE m.handle_id
    END AS 'MessageHandleID',

    CASE
        WHEN LENGTH(m.date_delivered) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (m.date_delivered / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(m.date_delivered) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', m.date_delivered + 978307200, 'UNIXEPOCH')
        WHEN m.date_delivered IS 0 THEN NULL
        ELSE m.date_delivered
    END AS 'MessageDateDelivered(UTC)',

    CASE
        WHEN LENGTH(m.date_read) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (m.date_read / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(m.date_read) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', m.date_read + 978307200, 'UNIXEPOCH')
        WHEN m.date_read IS 0 THEN NULL
        ELSE m.date_read
    END AS 'MessageDateRead(UTC)',

    CASE
        WHEN LENGTH(m.date_edited) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (m.date_edited / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(m.date_edited) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', m.date_edited + 978307200, 'UNIXEPOCH')
        WHEN m.date_edited IS 0 THEN NULL
        ELSE m.date_edited
    END AS 'MessageDateEdited(UTC)',

    CASE
        WHEN LENGTH(handle.id) = 14 AND handle.id LIKE '%p:+1%' THEN '(' || SUBSTR(handle.id, 5, 3) || ') ' || SUBSTR(handle.id, 8, 3) || '-' || SUBSTR(handle.id, 11, 4)
        WHEN LENGTH(handle.id) = 12 AND handle.id LIKE '+1%' THEN '(' || SUBSTR(handle.id, 3, 3) || ') ' || SUBSTR(handle.id, 6, 3) || '-' || SUBSTR(handle.id, 9, 4)
        WHEN LENGTH(handle.id) = 11 AND handle.id LIKE '1%' THEN '(' || SUBSTR(handle.id, 2, 3) || ') ' || SUBSTR(handle.id, 5, 3) || '-' || SUBSTR(handle.id, 8, 4)
        WHEN LENGTH(handle.id) = 10 THEN '(' || SUBSTR(handle.id, 1, 3) || ') ' || SUBSTR(handle.id, 4, 3) || '-' || SUBSTR(handle.id, 7, 4)
        WHEN handle.id IS NULL THEN NULL
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

    CASE m.item_type
        WHEN 0 THEN 'Message'
        WHEN 1 THEN 'GroupParticipantAdded'
        WHEN 2 THEN 'GroupRenamed'
        WHEN 3 THEN 'GroupActionType-0=Participant_Leaves/GroupActionType-1=GroupPhotoChanged-3'
        WHEN 4 THEN 'LocationSharingData'
        WHEN 5 THEN 'Unknown'
        WHEN 6 THEN 'Unknown'
        ELSE 'Unknown-Value : ' || m.item_type
    END AS 'ItemType',

    m.guid AS 'MessageGUID',

    CASE
        WHEN m.text IS NULL THEN NULL
        ELSE m.text
    END AS 'MessageText',

    SUBSTR(m.associated_message_guid, 5, 36) AS 'AssociatedMessageGUID',

    CASE m.associated_message_type
        WHEN 0 THEN NULL
        WHEN 2 THEN 'UnknownValue-2-ApplePaymentSent'
        WHEN 3 THEN 'UnknownValue-3-ApplePaymentRequested'
        WHEN 2000 THEN 'LOVEDReaction'
        WHEN 2001 THEN 'LIKEDReaction'
        WHEN 2002 THEN 'DISLIKEDReaction'
        WHEN 2003 THEN 'LAUGHEDReaction'
        WHEN 2004 THEN 'EMPHASIZEDReaction'
        WHEN 2005 THEN 'QUESTIONEDReaction'
        WHEN 3000 THEN 'RemovedLOVEDReaction'
        WHEN 3001 THEN 'RemovedLIKEReaction'
        WHEN 3002 THEN 'RemovedDISLIKEReaction'
        WHEN 3003 THEN 'RemovedLAUGHReaction'
        WHEN 3004 THEN 'RemovedEXCLAMATIONReaction'
        WHEN 3005 THEN 'RemovedQUESTIONReaction'
    END AS 'AssociatedMessageType',

    m.balloon_bundle_id AS 'BalloonBundleID',

    CASE m.was_delivered_quietly
        WHEN '0' THEN 'No'
        WHEN '1' THEN 'Yes'
        ELSE 'Unknown-Value : '  || m.was_delivered_quietly
    END AS 'WasDeliveredQuietly',

    CASE m.expressive_send_style_id
        WHEN 'com.apple.messages.effect.CKSpotlightEffect' THEN 'SpotlightEffect'
        WHEN 'com.apple.messages.effect.CKSparklesEffect' THEN 'SparklesEffect'
        WHEN 'com.apple.messages.effect.CKLasersEffect' THEN 'LaserEffect'
        WHEN 'com.apple.messages.effect.CKHeartEffect' THEN 'HeartEffect'
        WHEN 'com.apple.messages.effect.CKHappyBirthdayEffect' THEN 'HappyBirthdayEffect'
        WHEN 'com.apple.messages.effect.CKFireworksEffect' THEN 'FireworksEffect'
        WHEN 'com.apple.messages.effect.CKEchoEffect' THEN 'EchoEffect'
        WHEN 'com.apple.messages.effect.CKConfettiEffect' THEN 'ConfettiEffect'
        WHEN 'com.apple.MobileSMS.expressivesend.loud' THEN 'SMSExpressiveSendLoud'
        WHEN 'com.apple.MobileSMS.expressivesend.invisibleink' THEN 'SMSExpressiveSendInvisibleInk'
        WHEN 'com.apple.MobileSMS.expressivesend.impact' THEN 'SMSExpressiveSendImpact'
        WHEN 'com.apple.MobileSMS.expressivesend.gentle' THEN 'SMSExpressiveSendGentle'
        ELSE NULL
    END AS 'ExpressiveSendStyle',

    CASE m.is_read
        WHEN 0 THEN 'Unread'
        WHEN 1 THEN 'Read'
        ELSE 'Unknown-Value : ' || m.is_read
    END AS 'MessageIsRead',

    CASE c.display_name
        WHEN '' THEN NULL
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

    CASE
        WHEN a.total_bytes > 0 THEN printf("%,d", a.total_bytes)
        WHEN a.total_bytes IS 0 THEN '0'
        ELSE NULL
    END AS 'AttachmentFileSize(bytes)',

    a.mime_type AS 'AttachmentMimeType',
    a.uti AS 'AttachmentUTI',

    /* Date the attachment was created */
    CASE
        WHEN LENGTH(a.created_date) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (a.created_date / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(a.created_date) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', a.created_date + 978307200, 'UNIXEPOCH')
        WHEN a.created_date IS NULL THEN NULL
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


-- WHERE
--     m.associated_message_type IS NOT '0'
    -- m.expressive_send_style_id IS NOT NULL
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
    m.ROWID ASC