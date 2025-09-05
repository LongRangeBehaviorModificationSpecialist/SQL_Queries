/*
    [DLU]
        03-Sep-2025
    [OS Version]
        Android 16
*/


SELECT

    chat_messages.message_id AS 'MessageID',
    chat_messages.conversation_id AS 'ConversationID',
    chat_conversations.name AS 'ConversationName',
    chat_messages.sender AS 'Sender',
    chat_messages.recipient AS 'Recipient',

    datetime(chat_messages.timestamp / 1000, 'UNIXEPOCH') AS 'TimeStamp(UTC)',

    chat_messages.type AS 'MessageType',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.text') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.text')
        ELSE NULL
    END AS 'MessageText',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.photoContentReply') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.photoContentReply')
        ELSE NULL
    END AS 'PhotoContentReply',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.albumContentReply') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.albumContentReply')
        ELSE NULL
    END AS 'AlbumContentReply',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.mediaId') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.mediaId')
        ELSE NULL
    END AS 'MediaID',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.url') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.url')
        ELSE NULL
    END AS 'URL',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.lat') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.lat')
        ELSE NULL
    END AS 'Latitude',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.lon') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.lon')
        ELSE NULL
    END AS 'Longitude',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.albumId') IS NOT NULL
            THEN json_extract(body, '$.albumId')
        ELSE NULL
    END AS 'AlbumID',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.ownerProfileId') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.ownerProfileId')
        ELSE NULL
    END AS 'OwnerProfileID',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.coverUrl') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.coverUrl')
        ELSE NULL
    END AS 'CoverURL',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.albumContentId') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.albumContentId')
        ELSE NULL
    END AS 'AlbumContentID',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.contentType') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.contentType')
        ELSE NULL
    END AS 'ContentType',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.hasPhoto') IS NOT NULL
            AND json_extract(chat_messages.body, '$.hasPhoto') = TRUE
                THEN 'Yes'
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.hasPhoto') IS NOT NULL
            AND json_extract(chat_messages.body, '$.hasPhoto') = FALSE
                THEN 'No'
        ELSE NULL
    END AS 'HasPhoto',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.hasVideo') IS NOT NULL
            AND json_extract(chat_messages.body, '$.hasVideo') = TRUE
                THEN 'Yes'
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.hasVideo') IS NOT NULL
            AND json_extract(chat_messages.body, '$.hasVideo') = FALSE
                THEN 'No'
        ELSE NULL
    END AS 'HasVideo',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.isViewable') IS NOT NULL
            AND json_extract(chat_messages.body, '$.isViewable') = TRUE
                THEN 'Yes'
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.isViewable') IS NOT NULL
            AND json_extract(chat_messages.body, '$.isViewable') = FALSE
                THEN 'No'
        ELSE NULL
    END AS 'IsViewable',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.viewableUntil') IS NOT NULL
            THEN datetime(json_extract(chat_messages.body, '$.viewableUntil') / 1000, 'UNIXEPOCH')
        ELSE NULL
    END AS 'ViewableUntil(UTC)',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.hasUnseenContent') IS NOT NULL
            AND json_extract(chat_messages.body, '$.hasUnseenContent') = TRUE
                THEN 'Yes'
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.hasUnseenContent') IS NOT NULL
            AND json_extract(chat_messages.body, '$.hasUnseenContent') = FALSE
                THEN 'No'
        ELSE NULL
    END AS 'HasUnseenContent',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.albumNumber') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.albumNumber')
        ELSE NULL
    END AS 'AlbumNumber',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.totalAlbumsShared') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.totalAlbumsShared')
        ELSE NULL
    END AS 'TotalAlbumsShared',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.length') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.length')
        ELSE NULL
    END AS 'Length',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.duration') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.duration')
        ELSE NULL
    END AS 'Duration',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.height') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.height')
        ELSE NULL
    END AS 'Height',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.width') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.width')
        ELSE NULL
    END AS 'Width',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.imageHash') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.imageHash')
        ELSE NULL
    END AS 'ImageHash',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.maxViews') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.maxViews')
        ELSE NULL
    END AS 'MaxViews',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.viewsRemaining') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.viewsRemaining')
        ELSE NULL
    END AS 'ViewsRemaining',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.createdAt') IS NOT NULL
            THEN datetime(json_extract(chat_messages.body, '$.createdAt') / 1000, 'UNIXEPOCH')
        ELSE NULL
    END AS 'CreatedDate(UTC)',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.expiresAt') IS NOT NULL
            THEN datetime(json_extract(chat_messages.body, '$.expiresAt') / 1000, 'UNIXEPOCH')
        ELSE NULL
    END AS 'ExpiresAt(UTC)',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.expirationType') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.expirationType')
        ELSE NULL
    END AS 'ExpirationType'


FROM chat_messages
    LEFT JOIN chat_conversations ON chat_messages.conversation_id = chat_conversations.conversation_id
