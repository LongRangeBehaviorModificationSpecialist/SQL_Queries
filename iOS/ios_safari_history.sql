SELECT
    ROW_NUMBER() OVER() AS 'Record #',
    history_visits.id AS 'Row_ID',
    history_items.id AS 'Item_ID',
    datetime(history_visits.visit_time + 978307200, 'UNIXEPOCH') AS 'Visit_Time (UTC)',
    datetime(history_visits.visit_time + 978307200, 'UNIXEPOCH', 'localtime') AS 'Visit_Time (Local)',
    CASE history_visits.load_successful
        WHEN '0' THEN 'No'
        WHEN '1' THEN 'Yes'
        ELSE history_visits.load_successful
    END AS 'Load_Successful',
    CASE history_visits.origin
        WHEN '0' THEN 'This Device'
        WHEN '1' THEN 'iCloud Synced Device'
        ELSE history_visits.origin
    END AS 'iCloud Sync',
    history_visits.title AS 'Web_Page_Title',
    history_items.url AS 'URL',
    history_items.visit_count AS 'Visit_Count',
    history_visits.redirect_source AS 'Redirect_Source',
    history_visits.redirect_destination AS 'Redirect_Destination'

FROM history_visits
    JOIN history_items ON history_visits.history_item = history_items.id

WHERE history_visits.title LIKE '%shoot%'

ORDER BY history_visits.visit_time ASC
