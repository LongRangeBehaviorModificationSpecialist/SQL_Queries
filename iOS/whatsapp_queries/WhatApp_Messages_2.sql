-- Copied from: https://towardsdatAScience.com/analyzing-my-whatsapp-databASe-using-sql-and-redASh-5ef9bd6a0b0

SELECT

    ROW_NUMBER() OVER() AS 'RecordNo.',
    ZWACHATSESSION.ZPARTNERNAME AS 'FriendName',
    ZWAMESSAGE.ZISFROMME AS 'IsFromMe',

    CASE ZWAMESSAGE.ZISFROMME
        WHEN 0 THEN ZWAMESSAGE.ZFROMJID
        ELSE ZWAMESSAGE.ZTOJID
    END AS 'FriendNumber',

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
    END AS 'MessageType',

    datetime(ZWAMESSAGE.ZMESSAGEDATE + 978307200, 'UNIXEPOCH') AS 'MessageDateTime(UTC)',
    datetime(ZWAMESSAGE.ZMESSAGEDATE + 978307200, 'UNIXEPOCH', 'localtime') AS 'MessageDateTime(Local)',
    ZWAMESSAGE.ZTEXT AS 'MessageText'


FROM ZWACHATSESSION

    INNER JOIN ZWAMESSAGE ON ZWACHATSESSION.ZCONTACTJID == 'friend_number'


WHERE ZWACHATSESSION.ZSESSIONTYPE == 0
