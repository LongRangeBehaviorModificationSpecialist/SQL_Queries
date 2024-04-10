SELECT
    ROW_NUMBER() OVER() AS 'Record No.',
    history_visits.id AS 'Row ID',
    history_items.id AS 'Item ID',
    datetime(history_visits.visit_time + 978307200, 'UNIXEPOCH') AS 'Visit Time (UTC)',
    datetime(history_visits.visit_time + 978307200, 'UNIXEPOCH', 'localtime') AS 'Visit Time (Local)',
    CASE history_visits.load_successful
        WHEN '0' THEN 'No'
        WHEN '1' THEN 'Yes'
        ELSE history_visits.load_successful
    END AS 'Load Successful',
    CASE history_visits.origin
        WHEN '0' THEN 'This Device'
        WHEN '1' THEN 'iCloud Synced Device'
        ELSE history_visits.origin
    END AS 'iCloud Sync',
    history_visits.title AS 'Web Page Title',
    history_items.url AS 'URL',
    history_items.visit_count AS 'Visit Count',
    history_visits.redirect_source AS 'Redirect Source',
    history_visits.redirect_destination AS 'Redirect Destination'

FROM history_visits
    JOIN history_items ON history_visits.history_item = history_items.id

WHERE history_visits.title LIKE '%shoot%'

ORDER BY history_visits.visit_time ASC
