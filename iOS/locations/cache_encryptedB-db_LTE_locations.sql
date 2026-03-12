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

    ROW_NUMBER() OVER() AS 'RecordNumber',

    strftime('%Y-%m-%dT%H:%M:%SZ', datetime(LteCellLocation.timestamp + 978307200, 'UNIXEPOCH')) AS 'Timestamp(UTC)',
    strftime('%Y-%m-%d %H:%M:%S', datetime(LteCellLocation.timestamp + 978307200, 'UNIXEPOCH', 'localtime')) AS 'Timestamp(Local)',

    LteCellLocation.Latitude AS 'Latitude',
    LteCellLocation.Longitude AS 'Longitude',
    RTRIM(LTRIM(CONCAT(ROUND(LteCellLocation.Latitude, 6), ',', ROUND(LteCellLocation.Longitude, 6)))) AS 'Lat/Long(Merged)',

    LteCellLocation.MCC AS 'MCC',
    LteCellLocation.MNC AS 'MNC',
    LteCellLocation.TAC AS 'TAC',
    LteCellLocation.CI AS 'CI',
    LteCellLocation.HorizontalAccuracy AS 'HorizontalAccuracy',
    LteCellLocation.Altitude AS 'Altitude',
    LteCellLocation.Confidence AS 'Confidence'


FROM LteCellLocation


ORDER BY LteCellLocation.timestamp DESC