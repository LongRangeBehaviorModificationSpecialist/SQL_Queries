/*
[DLU]
    03_Sep_2025
[OS Version]
    Android 16
*/


SELECT

    chat_messages.message_id AS 'message_id',
    chat_messages.conversation_id AS 'conversation_id',
    chat_conversations.name AS 'conversation_name',
    chat_messages.sender AS 'sender',
    chat_messages.recipient AS 'recipient',

    datetime(chat_messages.timestamp / 1000, 'UNIXEPOCH') AS 'time_stamp_utc',

    chat_messages.type AS 'message_type',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.text') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.text')
        ELSE NULL
    END AS 'message_text',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.photoContentReply') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.photoContentReply')
        ELSE NULL
    END AS 'photo_content_reply',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.albumContentReply') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.albumContentReply')
        ELSE NULL
    END AS 'album_content_reply',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.mediaId') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.mediaId')
        ELSE NULL
    END AS 'media_id',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.url') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.url')
        ELSE NULL
    END AS 'url',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.lat') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.lat')
        ELSE NULL
    END AS 'latitude',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.lon') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.lon')
        ELSE NULL
    END AS 'longitude',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.albumId') IS NOT NULL
            THEN json_extract(body, '$.albumId')
        ELSE NULL
    END AS 'album_id',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.ownerProfileId') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.ownerProfileId')
        ELSE NULL
    END AS 'owner_profile_id',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.coverUrl') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.coverUrl')
        ELSE NULL
    END AS 'cover_url',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.albumContentId') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.albumContentId')
        ELSE NULL
    END AS 'album_content_id',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.contentType') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.contentType')
        ELSE NULL
    END AS 'content_type',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.hasPhoto') IS NOT NULL
            AND json_extract(chat_messages.body, '$.hasPhoto') = TRUE
                THEN 'Yes'
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.hasPhoto') IS NOT NULL
            AND json_extract(chat_messages.body, '$.hasPhoto') = FALSE
                THEN 'No'
        ELSE NULL
    END AS 'has_photo',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.hasVideo') IS NOT NULL
            AND json_extract(chat_messages.body, '$.hasVideo') = TRUE
                THEN 'Yes'
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.hasVideo') IS NOT NULL
            AND json_extract(chat_messages.body, '$.hasVideo') = FALSE
                THEN 'No'
        ELSE NULL
    END AS 'has_video',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.isViewable') IS NOT NULL
            AND json_extract(chat_messages.body, '$.isViewable') = TRUE
                THEN 'Yes'
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.isViewable') IS NOT NULL
            AND json_extract(chat_messages.body, '$.isViewable') = FALSE
                THEN 'No'
        ELSE NULL
    END AS 'is_viewable',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.viewableUntil') IS NOT NULL
            THEN datetime(json_extract(chat_messages.body, '$.viewableUntil') / 1000, 'UNIXEPOCH')
        ELSE NULL
    END AS 'viewable_until_utc',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.hasUnseenContent') IS NOT NULL
            AND json_extract(chat_messages.body, '$.hasUnseenContent') = TRUE
                THEN 'Yes'
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.hasUnseenContent') IS NOT NULL
            AND json_extract(chat_messages.body, '$.hasUnseenContent') = FALSE
                THEN 'No'
        ELSE NULL
    END AS 'has_unseen_content',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.albumNumber') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.albumNumber')
        ELSE NULL
    END AS 'album_number',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.totalAlbumsShared') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.totalAlbumsShared')
        ELSE NULL
    END AS 'total_albums_shared',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.length') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.length')
        ELSE NULL
    END AS 'length',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.duration') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.duration')
        ELSE NULL
    END AS 'duration',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.height') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.height')
        ELSE NULL
    END AS 'height',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.width') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.width')
        ELSE NULL
    END AS 'width',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.imageHash') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.imageHash')
        ELSE NULL
    END AS 'image_hash',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.maxViews') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.maxViews')
        ELSE NULL
    END AS 'max_views',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.viewsRemaining') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.viewsRemaining')
        ELSE NULL
    END AS 'views_remaining',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.createdAt') IS NOT NULL
            THEN datetime(json_extract(chat_messages.body, '$.createdAt') / 1000, 'UNIXEPOCH')
        ELSE NULL
    END AS 'created_date_utc',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.expiresAt') IS NOT NULL
            THEN datetime(json_extract(chat_messages.body, '$.expiresAt') / 1000, 'UNIXEPOCH')
        ELSE NULL
    END AS 'expires_at_utc',

    CASE
        WHEN json_valid(chat_messages.body) AND json_extract(chat_messages.body, '$.expirationType') IS NOT NULL
            THEN json_extract(chat_messages.body, '$.expirationType')
        ELSE NULL
    END AS 'expiration_type'


FROM chat_messages
    LEFT JOIN chat_conversations ON chat_messages.conversation_id = chat_conversations.conversation_id
