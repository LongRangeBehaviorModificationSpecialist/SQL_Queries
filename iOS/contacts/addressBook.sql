

SELECT

    ROW_NUMBER() OVER() AS 'RecordNo.',
    ABPerson.ROWID AS 'ABPerson.ROWID',
    ABPerson.First AS 'FirstName',
    ABPerson.Middle AS 'MiddleName',
    ABPerson.Last AS 'LastName',
    ABPerson.Organization AS 'Organization',
    ABPerson.Department AS 'Department',
    ABPerson.Birthday AS 'Birthday',
    ABPerson.JobTitle AS 'JobTitle',
    ABPerson.Note AS 'Note',

    (SELECT value FROM ABMultiValue WHERE property = 3 AND record_id = ABPerson.ROWID AND label = (
        SELECT ROWID FROM ABMultiValueLabel WHERE value = '_$!<Work>!$_')) AS 'WorkPhone',
    (SELECT value FROM ABMultiValue WHERE property = 3 AND record_id = ABPerson.ROWID AND label = (
        SELECT ROWID FROM ABMultiValueLabel WHERE value = '_$!<Mobile>!$_')) AS 'MobilePhone',
    (SELECT value FROM ABMultiValue WHERE property = 3 AND record_id = ABPerson.ROWID AND label = (
        SELECT ROWID FROM ABMultiValueLabel WHERE value = '_$!<Home>!$_')) AS 'HomePhone',
    (SELECT value FROM ABMultiValue WHERE property = 3 AND record_id = ABPerson.ROWID AND label IS NULL) AS 'Phone(Other)',

    (SELECT group_concat(value, ' | ') FROM ABMultiValue WHERE property = 4 AND record_id = ABPerson.ROWID) AS 'Email',

    (SELECT value FROM ABMultiValueEntry WHERE parent_id IN (
        SELECT ROWID FROM ABMultiValue WHERE record_id = ABPerson.ROWID) AND key = (
            SELECT ROWID FROM ABMultiValueEntryKey WHERE LOWER(value) = 'street')) AS 'Address',
    (SELECT value FROM ABMultiValueEntry WHERE parent_id IN (
        SELECT ROWID FROM ABMultiValue WHERE record_id = ABPerson.ROWID) AND key = (
            SELECT ROWID FROM ABMultiValueEntryKey WHERE LOWER(value) = 'city')) AS 'City',
    (SELECT value FROM ABMultiValueEntry WHERE parent_id IN (
        SELECT ROWID FROM ABMultiValue WHERE record_id = ABPerson.ROWID) AND key = (
            SELECT ROWID FROM ABMultiValueEntryKey WHERE LOWER(value) = 'state')) AS 'State',
    (SELECT value FROM ABMultiValueEntry WHERE parent_id IN (
        SELECT ROWID FROM ABMultiValue WHERE record_id = ABPerson.ROWID) AND key = (
            SELECT ROWID FROM ABMultiValueEntryKey WHERE LOWER(value) = 'zip')) AS 'ZipCode',
    (SELECT value FROM ABMultiValueEntry WHERE parent_id IN (
        SELECT ROWID FROM ABMultiValue WHERE record_id = ABPerson.ROWID) AND key = (
            SELECT ROWID FROM ABMultiValueEntryKey WHERE LOWER(value) = 'country')) AS 'Country',

    (SELECT GROUP_CONCAT(value, '; ') FROM ABMultiValue WHERE property = 22 AND record_id = ABPerson.ROWID) AS 'URL',

    CASE
        WHEN ABPersonFullTextSearch_content.c21RelatedNames IS NULL THEN 'n/a'
        ELSE ABPersonFullTextSearch_content.c21RelatedNames
    END AS 'FullTextSearch.c21RelatedNames',
    ABPersonFullTextSearch_content.c19SocialProfile AS 'FullTextSearch.c19SocialProfile',

    (SELECT GROUP_CONCAT(
        CASE ABMultiValueEntry.key
            WHEN 1 THEN 'Service: ' || value
            WHEN 2 THEN 'Username: ' || value
            WHEN 3 THEN 'URL: ' || value
            ELSE ABMultiValueEntry.key || ': ' || value
        END, ' | ')
        FROM ABMultiValueEntry WHERE parent_id IN (
            SELECT ROWID FROM ABMultiValue WHERE record_id = ABPerson.ROWID)) AS '**Services (TESTING)',

    CASE
        WHEN LENGTH(ABPerson.CreationDate) = 18 THEN strftime(
            '%Y-%m-%d %H:%M:%S', (ABPerson.CreationDate / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(ABPerson.CreationDate) = 9 THEN strftime(
            '%Y-%m-%d %H:%M:%S', ABPerson.CreationDate + 978307200, 'UNIXEPOCH')
        ELSE ABPerson.CreationDate
    END AS 'CreationDate(UTC)',

    CASE
        WHEN LENGTH(ABPerson.ModificationDate) = 18 THEN strftime(
            '%Y-%m-%d %H:%M:%S', (ABPerson.ModificationDate / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(ABPerson.ModificationDate) = 9 THEN strftime(
            '%Y-%m-%d %H:%M:%S', ABPerson.ModificationDate + 978307200, 'UNIXEPOCH')
        ELSE ABPerson.ModificationDate
    END AS 'ModificationDate(UTC)',

    /* Source for each line of data */
    'File: /private/var/mobile/Library/AddressBook/AddressBook.sqlitedb' AS 'DatabaseFile',
    'Table: ABPerson(ROWID:' || ABPerson.ROWID || ')' AS 'DataSource'


FROM ABPerson
    LEFT OUTER JOIN ABPersonFullTextSearch_content ON ABPerson.ROWID = ABPersonFullTextSearch_content.ROWID


ORDER BY ABPerson.ROWID
