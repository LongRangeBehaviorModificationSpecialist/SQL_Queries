SELECT
    /* Add a row number at the beggining of each row */
    ROW_NUMBER() OVER() AS 'RECORD_NUMBER',
    messages._id AS 'messages._id',
    messages.conversation_id AS 'messages.conversation_id',

    /* ID of recipient of the message */
    /* Removes unnecessary text at the start of the string to leave just the 10-digit phone number */
    /* Formats string as a U.S. phone number, i.e. (###) ###-#### */
    CASE
        WHEN LENGTH(messages.recipients) = 12 AND messages.recipients LIKE '+1%' THEN '(' || SUBSTR(messages.recipients,3,3) || ') ' || SUBSTR(messages.recipients,6,3) || '-' || SUBSTR(messages.recipients,9,4)
        WHEN LENGTH(messages.recipients) = 11 AND messages.recipients LIKE '1%' THEN '(' || SUBSTR(messages.recipients,2,3) || ') ' || SUBSTR(messages.recipients,5,3) || '-' || SUBSTR(messages.recipients,8,4)
        WHEN LENGTH(messages.recipients) = 10 THEN '(' || SUBSTR(messages.recipients,1,3) || ') ' || SUBSTR(messages.recipients,4,3) || '-' || SUBSTR(messages.recipients,7,4)
        WHEN messages.recipients IS NULL THEN 'n/a'
        ELSE messages.recipients
    END AS 'messages.recipients',

    /* Name of recipient (if documented) */
    CASE
        WHEN recipients.cache_name IS NULL THEN 'n/a'
        ELSE recipients.cache_name
    END AS 'recipients.cache_name',

    /* Message direction (incoming/outgoing) */
    CASE messages.message_box_type
        WHEN 102 THEN '102  [Outgoing]'
        WHEN 100 THEN '100  [Incoming]'
        ELSE messages.message_box_type
    END AS 'messages.message_box_type',

    /* Date/Time the message was created in UTC */
    strftime('%Y-%m-%d %H:%M:%S', messages.created_timestamp / 1000, 'UNIXEPOCH') AS 'messages.created_timestamp(UTC)',

    /* Date/Time the message was sent in UTC */
    CASE
        WHEN messages.sent_timestamp IS 0 THEN 'n/a'
        ELSE strftime('%Y-%m-%d %H:%M:%S', messages.sent_timestamp / 1000, 'UNIXEPOCH')
    END AS 'messages.sent_timestamp(UTC)',

    messages.remote_message_uri AS 'messages.remote_message_uri',

    /* Message content */
    CASE
        WHEN parts.text IS NULL THEN 'n/a'
        ELSE parts.text
    END AS 'parts.text',

    CASE
        WHEN parts.content_uri IS NULL THEN 'n/a'
        ELSE parts.content_uri
    END AS 'parts.content_uri',

    parts.content_type AS 'parts.content_type',
    messages.message_type AS 'messages.message_type',

    /* If the message had an attachment, returns the file name */
    CASE
        WHEN parts.file_name IS NULL THEN 'n/a'
        ELSE parts.file_name
    END AS 'parts.file_name',

    /* Output the attached file size formatted with commas as needed */
    printf("%,d", parts.size) AS 'parts.size(bytes)',
    /* Output the message size formatted with commas as needed */
    printf("%,d", messages.message_size) AS ' messages.message_size(bytes)',
    /* Was the message read */
    messages.is_read AS 'messages.is_read?',

    /* Date/Time the message was updated (if any) in UTC */
    CASE
        WHEN messages.updated_timestamp IS 0 THEN 'n/a'
        ELSE strftime('%Y-%m-%d %H:%M:%S', messages.updated_timestamp / 1000, 'UNIXEPOCH')
    END AS 'messages.updated_timestamp',

    messages.creator AS 'messages.creator',
    messages.remote_creator AS 'messages.remote_creator',
    messages.req_app_id AS 'messages.req_app_id',

    /* Source for each line of data */
    'File: \data\data\com.samsung.android.messaging\databases\message_content.db; Table: messages(_id: ' || messages._id || ')' AS 'DATA_SOURCE'


FROM messages
    LEFT OUTER JOIN parts ON messages._id = parts.message_id
    LEFT OUTER JOIN recipients ON messages.conversation_id = recipients._id


ORDER BY messages._id ASC
