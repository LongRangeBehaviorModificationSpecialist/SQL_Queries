-- Copied from: https://towardsdatAScience.com/analyzing-my-whatsapp-databASe-using-sql-and-redASh-5ef9bd6a0b0

SELECT
    ROW_NUMBER() OVER() AS 'Row #',
    ZWACHATSESSION.ZPARTNERNAME AS 'Friend Name',
    ZWAMESSAGE.ZISFROMME AS 'Is From Me',
    CASE ZWAMESSAGE.ZISFROMME
        WHEN 0 THEN ZWAMESSAGE.ZFROMJID
        ELSE ZWAMESSAGE.ZTOJID
    END AS 'Friend Number',
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
        ELSE ZWAMESSAGE.ZMESSAGETYPE
    END AS 'message_type',
    datetime(ZWAMESSAGE.ZMESSAGEDATE + 978307200, 'UNIXEPOCH') AS 'Message Date (UTC)',
    datetime(ZWAMESSAGE.ZMESSAGEDATE + 978307200, 'UNIXEPOCH', 'localtime') AS 'message_date (local time)',
    ZWAMESSAGE.ZTEXT AS 'message_text'

FROM ZWACHATSESSION
    INNER JOIN
        ZWAMESSAGE ON ZWACHATSESSION.ZCONTACTJID == 'friend_number'

WHERE ZWACHATSESSION.ZSESSIONTYPE == 0
