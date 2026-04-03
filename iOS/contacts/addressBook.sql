/*
[DLU]
    03-Apr-2026
[DATABASE PATH]
    /private/var/mobile/Library/AddressBook/AddressBook.sqlitedb
*/


SELECT

    ROW_NUMBER() OVER() AS 'record_number',
    ABPerson.ROWID AS 'rowid',
    ABPerson.First AS 'first',
    ABPerson.Middle AS 'middle',
    ABPerson.Last AS 'last',
    ABPerson.Organization AS 'organization',
    ABPerson.Department AS 'department',
    ABPerson.Birthday AS 'birthday',
    ABPerson.JobTitle AS 'job_title',
    ABPerson.Note AS 'note',

    (SELECT value FROM ABMultiValue WHERE property = 3 AND record_id = ABPerson.ROWID AND label = (
        SELECT ROWID FROM ABMultiValueLabel WHERE value = '_$!<Work>!$_')) AS 'work_phone',

    (SELECT value FROM ABMultiValue WHERE property = 3 AND record_id = ABPerson.ROWID AND label = (
        SELECT ROWID FROM ABMultiValueLabel WHERE value = '_$!<Mobile>!$_')) AS 'mobile_phone',

    (SELECT value FROM ABMultiValue WHERE property = 3 AND record_id = ABPerson.ROWID AND label = (
        SELECT ROWID FROM ABMultiValueLabel WHERE value = '_$!<Home>!$_')) AS 'home_phone',

    (SELECT value FROM ABMultiValue WHERE property = 3 AND record_id = ABPerson.ROWID AND label IS NULL) AS 'phone_other',

    (SELECT group_concat(value, ' | ') FROM ABMultiValue WHERE property = 4 AND record_id = ABPerson.ROWID) AS 'email',

    (SELECT value FROM ABMultiValueEntry WHERE parent_id IN (
        SELECT ROWID FROM ABMultiValue WHERE record_id = ABPerson.ROWID) AND key = (
            SELECT ROWID FROM ABMultiValueEntryKey WHERE LOWER(value) = 'street')) AS 'address',

    (SELECT value FROM ABMultiValueEntry WHERE parent_id IN (
        SELECT ROWID FROM ABMultiValue WHERE record_id = ABPerson.ROWID) AND key = (
            SELECT ROWID FROM ABMultiValueEntryKey WHERE LOWER(value) = 'city')) AS 'city',

    (SELECT value FROM ABMultiValueEntry WHERE parent_id IN (
        SELECT ROWID FROM ABMultiValue WHERE record_id = ABPerson.ROWID) AND key = (
            SELECT ROWID FROM ABMultiValueEntryKey WHERE LOWER(value) = 'state')) AS 'state',

    (SELECT value FROM ABMultiValueEntry WHERE parent_id IN (
        SELECT ROWID FROM ABMultiValue WHERE record_id = ABPerson.ROWID) AND key = (
            SELECT ROWID FROM ABMultiValueEntryKey WHERE LOWER(value) = 'zip')) AS 'zipcode',

    (SELECT value FROM ABMultiValueEntry WHERE parent_id IN (
        SELECT ROWID FROM ABMultiValue WHERE record_id = ABPerson.ROWID) AND key = (
            SELECT ROWID FROM ABMultiValueEntryKey WHERE LOWER(value) = 'country')) AS 'country',

    (SELECT GROUP_CONCAT(value, '; ') FROM ABMultiValue WHERE property = 22 AND record_id = ABPerson.ROWID) AS 'URL',

    CASE
        WHEN ABPersonFullTextSearch_content.c21RelatedNames IS NULL THEN NULL
        ELSE ABPersonFullTextSearch_content.c21RelatedNames
    END AS 'ABPersonFullTextSearch_content.c21RelatedNames',

    ABPersonFullTextSearch_content.c19SocialProfile AS 'FullTextSearch.c19SocialProfile',

    (SELECT GROUP_CONCAT(
        CASE ABMultiValueEntry.key
            WHEN 1 THEN '1 [Service: ' || value || ']'
            WHEN 2 THEN '2 [Username: ' || value || ']'
            WHEN 3 THEN '3 [URL: ' || value || ']'
            ELSE ABMultiValueEntry.key || ': ' || value
        END, ' | ')
        FROM ABMultiValueEntry WHERE parent_id IN (
            SELECT ROWID FROM ABMultiValue WHERE record_id = ABPerson.ROWID)) AS '**Services(TESTING)',

    CASE
        WHEN LENGTH(ABPerson.CreationDate) = 18 THEN strftime(
            '%Y-%m-%d %H:%M:%S', (ABPerson.CreationDate / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(ABPerson.CreationDate) = 9 THEN strftime(
            '%Y-%m-%d %H:%M:%S', ABPerson.CreationDate + 978307200, 'UNIXEPOCH')
        ELSE ABPerson.CreationDate
    END AS 'creation_date_utc',

    CASE
        WHEN LENGTH(ABPerson.ModificationDate) = 18 THEN strftime(
            '%Y-%m-%d %H:%M:%S', (ABPerson.ModificationDate / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(ABPerson.ModificationDate) = 9 THEN strftime(
            '%Y-%m-%d %H:%M:%S', ABPerson.ModificationDate + 978307200, 'UNIXEPOCH')
        ELSE ABPerson.ModificationDate
    END AS 'modification_date_utc',

    /* Source for each line of data */
    'AddressBook.sqlitedb; Table:ABPerson(ROWID:' || ABPerson.ROWID || ')' AS 'data_source'


FROM ABPerson
    LEFT OUTER JOIN ABPersonFullTextSearch_content ON ABPerson.ROWID = ABPersonFullTextSearch_content.ROWID


ORDER BY
    ABPerson.ROWID
