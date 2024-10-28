-- Attach database for AddressBook if needed
-- ATTACH DATABASE 'AddressBook.sqlitedb' AS 'AddressBook_db';

WITH DateFormat AS (
    SELECT
        message.ROWID AS MessageROWID,
        CASE
            WHEN LENGTH(message.date) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (message.date / 1000000000) + 978307200, 'UNIXEPOCH')
            WHEN LENGTH(message.date) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', message.date + 978307200, 'UNIXEPOCH')
            ELSE message.date
        END AS MessageDate,
        CASE
            WHEN LENGTH(message.date_delivered) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (message.date_delivered / 1000000000) + 978307200, 'UNIXEPOCH')
            WHEN LENGTH(message.date_delivered) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', message.date_delivered + 978307200, 'UNIXEPOCH')
            WHEN message.date_delivered IS 0 THEN 'N/A'
            ELSE message.date_delivered
        END AS MessageDateDelivered,
        CASE
            WHEN LENGTH(message.date_read) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (message.date_read / 1000000000) + 978307200, 'UNIXEPOCH')
            WHEN LENGTH(message.date_read) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', message.date_read + 978307200, 'UNIXEPOCH')
            WHEN message.date_read IS 0 THEN 'N/A'
            ELSE message.date_read
        END AS MessageDateRead,
        CASE
            WHEN LENGTH(attachment.created_date) = 18 THEN strftime('%Y-%m-%d %H:%M:%S', (attachment.created_date / 1000000000) + 978307200, 'UNIXEPOCH')
            WHEN LENGTH(attachment.created_date) = 9 THEN strftime('%Y-%m-%d %H:%M:%S', attachment.created_date + 978307200, 'UNIXEPOCH')
            WHEN attachment.created_date IS NULL THEN 'N/A'
            ELSE attachment.created_date
        END AS AttachmentCreatedDate

    FROM message

	      --LEFT JOIN attachment ON message.ROWID = attachment.message_id
	      LEFT JOIN message_attachment_join ON message.ROWID = message_attachment_join.message_id
	      LEFT JOIN attachment ON attachment.ROWID = message_attachment_join.attachment_id
),

FormattedHandle AS (
    SELECT
        handle.ROWID AS HandleRowID,
        CASE
            WHEN LENGTH(handle.id) = 14 AND handle.id LIKE '%p:+1%' THEN '(' || SUBSTR(handle.id, 5, 3) || ') ' || SUBSTR(handle.id, 8, 3) || '-' || SUBSTR(handle.id, 11, 4)
            WHEN LENGTH(handle.id) = 12 AND handle.id LIKE '+1%' THEN '(' || SUBSTR(handle.id, 3, 3) || ') ' || SUBSTR(handle.id, 6, 3) || '-' || SUBSTR(handle.id, 9, 4)
            WHEN LENGTH(handle.id) = 11 AND handle.id LIKE '1%' THEN '(' || SUBSTR(handle.id, 2, 3) || ') ' || SUBSTR(handle.id, 5, 3) || '-' || SUBSTR(handle.id, 8, 4)
            WHEN LENGTH(handle.id) = 10 THEN '(' || SUBSTR(handle.id,1,3) || ') ' || SUBSTR(handle.id, 4, 3) || '-' || SUBSTR(handle.id, 7, 4)
            ELSE handle.id
        END AS FormattedID

    FROM handle
)

SELECT
    ROW_NUMBER() OVER() AS 'RecordNo.',
    --m.MessageROWID,
    m.ROWID,
    cmj.message_id AS 'ChatMessageJoin.MessageID',
    df.MessageDate AS 'MessageDate(UTC)',
    CASE m.is_delivered WHEN 1 THEN 'Yes' WHEN 0 THEN 'No' ELSE 'Unknown-Value: ' || m.is_delivered END AS 'MessageIsDelivered',
    df.MessageDateDelivered AS 'MessageDateDelivered(UTC)',
    df.MessageDateRead AS 'MessageDateRead(UTC)',
    m.handle_id AS 'MessageHandleID',
    fh.FormattedID AS 'HandleID',
    CASE c.style WHEN '43' THEN 'GroupChat' WHEN '45' THEN 'P2P' END AS 'ChatStyle',
    cmj.chat_id AS 'ChatMessageJoinChatID',
    CASE m.is_from_me WHEN 1 THEN 'Outgoing' ELSE 'Incoming' END AS 'MessageIsFromMe',
    CASE m.type WHEN 0 THEN 'Message' WHEN 1 THEN 'GroupParticipantAdded' WHEN 2 THEN 'GroupRenamed' ELSE 'Unknown-Value: ' || m.type END AS 'MessageType',
    CASE WHEN m.text IS NULL THEN '**NO TEXT**' ELSE m.text END AS 'MessageText',
    CASE c.display_name WHEN NULL THEN 'N/A' ELSE c.display_name END AS 'ChatDisplayName',
    a.filename AS 'AttachmentFileName',
    a.transfer_name AS 'AttachmentTransferName',
    printf("%,d", a.total_bytes) AS 'AttachmentFileSize(bytes)',
    df.AttachmentCreatedDate AS 'AttachmentCreatedDate(UTC)',
    'File: /private/var/mobile/Library/SMS/sms.db' AS 'DatabaseFile'


FROM message m

    JOIN DateFormat df ON m.ROWID = df.MessageROWID
    LEFT JOIN message_attachment_join maj ON m.ROWID = maj.message_id
    LEFT JOIN attachment a ON maj.attachment_id = a.ROWID
    JOIN chat_message_join cmj ON m.ROWID = cmj.message_id
    JOIN chat c ON cmj.chat_id = c.ROWID
    LEFT JOIN FormattedHandle fh ON m.handle_id = fh.HandleRowID


ORDER BY m.date ASC, m.ROWID;