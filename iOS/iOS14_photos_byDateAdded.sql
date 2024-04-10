
-- changed album name due to iOS 14.x change.

SELECT
    ROW_NUMBER() OVER() AS 'Row #',
    ZASSET.Z_PK AS 'Index #',
    ZASSET.ZDIRECTORY AS 'Directory',
    ZASSET.ZFILENAME AS 'File Name',
    ZADDITIONALASSETATTRIBUTES.ZORIGINALFILENAME AS 'Original File Name',
    CASE ZASSET.ZKINDZUNIFORMTYPEIDENTIFIER
        WHEN '0' THEN 'Photo'
        WHEN '1' THEN 'Video'
        ELSE ZASSET.ZKINDZUNIFORMTYPEIDENTIFIER
    END AS 'File Type',
    ZASSET.ZUNIFORMTYPEIDENTIFIER AS 'MIME Type',
    CASE ZASSET.ZFAVORITE
        WHEN '0' THEN 'No'
        WHEN '1' THEN 'Yes'
        ELSE ZASSET.ZFAVORITE
    END AS 'Favorite',
    CASE
        WHEN LENGTH(ZASSET.ZDATECREATED) = 18 THEN datetime((ZASSET.ZDATECREATED / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(ZASSET.ZDATECREATED) = 9 THEN datetime(ZASSET.ZDATECREATED + 978307200, 'UNIXEPOCH')
        ELSE ZASSET.ZDATECREATED
    END AS 'Date Created (UTC)',
    datetime(ZASSET.ZADDEDDATE + 978307200, 'UNIXEPOCH') AS 'Date Added (UTC)',
    datetime(ZASSET.ZMODIFICATIONDATE + 978307200, 'UNIXEPOCH') AS 'Modification Date  (UTC)',
    CASE
        WHEN ZADDITIONALASSETATTRIBUTES.ZEXIFTIMESTAMPSTRING IS NULL THEN 'n/a'
        ELSE ZADDITIONALASSETATTRIBUTES.ZEXIFTIMESTAMPSTRING
    END AS 'EXIF Time Stamp (UTC)',
    CASE
        WHEN ZASSET.ZTRASHEDDATE IS NULL THEN 'n/a'
        ELSE datetime(ZASSET.ZTRASHEDDATE + 978307200, 'UNIXEPOCH')
    END AS 'File Trash Date (UTC)',
    ZADDITIONALASSETATTRIBUTES.ZVIEWCOUNT AS 'View Count',
    ZADDITIONALASSETATTRIBUTES.ZSHARECOUNT AS 'Share Count',
    CASE
        WHEN ZASSET.ZLASTSHAREDDATE IS NULL THEN 'n/a'
        ELSE datetime(ZASSET.ZLASTSHAREDDATE + 978307200, 'UNIXEPOCH')
    END AS 'Last Shared Date (UTC)',
    ZADDITIONALASSETATTRIBUTES.ZPLAYCOUNT AS 'Play Count',
    CASE ZASSET.ZHIDDEN
        WHEN '0' THEN 'No'
        WHEN '1' THEN 'Yes'
        ELSE 'Contact Examiner'
    END 'Is Hidden',
    ZASSET.ZDURATION AS 'Duration (seconds)',
    ZADDITIONALASSETATTRIBUTES.ZIMPORTEDBY AS 'Imported By',
    ZADDITIONALASSETATTRIBUTES.ZCAMERACAPTUREDEVICE AS 'Camera Capture Device',
    ZADDITIONALASSETATTRIBUTES.ZORIGINALFILESIZE AS 'Original File Size',
    ZADDITIONALASSETATTRIBUTES.ZORIGINALHEIGHT AS 'Original Height',
    ZADDITIONALASSETATTRIBUTES.ZORIGINALWIDTH AS 'Original Width',
    ZASSET.ZTHUMBNAILINDEX AS 'Thumbnail Index',
    CASE
        WHEN ZADDITIONALASSETATTRIBUTES.ZCREATORBUNDLEID IS NULL THEN 'n/a'
        ELSE ZADDITIONALASSETATTRIBUTES.ZCREATORBUNDLEID
    END AS 'Creator Bundle',
    CASE
        WHEN ZADDITIONALASSETATTRIBUTES.ZEDITORBUNDLEID IS NULL THEN 'n/a'
        ELSE ZADDITIONALASSETATTRIBUTES.ZEDITORBUNDLEID
    END AS 'Editor Bundle',
    ZADDITIONALASSETATTRIBUTES.ZLOCATIONHASH AS 'Location Hash',
    ZADDITIONALASSETATTRIBUTES.ZMASTERFINGERPRINT AS 'Master FingerPrint',
    CASE ZASSET.ZLATITUDE
        WHEN '-180.0' THEN 'n/a'
        ELSE ZASSET.ZLATITUDE
    END 'LATITUDE',
    CASE ZASSET.ZLONGITUDE
        WHEN '-180.0' THEN 'n/a'
        ELSE ZASSET.ZLONGITUDE
    END 'LONGITUDE'

FROM ZASSET
    JOIN ZADDITIONALASSETATTRIBUTES ON ZASSET.Z_PK = ZADDITIONALASSETATTRIBUTES.ZASSET

ORDER BY ZASSET.ZADDEDDATE ASC

/*

To get info for specific media files, enter the file name below

DO NOT put "OR" after the last file name

*/

-- WHERE (
--     ZFILENAME LIKE 'IMG 9007.JPG' OR
--     ZFILENAME LIKE 'IMG 9014.GIF' OR
--     ZFILENAME LIKE 'IMG 9037.JPG' OR
--     ZFILENAME LIKE 'IMG 9049.PNG' OR
--     ZFILENAME LIKE 'IMG 9058.JPG' OR
--     ZFILENAME LIKE 'IMG 9064.JPG' OR
--     ZFILENAME LIKE 'IMG 9092.JPG' OR
--     ZFILENAME LIKE 'IMG 9095.JPG' OR
--     ZFILENAME LIKE 'IMG 9123.PNG' OR
--     ZFILENAME LIKE 'IMG 9253.JPG'
--    )

/*
Use 'DESC' for decending order (most recent date on top)
Use 'ASC' for acending order (most recent date on bottom)
*/

