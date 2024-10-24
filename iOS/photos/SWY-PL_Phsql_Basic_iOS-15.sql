/*
Query copied from https://github.com/ScottKjr3347/iOS_SWY_PL_Photos.sqlite_Queries/blob/main/iOS15/iOS15_SWY-PL_Phsql_Basic.txt
*/

SELECT

    ROW_NUMBER() OVER() AS 'RecordNo.',
    zAsset.ZSORTTOKEN AS 'zAsset.SortToken',
    zAsset.ZPROMOTIONSCORE AS 'zAsset.PromotionScore',

    CASE zAsset.ZCOMPLETE
        WHEN 1 THEN "Yes"
        ELSE zAsset.ZCOMPLETE
    END AS 'zAsset.Complete',

    zAsset.Z_PK AS 'zAsset.Z_PK',
    zAddAssetAttr.Z_PK AS 'zAddAssetAttr.Z_PK',
    zCldMast.Z_PK AS 'zCldMast.Z_PK',
    zAsset.ZMASTER AS 'zAsset.ZMASTER',
    zAsset.ZEXTENDEDATTRIBUTES AS 'zAsset.ExtendedAttributes',
    zExtAttr.Z_PK AS 'zExtAttr.Z_PK',
    CMzCldMastMedData.ZCLOUDMASTER AS 'CMzCldMastMedData.ZCldMaster',
    zCldMast.ZMEDIAMETADATA AS 'zCldMast.ZMediaMetadata',
    CMzCldMastMedData.Z_PK AS 'CMzCldMastMedData.Z_PK',
    CMzCldMastMedData.Z_ENT AS 'CMzCldMastMedData.Z_ENT',
    zAsset.ZUUID AS 'zAsset-UUID',
    zAsset.ZCLOUDASSETGUID AS 'zAsset.ZCloudAssetGUID',
    zAsset.ZCLOUDCOLLECTIONGUID AS 'zAsset.ZCloudCollectionGUID',
    zCldMast.ZCLOUDMASTERGUID AS 'zCldMast.ZCloudMasterGUID',
    zGenAlbum.ZCLOUDGUID AS 'zGenAlbum.ZCloudGUID',
    zShare.ZSCOPEIDENTIFIER AS 'zShare.ZScopeID',
    zAddAssetAttr.ZORIGINALASSETSUUID AS 'zAddAssetAttr.ZOriginalAssetsUUID',
    zAddAssetAttr.ZPUBLICGLOBALUUID AS 'zAddAssetAttr.ZPublicGlobalUUID',
    zAddAssetAttr.ZMASTERFINGERPRINT AS 'zAddAssetAttr.ZMasterFingerprint',
    zAddAssetAttr.ZORIGINATINGASSETIDENTIFIER AS 'zAddAssetAttr.ZOriginatingAssetIdentifier',
    zCldMast.ZORIGINATINGASSETIDENTIFIER AS 'zCldMast.ZOriginatingAssetID',
    zIntResou.ZFINGERPRINT AS 'zIntResou.ZFingerprint',
    zAddAssetAttr.ZADJUSTEDFINGERPRINT AS 'zAddAssetAttr.ZAdjustedFingerprint',
    zUnmAdj.ZOTHERADJUSTMENTSFINGERPRINT AS 'zUnmAdj.ZOtherAdjustmentsFingerprint',
    zUnmAdj.ZSIMILARTOORIGINALADJUSTMENTSFINGERPRINT AS 'zUnmAdj.ZSimilarToOriginalAdjustmentsFingerprint',
    
    CASE ParentzGenAlbum.ZCLOUDLOCALSTATE
        WHEN 0 THEN '0-iCldPhotosON=AssetInShared/Other-Album/iCldPhotos-OFF=GenericAlbum'
        WHEN 1 THEN '1-iCldPhotos-ON=AssetInGenericAlbum'
        ELSE 'UnknownValue: ' || ParentzGenAlbum.ZCLOUDLOCALSTATE || ''
    END AS 'ParentzGenAlbum.ZCloudLocalState',

    ParentzGenAlbum.ZTITLE AS 'ParentzGenAlbum.ZTitle',
    datetime(ParentzGenAlbum.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'ParentzGenAlbum.ZCreationDate(UTC)',
    datetime(zGenAlbum.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'zGenAlbum.ZCreationDate(UTC)',
    
    CASE zGenAlbum.ZCLOUDLOCALSTATE
        WHEN 0 THEN '0-iCldPhotos-ON=Asset_In_Shared/Other-Album/iCldPhotos-OFF=GenericAlbum'
        WHEN 1 THEN '1-iCldPhotos-ON=AssetInGenericAlbum'
        ELSE 'UnknownValue: ' || zGenAlbum.ZCLOUDLOCALSTATE || ''
    END AS 'zGenAlbum.ZCloudLocalState',

    zGenAlbum.ZTITLE AS 'zGenAlbum.ZTitle',

    CASE zAsset.ZBUNDLESCOPE
        WHEN 0 THEN '0-iCldPhotos-ON=NotInSharedAlbum_iCldPhotos-OFF=OnLocalDevice'
        WHEN 1 THEN '1-SWYSyndicationCMMAsset'
        WHEN 2 THEN '2-iCldPhotos-ON=AssetInCloudSharedAlbum'
        WHEN 3 THEN '3-iCldPhotos-ON=SWYSyndicationAsset'
        ELSE 'UnknownValue: ' || zAsset.ZBUNDLESCOPE || ''
    END AS 'zAsset.ZBundleScope',

    CASE zAsset.ZCLOUDISMYASSET
        WHEN 0 THEN '0-NotMyAssetInSharedAlbum'
        WHEN 1 THEN '1-MyAssetInSharedAlbum'
        ELSE 'UnknownValue: ' || zAsset.ZCLOUDISMYASSET || ''
    END AS 'zAsset.ZCloudIsMyAsset',

    CASE zAsset.ZCLOUDISDELETABLE
        WHEN 0 THEN '0-No'
        WHEN 1 THEN '1-Yes'
        ELSE 'UnknownValue: ' || zAsset.ZCLOUDISDELETABLE || ''
    END AS 'zAsset.ZCloudIsDeletable',

    CASE zAsset.ZCLOUDLOCALSTATE
        WHEN 0 THEN 'iCldPhotos ON=Asset In Shared-Other Album/iCldPhotos OFF=Not Synced'
        WHEN 1 THEN 'iCldPhotos ON=Asset Synced with iCloud'
        ELSE 'UnknownValue!: ' || zAsset.ZCLOUDLOCALSTATE || ''
    END AS 'zAsset.ZCloudLocalState',

    CASE zAsset.ZVISIBILITYSTATE
        WHEN 0 THEN '0-VisiblePhotoLibrary'
        WHEN 2 THEN '2-NotVisiblePhotoLibrary'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZVISIBILITYSTATE || ''
    END AS 'zAsset.ZVisibilityState',

    zExtAttr.ZCAMERAMAKE AS 'zExtAttr.ZCAMERAMAKE',
    zExtAttr.ZCAMERAMODEL AS 'zExtAttr.ZCAMERAMODEL',
    zExtAttr.ZLENSMODEL AS 'zExtAttr.ZLENSMODEL',

    CASE zExtAttr.ZFLASHFIRED
        WHEN 0 THEN '0-NoFlash'
        WHEN 1 THEN '1-FlashFired'
        ELSE 'UnknownValue!: ' || zExtAttr.ZFLASHFIRED || ''
    END AS 'zExtAttr.ZFLASHFIRED',

    zExtAttr.ZFOCALLENGTH AS 'zExtAttr.ZFocalLength',
    zExtAttr.ZFOCALLENGTHIN35MM AS 'zExtAttr.ZFocalLengthIn35MM',
    zExtAttr.ZDIGITALZOOMRATIO AS 'zExtAttr.ZDigitalZoomRatio',

    CASE zAsset.ZDERIVEDCAMERACAPTUREDEVICE
        WHEN 0 THEN '0-BackCamera/Other'
        WHEN 1 THEN '1-FrontCamera'
        ELSE 'UnknownValue!: ' || zAsset.ZDERIVEDCAMERACAPTUREDEVICE || ''
    END AS 'zAsset.ZDerivedCameraCaptureDevice',

    CASE zAddAssetAttr.ZCAMERACAPTUREDEVICE
        WHEN 0 THEN '0-BackCamera/Other'
        WHEN 1 THEN '1-FrontCamera'
        ELSE 'UnknownValue!: ' || zAddAssetAttr.ZCAMERACAPTUREDEVICE || ''
    END AS 'zAddAssetAttr.ZCameraCaptureDevice',

    CASE zAddAssetAttr.ZIMPORTEDBY
        WHEN 0 THEN '0-CloudOther'
        WHEN 1 THEN '1-NativeBackCamera'
        WHEN 2 THEN '2-NativeFrontCamera'
        WHEN 3 THEN '3-ThirdPartyApp'
        WHEN 4 THEN '4-StillTesting'
        WHEN 5 THEN '5-PhotoBoothPLAsset'
        WHEN 6 THEN '6-ThirdPartyApp'
        WHEN 7 THEN '7-iCloudShareLinkCMMAsset'
        WHEN 8 THEN '8-SystemPackageApp'
        WHEN 9 THEN '9-NativeApp'
        WHEN 10 THEN '10-StillTesting'
        WHEN 11 THEN '11-StillTesting'
        WHEN 12 THEN '12-SWYSyndicationPL'
        ELSE 'Unknown-New-Value!: ' || zAddAssetAttr.ZIMPORTEDBY || ''
    END AS 'zAddAssetAttr.ZImportedBy',

    CASE zCldMast.ZIMPORTEDBY
        WHEN 0 THEN '0-CloudOther'
        WHEN 1 THEN '1-NativeBackCamera'
        WHEN 2 THEN '2-NativeFrontCamera'
        WHEN 3 THEN '3-ThirdPartyApp'
        WHEN 4 THEN '4-StillTesting'
        WHEN 5 THEN '5-PhotoBoothPLAsset'
        WHEN 6 THEN '6-ThirdPartyApp'
        WHEN 7 THEN '7-iCloudShareLinkCMMAsset'
        WHEN 8 THEN '8-SystemPackageApp'
        WHEN 9 THEN '9-NativeApp'
        WHEN 10 THEN '10-StillTesting'
        WHEN 11 THEN '11-StillTesting'
        WHEN 12 THEN '12-SWYSyndicationPL'
        ELSE 'Unknown-New-Value!: ' || zCldMast.ZIMPORTEDBY || ''
    END AS 'zCldMast.ZIMPORTEDBY',

    zAddAssetAttr.ZIMPORTEDBYBUNDLEIDENTIFIER AS 'zAddAssetAttr.Imported by Bundle Identifier',
    zAddAssetAttr.ZIMPORTEDBYDISPLAYNAME AS 'zAddAssetAttr-Imported By Display Name',
    zCldMast.ZIMPORTEDBYBUNDLEIDENTIFIER AS 'zCldMast-Imported by Bundle ID',
    zCldMast.ZIMPORTEDBYDISPLAYNAME AS 'zCldMast-Imported by Display Name',
    zAsset.ZIMAGEREQUESTHINTS AS 'zAsset-ImageRequestHints/HEX-Path',

    CASE zAsset.ZSAVEDASSETTYPE
        WHEN 0 THEN '0-Saved-via-other-source-0'
        WHEN 1 THEN '1-StillTesting-1'
        WHEN 2 THEN '2-StillTesting-2'
        WHEN 3 THEN '3-Local-Photo-Library-Asset-3'
        WHEN 4 THEN '4-Photo-Cloud-Sharing-Data-Asset-4'
        WHEN 5 THEN '5-PhotoBooth_Photo-Library-Asset-5'
        WHEN 6 THEN '6-Cloud-Photo-Library-Asset-6'
        WHEN 7 THEN '7-StillTesting-7'
        WHEN 8 THEN '8-iCloudLink_CloudMasterMomentAsset-8'
        WHEN 12 THEN '12-SWY-Syndication-PL-Asset/Auto-Displayed_in_LPL-12'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZSAVEDASSETTYPE || ''
    END AS 'zAsset-Saved Asset Type-LPL',

    CASE zAsset.ZSAVEDASSETTYPE
        WHEN 0 THEN '0-Saved-via-other-source-0'
        WHEN 1 THEN '1-StillTesting-1'
        WHEN 2 THEN '2-StillTesting-2'
        WHEN 3 THEN '3-SWY-Syndicaion-PL-Asset_Not_In_Local_PL-3'
        WHEN 4 THEN '4-Photo-Cloud-Sharing-Data-Asset-4'
        WHEN 5 THEN '5-StillTesting-5'
        WHEN 6 THEN '6-Cloud-Photo-Library-Asset-6'
        WHEN 7 THEN '7-StillTesting-7'
        WHEN 8 THEN '8-iCloudLink_CloudMasterMomentAsset-8'
        WHEN 12 THEN '12-SWY-Syndicaion-PL-Asset_In_Local_PL-12'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZSAVEDASSETTYPE || ''
    END AS 'zAsset-Saved Asset Type-SWYPL',

    zAsset.ZDIRECTORY AS 'zAsset-Directory/Path',
    zAsset.ZFILENAME AS 'zAsset-Filename',
    zAddAssetAttr.ZORIGINALFILENAME AS 'zAddAssetAttr-Original Filename',
    zCldMast.ZORIGINALFILENAME AS 'zCldMast-Orig Filename',
    zAddAssetAttr.ZSYNDICATIONIDENTIFIER AS 'zAddAssetAttr-Syndication Identifier',
    
    CASE zAsset.ZSYNDICATIONSTATE
        WHEN 0 THEN '0-Local-PL_Asset_Syndication_State_NA-0'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZSYNDICATIONSTATE || ''
    END AS 'zAsset-Syndication State-LPL',

    CASE zAsset.ZSYNDICATIONSTATE
        WHEN 0 THEN '0-Received-SWY_Synd_Asset-0'
        WHEN 1 THEN '1-Sent-SWY_Synd_Asset-1'
        WHEN 2 THEN '2-Manually-Saved_SWY_Synd_Asset-2'
        WHEN 8 THEN '8-SWY_Linked_Asset_was_Visible_On-Device_User_Deleted_Link-8'
        WHEN 10 THEN '10-Manually-Saved_SWY_Synd_Asset_User_Deleted_From_LPL-10'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZSYNDICATIONSTATE || ''
    END AS 'zAsset-Syndication State-SWYPL',

    zAddAssetAttr.ZSYNDICATIONHISTORY AS 'zAddAssetAttr-Syndication History',
    zMedAnlyAstAttr.ZSYNDICATIONPROCESSINGVERSION AS 'zMedAnlyAstAttr-Syndication Processing Version',
    
    CASE zMedAnlyAstAttr.ZSYNDICATIONPROCESSINGVALUE
        WHEN 0 THEN '0-NA-0'
        WHEN 1 THEN '1-STILLTESTING_Wide-Camera_JPG-1'
        WHEN 2 THEN '2-STILLTESTING_Telephoto_Camear_Lens-2'
        WHEN 4 THEN '4-STILLTESTING_SWY_Asset_OrigAssetImport_SystemPackageApp-4'
        WHEN 16 THEN '16-STILLTESTING-16'
        WHEN 1024 THEN '1024-STILLTESTING_SWY_Asset_OrigAssetImport_NativeCamera-1024'
        WHEN 2048 THEN '2048-STILLTESTING-2048'
        WHEN 4096 THEN '4096-STILLTESTING_SWY_Asset_Manually_Saved-4096'
        ELSE 'Unknown-New-Value!: ' || zMedAnlyAstAttr.ZSYNDICATIONPROCESSINGVALUE || ''
    END AS 'zMedAnlyAstAttr-Syndication Processing Value',

    datetime(zAsset.ZADDEDDATE + 978307200, 'UNIXEPOCH') AS 'zAsset-Add Date',

    CASE zAddAssetAttr.ZDATECREATEDSOURCE
        WHEN 0 THEN '0-Cloud-Asset-0'
        WHEN 1 THEN '1-Local_Asset_EXIF-1'
        WHEN 3 THEN '3-Local_Asset_No_EXIF-3'
        ELSE 'Unknown-New-Value!: ' || zAddAssetAttr.ZDATECREATEDSOURCE || ''
    END AS 'zAddAssetAttr-Date Created Source',

    datetime(zAsset.ZDATECREATED + 978307200, 'UNIXEPOCH') AS 'zAsset-Date Created',
    datetime(zCldMast.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'zCldMast-Creation Date',
    datetime(zIntResou.ZCLOUDMASTERDATECREATED + 978307200, 'UNIXEPOCH') AS 'zIntResou-CldMst Date Created',
    zAddAssetAttr.ZTIMEZONENAME AS 'zAddAssetAttr-Time Zone Name',
    zAddAssetAttr.ZTIMEZONEOFFSET AS 'zAddAssetAttr-Time Zone Offset',
    zAddAssetAttr.ZINFERREDTIMEZONEOFFSET AS 'zAddAssetAttr-Inferred Time Zone Offset',
    zAddAssetAttr.ZEXIFTIMESTAMPSTRING AS 'zAddAssetAttr-EXIF-String',
    datetime(zAsset.ZMODIFICATIONDATE + 978307200, 'UNIXEPOCH') AS 'zAsset-Modification Date',
    
    CASE zCldMast.ZCLOUDLOCALSTATE
        WHEN 0 THEN '0-Not Synced with Cloud-0'
        WHEN 1 THEN '1-Pending Upload-1'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-Synced with Cloud-3'
        ELSE 'Unknown-New-Value!: ' || zCldMast.ZCLOUDLOCALSTATE || ''
    END AS 'zCldMast-Cloud Local State',

    datetime(zCldMast.ZIMPORTDATE + 978307200, 'UNIXEPOCH') AS 'zCldMast-Import Date',
    zAsset.ZIMPORTSESSION AS 'zAsset-Import Session',
    zAddAssetAttr.ZIMPORTSESSIONID AS 'zAddAssetAttr-Import Session ID',
    datetime(zAddAssetAttr.ZALTERNATEIMPORTIMAGEDATE + 978307200, 'UNIXEPOCH') AS 'zAddAssetAttr-Alt Import Image Date',
    zCldMast.ZIMPORTSESSIONID AS 'zCldMast-Import Session ID',
    datetime(zAsset.ZCLOUDBATCHPUBLISHDATE + 978307200, 'UNIXEPOCH') AS 'zAsset-Cloud Batch Publish Date',
    datetime(zAsset.ZCLOUDSERVERPUBLISHDATE + 978307200, 'UNIXEPOCH') AS 'zAsset-Cloud Server Publish Date',
    zAsset.ZCLOUDDOWNLOADREQUESTS AS 'zAsset-Cloud Download Requests',
    zAsset.ZCLOUDBATCHID AS 'zAsset-Cloud Batch ID',
    datetime(zAddAssetAttr.ZLASTUPLOADATTEMPTDATE + 978307200, 'UNIXEPOCH') AS 'zAddAssetAttr-Last Upload Attempt Date-SWY',
    zAddAssetAttr.ZUPLOADATTEMPTS AS 'zAddAssetAttr-Upload Attempts',
    
    CASE zAsset.ZLATITUDE
        WHEN -180.0 THEN '-180.0'
        ELSE zAsset.ZLATITUDE
    END AS 'zAsset-Latitude',

    zExtAttr.ZLATITUDE AS 'zExtAttr-Latitude',

    CASE zAsset.ZLONGITUDE
        WHEN -180.0 THEN '-180.0'
        ELSE zAsset.ZLONGITUDE
    END AS 'zAsset-Longitude',

    zExtAttr.ZLONGITUDE AS 'zExtAttr-Longitude',

    CASE zAddAssetAttr.ZGPSHORIZONTALACCURACY
        WHEN -1.0 THEN '-1.0'
        ELSE zAddAssetAttr.ZGPSHORIZONTALACCURACY
    END AS 'zAddAssetAttr-GPS Horizontal Accuracy',

    zAsset.ZLOCATIONDATA AS 'zAsset-Location Data/HEX',
    zAddAssetAttr.ZREVERSELOCATIONDATA AS 'zAddAssetAttr-Reverse Location Data/Orig-Asset/HEX NSKeyed Plist',
    
    CASE zAddAssetAttr.ZSHIFTEDLOCATIONISVALID
        WHEN 0 THEN '0-Shifted Location Not Valid-0'
        WHEN 1 THEN '1-Shifted Location Valid-1'
    END AS 'zAddAssetAttr-Shifted Location Valid',

    zAddAssetAttr.ZSHIFTEDLOCATIONDATA AS 'zAddAssetAttr-Shifted Location Data',
    zAddAssetAttr.ZLOCATIONHASH AS 'zAddAssetAttr-Location Hash',

    CASE AAAzCldMastMedData.Z_OPT
        WHEN 1 THEN '1-StillTesting-Cloud-1'
        WHEN 2 THEN '2-StillTesting-This Device-2'
        WHEN 3 THEN '3-StillTesting-Muted-3'
        WHEN 4 THEN '4-StillTesting-Unknown-4'
        WHEN 5 THEN '5-StillTesting-Unknown-5'
        ELSE 'Unknown-New-Value!: ' || AAAzCldMastMedData.Z_OPT || ''
    END AS 'AAAzCldMastMedData-zOPT',

    zAddAssetAttr.ZMEDIAMETADATATYPE AS 'zAddAssetAttr-Media Metadata Type',
    AAAzCldMastMedData.ZDATA AS 'AAAzCldMastMedData-Data/HEX',

    CASE CMzCldMastMedData.Z_OPT
        WHEN 1 THEN '1-StillTesting-Has_CldMastAsset-1'
        WHEN 2 THEN '2-StillTesting-Local_Asset-2'
        WHEN 3 THEN '3-StillTesting-Muted-3'
        WHEN 4 THEN '4-StillTesting-Unknown-4'
        WHEN 5 THEN '5-StillTesting-Unknown-5'
        ELSE 'Unknown-New-Value!: ' || CMzCldMastMedData.Z_OPT || ''
    END AS 'CldMasterzCldMastMedData-zOPT',

    zCldMast.ZMEDIAMETADATATYPE AS 'zCldMast-Media Metadata Type',
    CMzCldMastMedData.ZDATA AS 'CMzCldMastMedData-Data/HEX',

    CASE zAsset.ZORIENTATION
        WHEN 1 THEN '1-Video-Default/Adjustment/Horizontal-Camera-(left)-1'
        WHEN 2 THEN '2-Horizontal-Camera-(right)-2'
        WHEN 3 THEN '3-Horizontal-Camera-(right)-3'
        WHEN 4 THEN '4-Horizontal-Camera-(left)-4'
        WHEN 5 THEN '5-Vertical-Camera-(top)-5'
        WHEN 6 THEN '6-Vertical-Camera-(top)-6'
        WHEN 7 THEN '7-Vertical-Camera-(bottom)-7'
        WHEN 8 THEN '8-Vertical-Camera-(bottom)-8'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZORIENTATION || ''
    END AS 'zAsset-Orientation',

    CASE zAddAssetAttr.ZORIGINALORIENTATION
        WHEN 1 THEN '1-Video-Default/Adjustment/Horizontal-Camera-(left)-1'
        WHEN 2 THEN '2-Horizontal-Camera-(right)-2'
        WHEN 3 THEN '3-Horizontal-Camera-(right)-3'
        WHEN 4 THEN '4-Horizontal-Camera-(left)-4'
        WHEN 5 THEN '5-Vertical-Camera-(top)-5'
        WHEN 6 THEN '6-Vertical-Camera-(top)-6'
        WHEN 7 THEN '7-Vertical-Camera-(bottom)-7'
        WHEN 8 THEN '8-Vertical-Camera-(bottom)-8'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZORIENTATION || ''
    END AS 'zAddAssetAttr-Original Orientation',

    CASE zIntResou.ZORIENTATION
        WHEN 0 THEN '0-NA-0'
        WHEN 1 THEN '1-Video-Default/Adjustment/Horizontal-Camera-(left)-1'
        WHEN 2 THEN '2-Horizontal-Camera-(right)-2'
        WHEN 3 THEN '3-Horizontal-Camera-(right)-3'
        WHEN 4 THEN '4-Horizontal-Camera-(left)-4'
        WHEN 5 THEN '5-Vertical-Camera-(top)-5'
        WHEN 6 THEN '6-Vertical-Camera-(top)-6'
        WHEN 7 THEN '7-Vertical-Camera-(bottom)-7'
        WHEN 8 THEN '8-Vertical-Camera-(bottom)-8'
        ELSE 'Unknown-New-Value!: ' || zIntResou.ZORIENTATION || ''
    END AS 'zIntResou-Orientation',

    CASE zAsset.ZKIND
        WHEN 0 THEN '0-Photo-0'
        WHEN 1 THEN '1-Video-1'
    END AS 'zAsset-Kind',

    CASE zAsset.ZKINDSUBTYPE
        WHEN 0 THEN '0-Still-Photo-0'
        WHEN 2 THEN '2-Live-Photo-2'
        WHEN 10 THEN '10-SpringBoard-Screenshot-10'
        WHEN 100 THEN '100-Video-100'
        WHEN 101 THEN '101-Slow-Mo-Video-101'
        WHEN 102 THEN '102-Time-lapse-Video-102'
        WHEN 103 THEN '103-Replay_Screen_Recording-103'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZKINDSUBTYPE || ''
    END AS 'zAsset-Kind-Sub-Type',

    CASE zAddAssetAttr.ZCLOUDKINDSUBTYPE
        WHEN 0 THEN '0-Still-Photo-0'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-Live-Photo-2'
        WHEN 3 THEN '3-Screenshot-3'
        WHEN 10 THEN '10-SpringBoard-Screenshot-10'
        WHEN 100 THEN '100-Video-100'
        WHEN 101 THEN '101-Slow-Mo-Video-101'
        WHEN 102 THEN '102-Time-lapse-Video-102'
        WHEN 103 THEN '103-Replay_Screen_Recording-103'
        ELSE 'Unknown-New-Value!: ' || zAddAssetAttr.ZCLOUDKINDSUBTYPE || ''
    END AS 'zAddAssetAttr-Cloud Kind Sub Type',

    CASE zAsset.ZPLAYBACKSTYLE
        WHEN 1 THEN '1-Image-1'
        WHEN 2 THEN '2-Image-Animated-2'
        WHEN 3 THEN '3-Live-Photo-3'
        WHEN 4 THEN '4-Video-4'
        WHEN 5 THEN '5-Video-Looping-5'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZPLAYBACKSTYLE || ''
    END AS 'zAsset-Playback Style',

    zAsset.ZPLAYBACKVARIATION AS 'zAsset-Playback Variation',
    zAsset.ZDURATION AS 'zAsset-Video Duration',
    zExtAttr.ZDURATION AS 'zExtAttr-Duration',
    zAsset.ZVIDEOCPDURATIONVALUE AS 'zAsset-Video CP Duration',
    zAddAssetAttr.ZVIDEOCPDURATIONTIMESCALE AS 'zAddAssetAttr-Video CP Duration Time Scale',
    zAsset.ZVIDEOCPVISIBILITYSTATE AS 'zAsset-Video CP Visibility State',
    zAddAssetAttr.ZVIDEOCPDISPLAYVALUE AS 'zAddAssetAttr-Video CP Display Value',
    zAddAssetAttr.ZVIDEOCPDISPLAYTIMESCALE AS 'zAddAssetAttr-Video CP Display Time Scale',
    zIntResou.ZASSET AS 'zIntResou-Asset=zAsset.zPK',
    zIntResou.Z_PK AS 'zIntResou-zPK',
    zIntResou.Z_ENT AS 'zIntResou-zENT',
    zIntResou.Z_OPT AS 'zIntResou-zOPT',
    zIntResou.ZQUALITYSORTVALUE AS 'zIntResou-Quality Sort Value Key',
    
    CASE zIntResou.ZDATASTORECLASSID
        WHEN 0 THEN '0-LPL-Asset_CPL-Asset-0'
        WHEN 1 THEN '1-StillTesting-1'
        WHEN 2 THEN '2-Photo-Cloud-Sharing-Asset-2'
        WHEN 3 THEN '3-SWY_Syndication_Asset-3'
        ELSE 'Unknown-New-Value!: ' || zIntResou.ZDATASTORECLASSID || ''
    END AS 'zIntResou-Datastore Class ID',

    CASE zAsset.ZCLOUDPLACEHOLDERKIND
        WHEN 0 THEN '0-Local&CloudMaster Asset-0'
        WHEN 1 THEN '1-StillTesting-1'
        WHEN 2 THEN '2-StillTesting-2'
        WHEN 3 THEN '3-JPG-Asset_Only_PhDa/Thumb/V2-3'
        WHEN 4 THEN '4-LPL-JPG-Asset_CPL-Asset-HEIC-JPG-JPEG-MOV-PNG-4'
        WHEN 5 THEN '5-Asset_synced_via_iCloud_Photos_2_Device-5'
        WHEN 6 THEN '6-StillTesting-6'
        WHEN 7 THEN '7-LPL-poster-JPG-Asset_CPL-Asset-MP4-7'
        WHEN 8 THEN '8-LPL-JPG_Asset_CPL-Asset-LivePhoto-MOV-8'
        WHEN 9 THEN '9-CPL_MP4_Asset_Saved_2_LPL-9'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZCLOUDPLACEHOLDERKIND || ''
    END AS 'zAsset-Cloud Placeholder Kind',

    CASE zIntResou.ZLOCALAVAILABILITY
        WHEN -1 THEN '(-1)_IR_Asset_Not_Available_Local-Device(-1)'
        WHEN 1 THEN '1-IR_Asset_Available_Local-Device-1'
        WHEN -32768 THEN '(-32768)_IR_Asset-SWY-Linked_Asset(-32768)'
        ELSE 'Unknown-New-Value!: ' || zIntResou.ZLOCALAVAILABILITY || ''
    END AS 'zIntResou-Local Availability',

    CASE zIntResou.ZLOCALAVAILABILITYTARGET
        WHEN 0 THEN '0-StillTesting-0'
        ELSE 'Unknown-New-Value!: ' || zIntResou.ZLOCALAVAILABILITYTARGET || ''
    END AS 'zIntResou-Local Availability Target',

    CASE zIntResou.ZCLOUDLOCALSTATE
        WHEN 0 THEN '0-IR_Asset_Not_Synced_No_IR-CldMastDateCreated-0'
        WHEN 1 THEN '1-IR_Asset_Pening-Upload-1'
        WHEN 2 THEN '2-IR_Asset_Photo_Cloud_Share_Asset_On-Local-Device-2'
        WHEN 3 THEN '3-IR_Asset_Synced_iCloud-3'
        ELSE 'Unknown-New-Value!: ' || zIntResou.ZCLOUDLOCALSTATE || ''
    END AS 'zIntResou-Cloud Local State',

    CASE zIntResou.ZREMOTEAVAILABILITY
        WHEN 0 THEN '0-IR_Asset-Not-Available-Remotely-0'
        WHEN 1 THEN '1-IR_Asset_Available-Remotely-1'
        ELSE 'Unknown-New-Value!: ' || zIntResou.ZREMOTEAVAILABILITY || ''
    END AS 'zIntResou-Remote Availability',

    CASE zIntResou.ZREMOTEAVAILABILITYTARGET
        WHEN 0 THEN '0-StillTesting-0'
        WHEN 1 THEN '1-StillTesting-1'
        ELSE 'Unknown-New-Value!: ' || zIntResou.ZREMOTEAVAILABILITYTARGET || ''
    END AS 'zIntResou-Remote Availability Target',

    zIntResou.ZTRANSIENTCLOUDMASTER AS 'zIntResou-Transient Cloud Master',
    zIntResou.ZSIDECARINDEX AS 'zIntResou-Side Car Index',
    zIntResou.ZFILEID AS 'zIntResou-File ID',

    CASE zIntResou.ZVERSION
        WHEN 0 THEN '0-IR_Asset_Standard-0'
        WHEN 1 THEN '1-StillTesting-1'
        WHEN 2 THEN '2-IR_Asset_Adjustments-Mutation-2'
        WHEN 3 THEN '3-IR_Asset_No_ IR-CldMastDateCreated-3'
        ELSE 'Unknown-New-Value!: ' || zIntResou.ZVERSION || ''
    END AS 'zIntResou-Version',

    zAddAssetAttr.ZORIGINALFILESIZE AS 'zAddAssetAttr-Original File Size',
    
    CASE zIntResou.ZRESOURCETYPE
        WHEN 0 THEN '0-Photo-0'
        WHEN 1 THEN '1-Video-1'
        WHEN 3 THEN '3-Live-Photo-3'
        WHEN 5 THEN '5-Adjustement-Data-5'
        WHEN 6 THEN '6-Screenshot-6'
        WHEN 9 THEN '9-AlternatePhoto-3rdPartyApp-StillTesting-9'
        WHEN 13 THEN '13-Movie-13'
        WHEN 14 THEN '14-Wallpaper-14'
        ELSE 'Unknown-New-Value!: ' || zIntResou.ZRESOURCETYPE || ''
    END AS 'zIntResou-Resource Type',

    zIntResou.ZDATASTOREKEYDATA AS 'zIntResou-DataStoreKeyData/HEX',

    CASE zIntResou.ZDATASTORESUBTYPE
        WHEN 0 THEN '0-No Cloud Inter Resource-0'
        WHEN 1 THEN '1-Main-Asset-Orig-Size-1'
        WHEN 2 THEN '2-Photo-with-Adjustments-2'
        WHEN 3 THEN '3-JPG-Large-Thumb-3'
        WHEN 4 THEN '4-JPG-Med-Thumb-4'
        WHEN 5 THEN '5-JPG-Small-Thumb-5'
        WHEN 6 THEN '6-Video-Med-Data-6'
        WHEN 7 THEN '7-Video-Small-Data-7'
        WHEN 8 THEN '8-MP4-Cloud-Share-8'
        WHEN 9 THEN '9-StillTesting'
        WHEN 10 THEN '10-3rdPartyApp_thumb-StillTesting-10'
        WHEN 11 THEN '11-StillTesting'
        WHEN 12 THEN '12-StillTesting'
        WHEN 13 THEN '13-PNG-Optimized_CPLAsset-13'
        WHEN 14 THEN '14-Wallpaper-14'
        WHEN 15 THEN '15-Has-Markup-and-Adjustments-15'
        WHEN 16 THEN '16-Video-with-Adjustments-16'
        WHEN 17 THEN '17-RAW_Photo-17_RT'
        WHEN 18 THEN '18-Live-Photo-Video_Optimized_CPLAsset-18'
        WHEN 19 THEN '19-Live-Photo-with-Adjustments-19'
        WHEN 20 THEN '20-StillTesting'
        WHEN 21 THEN '21-StillTesting'
        WHEN 22 THEN '22-Adjust-Mutation_AAE_Asset-22'
        WHEN 23 THEN '23-StillTesting'
        WHEN 24 THEN '24-StillTesting'
        WHEN 25 THEN '25-StillTesting'
        WHEN 26 THEN '26-MOV-Optimized_CPLAsset-26'
        WHEN 27 THEN '27-StillTesting'
        WHEN 28 THEN '28-MOV-Med-hdr-Data-28'
        ELSE 'Unknown-New-Value!: ' || zIntResou.ZDATASTORESUBTYPE || ''
    END AS 'zIntResou-Datastore Sub-Type',

    CASE zIntResou.ZCLOUDSOURCETYPE
        WHEN 0 THEN '0-NA-0'
        WHEN 1 THEN '1-Main-Asset-Orig-Size-1'
        WHEN 2 THEN '2-Photo-with-Adjustments-2'
        WHEN 3 THEN '3-JPG-Large-Thumb-3'
        WHEN 4 THEN '4-JPG-Med-Thumb-4'
        WHEN 5 THEN '5-JPG-Small-Thumb-5'
        WHEN 6 THEN '6-Video-Med-Data-6'
        WHEN 7 THEN '7-Video-Small-Data-7'
        WHEN 8 THEN '8-MP4-Cloud-Share-8'
        WHEN 9 THEN '9-StillTesting'
        WHEN 10 THEN '10-3rdPartyApp_thumb-StillTesting-10'
        WHEN 11 THEN '11-StillTesting'
        WHEN 12 THEN '12-StillTesting'
        WHEN 13 THEN '13-PNG-Optimized_CPLAsset-13'
        WHEN 14 THEN '14-Wallpaper-14'
        WHEN 15 THEN '15-Has-Markup-and-Adjustments-15'
        WHEN 16 THEN '16-Video-with-Adjustments-16'
        WHEN 17 THEN '17-RAW_Photo-17_RT'
        WHEN 18 THEN '18-Live-Photo-Video_Optimized_CPLAsset-18'
        WHEN 19 THEN '19-Live-Photo-with-Adjustments-19'
        WHEN 20 THEN '20-StillTesting'
        WHEN 21 THEN '21-StillTesting'
        WHEN 22 THEN '22-Adjust-Mutation_AAE_Asset-22'
        WHEN 23 THEN '23-StillTesting'
        WHEN 24 THEN '24-StillTesting'
        WHEN 25 THEN '25-StillTesting'
        WHEN 26 THEN '26-MOV-Optimized_CPLAsset-26'
        WHEN 27 THEN '27-StillTesting'
        WHEN 28 THEN '28-MOV-Med-hdr-Data-28'
        ELSE 'Unknown-New-Value!: ' || zIntResou.ZCLOUDSOURCETYPE || ''
    END AS 'zIntResou-Cloud Source Type',

    zIntResou.ZDATALENGTH AS 'zIntResou-Data Length',

    CASE zIntResou.ZRECIPEID
        WHEN 0 THEN '0-OrigFileSize_match_DataLength_or_Optimized-0'
        WHEN 65739 THEN '65739-JPG_Large_Thumb-65739'
        WHEN 65741 THEN '65741-Various_Asset_Types-or-Thumbs-65741'
        WHEN 65743 THEN '65743-ResouType-Photo_5003-or-5005-JPG_Thumb-65743'
        WHEN 65749 THEN '65749-LocalVideoKeyFrame-JPG_Thumb-65749'
        WHEN 65938 THEN '65938-FullSizeRender-Photo-or-plist-65938'
        WHEN 131072 THEN '131072-FullSizeRender-Video-or-plist-131072'
        WHEN 131079 THEN '131079-medium-MP4_Adj-Mutation_Asset-131079'
        WHEN 131081 THEN '131081-ResouType-Video_5003-or-5005-JPG_Thumb-131081'
        WHEN 131272 THEN '131272-FullSizeRender-Video_LivePhoto_Adj-Mutation-131272'
        WHEN 131275 THEN '131275-medium-MOV_LivePhoto-131275'
        WHEN 131277 THEN '131277-No-IR-Asset_LivePhoto-iCloud_Sync_Asset-131277'
        WHEN 131475 THEN '131475-medium-hdr-MOV-131475'
        WHEN 327683 THEN '327683-JPG-Thumb_for_3rdParty-StillTesting-327683'
        WHEN 327687 THEN '627687-WallpaperComputeResource-627687'
        ELSE 'Unknown-New-Value!: ' || zIntResou.ZRECIPEID || ''
    END AS 'zIntResou-Recipe ID',

    CASE zIntResou.ZCLOUDLASTPREFETCHDATE
        WHEN 0 THEN '0-NA-0'
        ELSE datetime(zIntResou.ZCLOUDLASTPREFETCHDATE + 978307200, 'UNIXEPOCH')
    END AS 'zIntResou-Cloud Last Prefetch Date',

    zIntResou.ZCLOUDPREFETCHCOUNT AS 'zIntResou-Cloud Prefetch Count',
    datetime(zIntResou.ZCLOUDLASTONDEMANDDOWNLOADDATE + 978307200, 'UNIXEPOCH') AS 'zIntResou-Last OnDemand Download Date',
    
    CASE zIntResou.ZUTICONFORMANCEHINT
        WHEN 0 THEN '0-NA/Doesnt_Conform-0'
        WHEN 1 THEN '1-UTTypeImage-1'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-UTTypeMovie-3'
        ELSE 'Unknown-New-Value!: ' || zIntResou.ZUTICONFORMANCEHINT || ''
    END AS 'zIntResou-UniformTypeID_UTI_Conformance_Hint',

    CASE zIntResou.ZCOMPACTUTI
        WHEN 1 THEN '1-jpeg/thm-1'
        WHEN 3 THEN '3-heic-3'
        WHEN 6 THEN '6-png-6'
        WHEN 7 THEN '7-StillTesting'
        WHEN 23 THEN '23-jpeg/heic/quicktime-mov-23'
        WHEN 24 THEN '24-mpeg4-24'
        WHEN 36 THEN '36-Wallpaper-36'
        WHEN 37 THEN '37-Adj/Mutation_Data-37'
        ELSE 'Unknown-New-Value!: ' || zIntResou.ZCOMPACTUTI || ''
    END AS 'zIntResou-Compact-UTI',

    zAsset.ZUNIFORMTYPEIDENTIFIER AS 'zAsset-Uniform Type ID',
    zAsset.ZORIGINALCOLORSPACE AS 'zAsset-Original Color Space',
    zCldMast.ZUNIFORMTYPEIDENTIFIER AS 'zCldMast-Uniform_Type_ID',

    CASE zCldMast.ZFULLSIZEJPEGSOURCE
        WHEN 0 THEN '0-CldMast-JPEG-Source-Video-0'
        WHEN 1 THEN '1-CldMast-JPEG-Source-Other-1'
        ELSE 'Unknown-New-Value!: ' || zCldMast.ZFULLSIZEJPEGSOURCE || ''
    END AS 'zCldMast-Full Size JPEG Source',

    zAsset.ZHDRGAIN AS 'zAsset-HDR Gain',

    CASE zAsset.ZHDRTYPE
        WHEN 0 THEN '0-No-HDR-0'
        WHEN 3 THEN '3-HDR_Photo-3_RT'
        WHEN 4 THEN '4-Non-HDR_Version-4_RT'
        WHEN 5 THEN '5-HEVC_Movie-5'
        WHEN 6 THEN '6-Panorama-6_RT'
        WHEN 10 THEN '10-HDR-Gain-10'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZHDRTYPE || ''
    END AS 'zAsset-zHDR_Type',

    zExtAttr.ZCODEC AS 'zExtAttr-Codec',
    zIntResou.ZCODECFOURCHARCODENAME AS 'zIntResou-Codec Four Char Code Name',
    zCldMast.ZCODECNAME AS 'zCldMast-Codec Name',
    zCldMast.ZVIDEOFRAMERATE AS 'zCldMast-Video Frame Rate',
    zCldMast.ZPLACEHOLDERSTATE AS 'zCldMast-Placeholder State',

    CASE zAsset.ZDEPTHTYPE
        WHEN 0 THEN '0-Not_Portrait-0_RT'
        ELSE 'Portrait: ' || zAsset.ZDEPTHTYPE || ''
    END AS 'zAsset-Depth_Type',

    zAsset.ZAVALANCHEUUID AS 'zAsset-Avalanche UUID',
    CASE zAsset.ZAVALANCHEPICKTYPE
        WHEN 0 THEN '0-NA/Single_Asset_Burst_UUID-0_RT'
        WHEN 2 THEN '2-Burst_Asset_Not_Selected-2_RT'
        WHEN 4 THEN '4-Burst_Asset_PhotosApp_Picked_KeyImage-4_RT'
        WHEN 8 THEN '8-Burst_Asset_Selected_for_LPL-8_RT'
        WHEN 16 THEN '16-Top_Burst_Asset_inStack_KeyImage-16_RT'
        WHEN 32 THEN '32-StillTesting-32_RT'
        WHEN 52 THEN '52-Burst_Asset_Visible_LPL-52'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZAVALANCHEPICKTYPE || ''
    END AS 'zAsset-Avalanche_Pick_Type/BurstAsset',

    CASE zAddAssetAttr.ZCLOUDAVALANCHEPICKTYPE
        WHEN 0 THEN '0-NA/Single_Asset_Burst_UUID-0_RT'
        WHEN 2 THEN '2-Burst_Asset_Not_Selected-2_RT'
        WHEN 4 THEN '4-Burst_Asset_PhotosApp_Picked_KeyImage-4_RT'
        WHEN 8 THEN '8-Burst_Asset_Selected_for_LPL-8_RT'
        WHEN 16 THEN '16-Top_Burst_Asset_inStack_KeyImage-16_RT'
        WHEN 32 THEN '32-StillTesting-32_RT'
        WHEN 52 THEN '52-Burst_Asset_Visible_LPL-52'
        ELSE 'Unknown-New-Value!: ' || zAddAssetAttr.ZCLOUDAVALANCHEPICKTYPE || ''
    END AS 'zAddAssetAttr-Cloud_Avalanche_Pick_Type/BurstAsset',

    CASE zAddAssetAttr.ZCLOUDRECOVERYSTATE
        WHEN 0 THEN '0-StillTesting-0'
        WHEN 1 THEN '1-StillTesting-1'
        ELSE 'Unknown-New-Value!: ' || zAddAssetAttr.ZCLOUDRECOVERYSTATE || ''
    END AS 'zAddAssetAttr-Cloud Recovery State',

    zAddAssetAttr.ZCLOUDSTATERECOVERYATTEMPTSCOUNT AS 'zAddAssetAttr-Cloud State Recovery Attempts Count',
    zAsset.ZDEFERREDPROCESSINGNEEDED AS 'zAsset-Deferred Processing Needed',
    zAsset.ZVIDEODEFERREDPROCESSINGNEEDED AS 'zAsset-Video Deferred Processing Needed',
    zAddAssetAttr.ZDEFERREDPHOTOIDENTIFIER AS 'zAddAssetAttr-Deferred Photo Identifier',
    zAddAssetAttr.ZDEFERREDPROCESSINGCANDIDATEOPTIONS AS 'zAddAssetAttr-Deferred Processing Candidate Options',
    
    CASE zAsset.ZHASADJUSTMENTS
        WHEN 0 THEN '0-No-Adjustments-0'
        WHEN 1 THEN '1-Yes-Adjustments-1'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZHASADJUSTMENTS || ''
    END AS 'zAsset-Has Adjustments/Camera-Effects-Filters',

    zUnmAdj.ZASSETATTRIBUTES AS 'zUnmAdj-Asset Attributes=zAddAssetAttr.zPK',
    zAddAssetAttr.ZUNMANAGEDADJUSTMENT AS 'zAddAssetAttr-UnmanAdjust Key=zUnmAdj.zPK',
    zUnmAdj.Z_PK AS 'zUnmAdj-zPK=zAddAssetAttr.ZUnmanAdj Key',
    zUnmAdj.ZUUID AS 'zUnmAdj-UUID',
    datetime(zAsset.ZADJUSTMENTTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'zAsset-Adjustment Timestamp',
    datetime(zUnmAdj.ZADJUSTMENTTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'zUnmAdj-Adjustment Timestamp',
    zAddAssetAttr.ZEDITORBUNDLEID AS 'zAddAssetAttr-Editor Bundle ID',
    zUnmAdj.ZEDITORLOCALIZEDNAME AS 'zUnmAdj-Editor Localized Name',
    zUnmAdj.ZADJUSTMENTFORMATIDENTIFIER AS 'zUnmAdj-Adjustment Format ID',
    zAddAssetAttr.ZMONTAGE AS 'zAddAssetAttr-Montage',

    CASE zUnmAdj.ZADJUSTMENTRENDERTYPES
        WHEN 0 THEN '0-Standard or Portrait with erros-0'
        WHEN 1 THEN '1-StillTesting-1'
        WHEN 2 THEN '2-Portrait-2'
        WHEN 3 THEN '3-StillTesting-3'
        WHEN 4 THEN '4-StillTesting-4'
        ELSE 'Unknown-New-Value!: ' || zUnmAdj.ZADJUSTMENTRENDERTYPES || ''
    END AS 'zUnmAdj-Adjustment Render Types',

    CASE zUnmAdj.ZADJUSTMENTFORMATVERSION
        WHEN 1.0 THEN '1.0-Markup-1.0'
        WHEN 1.1 THEN '1.1-Slow-Mo-1.1'
        WHEN 1.2 THEN '1.2-StillTesting'
        WHEN 1.3 THEN '1.3-StillTesting'
        WHEN 1.4 THEN '1.4-Filter-1.4'
        WHEN 1.5 THEN '1.5-Adjust-1.5'
        WHEN 1.6 THEN '1.6-Video-Trim-1.6'
        WHEN 1.7 THEN '1.7-StillTesting'
        WHEN 1.8 THEN '1.8-StillTesting'
        WHEN 1.9 THEN '1.9-StillTesting'
        WHEN 2.0 THEN '2.0-ScreenshotServices'
        ELSE 'Unknown-New-Value!: ' || zUnmAdj.ZADJUSTMENTFORMATVERSION || ''
    END AS 'zUnmAdj-Adjustment Format Version',

    zUnmAdj.ZADJUSTMENTBASEIMAGEFORMAT AS 'zUnmAdj-Adjustment Base Image Format',
    
    CASE zAsset.ZFAVORITE
        WHEN 0 THEN '0-Asset Not Favorite-0'
        WHEN 1 THEN '1-Asset Favorite-1'
    END AS 'zAsset-Favorite',

    CASE zAsset.ZHIDDEN
        WHEN 0 THEN '0-Asset Not Hidden-0'
        WHEN 1 THEN '1-Asset Hidden-1'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZHIDDEN || ''
    END AS 'zAsset-Hidden',

    CASE zAsset.ZTRASHEDSTATE
        WHEN 0 THEN '0-Asset Not In Trash/Recently Deleted-0'
        WHEN 1 THEN '1-Asset In Trash/Recently Deleted-1'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZTRASHEDSTATE || ''
    END AS 'zAsset-Trashed State/LocalAssetRecentlyDeleted',

    datetime(zAsset.ZTRASHEDDATE + 978307200, 'UNIXEPOCH') AS 'zAsset-Trashed Date',
    
    CASE zIntResou.ZTRASHEDSTATE
        WHEN 0 THEN '0-zIntResou-Not In Trash/Recently Deleted-0'
        WHEN 1 THEN '1-zIntResou-In Trash/Recently Deleted-1'
        ELSE 'Unknown-New-Value!: ' || zIntResou.ZTRASHEDSTATE || ''
    END AS 'zIntResou-Trash State',

    datetime(zIntResou.ZTRASHEDDATE + 978307200, 'UNIXEPOCH') AS 'zIntResou-Trashed Date',

    CASE zAsset.ZCLOUDDELETESTATE
        WHEN 0 THEN '0-Cloud Asset Not Deleted-0'
        WHEN 1 THEN '1-Cloud Asset Deleted-1'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZCLOUDDELETESTATE || ''
    END AS 'zAsset-Cloud Delete State',

    CASE zIntResou.ZCLOUDDELETESTATE
        WHEN 0 THEN '0-Cloud IntResou Not Deleted-0'
        WHEN 1 THEN '1-Cloud IntResou Deleted-1'
        ELSE 'Unknown-New-Value!: ' || zIntResou.ZCLOUDDELETESTATE || ''
    END AS 'zIntResou-Cloud Delete State',

    CASE zAddAssetAttr.ZPTPTRASHEDSTATE
        WHEN 0 THEN '0-PTP Not in Trash-0'
        WHEN 1 THEN '1-PTP In Trash-1'
        ELSE 'UnknownValue: ' || zAddAssetAttr.ZPTPTRASHEDSTATE || ''
    END AS 'zAddAssetAttr.ZPTPTrashedState',

    CASE zIntResou.ZPTPTRASHEDSTATE
        WHEN 0 THEN '0-PTPIntResouNotInTrash'
        WHEN 1 THEN '1-PTPIntResouInTrash'
        ELSE 'UnknownValue: ' || zIntResou.ZPTPTRASHEDSTATE
    END AS 'zIntResou.ZPTPTrashedState',

    zIntResou.ZCLOUDDELETEASSETUUIDWITHRESOURCETYPE AS 'zIntResou.ZCloudDeleteAssetUUIDWithResourceType',
    datetime(zMedAnlyAstAttr.ZMEDIAANALYSISTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'zMedAnlyAstAttr.ZMediaAnalysisTimestamp(UTC)',
    datetime(zAsset.ZANALYSISSTATEMODIFICATIONDATE + 978307200, 'UNIXEPOCH') AS 'zAsset.ZAnalysisStateModificaionDate(UTC)',
    zAddAssetAttr.ZPENDINGVIEWCOUNT AS 'zAddAssetAttr-Pending View Count',
    zAddAssetAttr.ZVIEWCOUNT AS 'zAddAssetAttr.ZViewCount',
    zAddAssetAttr.ZPENDINGPLAYCOUNT AS 'zAddAssetAttr.ZPendingPlayCount',
    zAddAssetAttr.ZPLAYCOUNT AS 'zAddAssetAttr.ZPlayCount',
    zAddAssetAttr.ZPENDINGSHARECOUNT AS 'zAddAssetAttr.ZPendingShareCount',
    zAddAssetAttr.ZSHARECOUNT AS 'zAddAssetAttr.ZShareCount',
    datetime(zAsset.ZLASTSHAREDDATE + 978307200, 'UNIXEPOCH') AS 'zAsset.ZLastSharedDate(UTC)',
    zAddAssetAttr.ZSHAREORIGINATOR AS 'zAddAssetAttr-Share Originator',
    
    CASE zAddAssetAttr.ZALLOWEDFORANALYSIS
        WHEN 0 THEN '0-AssetNotAllowedForAnalysis'
        WHEN 1 THEN '1-AssetAllowedForAnalysis'
        ELSE 'UnknownValue: ' || zAddAssetAttr.ZALLOWEDFORANALYSIS
    END AS 'zAddAssetAttr.ZAllowedForAnalysis',

    zAddAssetAttr.ZSCENEANALYSISVERSION AS 'zAddAssetAttr.ZSceneAnalysisVersion',
    
    CASE zAddAssetAttr.ZSCENEANALYSISISFROMPREVIEW
        WHEN 0 THEN '0-No'
        ELSE 'UnknownValue: ' || zAddAssetAttr.ZSCENEANALYSISISFROMPREVIEW
    END AS 'zAddAssetAttr.ZSceneAnalysisIsFromPreview',

    datetime(zAddAssetAttr.ZSCENEANALYSISTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'zAddAssetAttr.ZSceneAnalysisTimestamph(UTC)',
    
    CASE zAddAssetAttr.ZDESTINATIONASSETCOPYSTATE
        WHEN 0 THEN '0-NoCopy'
        WHEN 1 THEN '1-HasACopy'
        WHEN 2 THEN '2-HasACopy'
        ELSE 'UnknownValue: ' || zAddAssetAttr.ZDESTINATIONASSETCOPYSTATE
    END AS 'zAddAssetAttr.ZDestinationAssetCopyState',

    zSceneP.ZDATA AS 'zSceneP.ZData',
    zAddAssetAttr.ZSOURCEASSETFORDUPLICATIONSCOPEIDENTIFIER AS 'zAddAssetAttr.ZSourceAssetForDuplicationScopeIdentifier',
    zCldMast.ZSOURCEMASTERFORDUPLICATIONSCOPEIDENTIFIER AS 'zCldMast.ZSourceMasterForDuplicationScopeIdentifier',
    zAddAssetAttr.ZSOURCEASSETFORDUPLICATIONIDENTIFIER AS 'zAddAssetAttr.ZSourceAssetForDuplicationIdentifier',
    zCldMast.ZSOURCEMASTERFORDUPLICATIONIDENTIFIER AS 'zCldMast.ZSourceMasterForDuplicationIdentifier'


FROM ZASSET zAsset

    LEFT JOIN ZADDITIONALASSETATTRIBUTES zAddAssetAttr ON zAddAssetAttr.Z_PK = zAsset.ZADDITIONALATTRIBUTES
    LEFT JOIN ZEXTENDEDATTRIBUTES zExtAttr ON zExtAttr.Z_PK = zAsset.ZEXTENDEDATTRIBUTES
    LEFT JOIN ZINTERNALRESOURCE zIntResou ON zIntResou.ZASSET = zAsset.Z_PK
    LEFT JOIN ZSCENEPRINT zSceneP ON zSceneP.Z_PK = zAddAssetAttr.ZSCENEPRINT
    LEFT JOIN Z_27ASSETS z27Assets ON z27Assets.Z_3ASSETS = zAsset.Z_PK
    LEFT JOIN ZGENERICALBUM zGenAlbum ON zGenAlbum.Z_PK = z27Assets.Z_27ALBUMS
    LEFT JOIN ZUNMANAGEDADJUSTMENT zUnmAdj ON zAddAssetAttr.ZUNMANAGEDADJUSTMENT = zUnmAdj.Z_PK
    LEFT JOIN Z_26ALBUMLISTS z26AlbumLists ON z26AlbumLists.Z_26ALBUMS = zGenAlbum.Z_PK
    LEFT JOIN ZALBUMLIST zAlbumList ON zAlbumList.Z_PK = z26AlbumLists.Z_2ALBUMLISTS
    LEFT JOIN ZGENERICALBUM ParentzGenAlbum ON ParentzGenAlbum.Z_PK = zGenAlbum.ZPARENTFOLDER
    LEFT JOIN ZCLOUDMASTER zCldMast ON zAsset.ZMASTER = zCldMast.Z_PK
    LEFT JOIN ZCLOUDMASTERMEDIAMETADATA AAAzCldMastMedData ON AAAzCldMastMedData.Z_PK = zAddAssetAttr.ZMEDIAMETADATA
    LEFT JOIN ZCLOUDMASTERMEDIAMETADATA CMzCldMastMedData ON CMzCldMastMedData.Z_PK = zCldMast.ZMEDIAMETADATA
    LEFT JOIN ZMEDIAANALYSISASSETATTRIBUTES zMedAnlyAstAttr ON zAsset.ZMEDIAANALYSISATTRIBUTES = zMedAnlyAstAttr.Z_PK
    LEFT JOIN ZSHARE zShare ON zShare.Z_PK = zAsset.ZMOMENTSHARE


ORDER BY 

    zAsset.ZADDEDDATE
