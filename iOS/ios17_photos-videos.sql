SELECT
    ROW_NUMBER() OVER() AS 'RowNumber',
    ZASSET.Z_PK AS 'AssetPrimaryKey',
    ZASSET.ZDIRECTORY AS 'Directory',
    ZASSET.ZFILENAME AS 'FileName',
    ZADDITIONALASSETATTRIBUTES.ZORIGINALFILENAME AS 'OriginalFileName',
    ZASSET.ZUNIFORMTYPEIDENTIFIER AS 'MIMEType',
    CASE ZASSET.ZFAVORITE
        WHEN '0' THEN 'No'
        WHEN '1' THEN 'Yes'
        ELSE ZASSET.ZFAVORITE
    END AS 'Favorite',
    CASE
        WHEN LENGTH(ZASSET.ZDATECREATED) = 18 THEN datetime((ZASSET.ZDATECREATED / 1000000000) + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(ZASSET.ZDATECREATED) = 12 THEN datetime(ZASSET.ZDATECREATED + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(ZASSET.ZDATECREATED) = 13 THEN datetime(ZASSET.ZDATECREATED + 978307200, 'UNIXEPOCH')
        WHEN LENGTH(ZASSET.ZDATECREATED) = 9 THEN datetime(ZASSET.ZDATECREATED + 978307200, 'UNIXEPOCH')
        ELSE ZASSET.ZDATECREATED
    END AS 'DateCreated(UTC)',
    datetime(ZASSET.ZADDEDDATE + 978307200, 'UNIXEPOCH') AS 'DateAdded(UTC)',
    datetime(ZASSET.ZMODIFICATIONDATE + 978307200, 'UNIXEPOCH') AS 'ModificationDate(UTC)',
    CASE
        WHEN ZADDITIONALASSETATTRIBUTES.ZEXIFTIMESTAMPSTRING IS NULL THEN 'n/a'
        ELSE ZADDITIONALASSETATTRIBUTES.ZEXIFTIMESTAMPSTRING
    END AS 'EXIFTimeStamp(UTC)',
    CASE
        WHEN ZASSET.ZTRASHEDDATE IS NULL THEN 'n/a'
        ELSE datetime(ZASSET.ZTRASHEDDATE + 978307200, 'UNIXEPOCH')
    END AS 'FileTrashDate(UTC)',
    ZADDITIONALASSETATTRIBUTES.ZVIEWCOUNT AS 'ViewCount',
    ZADDITIONALASSETATTRIBUTES.ZSHARECOUNT AS 'ShareCount',
    CASE
        WHEN ZASSET.ZLASTSHAREDDATE IS NULL THEN 'n/a'
        ELSE datetime(ZASSET.ZLASTSHAREDDATE + 978307200, 'UNIXEPOCH')
    END AS 'LastSharedDate(UTC)',
    ZADDITIONALASSETATTRIBUTES.ZPLAYCOUNT AS 'PlayCount',
    CASE ZASSET.ZHIDDEN
        WHEN '0' THEN 'No'
        WHEN '1' THEN 'Yes'
        ELSE 'ContactExaminer'
    END 'IsHidden',
    ZASSET.ZDURATION AS 'Duration(seconds)',
    ZADDITIONALASSETATTRIBUTES.ZIMPORTEDBY AS 'ImportedBy',
    ZADDITIONALASSETATTRIBUTES.ZCAMERACAPTUREDEVICE AS 'CameraCaptureDevice',
    ZADDITIONALASSETATTRIBUTES.ZORIGINALFILESIZE AS 'OriginalFileSize',
    ZADDITIONALASSETATTRIBUTES.ZORIGINALHEIGHT AS 'OriginalHeight',
    ZADDITIONALASSETATTRIBUTES.ZORIGINALWIDTH AS 'OriginalWidth',
    ZASSET.ZTHUMBNAILINDEX AS 'ThumbnailIndex',
    CASE
        WHEN ZADDITIONALASSETATTRIBUTES.ZEDITORBUNDLEID IS NULL THEN 'n/a'
        ELSE ZADDITIONALASSETATTRIBUTES.ZEDITORBUNDLEID
    END AS 'EditorBundle',
    ZADDITIONALASSETATTRIBUTES.ZLOCATIONHASH AS 'LocationHash',
    ZADDITIONALASSETATTRIBUTES.ZMASTERFINGERPRINT AS 'MasterFingerPrint',
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

WHERE
        ZASSET.ZFILENAME  IS 'IMG_6263.HEIC' OR
        ZASSET.ZFILENAME  IS 'IMG_6267.HEIC' OR
        ZASSET.ZFILENAME  IS 'IMG_6287.HEIC' OR
        ZASSET.ZFILENAME  IS 'IMG_6290.HEIC' OR
        ZASSET.ZFILENAME  IS 'IMG_6291.HEIC' OR
        ZASSET.ZFILENAME  IS 'IMG_6292.HEIC' OR
        ZASSET.ZFILENAME  IS 'IMG_6350.HEIC' OR
        ZASSET.ZFILENAME  IS 'IMG_6351.HEIC' OR
        ZASSET.ZFILENAME  IS 'IMG_6352.HEIC' OR
        ZASSET.ZFILENAME  IS 'IMG_6353.HEIC' OR
        ZASSET.ZFILENAME  IS 'IMG_6354.HEIC' OR
        ZASSET.ZFILENAME  IS 'IMG_6355.HEIC' OR
        ZASSET.ZFILENAME  IS 'IMG_6264.MOV' OR
        ZASSET.ZFILENAME  IS 'IMG_6265.MOV' OR
        ZASSET.ZFILENAME  IS 'IMG_6266.MOV' OR
        ZASSET.ZFILENAME  IS 'IMG_6269.MOV' OR
        ZASSET.ZFILENAME  IS 'IMG_6270.MOV' OR
        ZASSET.ZFILENAME  IS 'IMG_6271.MOV' OR
        ZASSET.ZFILENAME  IS 'IMG_6272.MOV'

ORDER BY ZASSET.Z_PK ASC