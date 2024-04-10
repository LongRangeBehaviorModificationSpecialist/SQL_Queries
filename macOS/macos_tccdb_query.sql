/*
MODULE_NOTES = Transparancy, Consent, and Control (TCC) Database - Application Permissions

[Database Metadata]
DATABASE = TCC.db
PLATFORM = macOS
VERSIONS = 10.14, 10.15

QUERY=
*/

SELECT
    datetime ( LAST_MODIFIED, 'UNIXEPOCH' ) AS 'Last Modified',
    SERVICE AS 'Service',
    CLIENT AS 'Client',
    CASE ALLOWED
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE 'Contact Examiner for Further'
    END AS 'Allowed',
    CLIENT_TYPE AS 'Client Type',
    PROMPT_COUNT AS 'Prompt Count',
    INDIRECT_OBJECT_IDENTIFIER AS 'Indirect Object Identifier'

FROM ACCESS
