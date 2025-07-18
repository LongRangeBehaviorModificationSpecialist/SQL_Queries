SELECT

    ROW_NUMBER() OVER() AS 'RECORD_NUMBER',
    history_visits.id AS 'history_visits.id',
    history_items.id AS 'history_items.id',

    datetime(history_visits.visit_time + 978307200, 'UNIXEPOCH') AS 'history_visits.visit_time(UTC)',

    CASE history_visits.load_successful
        WHEN 0 THEN '0  [No]'
        WHEN 1 THEN '1  [Yes]'
        ELSE history_visits.load_successful
    END AS 'history_visits.load_successful',

    CASE history_visits.origin
        WHEN 0 THEN '0  [Viewed On This Device]'
        WHEN 1 THEN '1  [Synced From iCloud Device]'
        ELSE history_visits.origin
    END AS 'history_visits.origin',

    history_visits.title AS 'history_visits.title',
    history_items.url AS 'history_items.url',
    --history_items.visit_count AS 'VisitCount',
    history_visits.redirect_source AS 'history_visits.redirect_source',
    history_visits.redirect_destination AS 'history_visits.redirect_destination',

    /* Source for each line of data */
    '/private/var/mobile/Library/Safari/History.db; Table: history_items(id:' ||  history_items.id || '), Table: history_visits(id:' || history_visits.id || ')' AS 'DATA_SOURCE'


FROM history_visits
    JOIN history_items ON history_visits.history_item = history_items.id


WHERE
    history_items.url LIKE '%270357737392%'


ORDER BY
    history_visits.visit_time ASC