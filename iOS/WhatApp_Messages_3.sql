-- Copied from: https://towardsdatascience.com/analyzing-my-whatsapp-database-using-sql-and-redash-5ef9bd6a0b0

CREATE view group_messages AS

SELECT
    ZWACHATSESSION.ZPARTNERNAME AS 'Group Name',
    CASE ZWAMESSAGE.ZISFROMME
        WHEN 0 THEN 'Incoming'
        WHEN 1 THEN 'Outgoing'
        ELSE ZWAMESSAGE.ZISFROMME
    END AS 'Message Direction',
    CASE ZWAMESSAGE.ZISFROMME
        WHEN 0 THEN ZWAMESSAGE.ZFROMJID
        ELSE ZWAMESSAGE.ZTOJID
    END AS 'Group ID',
    CASE ZWAMESSAGE.ZMESSAGETYPE
        WHEN 0 THEN 'text'
        WHEN 1 THEN 'image'
        WHEN 2 THEN 'video'
        WHEN 3 THEN 'voice_message'
        WHEN 4 THEN 'gif'
        WHEN 5 THEN 'location'
        WHEN 6 THEN 'group_event'
        WHEN 7 THEN 'hyperlink'
        WHEN 8 THEN 'document'
        WHEN 14 THEN 'deleted_message'
        WHEN 15 THEN 'sticker'
        ELSE 'unknown'
    END AS 'Message Type',
    datetime(ZWAMESSAGE.ZMESSAGEDATE + 978307200, 'unixepoch') AS 'Message Date (UTC)',
    datetime(ZWAMESSAGE.ZMESSAGEDATE + 978307200, 'unixepoch', 'localtime') AS 'Message Date (Local Time)',
    ZWAMESSAGE.ZTEXT AS 'Message Text',
    friend_chat_session.ZPARTNERNAME AS 'Friend Name',
    ZWAGROUPMEMBER.ZMEMBERJID AS 'Friend ID'

FROM ZWACHATSESSION
    INNER JOIN
        ZWAMESSAGE ON ZWACHATSESSION.ZCONTACTJID == "Group ID"
    LEFT JOIN
        ZWAGROUPMEMBER ON ZWAMESSAGE.ZGROUPMEMBER == ZWAGROUPMEMBER.Z_PK
    LEFT JOIN
        ZWACHATSESSION AS friend_chat_session ON ZWAGROUPMEMBER.ZMEMBERJID == friend_chat_session.ZCONTACTJID

WHERE ZWACHATSESSION.ZSESSIONTYPE == 1 AND message_type not IN ('unknown', 'group_event');
