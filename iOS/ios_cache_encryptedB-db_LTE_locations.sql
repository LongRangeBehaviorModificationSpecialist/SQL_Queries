/*
[Module Metadata]
AUTHOR=[@mikespon]
MODULE_NOTES=Locations from LTE data

[Database Metadata]
DATABASE=cache_encryptedB.db
DATABASEPATH=/private/var/root/Library/Caches/locationd/
PLATFORM=iOS
VERSION=iOS 16.6 (20G75)
*/

SELECT
    ROW_NUMBER() OVER() AS 'Record No.',
    strftime('%Y-%m-%dT%H:%M:%SZ', datetime(timestamp + 978307200, 'UNIXEPOCH')) AS 'Timestamp (UTC)',
    strftime('%Y-%m-%d %H:%M:%S', datetime(timestamp + 978307200, 'UNIXEPOCH', 'localtime')) AS 'Timestamp (Local)',
    Latitude AS 'Latitude',
    Longitude AS 'Longitude',
	MCC AS 'MCC',
	MNC AS 'MNC',
	TAC AS 'TAC',
	CI AS 'CI',
	HorizontalAccuracy AS 'HorizontalAccuracy',
    Altitude AS 'Altitude',
    Confidence AS 'Confidence'

FROM LteCellLocation

ORDER BY timestamp DESC