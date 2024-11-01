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
        WHEN 0 THEN 'Text'
        WHEN 1 THEN 'Image'
        WHEN 2 THEN 'Video'
        WHEN 3 THEN 'VoiceMessage'
        WHEN 4 THEN 'Gif'
        WHEN 5 THEN 'Location'
        WHEN 6 THEN 'GroupEvent'
        WHEN 7 THEN 'Hyperlink'
        WHEN 8 THEN 'Document'
        WHEN 14 THEN 'DeletedMessage'
        WHEN 15 THEN 'Sticker'
        ELSE ZWAMESSAGE.ZMESSAGETYPE
    END AS 'MessageType',

    datetime(ZWAMESSAGE.ZMESSAGEDATE + 978307200, 'UNIXEPOCH') AS 'MessageDateTime(UTC)',
    ZWAMESSAGE.ZTEXT AS 'MessageText'


FROM ZWACHATSESSION
    INNER JOIN ZWAMESSAGE ON ZWACHATSESSION.ZCONTACTJID == 'friend_number'


WHERE
    ZWACHATSESSION.ZSESSIONTYPE == 0
