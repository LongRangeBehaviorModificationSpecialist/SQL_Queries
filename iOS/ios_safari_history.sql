SELECT
    ROW_NUMBER() OVER() AS 'Record No.',
    history_visits.id AS 'HistoryVisit ID',
    history_items.id AS 'HistoryItem ID',
    datetime(history_visits.visit_time + 978307200, 'UNIXEPOCH') AS 'VisitTime (UTC)',
    datetime(history_visits.visit_time + 978307200, 'UNIXEPOCH', 'localtime') AS 'VisitTime (Local)',
    CASE history_visits.load_successful
        WHEN '0' THEN 'No'
        WHEN '1' THEN 'Yes'
        ELSE history_visits.load_successful
    END AS 'LoadSuccessful',
    CASE history_visits.origin
        WHEN '0' THEN 'Viewed On This Device'
        WHEN '1' THEN 'Synced From iCloud Device'
        ELSE history_visits.origin
    END AS 'iCloudSync',
    history_visits.title AS 'WebPageTitle',
    history_items.url AS 'URL',
    --history_items.visit_count AS 'VisitCount',
    history_visits.redirect_source AS 'RedirectSource',
    history_visits.redirect_destination AS 'RedirectDestination',
    /* Source for each line of data */
    'File: /private/var/mobile/Library/Safari/History.db' AS 'Source',
    /* Location of data */
    'Table: history_items(id:' ||  history_items.id || '), Table: history_visits(id:' || history_visits.id || ')' AS 'Location'

FROM history_visits
    JOIN history_items ON history_visits.history_item = history_items.id

WHERE
    history_items.url LIKE '%270357737392%'

ORDER BY history_visits.visit_time ASC