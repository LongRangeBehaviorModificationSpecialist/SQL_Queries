/*
[Module Metadata]
AUTHOR=[@mikespon]
MODULE_NOTES=Locations from Wifi

[Database Metadata]
DATABASE=cache_encryptedB.db
DATABASEPATH=/private/var/root/Library/Caches/locationd/
PLATFORM=iOS
VERSION=iOS 16.6 (20G75)
*/

SELECT
    ROW_NUMBER() OVER() AS 'RecordNo.',
    /* This will concat the MAC address into a readable format */
    UPPER(substr(printf("%0!.12x", MAC), 1, 2) || ':' ||
        substr(printf("%0!.12x", MAC), 3, 2) || ':' ||
        substr(printf("%0!.12x", MAC), 5, 2) || ':' ||
        substr(printf("%0!.12x", MAC), 7, 2) || ':' ||
        substr(printf("%0!.12x", MAC), 9, 2) || ':' ||
        substr(printf("%0!.12x", MAC), 11, 2)) AS 'MACAddress',
    Channel AS 'Channel',
    strftime('%Y-%m-%dT%H:%M:%SZ', datetime(timestamp + 978307200, 'UNIXEPOCH')) AS 'Timestamp(UTC)',
    strftime('%Y-%m-%d %H:%M:%S', datetime(timestamp + 978307200, 'UNIXEPOCH', 'localtime')) AS 'Timestamp(Local)',
    Latitude AS 'Latitude',
    Longitude AS 'Longitude',
    HorizontalAccuracy AS 'HorizontalAccuracy',
    Altitude AS 'Altitude',
    Confidence AS 'Confidence'

FROM WifiLocation

ORDER BY timestamp DESC