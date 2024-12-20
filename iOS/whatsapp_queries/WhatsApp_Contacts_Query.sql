
SELECT

    ROW_NUMBER() OVER() AS 'RecordNo.',
    ZWAADDRESSBOOKCONTACT.Z_PK AS 'ID',
    ZWAADDRESSBOOKCONTACT.ZGIVENNAME AS 'GivenName',
    ZWAADDRESSBOOKCONTACT.ZHIGHLIGHTEDNAME AS 'HighlightedName',
    ZWAADDRESSBOOKCONTACT.ZFULLNAME AS 'FullName',
    ZWAADDRESSBOOKCONTACT.ZABOUTTEXT AS 'AboutText',
    datetime(ZWAADDRESSBOOKCONTACT.ZABOUTTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'AboutDateTimestamp(UTC)',
    ZWAADDRESSBOOKCONTACT.ZPHONENUMBER AS 'PhoneNumber',

    CASE ZWAADDRESSBOOKCONTACT.ZPHONENUMBERLABEL
        WHEN '_$!<Work>!$_' THEN 'Work'
        WHEN '_$!<Mobile>!$_' THEN 'Mobile'
        WHEN '_$!<Home>!$_' THEN 'Home'
        WHEN '_$!<Other>!$_' THEN 'Other'
        ELSE ZWAADDRESSBOOKCONTACT.ZPHONENUMBERLABEL
    END AS 'Label',

    ZWAADDRESSBOOKCONTACT.ZWHATSAPPID AS 'WhatsAppID'


FROM ZWAADDRESSBOOKCONTACT


ORDER BY
    ZWAADDRESSBOOKCONTACT.Z_PK ASC
