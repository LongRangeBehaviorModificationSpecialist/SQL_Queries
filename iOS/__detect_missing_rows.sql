--DLU 17-Jul-2025


SELECT
    *,
    -- Compute time difference between the StartTime value and the EndTime value
    CASE
        WHEN StartTime IS NULL OR EndTime IS NULL THEN NULL
        WHEN EndTime < StartTime THEN 'TimeValueError [`EndTime` is before `StartTime`]'
        ELSE
            --Build human-readable duration only if timestamps are valid
            CASE
                WHEN ( strftime ( '%s', EndTime ) - strftime ( '%s', StartTime ) ) / 31536000 > 0
                THEN ( ( strftime ( '%s', EndTime ) - strftime ( '%s', StartTime ) ) / 31536000 ) || ' years '
                ELSE ''
            END
            ||
            CASE
                WHEN ( ( strftime ( '%s', EndTime ) - strftime ( '%s', StartTime ) ) % 31536000 ) / 86400 > 0
                THEN ( ( ( strftime ( '%s', EndTime ) - strftime ( '%s', StartTime ) ) % 31536000 ) / 86400 ) || ' days '
                ELSE ''
            END
            ||
            CASE
                WHEN ( ( strftime ( '%s', EndTime ) - strftime ( '%s', StartTime ) ) % 86400 ) / 3600 > 0
                THEN ( ( ( strftime ( '%s', EndTime ) - strftime ( '%s', StartTime ) ) % 86400 ) / 3600 ) || ' hours '
                ELSE ''
            END
            ||
            CASE
                WHEN ( ( strftime ( '%s', EndTime ) - strftime ( '%s', StartTime ) ) % 3600 ) / 60 > 0
                THEN ( ( ( strftime ( '%s', EndTime ) - strftime ( '%s', StartTime ) ) % 3600 ) / 60 ) || ' min '
                ELSE ''
            END
            ||
            CASE
                WHEN ( ( strftime ( '%s', EndTime ) - strftime ( '%s', StartTime ) ) % 60 ) > 0
                THEN ( ( strftime ( '%s', EndTime ) - strftime ( '%s', StartTime ) ) % 60 ) || ' sec'
                ELSE ''
            END
    END AS TimeSpan


FROM (
    SELECT
        LAG ( ROWID, 1 ) OVER ( ORDER BY ROWID ) AS "PreviousROWID",
        ROWID AS 'ROWID',
        ( ROWID - ( LAG ( ROWID, 1 ) OVER ( ORDER BY ROWID ) ) - 1 ) AS 'NumberOfMissingRecords',
        LAG ( datetime ( ZADDEDDATE + 978307200, 'UNIXEPOCH' ) ) OVER ( ORDER BY ROWID ) AS 'StartTime',
        datetime ( ZADDEDDATE + 978307200, 'UNIXEPOCH' ) AS 'EndTime'
    FROM ZASSET
) AS list


WHERE ROWID - "PreviousROWID" > 1;



