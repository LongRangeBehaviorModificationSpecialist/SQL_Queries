/*
[DLU]
    12-Mar-2026
*/


SELECT
    *,
    -- Compute time difference between the StartTime value and the EndTime value
    CASE
        WHEN "start_time" IS NULL OR "end_time" IS NULL THEN NULL
        WHEN "end_time" < "start_time" THEN 'TimeValueError [`EndTime` is before `StartTime`]'
        ELSE
            --Build human-readable duration only if timestamps are valid
            CASE
                WHEN (strftime ('%s', "end_time") - strftime('%s', "start_time")) / 31536000 > 0
                THEN ((strftime('%s', "end_time") - strftime('%s', "start_time")) / 31536000) || ' years '
                ELSE ''
            END
            ||
            CASE
                WHEN ((strftime('%s', "end_time") - strftime('%s', "start_time")) % 31536000) / 86400 > 0
                THEN (((strftime('%s', "end_time") - strftime('%s', "start_time")) % 31536000) / 86400) || ' days '
                ELSE ''
            END
            ||
            CASE
                WHEN ((strftime('%s', "end_time") - strftime('%s', "start_time")) % 86400) / 3600 > 0
                THEN (((strftime('%s', "end_time") - strftime('%s', "start_time")) % 86400) / 3600) || ' hours '
                ELSE ''
            END
            ||
            CASE
                WHEN ((strftime('%s', "end_time") - strftime('%s', "start_time")) % 3600) / 60 > 0
                THEN (((strftime('%s', "end_time") - strftime('%s', "start_time")) % 3600) / 60) || ' min '
                ELSE ''
            END
            ||
            CASE
                WHEN ((strftime('%s', "end_time") - strftime('%s', "start_time")) % 60) > 0
                THEN ((strftime('%s', "end_time") - strftime('%s', "start_time")) % 60) || ' sec'
                ELSE ''
            END
    END AS TimeSpan


FROM (
    SELECT
        -- Change `ROWID` to the name of the column containing the primary key
        LAG (ROWID, 1) OVER (ORDER BY ROWID) AS 'previous_rowid',
        ROWID AS 'row_id',
        (ROWID - (LAG (ROWID, 1) OVER (ORDER BY ROWID)) - 1) AS 'number_of_missing_records',

        -- Change `ZDATEADDED` to the name of the column containing the timestamp value
        LAG (datetime(ZADDEDDATE + 978307200, 'UNIXEPOCH')) OVER (ORDER BY ROWID) AS 'start_time',
        datetime(ZADDEDDATE + 978307200, 'UNIXEPOCH') AS 'end_time'

    FROM ZASSET

) AS 'list'


WHERE ROWID - "previous_rowid" > 1;