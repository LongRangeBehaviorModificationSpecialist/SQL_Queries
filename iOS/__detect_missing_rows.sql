/*
[DLU]
    12-Mar-2026
*/


SELECT
    *,
    -- Compute time difference between the StartTime value and the EndTime value
    CASE
        WHEN "Start-Time" IS NULL OR "End-Time" IS NULL THEN NULL
        WHEN "End-Time" < "Start-Time" THEN 'TimeValueError [`EndTime` is before `StartTime`]'
        ELSE
            --Build human-readable duration only if timestamps are valid
            CASE
                WHEN (strftime ('%s', "End-Time") - strftime('%s', "Start-Time")) / 31536000 > 0
                THEN ((strftime('%s', "End-Time") - strftime('%s', "Start-Time")) / 31536000) || ' years '
                ELSE ''
            END
            ||
            CASE
                WHEN ((strftime('%s', "End-Time") - strftime('%s', "Start-Time")) % 31536000) / 86400 > 0
                THEN (((strftime('%s', "End-Time") - strftime('%s', "Start-Time")) % 31536000) / 86400) || ' days '
                ELSE ''
            END
            ||
            CASE
                WHEN ((strftime('%s', "End-Time") - strftime('%s', "Start-Time")) % 86400) / 3600 > 0
                THEN (((strftime('%s', "End-Time") - strftime('%s', "Start-Time")) % 86400) / 3600) || ' hours '
                ELSE ''
            END
            ||
            CASE
                WHEN ((strftime('%s', "End-Time") - strftime('%s', "Start-Time")) % 3600) / 60 > 0
                THEN (((strftime('%s', "End-Time") - strftime('%s', "Start-Time")) % 3600) / 60) || ' min '
                ELSE ''
            END
            ||
            CASE
                WHEN ((strftime('%s', "End-Time") - strftime('%s', "Start-Time")) % 60) > 0
                THEN ((strftime('%s', "End-Time") - strftime('%s', "Start-Time")) % 60) || ' sec'
                ELSE ''
            END
    END AS TimeSpan


FROM (
    SELECT
        -- Change `ROWID` to the name of the column containing the primary key
        LAG (ROWID, 1) OVER (ORDER BY ROWID) AS 'Previous-ROWID',
        ROWID AS 'ROWID',
        (ROWID - (LAG (ROWID, 1) OVER (ORDER BY ROWID)) - 1) AS 'Number-Of-Missing-Records',

        -- Change `ZDATEADDED` to the name of the column containing the timestamp value
        LAG (datetime(ZADDEDDATE + 978307200, 'UNIXEPOCH')) OVER (ORDER BY ROWID) AS 'Start-Time',
        datetime(ZADDEDDATE + 978307200, 'UNIXEPOCH') AS 'End-Time'

    FROM ZASSET

) AS 'list'


WHERE ROWID - "Previous-ROWID" > 1;