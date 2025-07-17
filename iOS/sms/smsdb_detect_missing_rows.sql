/*
  [URL]
    https://belkasoft.com/lagging-for-win
*/

/*
SELECT * FROM (
    SELECT LAG (ROWID, 1) OVER (ORDER BY ROWID) AS "PreviousROWID",
    rowid AS ROWID,

    from message) list
    WHERE ROWID - "PreviousROWID" > 1
*/

SELECT * FROM (
    SELECT LAG (ROWID, 1) OVER (ORDER BY ROWID) AS "PREVIOUSROWID",
    rowid AS 'ROWID',
    (ROWID - (LAG (ROWID, 1) OVER (ORDER BY ROWID)) - 1) AS 'NumberOfMissingRows',
    LAG(datetime(date / 1000000000 + 978307200, 'UNIXEPOCH'), 1) OVER (ORDER BY ROWID) AS 'BeginningTimestamp',
    datetime(date / 1000000000 + 978307200, 'UNIXEPOCH') AS 'EndingTimestamp'
    from message) list
    WHERE ROWID - "PreviousROWID" > 1;