SELECT
    /* Add a row number at the beggining of each row */
    ROW_NUMBER() OVER() AS 'Row #',
    messages._id AS 'Message ID',
    messages.conversation_id AS 'Conversation ID',
    /* ID of recipient of the message */
    /* Removes unnecessary text at the start of the string to leave just the 10-digit phone number */
    /* Formats string as a U.S. phone number, i.e. (###) ###-#### */
    CASE
        WHEN LENGTH(messages.recipients) = 12 AND messages.recipients LIKE '+1%' THEN '(' || SUBSTR(messages.recipients,3,3) || ') ' || SUBSTR(messages.recipients,6,3) || '-' || SUBSTR(messages.recipients,9,4)
        WHEN LENGTH(messages.recipients) = 11 AND messages.recipients LIKE '1%' THEN '(' || SUBSTR(messages.recipients,2,3) || ') ' || SUBSTR(messages.recipients,5,3) || '-' || SUBSTR(messages.recipients,8,4)
        WHEN LENGTH(messages.recipients) = 10 THEN '(' || SUBSTR(messages.recipients,1,3) || ') ' || SUBSTR(messages.recipients,4,3) || '-' || SUBSTR(messages.recipients,7,4)
        WHEN messages.recipients IS NULL THEN 'n/a'
        ELSE messages.recipients
    END AS 'Recipients',
    /* Name of recipient (if documented) */
    CASE
        WHEN recipients.cache_name IS NULL THEN 'n/a'
        ELSE recipients.cache_name
    END AS 'Recipient Name',
    /* Message direction (incoming/outgoing) */
    CASE
        WHEN messages.message_box_type IS 102 THEN 'Outgoing'
        WHEN messages.message_box_type IS 100 THEN 'Incoming'
        ELSE messages.message_box_type
    END AS 'Direction',
    /* Date/Time the message was created in UTC */
    strftime('%Y-%m-%d %H:%M:%S', messages.created_timestamp / 1000, 'UNIXEPOCH') AS 'Time Created (UTC)',
    /* Date/Time the message was sent in UTC */
    CASE
        WHEN messages.sent_timestamp IS 0 THEN 'n/a'
        ELSE strftime('%Y-%m-%d %H:%M:%S', messages.sent_timestamp / 1000, 'UNIXEPOCH')
    END AS 'Time Sent (UTC)',
    messages.remote_message_uri AS 'Message URI',
    /* Message content */
    CASE
        WHEN parts.text IS NULL THEN 'n/a'
        ELSE parts.text
    END AS 'Message Text',
    CASE
        WHEN parts.content_uri IS NULL THEN 'n/a'
        ELSE parts.content_uri
    END AS 'Content URI',
    parts.content_type AS 'Content Type',
    messages.message_type AS 'Message Type',
    /* If the message had an attachment, returns the file name */
    CASE
        WHEN parts.file_name IS NULL THEN 'n/a'
        ELSE parts.file_name
    END AS 'File Name',
    /* Output the attached file size formatted with commas as needed */
    printf("%,d", parts.size) AS 'File Size (bytes)',
    /* Output the message size formatted with commas as needed */
    printf("%,d", messages.message_size) AS 'Message Size (bytes)',
    /* Was the message read */
    messages.is_read AS 'Is Read?',
    /* Date/Time the message was updated (if any) in UTC */
    CASE
        WHEN messages.updated_timestamp IS 0 THEN 'n/a'
        ELSE strftime('%Y-%m-%d %H:%M:%S', messages.updated_timestamp / 1000, 'UNIXEPOCH')
    END AS 'Time Updated (UTC)',
    messages.creator AS 'Creator',
    messages.remote_creator AS 'Remote Creator',
    messages.req_app_id AS 'Req App ID',
    /* Source for each line of data */
    'File: \data\data\com.samsung.android.messaging\databases\message_content.db; Table: messages(_id: ' || messages._id || ')' AS 'Data Source'

FROM messages
    LEFT OUTER JOIN
        parts ON messages._id = parts.message_id
    LEFT OUTER JOIN
        recipients ON messages.conversation_id = recipients._id

ORDER BY messages._id ASC
