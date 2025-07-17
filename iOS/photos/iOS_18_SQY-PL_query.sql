/*
  [DLU]
    2024-10-04

  [NOTES]
    Parts of query copied from:  https://github.com/ScottKjr3347/iOS_SWY_PL_Photos.sqlite_Queries/blob/main/iOS17/iOS17_SWY-PL_Phsql_LargeReference.txt

    Blog Link:  https://theforensicscooter.com/2022/09/16/shared-with-you-syndication-photo-library-message-attachments-linked-assets/#_Toc114172924

    This query is for the Shared With You (SWY) Syndication Photo Library (PL) Photos.sqlite database.

    Database location:
      /private/var/mobile/Library/Photos/Libraries/Syndication.photoslibrary/database/Photos.sqlite
*/

SELECT

    /* Add a row number at the beggining of each row */
    ROW_NUMBER() OVER() AS 'RowNo.',
    ZASSET.Z_PK AS 'AssetRowID',
    --ZASSET.ZADDITIONALATTRIBUTES AS 'AddAttributesKey',
    --ZDETECTEDFACE.ZASSETFORFACE AS 'DetectedFaceAsset',

    CASE ZASSET.ZKIND
        WHEN 0 THEN 'Photo'
        WHEN 1 THEN 'Video'
        ELSE ZASSET.ZKIND
    END AS 'FileType',

    ZASSET.ZUNIFORMTYPEIDENTIFIER AS 'MIMEType',

    datetime(ZASSET.ZADDEDDATE + 978307200, 'UNIXEPOCH') AS 'DateAdded(UTC)',

    ZASSET.ZFILENAME AS 'File Name',
    ZADDITIONALASSETATTRIBUTES.ZORIGINALFILENAME AS 'OriginalFilename',

    datetime(ZASSET.ZDATECREATED + 978307200, 'UNIXEPOCH') AS 'DateCreated(UTC)',
    datetime(ZASSET.ZMODIFICATIONDATE + 978307200, 'UNIXEPOCH') AS 'ModificationDate(UTC)',

    -- The EXIF data is stored in the device local time at the time of capture/creation
    ZADDITIONALASSETATTRIBUTES.ZEXIFTIMESTAMPSTRING AS 'EXIFTimeStamp(DeviceTime)',

    CASE ZASSET.ZSYNDICATIONSTATE
        WHEN 0 THEN '0-Received-SWY_Synd_Asset'
        WHEN 1 THEN '1-Sent-SWY_Synd_Asset'
        WHEN 2 THEN '2-Manually-Saved_SWY_Synd_Asset'
        WHEN 3 THEN '3-STILLTESTING_Sent-SWY'
        WHEN 8 THEN '8-SWY_Linked_Asset_was_Visible_On-Device_User_Deleted_Link'
        WHEN 9 THEN '9-STILLTESTING_Sent_SWY'
        WHEN 10 THEN '10-Manually-Saved_SWY_Synd_Asset_User_Deleted_From_LPL'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZSYNDICATIONSTATE || ''
    END AS 'ZASSET-SyndicationState',

    datetime(ZADDITIONALASSETATTRIBUTES.ZSCENEANALYSISTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'SceneAnalysisTimeStamp(UTC)',

    datetime(ZASSET.ZANALYSISSTATEMODIFICATIONDATE + 978307200, 'UNIXEPOCH') AS 'AnalysisStateModificationDate(UTC)',

    -- CASE ZASSET.ZHASADJUSTMENTS
    --     WHEN 0 THEN 'No'
    --     WHEN 1 THEN 'Yes'
    --     ELSE ZASSET.ZHASADJUSTMENTS
    -- END AS 'HasAdjustments',

    datetime(ZASSET.ZADJUSTMENTTIMESTAMP + 978307200, 'UNIXEPOCH')  AS 'AdjustmentsTimeStamp(UTC)',

    CASE
        WHEN ZGENERICALBUM.ZTITLE IS NULL THEN 'n/a'
        ELSE ZGENERICALBUM.ZTITLE
    END AS 'AlbumTitle',

    --ZADDITIONALASSETATTRIBUTES.ZCREATORBUNDLEID AS 'Creator Bundle ID',
    ZADDITIONALASSETATTRIBUTES.ZIMPORTEDBYBUNDLEIDENTIFIER AS 'ImportedByBundleID',
    /*
    This column can correlate to the `guid` column in the `message` table of the
    sms.db file.  This can tell what message a given image was associated with.
    The ZSYNDICATIONIDENTIFIER will have the following format:
      at_0_B2F67B26-592F-4551-8D0C-9CFBC15653F4
      --"at" indicates the item\asset is from within Apple Messages application
        or was an attachment to a message.
    The first number between the underscores indicates how many images were sent
    as part of that message -- counting begins at "0" -- so, in the example above,
    one (1) image was sent with this message (if the number were "1", that would
    indicate that two files were attached to the message).  The ID formatted as:
    8-4-4-4-12 is the message GUID from the sms.db file.
    */
    ZADDITIONALASSETATTRIBUTES.ZSYNDICATIONIDENTIFIER AS 'SyndicationIdentifier',

    CASE
        WHEN ZADDITIONALASSETATTRIBUTES.ZEDITORBUNDLEID IS NULL THEN 'n/a'
        ELSE ZADDITIONALASSETATTRIBUTES.ZEDITORBUNDLEID
    END AS 'EditorBundleID',

    ZASSET.ZDIRECTORY AS 'Directory',

    CASE ZASSET.ZSAVEDASSETTYPE
        WHEN 0 THEN '0-Saved-via-other-source'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-SWY-Syndicaion-PL-Asset_NoAuto-Display_In_LPL'
        WHEN 4 THEN '4-Photo-Cloud-Sharing-Data-Asset'
        WHEN 5 THEN '5-StillTesting'
        WHEN 6 THEN '6-Cloud-Photo-Library-Asset'
        WHEN 7 THEN '7-StillTesting'
        WHEN 8 THEN '8-iCloudLink_CloudMasterMomentAsset'
        WHEN 12 THEN '12-SWY-Syndicaion-PL-Asset_Auto-Display_In_LPL'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZSAVEDASSETTYPE || ''
    END AS 'SavedAssetType',

    CASE
        WHEN ZASSET.ZFACEAREAPOINTS > 0 THEN 'Yes'
        ELSE 'n/a (' || ZASSET.ZFACEAREAPOINTS || ')'
    END AS 'FaceDetectedinPhoto',

    ZPERSON.ZDISPLAYNAME AS 'DisplayName',
    ZPERSON.ZFULLNAME AS 'FullName',
    ZPERSON.ZFACECOUNT AS 'FaceCount',
    ZDETECTEDFACE.ZPERSONFORFACE AS 'Person',
    ZPERSON.ZCONTACTMATCHINGDICTIONARY AS 'ContactBlob',
    ZPERSON.ZPERSONUUID AS 'PersonUUID',
    ZDETECTEDFACE.ZQUALITYMEASURE AS 'DetectedFaceQuality',

    CASE ZDETECTEDFACE.ZAGETYPE
        WHEN 1 THEN 'Baby/Toddler'
        WHEN 2 THEN 'Baby/Toddler'
        WHEN 3 THEN 'Child/YoungAdult'
        WHEN 4 THEN 'YoungAdult/Adult'
        WHEN 5 THEN 'Adult'
        ELSE ZDETECTEDFACE.ZAGETYPE
    END AS 'AgeTypeEstimate',

    CASE ZDETECTEDFACE.ZGENDERTYPE
        WHEN 1 THEN 'Male'
        WHEN 2 THEN 'Female'
        ELSE ZDETECTEDFACE.ZGENDERTYPE
    END AS 'Gender',

    CASE ZDETECTEDFACE.ZGLASSESTYPE
        WHEN 1 THEN 'Eye'
        WHEN 2 THEN 'Sun'
        WHEN 3 THEN 'None'
        ELSE ZDETECTEDFACE.ZGLASSESTYPE
    END AS 'GlassesType',

    CASE ZDETECTEDFACE.ZFACIALHAIRTYPE
        WHEN 1 THEN 'None'
        WHEN 2 THEN 'Beard/Mustache'
        WHEN 3 THEN 'Goatee'
        WHEN 5 THEN 'Stubble'
        ELSE ZDETECTEDFACE.ZFACIALHAIRTYPE
    END AS 'FacialHairType',

    CASE ZDETECTEDFACE.ZHAIRTYPE
        WHEN 2 THEN 'Bald'
        WHEN 3 THEN 'NotBald'
        ELSE ZDETECTEDFACE.ZHAIRTYPE
    END AS 'Baldness',

    ZASSET.ZORIGINALCOLORSPACE AS 'ColorSpace',
    ZASSET.Zduration AS 'Duration(sec)',
    ZASSET.Zvideocpdurationvalue AS 'VideoDuration',

    CASE ZASSET.ZCOMPLETE
        WHEN 1 THEN 'Yes'
        ELSE 'ContactExaminer'
    END AS 'Complete',

    CASE ZASSET.ZVISIBILITYSTATE
        WHEN 0 THEN 'Visible'
        WHEN 1 THEN 'PhotoStreamsData'
        WHEN 2 THEN 'Burst'
        ELSE ZASSET.ZVISIBILITYSTATE
    END AS 'VisibilityState',

    CASE ZASSET.ZFAVORITE
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE ZASSET.ZFAVORITE
    END AS 'Favorite',

    CASE ZASSET.zhidden
        WHEN 0 THEN 'NotHidden'
        WHEN 1 THEN 'FileHidden'
        ELSE ZASSET.zhidden
    END AS 'HiddenFile',

    CASE ZASSET.ZTRASHEDSTATE
        WHEN 1 THEN 'InTrash'
        WHEN 0 THEN 'NotInTrash'
        ELSE ZASSET.ZTRASHEDSTATE
    END AS 'TrashState',

    CASE
        WHEN ZASSET.ZTRASHEDDATE IS NULL THEN 'n/a'
        ELSE datetime(ZASSET.ZTRASHEDDATE + 978307200, 'UNIXEPOCH')
    END AS 'FileTrashDate(UTC)',

    ZADDITIONALASSETATTRIBUTES.ZVIEWCOUNT AS 'ViewCount',
    ZADDITIONALASSETATTRIBUTES.ZPLAYCOUNT AS 'PlayCount',
    ZADDITIONALASSETATTRIBUTES.ZSHARECOUNT AS 'ShareCount',

    datetime(ZASSET.ZLASTSHAREDDATE + 978307200, 'UNIXEPOCH') AS 'LastSharedDate(UTC)',

    printf("%,d", ZADDITIONALASSETATTRIBUTES.ZORIGINALFILESIZE) AS 'OriginalFileSize(bytes)',
    ZASSET.ZHEIGHT AS 'FileHeight',
    ZADDITIONALASSETATTRIBUTES.ZORIGINALHEIGHT AS 'OriginalFileHeight',
    ZASSET.ZWIDTH AS 'FileWidth',
    ZADDITIONALASSETATTRIBUTES.ZORIGINALWIDTH AS 'OriginalFileWidth',
    ZADDITIONALASSETATTRIBUTES.ZCAMERACAPTUREDEVICE AS 'CameraCaptureDevice',

    CASE ZASSET.ZORIENTATION
        WHEN 1 THEN 'Horizontal (Left)'
        WHEN 3 THEN 'Horizontal (Right)'
        WHEN 6 THEN 'Vertical (Up)'
        WHEN 8 THEN 'Vertical (Down)'
        ELSE ZASSET.ZORIENTATION
    END AS 'Orientation',

    CASE ZADDITIONALASSETATTRIBUTES.ZORIGINALORIENTATION
        WHEN 1 THEN 'Horizontal(Left)'
        WHEN 3 THEN 'Horizontal(Right)'
        WHEN 6 THEN 'Vertical(Up)'
        WHEN 8 THEN 'Vertical(Down)'
        ELSE ZASSET.ZORIENTATION
    END AS 'OriginalOrientation',

    ZADDITIONALASSETATTRIBUTES.ZTIMEZONENAME AS 'TimeZoneName',
    ZADDITIONALASSETATTRIBUTES.ZTIMEZONEOFFSET AS 'TimeZoneOffset',
    ZADDITIONALASSETATTRIBUTES.ZINFERREDTIMEZONEOFFSET AS 'InferredTimeZoneOffset',
    ZASSET.ZLOCATIONDATA AS 'FileLocationData',

    CASE ZASSET.ZLATITUDE
        WHEN -180.0 THEN 'n/a'
        ELSE ZASSET.ZLATITUDE
    END 'Latitude',

    CASE ZASSET.ZLONGITUDE
        WHEN -180.0 THEN 'n/a'
        ELSE ZASSET.ZLONGITUDE
    END 'Longitude',

    CASE ZADDITIONALASSETATTRIBUTES.ZSHIFTEDLOCATIONISVALID
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE ZADDITIONALASSETATTRIBUTES.ZSHIFTEDLOCATIONISVALID
    END AS 'ShiftedLocationValid',

    CASE ZADDITIONALASSETATTRIBUTES.ZREVERSELOCATIONDATAISVALID
        WHEN 0 THEN 'No'
        WHEN 1 THEN 'Yes'
        ELSE ZADDITIONALASSETATTRIBUTES.ZREVERSELOCATIONDATAISVALID
    END AS 'ReverseLocationDataIsValid',

    ZADDITIONALASSETATTRIBUTES.ZREVERSELOCATIONDATA AS 'OrgFileReverseLocationData',
    ZASSET.ZTHUMBNAILINDEX AS 'ThumbnailIndex',
    ZADDITIONALASSETATTRIBUTES.ZEMBEDDEDTHUMBNAILWIDTH AS 'EmbeddedThumbnailWidth',
    ZADDITIONALASSETATTRIBUTES.ZEMBEDDEDTHUMBNAILHEIGHT AS 'EmbeddedThumbnailHeight',
    ZADDITIONALASSETATTRIBUTES.ZEMBEDDEDTHUMBNAILOFFSET AS 'EmbeddedThumbnailOffset',
    ZADDITIONALASSETATTRIBUTES.ZEMBEDDEDTHUMBNAILLENGTH AS 'EmbeddedThumbnailLength',
    ZASSET.ZMOMENT AS 'MomentPK',
    ZMOMENT.ZTITLE AS 'MomentTitle',

    datetime(ZMOMENT.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'MomentStartDate(UTC)',
    datetime(ZMOMENT.Zrepresentativedate + 978307200, 'UNIXEPOCH') AS 'MomentRepresentativeDate(UTC)',
    datetime(ZMOMENT.ZMODIFICATIONDATE + 978307200, 'UNIXEPOCH') AS 'MomentModificationDate(UTC)',
    datetime(ZMOMENT.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'MomentEndDate(UTC)',

    CASE ZMOMENT.ZAPPROXIMATELATITUDE
        WHEN -180.0 THEN 'n/a'
        ELSE ZMOMENT.ZAPPROXIMATELATITUDE
    END AS 'MomentApproxLatitude',

    CASE ZMOMENT.ZAPPROXIMATELONGITUDE
        WHEN -180.0 THEN 'n/a'
        ELSE ZMOMENT.ZAPPROXIMATELONGITUDE
    END AS 'MomentApproxLongitude',

    ZASSET.ZUUID AS 'UUID',
    ZASSET.ZMEDIAGROUPUUID AS 'MediaGroupUUID',
    ZASSET.ZCLOUDASSETGUID AS 'CloudAssetGUID',
    ZADDITIONALASSETATTRIBUTES.ZPUBLICGLOBALUUID AS 'PublicGlobalUUID',
    -- ZADDITIONALASSETATTRIBUTES.ZMASTERFINGERPRINT AS 'MasterFingerprint',
    -- ZADDITIONALASSETATTRIBUTES.ZADJUSTEDFINGERPRINT AS 'AdjustedFingerprint',

     /* Source for each line of data */
    '/private/var/mobile/Library/Photos/Libraries/Syndication.photoslibrary/database/Photos.sqlite; ZASSET(Z_PK:' || ZASSET.Z_PK || ')' AS 'Data Source'


FROM ZASSET
    LEFT JOIN ZMOMENT ON
        ZASSET.ZMOMENT = ZMOMENT.Z_PK
    JOIN ZADDITIONALASSETATTRIBUTES ON
        ZASSET.ZADDITIONALATTRIBUTES = ZADDITIONALASSETATTRIBUTES.Z_PK
    LEFT JOIN ZDETECTEDFACE ON
        ZADDITIONALASSETATTRIBUTES.ZASSET = ZDETECTEDFACE.ZASSETFORFACE
    LEFT JOIN ZPERSON ON
        ZPERSON.Z_PK = ZDETECTEDFACE.ZPERSONFORFACE
    LEFT JOIN Z_30ASSETS ON
        ZASSET.Z_PK = Z_30ASSETS.Z_3ASSETS
    LEFT JOIN ZGENERICALBUM ON
        ZGENERICALBUM.Z_PK = Z_30ASSETS.Z_30ALBUMS


--WHERE ZADDITIONALASSETATTRIBUTES.ZIMPORTEDBYBUNDLEIDENTIFIER IS 'com.apple.FileProvider.LocalStorage'


ORDER BY ZASSET.Z_PK ASC