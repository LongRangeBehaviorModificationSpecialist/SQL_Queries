/*
[DLU]
    05-Sep-2025
Copied from
    https://towardsdatascience.com/analyzing-my-whatsapp-database-using-sql-and-redash-5ef9bd6a0b0
*/

CREATE view group_messages AS

SELECT

    ROW_NUMBER() OVER() AS 'record_number',

    ZWACHATSESSION.ZPARTNERNAME AS 'ZWACHATSESSION.zpartnername',

    CASE ZWAMESSAGE.ZISFROMME
        WHEN 0 THEN 'Incoming [0]'
        WHEN 1 THEN 'Outgoing [1]'
        ELSE 'Unknown Value: ' || ZWAMESSAGE.ZISFROMME || ''
    END AS 'ZWAMESSAGE.zisfromme',

    CASE ZWAMESSAGE.ZISFROMME
        WHEN 0 THEN ZWAMESSAGE.ZFROMJID
        ELSE ZWAMESSAGE.ZTOJID
    END AS 'groupid',

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
        ELSE 'Unknown Value: ' || ZWAMESSAGE.ZMESSAGETYPE || ''
    END AS 'ZWAMESSAGE.zmessagetype',

    datetime(ZWAMESSAGE.ZMESSAGEDATE + 978307200, 'unixepoch') AS 'ZWAMESSAGE.zmessagedate(utc)',

    ZWAMESSAGE.ZTEXT AS 'ZWAMESSAGE.ztext',
    friend_chat_session.ZPARTNERNAME AS 'friend_chat_session.zpartnername',
    ZWAGROUPMEMBER.ZMEMBERJID AS 'ZWAGROUPMEMBER.zmemberjid'


FROM ZWACHATSESSION
    INNER JOIN ZWAMESSAGE ON ZWACHATSESSION.ZCONTACTJID == "Group ID"
    LEFT JOIN ZWAGROUPMEMBER ON ZWAMESSAGE.ZGROUPMEMBER == ZWAGROUPMEMBER.Z_PK
    LEFT JOIN ZWACHATSESSION AS friend_chat_session ON ZWAGROUPMEMBER.ZMEMBERJID == friend_chat_session.ZCONTACTJID


WHERE
    ZWACHATSESSION.ZSESSIONTYPE == 1 AND message_type not IN ('unknown', 'group_event');
