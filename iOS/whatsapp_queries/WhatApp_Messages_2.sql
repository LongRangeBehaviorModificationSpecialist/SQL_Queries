/*
[DLU]
    20-Apr-2026
Copied from
    https://towardsdatAScience.com/analyzing-my-whatsapp-databASe-using-sql-and-redASh-5ef9bd6a0b0
*/

SELECT

    ROW_NUMBER() OVER() AS 'record_number',

    ZWACHATSESSION.ZPARTNERNAME AS 'ZWACHATSESSION.zpartnername',

    CASE ZWAMESSAGE.ZISFROMME
        WHEN 0 THEN ZWAMESSAGE.ZFROMJID
        ELSE ZWAMESSAGE.ZTOJID
    END AS 'ZWAMESSAGE.zisfromme',

    CASE ZWAMESSAGE.ZMESSAGETYPE
        WHEN 0 THEN 'Text [0]'
        WHEN 1 THEN 'Image [1]'
        WHEN 2 THEN 'Video [2]'
        WHEN 3 THEN 'Voice Message [3]'
        WHEN 4 THEN 'Gif [4]'
        WHEN 5 THEN 'Location [5]'
        WHEN 6 THEN 'Group Event [6]'
        WHEN 7 THEN 'Hyperlink [7]'
        WHEN 8 THEN 'Document [8]'
        WHEN 14 THEN 'Deleted Message [14]'
        WHEN 15 THEN 'Sticker [15]'
        ELSE ZWAMESSAGE.ZMESSAGETYPE
    END AS 'ZWAMESSAGE.zmessagetype',

    datetime(ZWAMESSAGE.ZMESSAGEDATE + 978307200, 'UNIXEPOCH') AS 'ZWAMESSAGE.zmessagedate(utc)',

    ZWAMESSAGE.ZTEXT AS 'ZWAMESSAGE.ztext'


FROM ZWACHATSESSION
    INNER JOIN ZWAMESSAGE ON ZWACHATSESSION.ZCONTACTJID == 'friend_number'


WHERE
    ZWACHATSESSION.ZSESSIONTYPE == 0
