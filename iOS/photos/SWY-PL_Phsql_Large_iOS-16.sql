/*
Query copied from https://github.com/ScottKjr3347/iOS_SWY_PL_Photos.sqlite_Queries/blob/main/iOS16/iOS16_SWY-PL_Phsql_Large.txt
*/

SELECT
    ROW_NUMBER() OVER() AS 'Record #',
    zAsset.ZSORTTOKEN AS 'zAsset.ZSORTTOKEN',
    zAsset.ZPROMOTIONSCORE AS 'zAsset.ZPROMOTIONSCORE',

    CASE zAsset.ZCOMPLETE
        WHEN 1 THEN '1 [Yes]'
    END AS 'zAsset.ZCOMPLETE',

    zAsset.Z_PK AS 'zAsset.Z_PK',
    zAddAssetAttr.Z_PK AS 'zAddAssetAttr.Z_PK',
    --[zCldMast.Z_PK=zAsset.ZMaster]
    zCldMast.Z_PK AS 'zCldMast.Z_PK',
    --[zAsset.ZMaster=zCldMast.Z_PK]
    zAsset.ZMASTER AS 'zAsset.ZMaster',
    --[zAsset.ZEXTENDEDATTRIBUTES=zExtAttr.Z_PK]
    zAsset.ZEXTENDEDATTRIBUTES AS 'zAsset.ZEXTENDEDATTRIBUTES',
    --[zExtAttr.Z_PK=zAsset.zExtendedAttributes]
    zExtAttr.Z_PK AS 'zExtAttr.Z_PK',
    --[CMzCldMastMedData-CldMast=zCldMast.Z_PK]
    CMzCldMastMedData.ZCLOUDMASTER AS 'CMzCldMastMedData.ZCLOUDMASTER',
    --[zCldMast-Media Metadata Key=zCldMastMedData.zPK]
    zCldMast.ZMEDIAMETADATA AS 'zCldMast.ZMEDIAMETADATA',
    --[CMzCldMastMedData.Z_PK=zAddAssetAttr&zCldMast-MediaMetaDataKey]
    CMzCldMastMedData.Z_PK AS 'CMzCldMastMedData.Z_PK',
    CMzCldMastMedData.Z_ENT AS 'CMzCldMastMedData.Z_ENT',
    zAsset.ZUUID AS 'zAsset.UUID',
    --[zAsset-Cloud_Asset_GUID = store.cloudphotodb]
    zAsset.ZCLOUDASSETGUID AS 'zAsset.ZCLOUDASSETGUID',
    zAsset.ZCLOUDCOLLECTIONGUID AS 'zAsset.ZCLOUDCOLLECTIONGUID',
    --[zCldMast-Cloud_Master_GUID = store.cloudphotodb]
    zCldMast.ZCLOUDMASTERGUID AS 'zCldMast.ZCLOUDMASTERGUID',
    zGenAlbum.ZCLOUDGUID AS 'zGenAlbum-Cloud_GUID = store.cloudphotodb',
    zShare.ZSCOPEIDENTIFIER AS 'zShare-Scope ID = store.cloudphotodb',
    zAddAssetAttr.ZORIGINALASSETSUUID AS 'zAddAssetAttr-Original Assets UUID',
    zAddAssetAttr.ZPUBLICGLOBALUUID AS 'zAddAssetAttr-Public Global UUID',
    zAddAssetAttr.ZMASTERFINGERPRINT AS 'zAddAssetAttr-Master Fingerprint',
    zAddAssetAttr.ZORIGINATINGASSETIDENTIFIER AS 'zAddAssetAttr-Originating Asset Identifier',
    zCldMast.ZORIGINATINGASSETIDENTIFIER AS 'zCldMast-Originating Asset ID',
    zIntResou.ZFINGERPRINT AS 'zIntResou-Fingerprint',
    zAddAssetAttr.ZADJUSTEDFINGERPRINT AS 'zAddAssetAttr.Adjusted Fingerprint',
    zUnmAdj.ZOTHERADJUSTMENTSFINGERPRINT AS 'zUnmAdj-Other Adjustments Fingerprint',
    zUnmAdj.ZSIMILARTOORIGINALADJUSTMENTSFINGERPRINT AS 'zUnmAdj-Similar to Orig Adjustments Fingerprint',

    CASE ParentzGenAlbum.ZCLOUDLOCALSTATE
        WHEN 0 THEN '0-iCldPhotos-ON=Asset_In_Shared/Other-Album/iCldPhotos-OFF=Generic_Album-0'
        WHEN 1 THEN '1-iCldPhotos-ON=Asset_In_Generic Album-1'
        ELSE 'Unknown-New-Value!: ' || ParentzGenAlbum.ZCLOUDLOCALSTATE || ''
    END AS 'ParentzGenAlbum-Cloud-Local-State-4Start',

    ParentzGenAlbum.ZTITLE AS 'ParentzGenAlbum-Title-4Start',

    datetime(ParentzGenAlbum.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'ParentzGenAlbum-Creation Date-4Start',
    datetime(zGenAlbum.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'zGenAlbum-Creation Date-4Start',

    CASE zGenAlbum.ZCLOUDLOCALSTATE
        WHEN 0 THEN '0-iCldPhotos-ON=Asset_In_Shared/Other-Album/iCldPhotos-OFF=Generic_Album-0'
        WHEN 1 THEN '1-iCldPhotos-ON=Asset_In_Generic_ Album-1'
        ELSE 'Unknown-New-Value!: ' || zGenAlbum.ZCLOUDLOCALSTATE || ''
    END AS 'zGenAlbum-Cloud_Local_State-4Start',

    zGenAlbum.ZTITLE AS 'zGenAlbum-Title-4Start',

    CASE zAsset.ZBUNDLESCOPE
        WHEN 0 THEN '0-iCldPhotos-ON=Not-In-Shared-Album_iCldPhotos-OFF=On-Local-Device-0'
        WHEN 1 THEN '1-SWY-Syndication_CMMAsset-1'
        WHEN 2 THEN '2-iCldPhotos-ON=Asset-In-Cloud-Shared-Album-2'
        WHEN 3 THEN '3-iCldPhotos-ON=SWY-Syndication-Asset-3'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZBUNDLESCOPE || ''
    END AS 'zAsset-Bundle Scope',

    CASE zAsset.ZCLOUDISMYASSET
        WHEN 0 THEN '0-Not_My_Asset_in_Shared_Album-0'
        WHEN 1 THEN '1-My_Asset_in_Shared_Album-1'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZCLOUDISMYASSET || ''
    END AS 'zAsset-Cloud is My Asset',

    CASE zAsset.ZCLOUDISDELETABLE
        WHEN 0 THEN '0-No-0'
        WHEN 1 THEN '1-Yes-1'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZCLOUDISDELETABLE || ''
    END AS 'zAsset-Cloud is deletable/Asset',

    CASE zAsset.ZCLOUDLOCALSTATE
        WHEN 0 THEN 'iCldPhotos ON=Asset In Shared-Other Album/iCldPhotos OFF=Not Synced-0'
        WHEN 1 THEN 'iCldPhotos ON=Asset Synced with iCloud-1'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZCLOUDLOCALSTATE || ''
    END AS 'zAsset-Cloud Local State',

    CASE zAsset.ZVISIBILITYSTATE
        WHEN 0 THEN '0-Visible-Photo-Library-0'
        WHEN 2 THEN '2-Not-Visible-Photo-Library-2'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZVISIBILITYSTATE || ''
    END AS 'zAsset-Visibility State',

    zExtAttr.ZCAMERAMAKE AS 'zExtAttr-Camera Make',
    zExtAttr.ZCAMERAMODEL AS 'zExtAttr-Camera Model',
    zExtAttr.ZLENSMODEL AS 'zExtAttr-Lens Model',

    CASE zExtAttr.ZFLASHFIRED
        WHEN 0 THEN '0-No Flash-0'
        WHEN 1 THEN '1-Flash Fired-1'
        ELSE 'Unknown-New-Value!: ' || zExtAttr.ZFLASHFIRED || ''
    END AS 'zExtAttr-Flash Fired',

    zExtAttr.ZFOCALLENGTH AS 'zExtAttr-Focal Lenght',
    zExtAttr.ZFOCALLENGTHIN35MM AS 'zExtAttr-Focal Lenth in 35MM',
    zExtAttr.ZDIGITALZOOMRATIO AS 'zExtAttr-Digital Zoom Ratio',

    CASE zAsset.ZDERIVEDCAMERACAPTUREDEVICE
        WHEN 0 THEN '0-Back-Camera/Other-0'
        WHEN 1 THEN '1-Front-Camera-1'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZDERIVEDCAMERACAPTUREDEVICE || ''
    END AS 'zAsset-Derived Camera Capture Device',

    CASE zAddAssetAttr.ZCAMERACAPTUREDEVICE
        WHEN 0 THEN '0-Back-Camera/Other-0'
        WHEN 1 THEN '1-Front-Camera-1'
        ELSE 'Unknown-New-Value!: ' || zAddAssetAttr.ZCAMERACAPTUREDEVICE || ''
    END AS 'zAddAssetAttr-Camera Captured Device',

    CASE zAddAssetAttr.ZIMPORTEDBY
        WHEN 0 THEN '0-Cloud-Other-0'
        WHEN 1 THEN '1-Native-Back-Camera-1'
        WHEN 2 THEN '2-Native-Front-Camera-2'
        WHEN 3 THEN '3-Third-Party-App-3'
        WHEN 4 THEN '4-StillTesting-4'
        WHEN 5 THEN '5-PhotoBooth_PL-Asset-5'
        WHEN 6 THEN '6-Third-Party-App-6'
        WHEN 7 THEN '7-iCloud_Share_Link-CMMAsset-7'
        WHEN 8 THEN '8-System-Package-App-8'
        WHEN 9 THEN '9-Native-App-9'
        WHEN 10 THEN '10-StillTesting-10'
        WHEN 11 THEN '11-StillTesting-11'
        WHEN 12 THEN '12-SWY_Syndication_PL-12'
        ELSE 'Unknown-New-Value!: ' || zAddAssetAttr.ZIMPORTEDBY || ''
    END AS 'zAddAssetAttr-Imported by',

    CASE zCldMast.ZIMPORTEDBY
        WHEN 0 THEN '0-Cloud-Other-0'
        WHEN 1 THEN '1-Native-Back-Camera-1'
        WHEN 2 THEN '2-Native-Front-Camera-2'
        WHEN 3 THEN '3-Third-Party-App-3'
        WHEN 4 THEN '4-StillTesting-4'
        WHEN 5 THEN '5-PhotoBooth_PL-Asset-5'
        WHEN 6 THEN '6-Third-Party-App-6'
        WHEN 7 THEN '7-iCloud_Share_Link-CMMAsset-7'
        WHEN 8 THEN '8-System-Package-App-8'
        WHEN 9 THEN '9-Native-App-9'
        WHEN 10 THEN '10-StillTesting-10'
        WHEN 11 THEN '11-StillTesting-11'
        WHEN 12 THEN '12-SWY_Syndication_PL-12'
        ELSE 'Unknown-New-Value!: ' || zCldMast.ZIMPORTEDBY || ''
    END AS 'zCldMast-Imported By',

    zAddAssetAttr.ZIMPORTEDBYBUNDLEIDENTIFIER AS 'zAddAssetAttr.Imported by Bundle Identifier',
    zAddAssetAttr.ZIMPORTEDBYDISPLAYNAME AS 'zAddAssetAttr-Imported By Display Name',
    zCldMast.ZIMPORTEDBYBUNDLEIDENTIFIER AS 'zCldMast-Imported by Bundle ID',
    zCldMast.ZIMPORTEDBYDISPLAYNAME AS 'zCldMast-Imported by Display Name',
    zAsset.ZIMAGEREQUESTHINTS AS 'zAsset-ImageRequestHints/HEX-Path',

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

    zAsset.ZDIRECTORY AS 'zAsset-Directory/Path',
    zAsset.ZFILENAME AS 'zAsset-Filename',
    zAddAssetAttr.ZORIGINALFILENAME AS 'zAddAssetAttr-Original Filename',
    zCldMast.ZORIGINALFILENAME AS 'zCldMast-Orig Filename',
    zAddAssetAttr.ZSYNDICATIONIDENTIFIER AS 'zAddAssetAttr-Syndication Identifier',

    CASE zAsset.ZSYNDICATIONSTATE
        WHEN 0 THEN '0-Received-SWY_Synd_Asset-0'
        WHEN 1 THEN '1-Sent-SWY_Synd_Asset-1'
        WHEN 2 THEN '2-Manually-Saved_SWY_Synd_Asset-2'
        WHEN 8 THEN '8-SWY_Linked_Asset_was_Visible_On-Device_User_Deleted_Link-8'
        WHEN 10 THEN '10-Manually-Saved_SWY_Synd_Asset_User_Deleted_From_LPL-10'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZSYNDICATIONSTATE || ''
    END AS 'zAsset-Syndication State-SWYPL',

    CASE zAsset.ZSYNDICATIONSTATE
        WHEN 0 THEN '0-Local-PL_Asset_Syndication_State_NA-0'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZSYNDICATIONSTATE || ''
    END AS 'zAsset-Syndication State-LPL',

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
    CASE zAsset.ZSEARCHINDEXREBUILDSTATE
        WHEN 0 THEN '0-StillTesting-0'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZSEARCHINDEXREBUILDSTATE || ''
    END AS 'zAsset-Search Index Rebuild State',
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
    zIntResou.Z_PK AS 'zIntResou.Z_PK',
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
    CASE zAsset.ZMONOSKITYPE
        WHEN 0 THEN '0-StillTesting No-Monoski-0'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZMONOSKITYPE || ''
    END AS 'zAsset-Mono Skin Type',
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
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
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
    zUnmAdj.Z_PK AS 'zUnmAdj.Z_PK=zAddAssetAttr.ZUnmanAdj Key',
    zUnmAdj.ZUUID AS 'zUnmAdj-UUID',
    datetime(zAsset.ZADJUSTMENTTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'zAsset-Adjustment Timestamp',
    datetime(zUnmAdj.ZADJUSTMENTTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'zUnmAdj-Adjustment Timestamp',
    zAddAssetAttr.ZEDITORBUNDLEID AS 'zAddAssetAttr-Editor Bundle ID',
    zUnmAdj.ZEDITORLOCALIZEDNAME AS 'zUnmAdj-Editor Localized Name',
    zUnmAdj.ZADJUSTMENTFORMATIDENTIFIER AS 'zUnmAdj-Adjustment Format ID',
    zAddAssetAttr.ZMONTAGE AS 'zAddAssetAttr-Montage',
    CASE zUnmAdj.ZADJUSTMENTRENDERTYPES
        WHEN 0 THEN '0-Standard or Portrait with erros-0'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-Portrait-2'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
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
        WHEN 2.0 THEN '2.0-ScreenshotServices-2.0'
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
    CASE zAsset.ZDELETEREASON
        WHEN 1 THEN '1-StillTesting Delete-Reason-1'
        WHEN 2 THEN '2-StillTesting Delete-Reason-2'
        WHEN 3 THEN '3-StillTesting Delete-Reason-3'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZDELETEREASON || ''
    END AS 'zAsset-Delete-Reason',
    CASE zAsset.ZTRASHEDBYPARTICIPANT
        WHEN 1 THEN '1-Asset Trashed/Recently Deleted by Participant-1'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZTRASHEDBYPARTICIPANT || ''
    END AS 'zAsset-Trashed by Participant',
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
        ELSE 'Unknown-New-Value!: ' || zAddAssetAttr.ZPTPTRASHEDSTATE || ''
    END AS 'zAddAssetAttr-PTP Trashed State',
    CASE zIntResou.ZPTPTRASHEDSTATE
        WHEN 0 THEN '0-PTP IntResou Not in Trash-0'
        WHEN 1 THEN '1-PTP IntResou In Trash-1'
        ELSE 'Unknown-New-Value!: ' || zIntResou.ZPTPTRASHEDSTATE || ''
    END AS 'zIntResou-PTP Trashed State',
    zIntResou.ZCLOUDDELETEASSETUUIDWITHRESOURCETYPE AS 'zIntResou-Cloud Delete Asset UUID With Resource Type',
    datetime(zMedAnlyAstAttr.ZMEDIAANALYSISTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'zMedAnlyAstAttr-Media Analysis Timestamp',
    datetime(zAsset.ZANALYSISSTATEMODIFICATIONDATE + 978307200, 'UNIXEPOCH') AS 'zAsset-Analysis State Modificaion Date',
    zAddAssetAttr.ZPENDINGVIEWCOUNT AS 'zAddAssetAttr-Pending View Count',
    zAddAssetAttr.ZVIEWCOUNT AS 'zAddAssetAttr-View Count',
    zAddAssetAttr.ZPENDINGPLAYCOUNT AS 'zAddAssetAttr-Pending Play Count',
    zAddAssetAttr.ZPLAYCOUNT AS 'zAddAssetAttr-Play Count',
    zAddAssetAttr.ZPENDINGSHARECOUNT AS 'zAddAssetAttr-Pending Share Count',
    zAddAssetAttr.ZSHARECOUNT AS 'zAddAssetAttr-Share Count',
    datetime(zAsset.ZLASTSHAREDDATE + 978307200, 'UNIXEPOCH') AS 'zAsset-Last Shared Date',
    zAddAssetAttr.ZSHAREORIGINATOR AS 'zAddAssetAttr-Share Originator',
    CASE zAddAssetAttr.ZALLOWEDFORANALYSIS
        WHEN 0 THEN '0-Asset Not Allowed For Analysis-0'
        WHEN 1 THEN '1-Asset Allowed for Analysis-1'
        ELSE 'Unknown-New-Value!: ' || zAddAssetAttr.ZALLOWEDFORANALYSIS || ''
    END AS 'zAddAssetAttr-Allowed for Analysis',
    zAddAssetAttr.ZSCENEANALYSISVERSION AS 'zAddAssetAttr-Scene Analysis Version',
    CASE zAddAssetAttr.ZSCENEANALYSISISFROMPREVIEW
        WHEN 0 THEN '0-No-0'
        ELSE 'Unknown-New-Value!: ' || zAddAssetAttr.ZSCENEANALYSISISFROMPREVIEW || ''
    END AS 'zAddAssetAttr-Scene Analysis is From Preview',
    datetime(zAddAssetAttr.ZSCENEANALYSISTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'zAddAssetAttr-Scene Analysis Timestamp',
    CASE zAsset.ZDUPLICATEASSETVISIBILITYSTATE
        WHEN 0 THEN 'No-Duplicates-0'
        WHEN 1 THEN 'Has Duplicate-1'
        WHEN 2 THEN 'Is a Duplicate-2'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZDUPLICATEASSETVISIBILITYSTATE || ''
    END AS 'zAsset-Duplication Asset Visibility State',
    CASE zAddAssetAttr.ZDESTINATIONASSETCOPYSTATE
        WHEN 0 THEN '0-No Copy-0'
        WHEN 1 THEN '1-Has A Copy-1'
        WHEN 2 THEN '2-Has A Copy-2'
        ELSE 'Unknown-New-Value!: ' || zAddAssetAttr.ZDESTINATIONASSETCOPYSTATE || ''
    END AS 'zAddAssetAttr-Destination Asset Copy State',
    zSceneP.ZDATA AS 'zSceneP-Data/HEX NSKeyed Plist',
    zSceneP.ZDUPLICATEMATCHINGDATA AS 'zSceneP-Duplicate Matching Data/HEX NSKeyed Plist',
    zSceneP.ZDUPLICATEMATCHINGALTERNATEDATA AS 'zSceneP-Duplicate Matching Alternat Data/HEX NSKeyed Plist',
    zAddAssetAttr.ZSOURCEASSETFORDUPLICATIONSCOPEIDENTIFIER AS 'zAddAssetAttr-Source Asset for Duplication Scope ID',
    zCldMast.ZSOURCEMASTERFORDUPLICATIONSCOPEIDENTIFIER AS 'zCldMast-Source Master For Duplication Scope ID',
    zAddAssetAttr.ZSOURCEASSETFORDUPLICATIONIDENTIFIER AS 'zAddAssetAttr-Source Asset For Duplication ID',
    zCldMast.ZSOURCEMASTERFORDUPLICATIONIDENTIFIER AS 'zCldMast-Source Master for Duplication ID',
    zExtAttr.Z_ENT AS 'zExtAttr-zENT',
    zExtAttr.Z_OPT AS 'zExtAttr-zOPT',
    zAddAssetAttr.ZVARIATIONSUGGESTIONSTATES AS 'zAddAssetAttr-Variation Suggestions States',
    zAsset.ZHIGHFRAMERATESTATE AS 'zAsset-High Frame Rate State',
    zAsset.ZVIDEOKEYFRAMETIMESCALE AS 'zAsset-Video Key Frame Time Scale',
    zAsset.ZVIDEOKEYFRAMEVALUE AS 'zAsset-Video Key Frame Value',
    zExtAttr.ZISO AS 'zExtAttr-ISO',
    zExtAttr.ZMETERINGMODE AS 'zExtAttr-Metering Mode',
    zExtAttr.ZSAMPLERATE AS 'zExtAttr-Sample Rate',
    zExtAttr.ZTRACKFORMAT AS 'zExtAttr-Track Format',
    zExtAttr.ZWHITEBALANCE AS 'zExtAttr-White Balance',
    zExtAttr.ZASSET AS 'zExtAttr-Asset Key',
    zExtAttr.ZAPERTURE AS 'zExtAttr-Aperture',
    zExtAttr.ZBITRATE AS 'zExtAttr-BitRate',
    zExtAttr.ZEXPOSUREBIAS AS 'zExtAttr-Exposure Bias',
    zExtAttr.ZFPS AS 'zExtAttr-Frames Per Second',
    zExtAttr.ZSHUTTERSPEED AS 'zExtAttr-Shutter Speed',
    zExtAttr.ZSLUSHSCENEBIAS AS 'zExtAttr-Slush Scene Bias',
    zExtAttr.ZSLUSHVERSION AS 'zExtAttr-Slush Version',
    zExtAttr.ZSLUSHPRESET AS 'zExtAttr-Slush Preset',
    zExtAttr.ZSLUSHWARMTHBIAS AS 'zExtAttr-Slush Warm Bias',
    zAsset.ZHEIGHT AS 'zAsset-Height',
    zAddAssetAttr.ZORIGINALHEIGHT AS 'zAddAssetAttr-Original Height',
    zIntResou.ZUNORIENTEDHEIGHT AS 'zIntResou-Unoriented Height',
    zAsset.ZWIDTH AS 'zAsset-Width',
    zAddAssetAttr.ZORIGINALWIDTH AS 'zAddAssetAttr-Original Width',
    zIntResou.ZUNORIENTEDWIDTH AS 'zIntResou-Unoriented Width',
    zShare.ZTHUMBNAILIMAGEDATA AS 'zShare-Thumbnail Image Data',
    zAsset.ZTHUMBNAILINDEX AS 'zAsset-Thumbnail Index',
    zAddAssetAttr.ZEMBEDDEDTHUMBNAILHEIGHT AS 'zAddAssetAttr-Embedded Thumbnail Height',
    zAddAssetAttr.ZEMBEDDEDTHUMBNAILLENGTH AS 'zAddAssetAttr-Embedded Thumbnail Length',
    zAddAssetAttr.ZEMBEDDEDTHUMBNAILOFFSET AS 'zAddAssetAttr-Embedded Thumbnail Offset',
    zAddAssetAttr.ZEMBEDDEDTHUMBNAILWIDTH AS 'zAddAssetAttr-Embedded Thumbnail Width',
    zAsset.ZPACKEDACCEPTABLECROPRECT AS 'zAsset-Packed Acceptable Crop Rect',
    zAsset.ZPACKEDBADGEATTRIBUTES AS 'zAsset-Packed Badge Attributes',
    zAsset.ZPACKEDPREFERREDCROPRECT AS 'zAsset-Packed Preferred Crop Rect',
    zAsset.ZCURATIONSCORE AS 'zAsset-Curation Score',
    zAsset.ZCAMERAPROCESSINGADJUSTMENTSTATE AS 'zAsset-Camera Processing Adjustment State',
    zAsset.ZDEPTHTYPE AS 'zAsset-Depth Type',
    zAsset.ZISMAGICCARPET AS 'zAsset-Is Magic Carpet',
    zAsset.ZLIBRARYSCOPE AS 'zAsset-Library Scope Key',
    CASE zAsset.ZLIBRARYSCOPESHARESTATE
        WHEN 0 THEN '0-StillTesting Not-Shared-0'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZLIBRARYSCOPESHARESTATE || ''
    END AS 'zAsset-Library Scope Share State',
    zAddAssetAttr.ZORIGINALRESOURCECHOICE AS 'zAddAssetAttr-Orig Resource Choice',
    zAddAssetAttr.ZSNOWDAYSNOWPLOWIDENTIFIER AS 'zAddAssetAttr-Snow Day Snow Plow ID',
    zAddAssetAttr.ZSPATIALOVERCAPTUREGROUPIDENTIFIER AS 'zAddAssetAttr-Spatial Over Capture Group ID',
    zAddAssetAttr.ZOBJECTSALIENCYRECTSDATA AS 'zAddAssetAttr-Object Saliency Rects Data/HEX NSKeyed Plist',
    zAddAssetAttr.ZORIGINALHASH AS 'zAddAssetAttr-Original Hash/HEX',
    zAddAssetAttr.ZPLACEANNOTATIONDATA AS 'zAddAssetAttr-Place Annotation Data',
    zAddAssetAttr.ZDISTANCEIDENTITY AS 'zAddAssetAttr-Distance Identity',
    zAssetDes.ZASSETATTRIBUTES AS 'zAssetDes-Asset Attributes Key=zAddAssetAttr.Z_PK',
    zAssetDes.ZLONGDESCRIPTION AS 'zAssetDes-Long Description',
    zAddAssetAttr.ZASSETDESCRIPTION AS 'zAddAssetAttr-Asset Description',
    zAddAssetAttr.ZTITLE AS 'zAddAssetAttr-Title/Comments via Cloud Website',
    zAddAssetAttr.ZACCESSIBILITYDESCRIPTION AS 'zAddAssetAttr-Accessibility Description',
    zAsset.ZCONVERSATION AS 'zAsset-Conversation',
    zAddAssetAttr.ZPHOTOSTREAMTAGID AS 'zAddAssetAttr-Photo Stream Tag ID',
    zAsset.ZMEDIAGROUPUUID AS 'zAsset-Media Group UUID',
    zAsset.ZPHOTOANALYSISATTRIBUTES AS 'zAsset-Photo Analysis Attributes Key',
    zPhotoAnalysisAssetAttr.Z_PK AS 'zPhotoAnalysisAssetAttr.Z_PK',
    zPhotoAnalysisAssetAttr.Z_ENT AS 'zPhotoAnalysisAssetAttr-zEnt',
    zPhotoAnalysisAssetAttr.Z_OPT AS 'zPhotoAnalysisAssetAttr-zOpt',
    zPhotoAnalysisAssetAttr.ZWALLPAPERPROPERTIESVERSION AS 'zPhotoAnalysisAssetAttr-Wallpaper Properties Version',
    zPhotoAnalysisAssetAttr.ZASSET AS 'zPhotoAnalysisAssetAttr-zAsset = zAsset.Z_PK',
    datetime(zPhotoAnalysisAssetAttr.ZWALLPAPERPROPERTIESTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'zPhotoAnalysisAssetAttr-Wallpaper Properties Timestamp',
    zPhotoAnalysisAssetAttr.ZWALLPAPERPROPERTIESDATA AS 'zPhotoAnalysisAssetAttr-Wallpaper Properties Data',
    datetime(zCldFeedEnt.ZENTRYDATE + 978307200, 'UNIXEPOCH') AS 'zCldFeedEnt-Entry Date',
    zCldFeedEnt.ZENTRYALBUMGUID AS 'zCldFeedEnt-Album-GUID=zGenAlbum.zCloudGUID',
    zCldFeedEnt.ZENTRYINVITATIONRECORDGUID AS 'zCldFeedEnt-Entry Invitation Record GUID',
    zCldFeedEnt.ZENTRYCLOUDASSETGUID AS 'zCldFeedEnt-Entry Cloud Asset GUID',
    CASE zCldFeedEnt.ZENTRYPRIORITYNUMBER
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zCldFeedEnt.ZENTRYPRIORITYNUMBER || ''
    END AS 'zCldFeedEnt-Entry Priority Number',
    CASE zCldFeedEnt.ZENTRYTYPENUMBER
        WHEN 1 THEN 'Is My Shared Asset-1'
        WHEN 2 THEN '2-StillTesting-2'
        WHEN 3 THEN '3-StillTesting-3'
        WHEN 4 THEN 'Not My Shared Asset-4'
        WHEN 5 THEN 'Asset in Album with Invite Record-5'
        ELSE 'Unknown-New-Value!: ' || zCldFeedEnt.ZENTRYTYPENUMBER || ''
    END AS 'zCldFeedEnt-Entry Type Number',
    zAsset.ZCLOUDFEEDASSETSENTRY AS 'zAsset-Cloud Feed Assets Entry=zCldFeedEnt.zPK',
    zCldFeedEnt.Z_PK AS 'zCldFeedEnt.Z_PK',
    zCldFeedEnt.Z_ENT AS 'zCldFeedEnt-zENT',
    zCldFeedEnt.Z_OPT AS 'zCldFeedEnt-zOPT',
    zAsset.Z_FOK_CLOUDFEEDASSETSENTRY AS 'zAsset-FOK-Cloud Feed Asset Entry Key',
    z28Assets.Z_FOK_3ASSETS AS 'z28Asset-FOK-3Assets=zAsset.Z_FOK_CLOUDFEEDASSETSENTRY',
    zCldSharedComment.ZCLOUDGUID AS 'zCldSharedComment-Cloud GUID',
    zCldSharedComment.ZCLOUDFEEDCOMMENTENTRY AS 'zCldSharedComment-CldFeedCommentEntry=zCldFeedEnt.zPK',
    zCldSharedComment.Z_PK AS 'zCldSharedComment.Z_PK',
    zCldSharedComment.Z_ENT AS 'zCldSharedComment-zENT',
    zCldSharedComment.Z_OPT AS 'zCldSharedComment-zOPT',
    zCldSharedComment.ZCOMMENTEDASSET AS 'zCldSharedComment-Commented Asset Key=zAsset.zPK',
    zCldSharedComment.Z_FOK_CLOUDFEEDCOMMENTENTRY AS 'zCldSharedComment-FOK-Cld-Feed-Comment-Entry-Key',
    datetime(zCldSharedComment.ZCOMMENTDATE + 978307200, 'UNIXEPOCH') AS 'zCldSharedComment-Date',
    datetime(zCldSharedComment.ZCOMMENTCLIENTDATE + 978307200, 'UNIXEPOCH') AS 'zCldSharedComment-Comment Client Date',
    datetime(zAsset.ZCLOUDLASTVIEWEDCOMMENTDATE + 978307200, 'UNIXEPOCH') AS 'zAsset-Cloud Last Viewed Comment Date',
    zCldSharedComment.ZCOMMENTTYPE AS 'zCldSharedComment-Type',
    zCldSharedComment.ZCOMMENTTEXT AS 'zCldSharedComment-Comment Text',
    zCldSharedComment.ZCOMMENTERHASHEDPERSONID AS 'zCldSharedComment-Commenter Hashed Person ID',
    CASE zCldSharedComment.ZISBATCHCOMMENT
        WHEN 0 THEN 'Not Batch Comment-0'
        WHEN 1 THEN 'Batch Comment-1'
        ELSE 'Unknown-New-Value!: ' || zCldSharedComment.ZISBATCHCOMMENT || ''
    END AS 'zCldSharedComment-Batch Comment',
    CASE zCldSharedComment.ZISCAPTION
        WHEN 0 THEN 'Not a Caption-0'
        WHEN 1 THEN 'Caption-1'
        ELSE 'Unknown-New-Value!: ' || zCldSharedComment.ZISCAPTION || ''
    END AS 'zCldSharedComment-Is a Caption',
    CASE zAsset.ZCLOUDHASCOMMENTSBYME
        WHEN 1 THEN 'Device Apple Acnt Commented/Liked Asset-1'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZCLOUDHASCOMMENTSBYME || ''
    END AS 'zAsset-Cloud Has Comments by Me',
    CASE zCldSharedComment.ZISMYCOMMENT
        WHEN 0 THEN 'Not My Comment-0'
        WHEN 1 THEN 'My Comment-1'
        ELSE 'Unknown-New-Value!: ' || zCldSharedComment.ZISMYCOMMENT || ''
    END AS 'zCldSharedComment-Is My Comment',
    CASE zCldSharedComment.ZISDELETABLE
        WHEN 0 THEN 'Not Deletable-0'
        WHEN 1 THEN 'Deletable-1'
        ELSE 'Unknown-New-Value!: ' || zCldSharedComment.ZISDELETABLE || ''
    END AS 'zCldSharedComment-Is Deletable',
    CASE zAsset.ZCLOUDHASCOMMENTSCONVERSATION
        WHEN 1 THEN 'Device Apple Acnt Commented/Liked Conversation-1'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZCLOUDHASCOMMENTSCONVERSATION || ''
    END AS 'zAsset-Cloud Has Comments Conversation',
    CASE zAsset.ZCLOUDHASUNSEENCOMMENTS
        WHEN 0 THEN 'zAsset No Unseen Comments-0'
        WHEN 1 THEN 'zAsset Unseen Comments-1'
        ELSE 'Unknown-New-Value!: ' || zAsset.ZCLOUDHASUNSEENCOMMENTS || ''
    END AS 'zAsset-Cloud Has Unseen Comments',
    zCldSharedCommentLiked.ZCLOUDFEEDLIKECOMMENTENTRY AS 'zCldSharedComment-CldFeedLikeCommentEntry Key',
    zCldSharedCommentLiked.ZLIKEDASSET AS 'zCldSharedComment-Liked Asset Key=zAsset.zPK',
    zCldSharedCommentLiked.Z_FOK_CLOUDFEEDLIKECOMMENTENTRY AS 'zCldSharedComment-FOK-Cld-Feed-Like-Comment-Entry-Key',
    CASE zCldSharedCommentLiked.ZISLIKE
        WHEN 0 THEN 'Asset Not Liked-0'
        WHEN 1 THEN 'Asset Liked-1'
        ELSE 'Unknown-New-Value!: ' || zCldSharedCommentLiked.ZISLIKE || ''
    END AS 'zCldSharedComment-Liked',
    zAssetContrib.Z_PK AS 'zAsstContrib.Z_PK',
    zAssetContrib.Z_ENT AS 'zAsstContrib-zEnt',
    zAssetContrib.Z_OPT AS 'zAsstContrib-zOpt',
    zAssetContrib.ZPARTICIPANT AS 'zAsstContrib-Participant ????=zSharePartic.Z_PK',
    zAssetContrib.Z3LIBRARYSCOPEASSETCONTRIBUTORS AS 'zAsstContrib-3Library Scope Asset Contributors',
    zSharePartic.Z_PK AS 'zSharePartic.Z_PK',
    zSharePartic.Z_ENT AS 'zSharePartic-zENT',
    zSharePartic.Z_OPT AS 'zSharePartic-zOPT',
    zSharePartic.ZROLE AS 'zSharePartic-Role',
    zSharePartic.ZSHARE AS 'zSharePartic-Share Key =zShare.Z_PK',
    zSharePartic.ZPARTICIPANTID AS 'zSharePartic-Participant ID',
    zSharePartic.ZUSERIDENTIFIER AS 'zSharePartic-User ID',
    zSharePartic.ZPERSON AS 'zSharePartic-Person =zPerson.Z_PK',
    zSharePartic.ZACCEPTANCESTATUS AS 'zSharePartic-Acceptance Status',
    zSharePartic.ZEMAILADDRESS AS 'zSharePartic-Email Address',
    zSharePartic.ZPHONENUMBER AS 'zSharePartic-Phone Number',
    zSharePartic.ZUUID AS 'zSharePartic-UUID',
    zSharePartic.ZNAMECOMPONENTS AS 'zSharePartic-Name Components',
    zSharePartic.Z54_SHARE AS 'zSharePartic-54Share',
    zSharePartic.ZPERMISSION AS 'zSharePartic-Premission',
    zSharePartic.ZISCURRENTUSER AS 'zSharePartic-Is Current User',
    ParentzGenAlbum.ZUUID AS 'ParentzGenAlbum-UUID',
    ParentzGenAlbum.ZCLOUDGUID AS 'ParentzGenAlbum-Cloud GUID',
    ParentzGenAlbum.Z_PK AS 'ParentzGenAlbum.Z_PK',
    CASE ParentzGenAlbum.ZKIND
        WHEN 2 THEN '2-Local Device-iCloud Photos Album-2'
        WHEN 1505 THEN '1505-Shared Album-1505'
        WHEN 1506 THEN '1506-Import_Session_AssetsImportedatSameTime-1506_RT'
        WHEN 1508 THEN '1508-My_Projects_Album_CalendarCardEct_RT'
        WHEN 1510 THEN '1510-Duplicate_Album-Pending_Merge-1510'
        WHEN 1552 THEN '1552-StillTesting'
        WHEN 1600 THEN '1600-StillTesting'
        WHEN 1602 THEN '1602-StillTesting'
        WHEN 1605 THEN '1605-StillTesting'
        WHEN 1606 THEN '1606-StillTesting'
        WHEN 1607 THEN '1607-StillTesting'
        WHEN 1608 THEN '1608-StillTesting'
        WHEN 1609 THEN '1609-StillTesting'
        WHEN 1610 THEN '1610-StillTesting'
        WHEN 1611 THEN '1611-StillTesting'
        WHEN 1612 THEN '1612-StillTesting'
        WHEN 1613 THEN '1613-StillTesting'
        WHEN 1614 THEN '1614-StillTesting'
        WHEN 1615 THEN '1615-StillTesting'
        WHEN 1616 THEN '1616-StillTesting'
        WHEN 1617 THEN '1617-StillTesting'
        WHEN 1618 THEN '1618-StillTesting'
        WHEN 1619 THEN '1619-StillTesting'
        WHEN 1620 THEN '1620-StillTesting'
        WHEN 1621 THEN '1621-StillTesting'
        WHEN 1622 THEN '1622-StillTesting'
        WHEN 1623 THEN '1623-StillTesting'
        WHEN 1624 THEN '1624-StillTesting'
        WHEN 1625 THEN '1625-StillTesting'
        WHEN 1626 THEN '1626-StillTesting'
        WHEN 1627 THEN '1627-StillTesting'
        WHEN 1628 THEN '1628-StillTesting'
        WHEN 1630 THEN '1630-StillTesting'
        WHEN 3571 THEN '3571-Progress-Sync-3571'
        WHEN 3572 THEN '3572-Progress-OTA-Restore-3572'
        WHEN 3573 THEN '3573-Progress-FS-Import-3573'
        WHEN 3998 THEN '3998-Project Root Folder-3998'
        WHEN 3999 THEN '3999-Parent_Folder_for_Generic_Album-3999'
        WHEN 4000 THEN '4000-Parent_is_Folder_on_Local_Device-4000'
        WHEN 4001 THEN '4001-StillTesting'
        WHEN 4002 THEN '4002-StillTesting'
        WHEN 4003 THEN '4003-StillTesting'
        ELSE 'Unknown-New-Value!: ' || ParentzGenAlbum.ZKIND || ''
    END AS 'ParentzGenAlbum-Kind',
    CASE ParentzGenAlbum.ZCLOUDLOCALSTATE
        WHEN 0 THEN '0-iCldPhotos-ON=Asset_In_Shared/Other_Album/iCldPhotos-OFF=Generic_Album-0'
        WHEN 1 THEN '1-iCldPhotos-ON=Asset_In_Generic_Album-1'
        ELSE 'Unknown-New-Value!: ' || ParentzGenAlbum.ZCLOUDLOCALSTATE || ''
    END AS 'ParentzGenAlbum-Cloud-Local-State',
    ParentzGenAlbum.ZTITLE AS 'ParentzGenAlbum-Title',
    datetime(ParentzGenAlbum.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'ParentzGenAlbum-Creation Date',
    ParentzGenAlbum.ZPENDINGITEMSCOUNT AS 'ParentzGenAlbum-Pending Items Count',
    CASE ParentzGenAlbum.ZPENDINGITEMSTYPE
        WHEN 1 THEN 'No-1'
        WHEN 24 THEN '24-StillTesting'
        ELSE 'Unknown-New-Value!: ' || ParentzGenAlbum.ZPENDINGITEMSTYPE || ''
    END AS 'ParentzGenAlbum-Pending Items Type',
    ParentzGenAlbum.ZSYNCEVENTORDERKEY AS 'ParentzGenAlbum-Sync Event Order Key',
    CASE ParentzGenAlbum.ZISPINNED
        WHEN 0 THEN '0-ParentzGenAlbum Not Pinned-0'
        WHEN 1 THEN '1-ParentzGenAlbum Pinned-1'
        ELSE 'Unknown-New-Value!: ' || ParentzGenAlbum.ZISPINNED || ''
    END AS 'ParentzGenAlbum-Pinned',
    CASE ParentzGenAlbum.ZCUSTOMSORTKEY
        WHEN 0 THEN '0-zGenAlbum-Sorted_Manually-0_RT'
        WHEN 1 THEN '1-zGenAlbum-CusSrtAsc0=Sorted_Newest_First/CusSrtAsc1=Sorted_Oldest_First-1-RT'
        WHEN 5 THEN '5-zGenAlbum-Sorted_by_Title-5_RT'
        ELSE 'Unknown-New-Value!: ' || ParentzGenAlbum.ZCUSTOMSORTKEY || ''
    END AS 'ParentzGenAlbum-Custom Sort Key',
    CASE ParentzGenAlbum.ZCUSTOMSORTASCENDING
        WHEN 0 THEN '0-zGenAlbum-Sorted_Newest_First-0'
        WHEN 1 THEN '1-zGenAlbum-Sorted_Oldest_First-1'
        ELSE 'Unknown-New-Value!: ' || ParentzGenAlbum.ZCUSTOMSORTASCENDING || ''
    END AS 'ParentzGenAlbum-Custom Sort Ascending',
    CASE ParentzGenAlbum.ZISPROTOTYPE
        WHEN 0 THEN '0-ParentzGenAlbum Not Prototype-0'
        WHEN 1 THEN '1-ParentzGenAlbum Prototype-1'
        ELSE 'Unknown-New-Value!: ' || ParentzGenAlbum.ZISPROTOTYPE || ''
    END AS 'ParentzGenAlbum-Is Prototype',
    CASE ParentzGenAlbum.ZTRASHEDSTATE
        WHEN 0 THEN '0-ParentzGenAlbum Not In Trash-0'
        WHEN 1 THEN '1-ParentzGenAlbum Album In Trash-1'
        ELSE 'Unknown-New-Value!: ' || ParentzGenAlbum.ZTRASHEDSTATE || ''
    END AS 'ParentzGenAlbum-Trashed State',
    datetime(ParentzGenAlbum.ZTRASHEDDATE + 978307200, 'UNIXEPOCH') AS 'ParentzGenAlbum-Trash Date',
    CASE ParentzGenAlbum.ZCLOUDDELETESTATE
        WHEN 0 THEN '0-ParentzGenAlbum Cloud Not Deleted-0'
        WHEN 1 THEN '1-ParentzGenAlbum Cloud Album Deleted-1'
        ELSE 'Unknown-New-Value!: ' || ParentzGenAlbum.ZCLOUDDELETESTATE || ''
    END AS 'ParentzGenAlbum-Cloud Delete State',
    z28Assets.Z_28ALBUMS AS 'z28Assets-28Albums=zGenAlbum.Z_PK',
    z27AlbumLists.Z_27ALBUMS AS 'z27AlbumList-27Albums=zGenAlbum.Z_PK',
    zGenAlbum.Z_PK AS 'zGenAlbum.Z_PK=26AlbumLists=26Albums',
    zGenAlbum.Z_ENT AS 'zGenAlbum-zEnt',
    zGenAlbum.Z_OPT AS 'zGenAlbum-zOpt',
    zGenAlbum.ZKEYASSET AS 'zGenAlbum-Key Asset/Key zAsset.Z_PK',
    z28Assets.Z_3ASSETS AS 'z28Assets-3Asset Key=zAsset.Z_PK in the Album',
    z28Assets.Z_FOK_3ASSETS AS 'z28Assets-FOK3Assets Key',
    zGenAlbum.ZSECONDARYKEYASSET AS 'zGenAlbum-Secondary Key Asset',
    zGenAlbum.ZTERTIARYKEYASSET AS 'zGenAlbum-Tertiary Key Asset',
    zGenAlbum.ZCUSTOMKEYASSET AS 'zGenAlbum-Custom Key Asset',
    zGenAlbum.ZSYNDICATE AS 'zGenAlbum-zSyndicate',
    zGenAlbum.ZIMPORTEDBYBUNDLEIDENTIFIER AS 'zGenAlbum-Imported by Bundle Identifier',
    zGenAlbum.ZIMPORTSESSIONID AS 'zGenAlbum-Import Session ID',
    zGenAlbum.ZPARENTFOLDER AS 'zGenAlbum-Parent Folder Key=zGenAlbum.Z_PK',
    zGenAlbum.Z_FOK_PARENTFOLDER AS 'zGenAlbum-FOK Parent Folder',
    CASE zGenAlbum.ZKIND
        WHEN 2 THEN '2-Local Device-iCloud Photos Album-2'
        WHEN 1505 THEN '1505-Shared Album-1505'
        WHEN 1506 THEN '1506-Import_Session_AssetsImportedatSameTime-1506_RT'
        WHEN 1508 THEN '1508-My_Projects_Album_CalendarCardEct_RT'
        WHEN 1510 THEN '1510-Duplicate_Album-Pending_Merge-1510'
        WHEN 1552 THEN '1552-StillTesting'
        WHEN 1600 THEN '1600-StillTesting'
        WHEN 1602 THEN '1602-StillTesting'
        WHEN 1605 THEN '1605-StillTesting'
        WHEN 1606 THEN '1606-StillTesting'
        WHEN 1607 THEN '1607-StillTesting'
        WHEN 1608 THEN '1608-StillTesting'
        WHEN 1609 THEN '1609-StillTesting'
        WHEN 1610 THEN '1610-StillTesting'
        WHEN 1611 THEN '1611-StillTesting'
        WHEN 1612 THEN '1612-StillTesting'
        WHEN 1613 THEN '1613-StillTesting'
        WHEN 1614 THEN '1614-StillTesting'
        WHEN 1615 THEN '1615-StillTesting'
        WHEN 1616 THEN '1616-StillTesting'
        WHEN 1617 THEN '1617-StillTesting'
        WHEN 1618 THEN '1618-StillTesting'
        WHEN 1619 THEN '1619-StillTesting'
        WHEN 1620 THEN '1620-StillTesting'
        WHEN 1621 THEN '1621-StillTesting'
        WHEN 1622 THEN '1622-StillTesting'
        WHEN 1623 THEN '1623-StillTesting'
        WHEN 1624 THEN '1624-StillTesting'
        WHEN 1625 THEN '1625-StillTesting'
        WHEN 1626 THEN '1626-StillTesting'
        WHEN 1627 THEN '1627-StillTesting'
        WHEN 1628 THEN '1628-StillTesting'
        WHEN 1630 THEN '1630-StillTesting'
        WHEN 3571 THEN '3571-Progress-Sync-3571'
        WHEN 3572 THEN '3572-Progress-OTA-Restore-3572'
        WHEN 3573 THEN '3573-Progress-FS-Import-3573'
        WHEN 3998 THEN '3998-Project Root Folder-3998'
        WHEN 3999 THEN '3999-Parent_is_Root_containing_Generic_Album_on_Local_Device-3999'
        WHEN 4000 THEN '4000-Parent_is_Sub-Folder_containing_Generic_Album_on_Local_Device-4000'
        WHEN 4001 THEN '4001-StillTesting'
        WHEN 4002 THEN '4002-StillTesting'
        WHEN 4003 THEN '4003-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zGenAlbum.ZKIND || ''
    END AS 'zGenAlbum-Album Kind',
    CASE zGenAlbum.ZCLOUDLOCALSTATE
        WHEN 0 THEN '0-iCldPhotos-ON=Asset_In_Shared/Other-Album/iCldPhotos-OFF=Generic_Album-0'
        WHEN 1 THEN '1-iCldPhotos-ON=Asset_In_Generic_Album-1'
        ELSE 'Unknown-New-Value!: ' || zGenAlbum.ZCLOUDLOCALSTATE || ''
    END AS 'zGenAlbum-Cloud_Local_State',
    zGenAlbum.ZTITLE AS 'zGenAlbum-Title/User&System Applied',
    datetime(zGenAlbum.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'zGenAlbum-Creation Date',
    datetime(zGenAlbum.ZCLOUDCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'zGenAlbum-Cloud Creation Date',
    datetime(zGenAlbum.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'zGenAlbum-Start Date',
    datetime(zGenAlbum.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'zGenAlbum-End Date',
    datetime(zGenAlbum.ZCLOUDSUBSCRIPTIONDATE + 978307200, 'UNIXEPOCH') AS 'zGenAlbum-Cloud Subscription Date',
    zGenAlbum.ZCLOUDMETADATA AS 'zGenAlbum-Cloud Metadata/HEX NSKeyed Plist',
    zGenAlbum.ZPENDINGITEMSCOUNT AS 'zGenAlbum-Pending Items Count',
    CASE zGenAlbum.ZPENDINGITEMSTYPE
        WHEN 1 THEN 'No-1'
        WHEN 24 THEN '24-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zGenAlbum.ZPENDINGITEMSTYPE || ''
    END AS 'zGenAlbum-Pending Items Type',
    zGenAlbum.ZCACHEDPHOTOSCOUNT AS 'zGenAlbum-Cached Photos Count',
    zGenAlbum.ZCACHEDVIDEOSCOUNT AS 'zGenAlbum-Cached Videos Count',
    zGenAlbum.ZCACHEDCOUNT AS 'zGenAlbum-Cached Count',
    zGenAlbum.ZUUID AS 'zGenAlbum-UUID',
    zGenAlbum.ZCLOUDGUID AS 'zGenAlbum-Cloud GUID',
    zCldShareAlbumInvRec.ZALBUMGUID AS 'zCldShareAlbumInvRec-Album GUID',
    zCldShareAlbumInvRec.ZCLOUDGUID AS 'zCldShareAlbumInvRec-Cloud GUID',
    zGenAlbum.ZPROJECTRENDERUUID AS 'zGenAlbum-Project Render UUID',
    zGenAlbum.ZSYNCEVENTORDERKEY AS 'zGenAlbum-Sync Event Order Key',
    CASE zGenAlbum.ZHASUNSEENCONTENT
        WHEN 0 THEN 'zGenAlbum Has No Unseen Content-0'
        WHEN 1 THEN 'zGenAlbum Has Unseen Content-1'
        ELSE 'Unknown-New-Value!: ' || zGenAlbum.ZHASUNSEENCONTENT || ''
    END AS 'zGenAlbum-Has Unseen Content',
    zGenAlbum.ZUNSEENASSETSCOUNT AS 'zGenAlbum-Unseen Asset Count',
    CASE zGenAlbum.ZISOWNED
        WHEN 0 THEN 'zGenAlbum-Not Owned by Device Apple Acnt-0'
        WHEN 1 THEN 'zGenAlbum-Owned by Device Apple Acnt-1'
        ELSE 'Unknown-New-Value!: ' || zGenAlbum.ZISOWNED || ''
    END AS 'zGenAlbum-is Owned',
    CASE zGenAlbum.ZCLOUDRELATIONSHIPSTATE
        WHEN 0 THEN 'zGenAlbum-Cloud Album Owned by Device Apple Acnt-0'
        WHEN 2 THEN 'zGenAlbum-Cloud Album Not Owned by Device Apple Acnt-2'
        ELSE 'Unknown-New-Value!: ' || zGenAlbum.ZCLOUDRELATIONSHIPSTATE || ''
    END AS 'zGenAlbum-Cloud Relationship State',
    CASE zGenAlbum.ZCLOUDRELATIONSHIPSTATELOCAL
        WHEN 0 THEN 'zGenAlbum-Shared Album Accessible Local Device-0'
        WHEN 1 THEN '1-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zGenAlbum.ZCLOUDRELATIONSHIPSTATELOCAL || ''
    END AS 'zGenAlbum-Cloud Relationship State Local',
    zGenAlbum.ZCLOUDOWNEREMAILKEY AS 'zGenAlbum-Cloud Owner Mail Key',
    zGenAlbum.ZCLOUDOWNERFIRSTNAME AS 'zGenAlbum-Cloud Owner Frist Name',
    zGenAlbum.ZCLOUDOWNERLASTNAME AS 'zGenAlbum-Cloud Owner Last Name',
    zGenAlbum.ZCLOUDOWNERFULLNAME AS 'zGenAlbum-Cloud Owner Full Name',
    zGenAlbum.ZCLOUDPERSONID AS 'zGenAlbum-Cloud Person ID',
    zGenAlbum.ZCLOUDOWNERHASHEDPERSONID AS 'zGenAlbum-Cloud Owner Hashed Person ID',
    zAsset.ZCLOUDOWNERHASHEDPERSONID AS 'zAsset-Cloud Owner Hashed Person ID',
    CASE zGenAlbum.ZCLOUDMULTIPLECONTRIBUTORSENABLEDLOCAL
        WHEN 0 THEN 'zGenAlbum-Local Cloud Single Contributor Enabled-0'
        WHEN 1 THEN 'zGenAlbum-Local Cloud Multi-Contributors Enabled-1'
        ELSE 'Unknown-New-Value!: ' || zGenAlbum.ZCLOUDMULTIPLECONTRIBUTORSENABLEDLOCAL || ''
    END AS 'zGenAlbum-Local Cloud Multi-Contributors Enabled',
    CASE zGenAlbum.ZCLOUDMULTIPLECONTRIBUTORSENABLED
        WHEN 0 THEN 'zGenAlbum-Cloud Single Contributor Enabled-0'
        WHEN 1 THEN 'zGenAlbum-Cloud Multi-Contributors Enabled-1'
        ELSE 'Unknown-New-Value!: ' || zGenAlbum.ZCLOUDMULTIPLECONTRIBUTORSENABLED || ''
    END AS 'zGenAlbum-Cloud Multi-Contributors Enabled',
    CASE zGenAlbum.ZCLOUDALBUMSUBTYPE
        WHEN 0 THEN 'zGenAlbum Multi-Contributor-0'
        ELSE 'Unknown-New-Value!: ' || zGenAlbum.ZCLOUDALBUMSUBTYPE || ''
    END AS 'zGenAlbum-Cloud Album Sub Type',
    datetime(zGenAlbum.ZCLOUDLASTCONTRIBUTIONDATE + 978307200, 'UNIXEPOCH') AS 'zGenAlbum-Cloud Contribution Date',
    datetime(zGenAlbum.ZCLOUDLASTINTERESTINGCHANGEDATE + 978307200, 'UNIXEPOCH') AS 'zGenAlbum-Cloud Last Interesting Change Date',
    CASE zGenAlbum.ZCLOUDNOTIFICATIONSENABLED
        WHEN 0 THEN 'zGenAlbum-Cloud Notifications Disabled-0'
        WHEN 1 THEN 'zGenAlbum-Cloud Notifications Enabled-1'
        ELSE 'Unknown-New-Value!: ' || zGenAlbum.ZCLOUDNOTIFICATIONSENABLED || ''
    END AS 'zGenAlbum-Cloud Notification Enabled',
    CASE zGenAlbum.ZISPINNED
        WHEN 0 THEN 'zGenAlbum-Local Not Pinned-0'
        WHEN 1 THEN 'zGenAlbum-Local Pinned-1'
        ELSE 'Unknown-New-Value!: ' || zGenAlbum.ZISPINNED || ''
    END AS 'zGenAlbum-Pinned',
    CASE zGenAlbum.ZCUSTOMSORTKEY
        WHEN 0 THEN '0-zGenAlbum-Sorted_Manually-0_RT'
        WHEN 1 THEN '1-zGenAlbum-CusSrtAsc0=Sorted_Newest_First/CusSrtAsc1=Sorted_Oldest_First-1-RT'
        WHEN 5 THEN '5-zGenAlbum-Sorted_by_Title-5_RT'
        ELSE 'Unknown-New-Value!: ' || zGenAlbum.ZCUSTOMSORTKEY || ''
    END AS 'zGenAlbum-Custom Sort Key',
    CASE zGenAlbum.ZCUSTOMSORTASCENDING
        WHEN 0 THEN '0-zGenAlbum-Sorted_Newest_First-0'
        WHEN 1 THEN '1-zGenAlbum-Sorted_Oldest_First-1'
        ELSE 'Unknown-New-Value!: ' || zGenAlbum.ZCUSTOMSORTASCENDING || ''
    END AS 'zGenAlbum-Custom Sort Ascending',
    CASE zGenAlbum.ZISPROTOTYPE
        WHEN 0 THEN 'zGenAlbum-Not Prototype-0'
        WHEN 1 THEN 'zGenAlbum-Prototype-1'
        ELSE 'Unknown-New-Value!: ' || zGenAlbum.ZISPROTOTYPE || ''
    END AS 'zGenAlbum-Is Prototype',
    CASE zGenAlbum.ZPROJECTDOCUMENTTYPE
        WHEN 0 THEN '0-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zGenAlbum.ZPROJECTDOCUMENTTYPE || ''
    END AS 'zGenAlbum-Project Document Type',
    CASE zGenAlbum.ZCUSTOMQUERYTYPE
        WHEN 0 THEN '0-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zGenAlbum.ZCUSTOMQUERYTYPE || ''
    END AS 'zGenAlbum-Custom Query Type',
    CASE zGenAlbum.ZTRASHEDSTATE
        WHEN 0 THEN 'zGenAlbum Not In Trash-0'
        WHEN 1 THEN 'zGenAlbum Album In Trash-1'
        ELSE 'Unknown-New-Value!: ' || zGenAlbum.ZTRASHEDSTATE || ''
    END AS 'zGenAlbum-Trashed State',
    datetime(zGenAlbum.ZTRASHEDDATE + 978307200, 'UNIXEPOCH') AS 'zGenAlbum-Trash Date',
    CASE zGenAlbum.ZCLOUDDELETESTATE
        WHEN 0 THEN 'zGenAlbum Cloud Not Deleted-0'
        WHEN 1 THEN 'zGenAlbum Cloud Album Deleted-1'
        ELSE 'Unknown-New-Value!: ' || zGenAlbum.ZCLOUDDELETESTATE || ''
    END AS 'zGenAlbum-Cloud Delete State',
    CASE zGenAlbum.ZCLOUDOWNERISWHITELISTED
        WHEN 0 THEN 'zGenAlbum Cloud Owner Not Whitelisted-0'
        WHEN 1 THEN 'zGenAlbum Cloud Owner Whitelisted-1'
        ELSE 'Unknown-New-Value!: ' || zGenAlbum.ZCLOUDOWNERISWHITELISTED || ''
    END AS 'zGenAlbum-Cloud Owner Whitelisted',
    CASE zGenAlbum.ZCLOUDPUBLICURLENABLEDLOCAL
        WHEN 0 THEN 'zGenAlbum Cloud Local Public URL Disabled-0'
        WHEN 1 THEN 'zGenAlbum Cloud Local has Public URL Enabled-1'
        ELSE 'Unknown-New-Value!: ' || zGenAlbum.ZCLOUDPUBLICURLENABLEDLOCAL || ''
    END AS 'zGenAlbum-Cloud Local Public URL Enabled',
    CASE zGenAlbum.ZCLOUDPUBLICURLENABLED
        WHEN 0 THEN 'zGenAlbum Cloud Public URL Disabled-0'
        WHEN 1 THEN 'zGenAlbum Cloud Public URL Enabled-1'
        ELSE 'Unknown-New-Value!: ' || zGenAlbum.ZCLOUDPUBLICURLENABLED || ''
    END AS 'zGenAlbum-Cloud Public URL Enabled',
    zGenAlbum.ZPUBLICURL AS 'zGenAlbum-Public URL',
    zGenAlbum.ZKEYASSETFACETHUMBNAILINDEX AS 'zGenAlbum-Key Asset Face Thumb Index',
    zGenAlbum.ZPROJECTEXTENSIONIDENTIFIER AS 'zGenAlbum-Project Text Extension ID',
    zGenAlbum.ZUSERQUERYDATA AS 'zGenAlbum-User Query Data',
    zGenAlbum.ZCUSTOMQUERYPARAMETERS AS 'zGenAlbum-Custom Query Parameters',
    zGenAlbum.ZPROJECTDATA AS 'zGenAlbum-Project Data',
    CASE zGenAlbum.ZSEARCHINDEXREBUILDSTATE
        WHEN 0 THEN '0-StillTesting GenAlbm-Search Index State-0'
        WHEN 1 THEN '1-StillTesting GenAlbm-Search Index State-1'
        WHEN 2 THEN '2-StillTesting GenAlbm-Search Index State-2'
        ELSE 'Unknown-New-Value!: ' || zGenAlbum.ZSEARCHINDEXREBUILDSTATE || ''
    END AS 'zGenAlbum-Search Index Rebuild State',
    CASE zGenAlbum.ZDUPLICATETYPE
        WHEN 0 THEN '0-StillTesting GenAlbumDuplicateType-0'
        WHEN 1 THEN 'Duplicate Asset_Pending-Merge-1'
        WHEN 2 THEN '2-StillTesting GenAlbumDuplicateType-2'
        ELSE 'Unknown-New-Value!: ' || zGenAlbum.ZDUPLICATETYPE || ''
    END AS 'zGenAlbum-Duplicate Type',
    CASE zGenAlbum.ZPRIVACYSTATE
        WHEN 0 THEN '0-StillTesting GenAlbm-Privacy State-0'
        WHEN 1 THEN '1-StillTesting GenAlbm-Privacy State-1'
        WHEN 2 THEN '2-StillTesting GenAlbm-Privacy State-2'
        ELSE 'Unknown-New-Value!: ' || zGenAlbum.ZPRIVACYSTATE || ''
    END AS 'zGenAlbum-Privacy State',
    zAlbumList.ZUUID AS 'zAlbumList-UUID',
    z27AlbumLists.Z_2ALBUMLISTS AS 'z27AlbumList-Album List Key',
    z27AlbumLists.Z_FOK_27ALBUMS AS 'z27AlbumList-FOK27Albums Key',
    zAlbumList.Z_PK AS 'zAlbumList.Z_PK/Album List Key',
    zAlbumList.Z_ENT AS 'zAlbumList-zENT',
    zAlbumList.Z_OPT AS 'zAlbumList-zOPT',
    zAlbumList.ZIDENTIFIER AS 'zAlbumList-ID Key',
    CASE zAlbumList.ZNEEDSREORDERINGNUMBER
        WHEN 1 THEN '1-Yes-1'
        ELSE 'Unknown-New-Value!: ' || zAlbumList.ZNEEDSREORDERINGNUMBER || ''
    END AS 'zAlbumList-Needs Reordering Number',
    zCldShareAlbumInvRec.ZUUID AS 'zCldShareAlbumInvRec-zUUID',
    zCldShareAlbumInvRec.ZALBUM AS 'zCldShareAlbumInvRec-Album Key',
    zCldShareAlbumInvRec.Z_PK AS 'zCldShareAlbumInvRec.Z_PK',
    zCldShareAlbumInvRec.Z_ENT AS 'zCldShareAlbumInvRec-zEnt',
    zCldShareAlbumInvRec.Z_OPT AS 'zCldShareAlbumInvRec-zOpt',
    zCldShareAlbumInvRec.Z_FOK_ALBUM AS 'zCldShareAlbumInvRec-FOK Album Key',
    CASE zCldShareAlbumInvRec.ZISMINE
        WHEN 0 THEN 'Not My Invitation-0'
        WHEN 1 THEN 'My Invitation-1'
        ELSE 'Unknown-New-Value!: ' || zCldShareAlbumInvRec.ZISMINE || ''
    END AS 'zCldShareAlbumInvRec-Is My Invitation to Shared Album',
    CASE zCldShareAlbumInvRec.ZINVITATIONSTATELOCAL
        WHEN 0 THEN '0-StillTesting-0'
        WHEN 1 THEN '1-StillTesting-1'
        ELSE 'Unknown-New-Value!: ' || zCldShareAlbumInvRec.ZINVITATIONSTATELOCAL || ''
    END AS 'zCldShareAlbumInvRec-Invitation State Local',
    CASE zCldShareAlbumInvRec.ZINVITATIONSTATE
        WHEN 1 THEN 'Shared Album Invitation Pending-1'
        WHEN 2 THEN 'Shared Album Invitation Accepted-2'
        WHEN 3 THEN 'Shared Album Invitation Declined-3'
        WHEN 4 THEN '4-StillTesting'
        WHEN 5 THEN '5-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zCldShareAlbumInvRec.ZINVITATIONSTATE || ''
    END AS 'zCldShareAlbumInvRec-Invitation State/Shared Album Invite Status',
    datetime(zCldShareAlbumInvRec.ZINVITEESUBSCRIPTIONDATE + 978307200, 'UNIXEPOCH') AS 'zCldShareAlbumInvRec-Subscription Date',
    zCldShareAlbumInvRec.ZINVITEEFIRSTNAME AS 'zCldShareAlbumInvRec-Invitee First Name',
    zCldShareAlbumInvRec.ZINVITEELASTNAME AS 'zCldShareAlbumInvRec-Invitee Last Name',
    zCldShareAlbumInvRec.ZINVITEEFULLNAME AS 'zCldShareAlbumInvRec-Invitee Full Name',
    zCldShareAlbumInvRec.ZINVITEEHASHEDPERSONID AS 'zCldShareAlbumInvRec-Invitee Hashed Person ID',
    zCldShareAlbumInvRec.ZINVITEEEMAILKEY AS 'zCldShareAlbumInvRec-Invitee Email Key/UnknownData',
    CASE zAddAssetAttr.ZSHARETYPE
        WHEN 0 THEN 'Not_iCloudLink-CMMomentAsset-0'
        WHEN 1 THEN 'iCloudLink-CMMomentAsset-1'
        ELSE 'Unknown-New-Value!: ' || zAddAssetAttr.ZSHARETYPE || ''
    END AS 'zAddAssetAttr-Share Type',
    zCldMast.ZMOMENTSHARE AS 'zCldMast-Moment Share Key=zShare.Z_PK',
    zAsset.ZMOMENTSHARE AS 'zAsset-Moment Share Key=zShare.Z_PK',
    zShare.Z_PK AS 'zShare.Z_PK',
    zShare.Z_ENT AS 'zShare-zENT',
    zShare.Z_OPT AS 'zShare-zOPT',
    CASE zShare.ZSTATUS
        WHEN 1 THEN 'Asset Shared via Copy iCloud Link-1'
        WHEN 3 THEN 'CMM_SWY_Syndication_Asset-3'
        ELSE 'Unknown-New-Value!: ' || zShare.ZSTATUS || ''
    END AS 'zShare-Status',
    datetime(zShare.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'zShare-Creation Date-iCldLnk-Created Timestamp',
    datetime(zShare.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'zShare-Start Date-iCldLnk-1st Asset Created Timestamp',
    datetime(zShare.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'zShare-End Date-iCldLnk-Last Asset Created Timestamp',
    datetime(zShare.ZEXPIRYDATE + 978307200, 'UNIXEPOCH') AS 'zShare-Expiry Date-iCldLnk-Expiration Timestamp',
    zShare.ZTITLE AS 'zShare-Title-iCldLnk-Title-zPH-Subtitle-VerboseDescription',
    zShare.ZSHAREURL AS 'zShare-Share URL-iCldLnk-URL',
    CASE zShare.ZPARTICIPANTCLOUDUPDATESTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zShare.ZPARTICIPANTCLOUDUPDATESTATE || ''
    END AS 'zShare-Participant Cloud Update State-New ios16',
    zShare.ZASSETCOUNT AS 'zShare-Asset Count-iCldLnk-Asset Count',
    zShare.ZCLOUDITEMCOUNT AS 'zShare-Cloud Item Count',
    zShare.ZPHOTOSCOUNT AS 'zShare-Photos Count-iCldLnk-Photos Count',
    zShare.ZCLOUDPHOTOCOUNT AS 'zShare-Cloud Photo Count',
    zShare.ZUPLOADEDPHOTOSCOUNT AS 'zShare-Uploaded Photos Count-iCldLnk-Photos Upload Count',
    zShare.ZVIDEOSCOUNT AS 'zShare-Videos Count-iCldLnk-Videos Count',
    zShare.ZCLOUDVIDEOCOUNT AS 'zShare-Cloud Video Count',
    zShare.ZUPLOADEDVIDEOSCOUNT AS 'zShare-Uploaded Videos Count-iCldLnk-Videos Upload Count',
    zShare.ZFORCESYNCATTEMPTED AS 'zShare-Force Sync Attempted-iCldLnk-Force Sync',
    zShare.ZAUTOSHAREPOLICY AS 'zShare-Auto Share Policy',
    zShare.ZRULESDATA AS 'zShare-Rules Data/HEX',
    CASE zShare.ZCLOUDLOCALSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zShare.ZCLOUDLOCALSTATE || ''
    END AS 'zShare-Cloud Local State-New ios16',
    CASE zShare.ZPREVIEWSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zShare.ZPREVIEWSTATE || ''
    END AS 'zShare-Preview State-New ios16',
    CASE zShare.ZEXITSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zShare.ZEXITSTATE || ''
    END AS 'zShare-Exit State-New ios16',
    CASE zShare.ZSCOPESYNCINGSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zShare.ZSCOPESYNCINGSTATE || ''
    END AS 'zShare-Scope Syncing State-New ios16',
    CASE zShare.ZSCOPETYPE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-Published'
        WHEN 3 THEN 'CMM_SWY_Syndication_Asset-3'
        ELSE 'Unknown-New-Value!: ' || zShare.ZSCOPETYPE || ''
    END AS 'zShare-Scope Type-iCldLnk',
    CASE zShare.ZLOCALPUBLISHSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-Published'
        ELSE 'Unknown-New-Value!: ' || zShare.ZLOCALPUBLISHSTATE || ''
    END AS 'zShare-Local Cloud Publish State-iCldLnk',
    CASE zShare.ZPUBLICPERMISSION
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-Public Premission Denied-1'
        WHEN 2 THEN '2-Public Premission Granted-2'
        ELSE 'Unknown-New-Value!: ' || zShare.ZPUBLICPERMISSION || ''
    END AS 'zShare-Public Permission-iCldLnk',
    zShare.ZUUID AS 'zShare-UUID-iCldLnk UUID',
    zShare.ZSCOPEIDENTIFIER AS 'zShare-Scope ID-iCldLnk',
    zShare.ZORIGINATINGSCOPEIDENTIFIER AS 'zShare-Originating Scope ID-iCldLnk',
    zShare.ZPREVIEWDATA AS 'zShare-Preview Data/PHOTO-HEX iCldLnk',
    CASE zShare.ZSHOULDIGNOREBUDGETS
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zShare.ZSHOULDIGNOREBUDGETS || ''
    END AS 'zShare-Should Ignor Budgets-iCldLnk',
    CASE zShare.ZSHOULDNOTIFYONUPLOADCOMPLETION
        WHEN 0 THEN '0-No'
        WHEN 1 THEN '1-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zShare.ZSHOULDNOTIFYONUPLOADCOMPLETION || ''
    END AS 'zShare-Should Notify On Upload Completion-iCldLnk',
    datetime(zShare.ZTRASHEDDATE + 978307200, 'UNIXEPOCH') AS 'zShare-Trashed Date Timestamp',
    CASE zShare.ZTRASHEDSTATE
        WHEN 0 THEN 'iCldLnk Not in Trash-0'
        WHEN 1 THEN 'iCldLnk In the Trash-1'
        ELSE 'Unknown-New-Value!: ' || zShare.ZTRASHEDSTATE || ''
    END AS 'zShare-Trashed State-iCldLnk',
    CASE zShare.ZCLOUDDELETESTATE
        WHEN 0 THEN 'iCldLnk Not Deleted-0'
        WHEN 1 THEN 'iCldLnk Deleted-1'
        ELSE 'Unknown-New-Value!: ' || zShare.ZCLOUDDELETESTATE || ''
    END AS 'zShare-Cloud Delete State-iCldLnk',
    datetime(zShare.ZLASTPARTICIPANTASSETTRASHNOTIFICATIONDATE + 978307200, 'UNIXEPOCH') AS 'zShare-Last Participant Asset Trash Notification Date Timestamp',
    datetime(zShare.ZLASTPARTICIPANTASSETTRASHNOTIFICATIONVIEWEDDATE + 978307200, 'UNIXEPOCH') AS 'zShare-Last Participant Asset Trash Notification View Date Timestamp',
    zGenAlbum.ZKEYASSETFACEIDENTIFIER AS 'zGenAlbum-Key Asset Face ID',
    CASE
        WHEN zAsset.ZFACEAREAPOINTS > 0 THEN 'Face Area Points Detected in zAsset'
        ELSE 'Face Area Points Not Detected in zAsset'
    END AS 'zFaceCrop-Face Area Points',
    zAsset.ZFACEADJUSTMENTVERSION AS 'zAsset-Face Adjustment Version',
    zAddAssetAttr.ZFACEREGIONS AS 'zAddAssetAttr-Face Regions HEX',
    zAddAssetAttr.ZFACEANALYSISVERSION AS 'zAddAssetAttr-Face Analysis Version',
    zDetFace.ZASSET AS 'zDetFace-Asset=zAsset.Z_PK/Asset Containing Face',
    CASE zDetFace.ZASSETVISIBLE
        WHEN 0 THEN 'Asset Not Visible Photo Library-0'
        WHEN 1 THEN 'Asset Visible Photo Library-1'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZASSETVISIBLE || ''
    END AS 'zDetFace-Asset Visible',
    zDetFacePrint.ZDATA AS 'zDetFacePrint-Data HEX',
    zPerson.ZCONTACTMATCHINGDICTIONARY AS 'zPerson-Contact Matching Dictionary HEX',
    zDetFace.Z_PK AS 'zDetFace.Z_PK',
    zDetFace.Z_ENT AS 'zDetFace-zEnt',
    zDetFace.Z_OPT AS 'zDetFace.zOpt',
    zDetFacePrint.ZFACE AS 'zDetFacePrint-Face Key',
    zPerson.ZKEYFACE AS 'zPerson-KeyFace=zDetFace.Z_PK',
    zDetFace.ZFACEPRINT AS 'zDetFace-Face Print',
    zDetFacePrint.Z_PK AS 'zDetFacePrint.Z_PK',
    zDetFacePrint.Z_ENT AS 'zDetFacePrint-zEnt',
    zDetFacePrint.Z_OPT AS 'zDetFacePrint-zOpt',
    zPerson.Z_PK AS 'zPerson.Z_PK=zDetFace-Person',
    zPerson.Z_ENT AS 'zPerson-zEnt',
    zPerson.Z_OPT AS 'zPerson-zOpt',
    zDetFace.ZPERSON AS 'zDetFace-Person=zPerson.Z_PK',
    zPerson.ZFACECOUNT AS 'zPerson-Face Count',
    zDetFace.ZPERSONBEINGKEYFACE AS 'zDetFace-Person Being Key Face',
    zFaceCrop.ZPERSON AS 'zFaceCrop-Person=zPerson.Z_PK&zDetFace-Person-Key',
    zFaceCrop.ZFACE AS 'zFaceCrop-Face Key',
    zDetFace.ZFACECROP AS 'zDetFace-Face Crop',
    zDetFace.ZFACEALGORITHMVERSION AS 'zDetFace-Face Algorithm Version',
    zDetFace.ZADJUSTMENTVERSION AS 'zDetFace-Adjustment Version',
    zDetFace.ZUUID AS 'zDetFace-UUID',
    zPerson.ZPERSONUUID AS 'zPerson-Person UUID',
    CASE zDetFace.ZCONFIRMEDFACECROPGENERATIONSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZCONFIRMEDFACECROPGENERATIONSTATE || ''
    END AS 'zDetFace-Confirmed Face Crop Generation State',
    CASE zDetFace.ZMANUAL
        WHEN 0 THEN 'zDetFace-Auto Detected-0'
        WHEN 1 THEN 'zDetFace-Manually Detected-1'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZMANUAL || ''
    END AS 'zDetFace-Manual',
    CASE zDetFace.ZDETECTIONTYPE
        WHEN 1 THEN '1-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZDETECTIONTYPE || ''
    END AS 'zDetFace-Detection Type',
    CASE zPerson.ZDETECTIONTYPE
        WHEN 1 THEN '1-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zPerson.ZDETECTIONTYPE || ''
    END AS 'zPerson-Detection Type',
    CASE zDetFace.ZVIPMODELTYPE
        WHEN 0 THEN 'Not VIP-0'
        WHEN 1 THEN 'VIP-1'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZVIPMODELTYPE || ''
    END AS 'zDetFace-VIP Model Type',
    CASE zDetFace.ZNAMESOURCE
        WHEN 0 THEN 'No Name Listed-0'
        WHEN 1 THEN '1-Face Crop-1'
        WHEN 2 THEN '2-Verified/Has-Person-URI'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        WHEN 5 THEN '5-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZNAMESOURCE || ''
    END AS 'zDetFace-Name Source',
    CASE zDetFace.ZCLOUDNAMESOURCE
        WHEN 0 THEN 'NA-0'
        WHEN 1 THEN '1-User Added Via Face Crop-1'
        WHEN 5 THEN '5-Asset Shared has Name'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZCLOUDNAMESOURCE || ''
    END AS 'zDetFace-Cloud Name Source',
    zPerson.ZSHAREPARTICIPANT AS 'zPerson-Share Participant =zSharePartic.Z_PK',
    zPerson.ZMERGECANDIDATECONFIDENCE AS 'zPerson-Merge Candidate Confidence',
    zPerson.ZPERSONURI AS 'zPerson-Person URI',
    zPerson.ZDISPLAYNAME AS 'zPerson-Display Name',
    zPerson.ZFULLNAME AS 'zPerson-Full Name',
    CASE zPerson.ZCLOUDVERIFIEDTYPE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zPerson.ZCLOUDVERIFIEDTYPE || ''
    END AS 'zPerson-Cloud Verified Type',
    CASE zFaceCrop.ZSTATE
        WHEN 5 THEN 'Validated-5'
        ELSE 'Unknown-New-Value!: ' || zFaceCrop.ZSTATE || ''
    END AS 'zFaceCrop-State',
    CASE zFaceCrop.ZTYPE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-Active'
        ELSE 'Unknown-New-Value!: ' || zFaceCrop.ZTYPE || ''
    END AS 'zFaceCrop-Type',
    zFaceCrop.ZASSET AS 'zFaceCrop-Asset Key',
    zFaceCrop.ZRESOURCEDATA AS 'zFaceCrop-Resource Data/HEX-PHOTO used for FaceCrop',
    zFaceCrop.ZUUID AS 'zFaceCrop-UUID',
    CASE zPerson.ZTYPE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zPerson.ZTYPE || ''
    END AS 'zPerson-Type',
    CASE zPerson.ZVERIFIEDTYPE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zPerson.ZVERIFIEDTYPE || ''
    END AS 'zPerson-Verified Type',
    CASE zPerson.ZGENDERTYPE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN 'Male-1'
        WHEN 2 THEN 'Female-2'
        ELSE 'Unknown-New-Value!: ' || zPerson.ZGENDERTYPE || ''
    END AS 'zPerson-Gender Type',
    CASE zDetFace.ZGENDERTYPE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN 'Male-1'
        WHEN 2 THEN 'Female-2'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZGENDERTYPE || ''
    END AS 'zDetFace-Gender Type',
    zDetFace.ZCENTERX AS 'zDetFace-Center X',
    zDetFace.ZCENTERY AS 'zDetFace-Center Y',
    CASE zPerson.ZAGETYPE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN 'Infant/Toddler Age Type-1'
        WHEN 2 THEN 'Toddler/Child Age Type-2'
        WHEN 3 THEN 'Child/Young Adult Age Type-3'
        WHEN 4 THEN 'Young Adult/Adult Age Type-4'
        WHEN 5 THEN 'Adult-5'
        ELSE 'Unknown-New-Value!: ' || zPerson.ZAGETYPE || ''
    END AS 'zPerson-Age Type Estimate',
    CASE zDetFace.ZAGETYPE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN 'Infant/Toddler Age Type-1'
        WHEN 2 THEN 'Toddler/Child Age Type-2'
        WHEN 3 THEN 'Child/Young Adult Age Type-3'
        WHEN 4 THEN 'Young Adult/Adult Age Type-4'
        WHEN 5 THEN 'Adult-5'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZAGETYPE || ''
    END AS 'zDetFace-Age Type Estimate',
    CASE zDetFace.ZETHNICITYTYPE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN 'Black/African American-1'
        WHEN 2 THEN 'White-2'
        WHEN 3 THEN 'Hispanic/Latino-3'
        WHEN 4 THEN 'Asian-4'
        WHEN 5 THEN 'Native Hawaiian/Other Pacific Islander-5'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZETHNICITYTYPE || ''
    END AS 'zDetFace-Ethnicity Type',
    CASE zDetFace.ZSKINTONETYPE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN 'Light-Pale White Skin Tone-1'
        WHEN 2 THEN 'White-Fair Skin Tone-2'
        WHEN 3 THEN 'Medium-White to Olive Skin Tone-3'
        WHEN 4 THEN 'Olive-Moderate Brown Skin Tone-4'
        WHEN 5 THEN 'Brown-Dark Brown Skin Tone-5'
        WHEN 6 THEN 'Black-Very Dark Brown to Black Skin Tone-6'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZSKINTONETYPE || ''
    END AS 'zDetFace-Skin Tone Type',
    CASE zDetFace.ZHAIRTYPE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        WHEN 5 THEN '5-StillTesting'
        WHEN 6 THEN '6-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZHAIRTYPE || ''
    END AS 'zDetFace-Hair Type',
    CASE zDetFace.ZHAIRCOLORTYPE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN 'Black/Brown Hair Color-1'
        WHEN 2 THEN 'Brown/Blonde Hair Color-2'
        WHEN 3 THEN 'Brown/Red Hair Color-3'
        WHEN 4 THEN 'Red/White Hair Color-4'
        WHEN 5 THEN 'StillTesting/Artifical-5'
        WHEN 6 THEN 'White/Bald Hair Color-6'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZHAIRCOLORTYPE || ''
    END AS 'zDetFace-Hair Color Type',
    CASE zDetFace.ZHEADGEARTYPE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        WHEN 5 THEN '5-No Headgear'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZHEADGEARTYPE || ''
    END AS 'zDetFace-Head Gear Type',
    CASE zDetFace.ZFACIALHAIRTYPE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN 'Clean Shaven Facial Hair Type-1'
        WHEN 2 THEN 'Beard Facial Hair Type-2'
        WHEN 3 THEN 'Goatee Facial Hair Type-3'
        WHEN 4 THEN 'Mustache Facial Hair Type-4'
        WHEN 5 THEN 'Stubble Facial Hair Type-5'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZFACIALHAIRTYPE || ''
    END AS 'zDetFace-Facial Hair Type',
    CASE zDetFace.ZHASFACEMASK
        WHEN 0 THEN 'No Mask-0'
        WHEN 1 THEN 'Has Mask-1'
        WHEN 2 THEN '2-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZHASFACEMASK || ''
    END AS 'zDetFace-Has Face Mask',
    CASE zDetFace.ZPOSETYPE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN 'Face Frontal Pose-1'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN 'Face Profile Pose-3'
        WHEN 4 THEN '4-StillTesting'
        WHEN 5 THEN '5-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZPOSETYPE || ''
    END AS 'zDetFace-Pose Type',
    CASE zDetFace.ZFACEEXPRESSIONTYPE
        WHEN 0 THEN 'NA-0'
        WHEN 1 THEN 'Disgusted/Angry-1'
        WHEN 2 THEN 'Suprised/Fearful-2'
        WHEN 3 THEN 'Neutral-3'
        WHEN 4 THEN 'Confident/Smirk-4'
        WHEN 5 THEN 'Happiness-5'
        WHEN 6 THEN 'Sadness-6'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZFACEEXPRESSIONTYPE || ''
    END AS 'zDetFace-Face Expression Type',
    CASE zDetFace.ZHASSMILE
        WHEN 0 THEN 'zDetFace No Smile-0'
        WHEN 1 THEN 'zDetFace Smile-1'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZHASSMILE || ''
    END AS 'zDetFace-Has Smile',
    CASE zDetFace.ZSMILETYPE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN 'zDetFace Smile No Teeth-1'
        WHEN 2 THEN 'zDetFace Smile has Teeth-2'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZSMILETYPE || ''
    END AS 'zDetFace-Smile Type',
    CASE zDetFace.ZLIPMAKEUPTYPE
        WHEN 0 THEN 'zDetFace No Lip Makeup-0'
        WHEN 1 THEN 'zDetFace Lip Makeup Detected-1'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZLIPMAKEUPTYPE || ''
    END AS 'zDetFace-Lip Makeup Type',
    CASE zDetFace.ZEYESSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN 'Eyes Closed-1'
        WHEN 2 THEN 'Eyes Open-2'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZEYESSTATE || ''
    END AS 'zDetFace-Eyes State',
    CASE zDetFace.ZISLEFTEYECLOSED
        WHEN 0 THEN 'Left Eye Open-0'
        WHEN 1 THEN 'Left Eye Closed-1'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZISLEFTEYECLOSED || ''
    END AS 'zDetFace-Is Left Eye Closed',
    CASE zDetFace.ZISRIGHTEYECLOSED
        WHEN 0 THEN 'Right Eye Open-0'
        WHEN 1 THEN 'Right Eye Closed-1'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZISRIGHTEYECLOSED || ''
    END AS 'zDetFace-Is Right Eye Closed',
    zDetFace.ZGAZECENTERX AS 'zDetFace-Gaze Center X',
    zDetFace.ZGAZECENTERY AS 'zDetFace-Gaze Center Y',

    CASE zDetFace.ZGAZETYPE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        WHEN 5 THEN '5-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZGAZETYPE || ''
    END AS 'zDetFace-Face Gaze Type',

    CASE zDetFace.ZGLASSESTYPE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN 'Eye Glasses-1'
        WHEN 2 THEN 'Sun Glasses-2'
        WHEN 3 THEN 'No Glasses-3'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZGLASSESTYPE || ''
    END AS 'zDetFace-Eye Glasses Type',

    CASE zDetFace.ZEYEMAKEUPTYPE
        WHEN 0 THEN 'No Eye Makeup-0'
        WHEN 1 THEN 'Eye Makeup Detected-1'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZEYEMAKEUPTYPE || ''
    END AS 'zDetFace-Eye Makeup Type',

    zDetFace.ZCLUSTERSEQUENCENUMBER AS 'zDetFace-Cluster Squence Number Key',
    zDetFace.ZGROUPINGIDENTIFIER AS 'zDetFace-Grouping ID',
    zDetFace.ZMASTERIDENTIFIER AS 'zDetFace-Master ID',
    zDetFace.ZQUALITY AS 'zDetFace-Quality',
    zDetFace.ZQUALITYMEASURE AS 'zDetFace-Quality Measure',
    zDetFace.ZSOURCEHEIGHT AS 'zDetFace-Source Height',
    zDetFace.ZSOURCEWIDTH AS 'zDetFace-Source Width',

    CASE zDetFace.ZHIDDEN
        WHEN 0 THEN 'Not Hidden-0'
        WHEN 1 THEN 'Hidden-1'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZHIDDEN || ''
    END AS 'zDetFace-Hidden/Asset Hidden',

    CASE zDetFace.ZISINTRASH
        WHEN 0 THEN 'Not In Trash-0'
        WHEN 1 THEN 'In Trash-1'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZISINTRASH || ''
    END AS 'zDetFace-In Trash/Recently Deleted',

    CASE zDetFace.ZCLOUDLOCALSTATE
        WHEN 0 THEN 'Not Synced with Cloud-0'
        WHEN 1 THEN 'Synced with Cloud-1'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZCLOUDLOCALSTATE || ''
    END AS 'zDetFace-Cloud Local State',

    CASE zDetFace.ZTRAININGTYPE
        WHEN 0 THEN '0-StillTesting'
        WHEN 5 THEN '5-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZTRAININGTYPE
    END AS 'zDetFace-Training Type',

    zDetFace.ZPOSEYAW AS 'zDetFace.Pose Yaw',
    zDetFace.ZBODYCENTERX AS 'zDetFace-Body Center X',
    zDetFace.ZBODYCENTERY AS 'zDetFace-Body Center Y',
    zDetFace.ZBODYHEIGHT AS 'zDetFace-Body Height',
    zDetFace.ZBODYWIDTH AS 'zDetFace-Body Width',
    zDetFace.ZROLL AS 'zDetFace-Roll',
    zDetFace.ZSIZE AS 'zDetFace-Size',
    zDetFace.ZCLUSTERSEQUENCENUMBER AS 'zDetFace-Cluster Squence Number',
    zDetFace.ZBLURSCORE AS 'zDetFace-Blur Score',
    zDetFacePrint.ZFACEPRINTVERSION AS 'zDetFacePrint-Face Print Version',
    zMedAnlyAstAttr.ZFACECOUNT AS 'zMedAnlyAstAttr-Face Count',
    zDetFaceGroup.Z_PK AS 'zDetFaceGroup.Z_PK',
    zDetFaceGroup.Z_ENT AS 'zDetFaceGroup-zENT',
    zDetFaceGroup.Z_OPT AS 'zDetFaceGroup-zOPT',
    zDetFace.ZFACEGROUPBEINGKEYFACE AS 'zDetFace-FaceGroupBeingKeyFace=zDetFaceGroup.Z_PK',
    zDetFace.ZFACEGROUP AS 'zDetFace-FaceGroup=zDetFaceGroup.Z_PK',
    zPerson.ZASSOCIATEDFACEGROUP AS 'zPerson-Assoc Face Group Key',
    zDetFaceGroup.ZKEYFACE AS 'zDetFaceGroup-KeyFace=zDetFace.Z_PK',
    zDetFaceGroup.ZASSOCIATEDPERSON AS 'zDetFaceGroup-AssocPerson=zPerson.Z_PK',
    zDetFaceGroup.ZUUID AS 'zDetFaceGroup-UUID',
    zDetFaceGroup.ZPERSONBUILDERSTATE AS 'zDetFaceGroup-Person Builder State',
    zDetFaceGroup.ZUNNAMEDFACECOUNT AS 'zDetFaceGroup-UnNamed Face Count',
    zPerson.ZINPERSONNAMINGMODEL AS 'zPerson-In Person Naming Model',
    zPerson.ZKEYFACEPICKSOURCE AS 'zPerson-Key Face Pick Source Key',
    zPerson.ZMANUALORDER AS 'zPerson-Manual Order Key',
    zPerson.ZQUESTIONTYPE AS 'zPerson-Question Type',
    zPerson.ZSUGGESTEDFORCLIENTTYPE AS 'zPerson-Suggested For Client Type',
    zPerson.ZMERGETARGETPERSON AS 'zPerson-Merge Target Person',

    CASE zPerson.ZCLOUDLOCALSTATE
        WHEN 0 THEN 'Person Not Synced with Cloud-0'
        WHEN 1 THEN 'Person Synced with Cloud-1'
        ELSE 'Unknown-New-Value!: ' || zPerson.ZCLOUDLOCALSTATE
    END AS 'zPerson-Cloud Local State',

    CASE zFaceCrop.ZCLOUDLOCALSTATE
        WHEN 0 THEN 'Not Synced with Cloud-0'
        WHEN 1 THEN 'Synced with Cloud-1'
        ELSE 'Unknown-New-Value!: ' || zFaceCrop.ZCLOUDLOCALSTATE || ''
    END AS 'zFaceCrop-Cloud Local State',

    CASE zFaceCrop.ZCLOUDTYPE
        WHEN 0 THEN 'Has Name-0'
        WHEN 5 THEN 'Has Face Key-5'
        WHEN 12 THEN '12-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zFaceCrop.ZCLOUDTYPE || ''
    END AS 'zFaceCrop-Cloud Type',

    CASE zPerson.ZCLOUDDELETESTATE
        WHEN 0 THEN 'Cloud Not Deleted-0'
        WHEN 1 THEN 'Cloud Deleted-1'
        ELSE 'Unknown-New-Value!: ' || zPerson.ZCLOUDDELETESTATE || ''
    END AS 'zPerson-Cloud Delete State',

    CASE zFaceCrop.ZCLOUDDELETESTATE
        WHEN 0 THEN 'Cloud Not Deleted-0'
        WHEN 1 THEN 'Cloud Deleted-1'
        ELSE 'Unknown-New-Value!: ' || zFaceCrop.ZCLOUDDELETESTATE || ''
    END AS 'zFaceCrop-Cloud Delete State',

    zFaceCrop.ZINVALIDMERGECANDIDATEPERSONUUID AS 'zFaceCrop-Invalid Merge Canidate Person UUID',
    zFaceCrop.Z_PK AS 'zFaceCrop.Z_PK',
    zFaceCrop.Z_ENT AS 'zFaceCrop-zEnt',
    zFaceCrop.Z_OPT AS 'zFaceCrop-zOpt',
    zMemory.Z_PK AS 'zMemory.Z_PK',
    zMemory.Z_ENT AS 'zMemory-zENT',
    zMemory.Z_OPT AS 'zMemory-zOPT',
    z3MemoryBCAs.Z_3CURATEDASSETS AS 'z3MemoryBCAs-3CuratedAssets=zAsset.Z_PK',
    z3MemoryBCAs.Z_44MEMORIESBEINGCURATEDASSETS AS 'z3MemoryBCAs-44MemoriesBeingCuratedAssets=zMemory.Z_PK',
    z3MemoryBECAs.Z_3EXTENDEDCURATEDASSETS AS 'z3MemoryBECAs-3ExtCuratedAssets=zAsset.Z_PK',
    z3MemoryBECAs.Z_44MEMORIESBEINGEXTENDEDCURATEDASSETS AS 'z3MemoryBECAs-44MemoriesBeingExtCuratedAssets=zMemory.Z_PK',
    z3MemoryBMCAs.Z_3MOVIECURATEDASSETS AS 'z3MemoryBMCAs-3MovieCuratedAssets=zAsset.Z_PK',
    z3MemoryBMCAs.Z_44MEMORIESBEINGMOVIECURATEDASSETS AS 'z3MemoryBMCAs-44MemoriesBeingMovieCuratedAssets=zMemory.Z_PK',
    z3MemoryBRAs.Z_3REPRESENTATIVEASSETS AS 'z3MemoryBRAs-3RepresentativeAssets=zAsset.Z_PK',
    z3MemoryBRAs.Z_44MEMORIESBEINGREPRESENTATIVEASSETS AS 'z3MemoryBRAs-44RepresentativeAssets=zMemory.Z_PK',
    z3MemoryBUCAs.Z_3USERCURATEDASSETS AS 'z3MemoryBUCAs-3UserCuratedAssets=zAsset.Z_PK',
    z3MemoryBUCAs.Z_44MEMORIESBEINGUSERCURATEDASSETS AS 'z3MemoryBUCAs-44MemoriesBeingUserCuratedAssets=zMemory.Z_PK',
    zMemory.ZKEYASSET AS 'zMemory-Key Asset=zAsset.Z_PK',
    zMemory.ZUUID AS 'zMemory-UUID',
    zMemory.ZASSETLISTPREDICATE AS 'zMemory-AssetListPredicte',
    zMemory.ZSCORE AS 'zMemory-Score',
    zMemory.ZSUBTITLE AS 'zMemory-SubTitle',
    zMemory.ZTITLE AS 'zMemory-Title',

    CASE zMemory.ZCATEGORY
        WHEN 1 THEN '1-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        WHEN 8 THEN '8-StillTesting'
        WHEN 16 THEN '16-StillTesting'
        WHEN 17 THEN '17-StillTesting'
        WHEN 19 THEN '19-StillTesting'
        WHEN 21 THEN '21-StillTesting'
        WHEN 201 THEN '201-StillTesting'
        WHEN 203 THEN '203-StillTesting'
        WHEN 204 THEN '204-StillTesting'
        WHEN 211 THEN '211-StillTesting'
        WHEN 217 THEN '217-StillTesting'
        WHEN 220 THEN '220-StillTesting'
        WHEN 301 THEN '301-StillTesting'
        WHEN 302 THEN '302-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zMemory.ZCATEGORY || ''
    END AS 'zMemory-Category',

    CASE zMemory.ZSUBCATEGORY
        WHEN 0 THEN '0-StillTesting'
        WHEN 201 THEN '201-StillTesting'
        WHEN 204 THEN '204-StillTesting'
        WHEN 206 THEN '206-StillTesting'
        WHEN 207 THEN '207-StillTesting'
        WHEN 212 THEN '212-StillTesting'
        WHEN 213 THEN '213-StillTesting'
        WHEN 214 THEN '214-StillTesting'
        WHEN 402 THEN '402-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zMemory.ZSUBCATEGORY || ''
    END AS 'zMemory-SubCategory',

    datetime(zMemory.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'zMemory-Creation Date',
    datetime(zMemory.ZLASTENRICHMENTDATE + 978307200, 'UNIXEPOCH') AS 'zMemory-Last Enrichment Date',

    CASE zMemory.ZUSERACTIONOPTIONS
        WHEN 0 THEN 'User Actions Options Memory Not User Created-0'
        WHEN 1 THEN 'User Actions Options Memory User Created-1'
        ELSE 'Unknown-New-Value!: ' || zMemory.ZUSERACTIONOPTIONS || ''
    END AS 'zMemory-User Action Options',

    CASE zMemory.ZFAVORITE
        WHEN 0 THEN 'Memory Not Favorite-0'
        WHEN 1 THEN 'Memory Favorite-1'
    END AS 'zMemory-Favorite Memory',

    zMemory.ZVIEWCOUNT AS 'zMemory-View Count',
    zMemory.ZPLAYCOUNT AS 'zMemory-Play Count',
    zMemory.ZREJECTED AS 'zMemory-Rejected',
    zMemory.ZSHARECOUNT AS 'zMemory-Share Count',
    zMemory.ZSHARINGCOMPOSITION AS 'zMemory-Sharing Composition',
    zMemory.ZPHOTOSGRAPHDATA AS 'zMemory-PhotosGraphData/HEX NSKeyed Plist',
    zMemory.ZMOVIEASSETSTATE AS 'zMemory-MovieAssetState/HEX NSKeyed Plist',
    zMemory.ZMOVIEDATA AS 'zMemory-MovieData/HEX NSKeyed Plist',

    datetime(zMemory.ZLASTMOVIEPLAYEDDATE + 978307200, 'UNIXEPOCH') AS 'zMemory-Last Movie Play Date',
    datetime(zMemory.ZLASTVIEWEDDATE + 978307200, 'UNIXEPOCH') AS 'zMemory-Last Viewed Date',

    zMemory.ZPENDINGPLAYCOUNT AS 'zMemory-Pending Play Count Memory',
    zMemory.ZPENDINGSHARECOUNT AS 'zMemory-Pending Share Count Memory',
    zMemory.ZPENDINGVIEWCOUNT AS 'zMemory-Pending View Count Memory',
    zMemory.ZPENDINGSTATE AS 'zMemory-Pending State',

    CASE zMemory.ZFEATUREDSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zMemory.ZFEATUREDSTATE || ''
    END AS 'zMemory-Featured State',

    zMemory.ZPHOTOSGRAPHVERSION AS 'zMemory-Photos Graph Version',
    zMemory.ZGRAPHMEMORYIDENTIFIER AS 'zMemory-Graph Memory Identifier',

    CASE zMemory.ZNOTIFICATIONSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zMemory.ZNOTIFICATIONSTATE || ''
    END AS 'zMemory-Notification State',

    CASE zMemory.ZCLOUDLOCALSTATE
        WHEN 0 THEN 'Memory Not Synced with Cloud-0'
        WHEN 1 THEN 'Memory Synced with Cloud-1'
        ELSE 'Unknown-New-Value!: ' || zMemory.ZCLOUDLOCALSTATE || ''
    END AS 'zMemory-Cloud Local State',

    CASE zMemory.ZCLOUDDELETESTATE
        WHEN 0 THEN 'Memory Not Deleted-0'
        WHEN 1 THEN 'Memory Deleted-1'
        ELSE 'Unknown-New-Value!: ' || zMemory.ZCLOUDDELETESTATE || ''
    END AS 'zMemory-Cloud Delete State',

    CASE zMemory.ZSTORYCOLORGRADEKIND
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zMemory.ZSTORYCOLORGRADEKIND || ''
    END AS 'zMemory-Story Color Grade Kind',

    CASE zMemory.ZSTORYSERIALIZEDTITLECATEGORY
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zMemory.ZSTORYSERIALIZEDTITLECATEGORY || ''
    END AS 'zMemory-Story Serialized Title Category',

    CASE zMemory.ZSYNDICATEDCONTENTSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        ELSE 'Unknown-New-Value!: ' || zMemory.ZSYNDICATEDCONTENTSTATE || ''
    END AS 'zMemory-Syndicated Content State',

    CASE zMemory.ZSEARCHINDEXREBUILDSTATE
        WHEN 0 THEN '0-StillTesting Memory-Search Index State-0'
        WHEN 1 THEN '1-StillTesting Memory-Search Index State-1'
        WHEN 2 THEN '2-StillTesting Memory-Search Index State-2'
        ELSE 'Unknown-New-Value!: ' || zMemory.ZSEARCHINDEXREBUILDSTATE || ''
    END AS 'zMemory-Search Index Rebuild State',

    zMemory.ZBLACKLISTEDFEATURE AS 'zMemory-Black Listed Feature',
    z3MemoryBCUAs.Z_3CUSTOMUSERASSETS AS 'z3MemoryBCAs-3Custom User Assets',
    z3MemoryBCUAs.Z_44MEMORIESBEINGCUSTOMUSERASSETS AS 'z3MemoryBCAs-44Memories Being Custom User Assets',
    z3MemoryBCUAs.Z_FOK_3CUSTOMUSERASSETS AS 'z3MemoryBCAs-FOK-3Custom User Assets',
    zMoment.ZUUID AS 'zMoment-UUID',
    zMoment.Z_PK AS 'zMoment.Z_PK',
    zAsset.ZMOMENT AS 'zAsset-zMoment = zMoment.Z_PK',
    zMoment.Z_ENT AS 'zMoment-zENT',
    zMoment.Z_OPT AS 'zMoment-zOPT',
    zMoment.ZAGGREGATIONSCORE AS 'zMoment-Aggregation Score',

    datetime(zMoment.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'zMoment-Start Date',
    datetime(zMoment.ZREPRESENTATIVEDATE + 978307200, 'UNIXEPOCH') AS 'zMoment-Representative Date',

    zMoment.ZTIMEZONEOFFSET AS 'zMoment-Timezone Offset',

    datetime(zMoment.ZMODIFICATIONDATE + 978307200, 'UNIXEPOCH') AS 'zMoment-Modification Date',
    datetime(zMoment.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'zMoment-End Date',

    zMoment.ZSUBTITLE AS 'zMoment-SubTitle',
    zMoment.ZLOCALIZEDLOCATIONNAMES AS 'zMoment-Localized Location Names',
    zMoment.ZTITLE AS 'zMoment-Title',

    CASE zMoment.ZORIGINATORSTATE
        WHEN 0 THEN '0-StillTesting Moment-Originator_State-0'
        WHEN 1 THEN '1-StillTesing Moment-Originator_State-1'
        WHEN 2 THEN '2-StillTesting Moment-Originator_State-2'
        ELSE 'Unknown-New-Value!: ' || zMoment.ZORIGINATORSTATE || ''
    END AS 'zMoment-Originator State',

    CASE zMoment.ZSHARINGCOMPOSITION
        WHEN 0 THEN '0-StillTesting Moment-Sharing_Compo-0'
        WHEN 1 THEN '1-StillTesting Moment-Sharing_Compo-1'
        WHEN 2 THEN '2-StillTesting Moment-Sharing_Compo-2'
        ELSE 'Unknown-New-Value!: ' || zMoment.ZSHARINGCOMPOSITION || ''
    END AS 'zMoment-Sharing Composition',

    zMoment.ZCACHEDCOUNTSHARED AS 'zMoment-Cached Count Shared',

    CASE zMoment.ZPROCESSEDLOCATION
        WHEN 2 THEN 'No-2'
        WHEN 3 THEN 'Yes-3'
        WHEN 6 THEN 'Yes-6'
        ELSE 'Unknown-New-Value!: ' || zMoment.ZPROCESSEDLOCATION || ''
    END AS 'zMoment-Processed Location',

    zMoment.ZAPPROXIMATELATITUDE AS 'zMoment-Approx Latitude',
    zMoment.ZAPPROXIMATELONGITUDE AS 'zMoment-Approx Longitude',

    CASE zMoment.ZGPSHORIZONTALACCURACY
        WHEN -1.0 THEN '-1.0'
        ELSE zMoment.ZGPSHORIZONTALACCURACY
    END AS 'zMoment-GPS Horizontal Accuracy',

    zMoment.ZCACHEDCOUNT AS 'zMoment-Cache Count',
    zMoment.ZCACHEDPHOTOSCOUNT AS 'zMoment-Cached Photos Count',
    zMoment.ZCACHEDVIDEOSCOUNT AS 'zMoment-Cached Videos Count',

    CASE zMoment.ZTRASHEDSTATE
        WHEN 0 THEN 'zMoment Not In Trash-0'
        WHEN 1 THEN 'zMoment In Trash-1'
        ELSE 'Unknown-New-Value!: ' || zMoment.ZTRASHEDSTATE || ''
    END AS 'zMoment-Trashed State',

    zMoment.ZHIGHLIGHT AS 'zMoment-Highlight Key',
    z3SuggBKA.Z_3KEYASSETS AS 'z3SuggBKA-3KeyAssets=zAsset.Z_PK',
    z3SuggBKA.Z_58SUGGESTIONSBEINGKEYASSETS AS 'z3SuggBKA-58SuggBeingKeyAssets=zSugg.Z_PK',
    SBKAzSugg.Z_PK AS 'SBKAzSugg.Z_PK',
    SBKAzSugg.Z_ENT AS 'SBKAzSugg-zENT',
    SBKAzSugg.Z_OPT AS 'SBKAzSugg-zOPT',
    SBKAzSugg.ZUUID AS 'SBKAzSugg-UUID',
    SBKAzSugg.ZSUGGESTIONCONTEXT AS 'SBKAzSugg-Suggestion Context',
    SBKAzSugg.ZSHARINGCOMPOSITION AS 'SBKAzSugg-Sharing Composition',

    datetime(SBKAzSugg.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'SBKAzSugg-Start Date',

    CASE SBKAzSugg.ZSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        ELSE 'Unknown-New-Value!: ' || SBKAzSugg.ZSTATE || ''
    END AS 'SBKAzSugg-State',

    CASE SBKAzSugg.ZFEATUREDSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        ELSE 'Unknown-New-Value!: ' || SBKAzSugg.ZFEATUREDSTATE || ''
    END AS 'SBKAzSugg-Featured State',

    CASE SBKAzSugg.ZNOTIFICATIONSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        ELSE 'Unknown-New-Value!: ' || SBKAzSugg.ZNOTIFICATIONSTATE || ''
    END AS 'SBKAzSugg-Notification State',

    datetime(SBKAzSugg.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'SBKAzSugg-Creation Date',
    datetime(SBKAzSugg.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'SBKAzSugg-End Date',
    datetime(SBKAzSugg.ZACTIVATIONDATE + 978307200, 'UNIXEPOCH') AS 'SBKAzSugg-Activation Date',
    datetime(SBKAzSugg.ZEXPUNGEDATE + 978307200, 'UNIXEPOCH') AS 'SBKAzSugg-Expunge Date',
    datetime(SBKAzSugg.ZRELEVANTUNTILDATE + 978307200, 'UNIXEPOCH') AS 'SBKAzSugg-Relevant Until Date',

    SBKAzSugg.ZTITLE AS 'SBKAzSugg-Title',
    SBKAzSugg.ZSUBTITLE AS 'SBKAzSugg-Sub Title',
    SBKAzSugg.ZCACHEDCOUNT AS 'SBKAzSugg-Cached Count',
    SBKAzSugg.ZCACHEDPHOTOSCOUNT AS 'SBKAzSugg-Cahed Photos Count',
    SBKAzSugg.ZCACHEDVIDEOSCOUNT AS 'SBKAzSugg-Cached Videos Count',

    CASE SBKAzSugg.ZTYPE
        WHEN 5 THEN '5-StillTesting'
        ELSE 'Unknown-New-Value!: ' || SBKAzSugg.ZTYPE || ''
    END AS 'SBKAzSugg-Type',

    CASE SBKAzSugg.ZSUBTYPE
        WHEN 501 THEN '501-StillTesting'
        WHEN 502 THEN '502-StillTesting'
        ELSE 'Unknown-New-Value!: ' || SBKAzSugg.ZSUBTYPE || ''
    END AS 'SBKAzSugg-Sub Type',

    SBKAzSugg.ZACTIONDATA AS 'SBKAzSugg-Action Data',
    SBKAzSugg.ZFEATURESDATA AS 'SBKAzSugg-Features Data/DeviceInfo HEX NSKeyed Plist',
    SBKAzSugg.ZVERSION AS 'SBKAzSugg-Version',

    CASE SBKAzSugg.ZCLOUDLOCALSTATE
        WHEN 0 THEN 'Suggestion Not Synced with Cloud-0'
        WHEN 1 THEN 'Suggestion Synced with Cloud-1'
        ELSE 'Unknown-New-Value!: ' || SBKAzSugg.ZCLOUDLOCALSTATE || ''
    END AS 'SBKAzSugg-Cloud Local State',

    CASE SBKAzSugg.ZCLOUDDELETESTATE
        WHEN 0 THEN 'Suggestion Not Deleted-0'
        WHEN 1 THEN 'Suggestion Deleted-1'
        ELSE 'Unknown-New-Value!: ' || SBKAzSugg.ZCLOUDDELETESTATE || ''
    END AS 'SBKAzSugg-Cloud Delete State',

    z3SuggBRA.Z_3REPRESENTATIVEASSETS1 AS 'z3SuggBRA-3RepAssets1',
    z3SuggBRA.Z_58SUGGESTIONSBEINGREPRESENTATIVEASSETS AS 'z3SuggBRA-58SuggBeingRepAssets',
    SBRAzSugg.Z_PK AS 'SBRAzSugg.Z_PK',
    SBRAzSugg.Z_ENT AS 'SBRAzSugg-zENT',
    SBRAzSugg.Z_OPT AS 'SBRAzSugg-zOPT',
    SBRAzSugg.ZUUID AS 'SBRAzSugg-UUID',
    SBRAzSugg.ZSUGGESTIONCONTEXT AS 'SBRAzSugg-Suggestion Context',
    SBRAzSugg.ZSHARINGCOMPOSITION AS 'SBRAzSugg-Sharing Composition',

    datetime(SBRAzSugg.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'SBRAzSugg-Start Date',

    CASE SBRAzSugg.ZSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        ELSE 'Unknown-New-Value!: ' || SBRAzSugg.ZSTATE || ''
    END AS 'SBRAzSugg-State',

    CASE SBRAzSugg.ZFEATUREDSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        ELSE 'Unknown-New-Value!: ' || SBRAzSugg.ZFEATUREDSTATE || ''
    END AS 'SBRAzSugg-Featured State',

    CASE SBRAzSugg.ZNOTIFICATIONSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        ELSE 'Unknown-New-Value!: ' || SBRAzSugg.ZNOTIFICATIONSTATE || ''
    END AS 'SBRAzSugg-Notification State',

    datetime(SBRAzSugg.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'SBRAzSugg-Creation Date',
    datetime(SBRAzSugg.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'SBRAzSugg-End Date',
    datetime(SBRAzSugg.ZACTIVATIONDATE + 978307200, 'UNIXEPOCH') AS 'SBRAzSugg-Activation Date',
    datetime(SBRAzSugg.ZEXPUNGEDATE + 978307200, 'UNIXEPOCH') AS 'SBRAzSugg-Expunge Date',
    datetime(SBRAzSugg.ZRELEVANTUNTILDATE + 978307200, 'UNIXEPOCH') AS 'SBRAzSugg-Relevant Until Date',

    SBRAzSugg.ZTITLE AS 'SBRAzSugg-Title',
    SBRAzSugg.ZSUBTITLE AS 'SBRAzSugg-Sub Title',
    SBRAzSugg.ZCACHEDCOUNT AS 'SBRAzSugg-Cached Count',
    SBRAzSugg.ZCACHEDPHOTOSCOUNT AS 'SBRAzSugg-Cahed Photos Count',
    SBRAzSugg.ZCACHEDVIDEOSCOUNT AS 'SBRAzSugg-Cached Videos Count',

    CASE SBRAzSugg.ZTYPE
        WHEN 5 THEN '5-StillTesting'
        ELSE 'Unknown-New-Value!: ' || SBRAzSugg.ZTYPE || ''
    END AS 'SBRAzSugg-Type',

    CASE SBRAzSugg.ZSUBTYPE
        WHEN 501 THEN '501-StillTesting'
        WHEN 502 THEN '502-StillTesting'
        ELSE 'Unknown-New-Value!: ' || SBRAzSugg.ZSUBTYPE || ''
    END AS 'SBRAzSugg-Sub Type',

    SBRAzSugg.ZACTIONDATA AS 'SBRAzSugg-Action Data',
    SBRAzSugg.ZFEATURESDATA AS 'SBRAzSugg-Features Data/DeviceInfo HEX NSKeyed Plist',
    SBRAzSugg.ZVERSION AS 'SBRAzSugg-Version',

    CASE SBRAzSugg.ZCLOUDLOCALSTATE
        WHEN 0 THEN 'Suggestion Not Synced with Cloud-0'
        WHEN 1 THEN 'Suggestion Synced with Cloud-1'
        ELSE 'Unknown-New-Value!: ' || SBRAzSugg.ZCLOUDLOCALSTATE || ''
    END AS 'SBRAzSugg-Cloud Local State',

    CASE SBRAzSugg.ZCLOUDDELETESTATE
        WHEN 0 THEN 'Suggestion Not Deleted-0'
        WHEN 1 THEN 'Suggestion Deleted-1'
        ELSE 'Unknown-New-Value!: ' || SBRAzSugg.ZCLOUDDELETESTATE || ''
    END AS 'SBRAzSugg-Cloud Delete State',

    AAAzCldMastMedData.Z_PK AS 'AAAzCldMastMedData.Z_PK=zAddAssetAttr&zCldMast-Media MetaData',
    AAAzCldMastMedData.Z_ENT AS 'AAAzCldMastMedData-zENT',
    AAAzCldMastMedData.ZCLOUDMASTER AS 'AAAzCldMastMedData-CldMast key',
    AAAzCldMastMedData.ZADDITIONALASSETATTRIBUTES AS 'AAAzCldMastMedData-AddAssetAttr=AddAssetAttr.Z_PK',
    zAddAssetAttr.ZMEDIAMETADATA AS 'zAddAssetAttr-MediaMetadata=AAAzCldMastMedData.Z_PK',
    zAsset.ZMEDIAANALYSISATTRIBUTES AS 'zAsset-Media Analysis Attributes',
    zMedAnlyAstAttr.Z_PK AS 'zMedAnlyAstAttr.Z_PK=zAddAssetAttr-Media Metadata',
    zMedAnlyAstAttr.ZASSET AS 'zMedAnlyAstAttr-zAsset Key',
    zMedAnlyAstAttr.Z_ENT AS 'zMedAnlyAstAttr-zEnt',
    zMedAnlyAstAttr.Z_OPT AS 'zMedAnlyAstAttr-zOpt',
    zMedAnlyAstAttr.ZASSET AS 'zMedAnlyAstAttr-Asset=zAsset.Z_PK',
    zMedAnlyAstAttr.ZMEDIAANALYSISVERSION AS 'zMedAnlyAstAttr-Media Analysis Version',
    zMedAnlyAstAttr.ZAUDIOCLASSIFICATION AS 'zMedAnlyAstAttr-Audio Classification',
    zMedAnlyAstAttr.ZBESTVIDEORANGEDURATIONTIMESCALE AS 'zMedAnlyAstAttr-Best Video Range Duration Time Scale',
    zMedAnlyAstAttr.ZBESTVIDEORANGESTARTTIMESCALE AS 'zMedAnlyAstAttr-Best Video Range Start Time Scale',
    zMedAnlyAstAttr.ZBESTVIDEORANGEDURATIONVALUE AS 'zMedAnlyAstAttr-Best Video Range Duration Value',
    zMedAnlyAstAttr.ZBESTVIDEORANGESTARTVALUE AS 'zMedAnlyAstAttr-Best Video Range Start Value',
    zMedAnlyAstAttr.ZPACKEDBESTPLAYBACKRECT AS 'zMedAnlyAstAttr-Packed Best Playback Rect',
    zMedAnlyAstAttr.ZACTIVITYSCORE AS 'zMedAnlyAstAttr-Activity Score',
    zMedAnlyAstAttr.ZVIDEOSCORE AS 'zMedAnlyAstAttr-Video Score',
    zMedAnlyAstAttr.ZAUDIOSCORE AS 'zMedAnlyAstAttr-Audio Score',
    zMedAnlyAstAttr.ZWALLPAPERSCORE AS 'zMedAnlyAstAttr-Wallpaper Score',
    zMedAnlyAstAttr.ZAUTOPLAYSUGGESTIONSCORE AS 'zMedAnlyAstAttr-AutoPlay Suggestion Score',
    zMedAnlyAstAttr.ZBLURRINESSSCORE AS 'zMedAnlyAstAttr-Blurriness Score',
    zMedAnlyAstAttr.ZEXPOSURESCORE AS 'zMedAnlyAstAttr-Exposure Score',
    zMedAnlyAstAttr.ZPROBABLEROTATIONDIRECTIONCONFIDENCE AS 'zMedAnlyAstAttr-Probable Rotation Direction Confidence',
    zMedAnlyAstAttr.ZPROBABLEROTATIONDIRECTION AS 'zMedAnlyAstAttr-Probable Rotation Direction',
    zMedAnlyAstAttr.ZSCREENTIMEDEVICEIMAGESENSITIVITY AS 'zMedAnlyAstAttr-Screen Time Device Image Sensitivity',
    zMedAnlyAstAttr.ZCOLORNORMALIZATIONDATA AS 'zMedAnlyAstAttr-Color Normalization Data',
    zAssetAnalyState.Z_PK AS 'zAssetAnalyState.Z_PK',
    zAssetAnalyState.Z_ENT AS 'zAssetAnalyState-zEnt',
    zAssetAnalyState.Z_OPT AS 'zAssetAnalyState-zOpt',
    zAssetAnalyState.ZANALYSISSTATE AS 'zAssetAnalyState-Analyisis State',
    zAssetAnalyState.ZWORKERFLAGS AS 'zAssetAnalyState-Worker Flags',
    zAssetAnalyState.ZWORKERTYPE AS 'zAssetAnalyState-Worker Type',
    zAssetAnalyState.ZASSET AS 'zAssetAnalyState-Asset=zAsset.Z_PK',

    datetime(zAssetAnalyState.ZIGNOREUNTILDATE + 978307200, 'UNIXEPOCH') AS 'zAssetAnalyState-Ignore Until Date',
    datetime(zAssetAnalyState.ZLASTIGNOREDDATE + 978307200, 'UNIXEPOCH') AS 'zAssetAnalyState-Last Ignored Date',

    zAssetAnalyState.ZSORTTOKEN AS 'zAssetAnalyState-Sort Token',
    zAssetAnalyState.ZASSETUUID AS 'zAssetAnalyState-Asset UUID',
    zMedAnlyAstAttr.ZCHARACTERRECOGNITIONATTRIBUTES AS 'zMedAnlyAstAttr-Character Recognition Attr',
    zCharRecogAttr.Z_PK AS 'zCharRecogAttr.Z_PK',
    zCharRecogAttr.Z_ENT AS 'zCharRecogAttr-zENT',
    zCharRecogAttr.Z_OPT AS 'zCharRecogAttr-zOPT',
    zCharRecogAttr.ZALGORITHMVERSION AS 'zCharRecogAttr-Algorithm Version',
    zCharRecogAttr.ZMEDIAANALYSISASSETATTRIBUTES AS 'zCharRecogAttr-MedAssetAttr=zMedAnlyAstAttr.Z_PK',
    zCharRecogAttr.ZADJUSTMENTVERSION AS 'zCharRecogAttr-Adjustment Version',
    zCharRecogAttr.ZCHARACTERRECOGNITIONDATA AS 'zCharRecogAttr-Character Recogition Data/HEX',
    zCharRecogAttr.ZMACHINEREADABLECODEDATA AS 'zCharRecogAttr-Machine Readable Code Data/HEX',
    zMedAnlyAstAttr.ZVISUALSEARCHATTRIBUTES AS 'zMedAnlyAstAttr-Visual Search Attributes',
    zVisualSearchAttr.Z_PK AS 'zVisualSearchAttr.Z_PK',
    zVisualSearchAttr.Z_ENT AS 'zVisualSearchAttr-zENT',
    zVisualSearchAttr.Z_OPT AS 'zVisualSearchAttr-zOPT',
    zVisualSearchAttr.ZALGORITHMVERSION AS 'zVisualSearchAttr-Algorithm Version',
    zVisualSearchAttr.ZMEDIAANALYSISASSETATTRIBUTES AS 'zVisualSearchAttr-MedAssetAttr=zMedAnlyAstAttr.Z_PK',
    zVisualSearchAttr.ZADJUSTMENTVERSION AS 'zVisualSearchAttr-Adjustment Version',
    zVisualSearchAttr.ZVISUALSEARCHDATA AS 'zVisualSearchAttr-Visual Search Data/HEX',
    zCompAssetAttr.ZASSET AS 'zCompAssetAttr-Asset Key',
    zCompAssetAttr.Z_PK AS 'zCompAssetAttr.Z_PK',
    zCompAssetAttr.Z_ENT AS 'zCompAssetAttr-zEnt',
    zCompAssetAttr.Z_OPT AS 'zCompAssetAttr-zOpt',
    zAsset.ZCOMPUTEDATTRIBUTES AS 'zAsset-Computed Attributes Asset Key',
    zAsset.ZOVERALLAESTHETICSCORE AS 'zAsset-Overall Aesthetic Score',
    zCompAssetAttr.ZBEHAVIORALSCORE AS 'zCompAssetAttr-Behavioral Score',
    zCompAssetAttr.ZFAILURESCORE AS 'zCompAssetAttr-Failure Score zCompAssetAttr',
    zCompAssetAttr.ZHARMONIOUSCOLORSCORE AS 'zCompAssetAttr-Harmonious Color Score',
    zCompAssetAttr.ZIMMERSIVENESSSCORE AS 'zCompAssetAttr-Immersiveness Score',
    zCompAssetAttr.ZINTERACTIONSCORE AS 'zCompAssetAttr-Interaction Score',
    zCompAssetAttr.ZINTERESTINGSUBJECTSCORE AS 'zCompAssetAttr-Intersting Subject Score',
    zCompAssetAttr.ZINTRUSIVEOBJECTPRESENCESCORE AS 'zCompAssetAttr-Intrusive Object Presence Score',
    zCompAssetAttr.ZLIVELYCOLORSCORE AS 'zCompAssetAttr-Lively Color Score',
    zCompAssetAttr.ZLOWLIGHT AS 'zCompAssetAttr-Low Light',
    zCompAssetAttr.ZNOISESCORE AS 'zCompAssetAttr-Noise Score',
    zCompAssetAttr.ZPLEASANTCAMERATILTSCORE AS 'zCompAssetAttr-Pleasant Camera Tilt Score',
    zCompAssetAttr.ZPLEASANTCOMPOSITIONSCORE AS 'zCompAssetAttr-Pleasant Composition Score',
    zCompAssetAttr.ZPLEASANTLIGHTINGSCORE AS 'zCompAssetAttr-Pleasant Lighting Score',
    zCompAssetAttr.ZPLEASANTPATTERNSCORE AS 'zCompAssetAttr-Pleasant Pattern Score',
    zCompAssetAttr.ZPLEASANTPERSPECTIVESCORE AS 'zCompAssetAttr-Pleasant Perspective Score',
    zCompAssetAttr.ZPLEASANTPOSTPROCESSINGSCORE AS 'zCompAssetAttr-Pleasant Post Processing Score',
    zCompAssetAttr.ZPLEASANTREFLECTIONSSCORE AS 'zCompAssetAttr-Pleasant Reflection Score',
    zCompAssetAttr.ZPLEASANTSYMMETRYSCORE AS 'zCompAssetAttrPleasant Symmetry Score',
    zCompAssetAttr.ZSHARPLYFOCUSEDSUBJECTSCORE AS 'zCompAssetAttr-Sharply Focused Subject Score',
    zCompAssetAttr.ZTASTEFULLYBLURREDSCORE AS 'zCompAssetAttr-Tastfully Blurred Score',
    zCompAssetAttr.ZWELLCHOSENSUBJECTSCORE AS 'zCompAssetAttr-Well Chosen Subject Score',
    zCompAssetAttr.ZWELLFRAMEDSUBJECTSCORE AS 'zCompAssetAttr-Well Framed Subject Score',
    zCompAssetAttr.ZWELLTIMEDSHOTSCORE AS 'zCompAssetAttr-Well Timeed Shot Score',
    zCldRes.Z_PK AS 'zCldRes.Z_PK',
    zCldRes.Z_ENT AS 'zCldRes-zENT',
    zCldRes.Z_OPT AS 'zCldRes-zOPT',
    zCldRes.ZCLOUDLOCALSTATE AS 'zCldRes-Cloud Local State',
    zCldRes.ZFILESIZE AS 'zCldRes-File Size',
    zCldRes.ZHEIGHT AS 'zCldRes-Height',
    zCldRes.ZISAVAILABLE AS 'zCldRes-Is Available',
    zCldRes.ZISLOCALLYAVAILABLE AS 'zCldRes-Is Locally Available',
    zCldRes.ZPREFETCHCOUNT AS 'zCldRes-Prefetch Count',
    zCldRes.ZSOURCETYPE AS 'zCldRes-Source Type',
    zCldRes.ZTYPE AS 'zCldRes-Type',
    zCldRes.ZWIDTH AS 'zCldRes-Width',
    zCldRes.ZASSET AS 'zCldRes-Asset=zAsset.Z_PK',
    zCldRes.ZCLOUDMASTER AS 'zCldRes-Cloud Master=zCldMast.Z_PK',
    zCldRes.ZDATECREATED AS 'zCldRes-Date Created',
    zCldRes.ZLASTONDEMANDDOWNLOADDATE AS 'zCldRes-Last OnDemand Download Date',
    zCldRes.ZLASTPREFETCHDATE AS 'zCldRes-Last Prefetch Date',
    zCldRes.ZPRUNEDAT AS 'zCldRes-Prunedat',
    zCldRes.ZASSETUUID AS 'zCldRes-Asset UUID',
    zCldRes.ZFILEPATH AS 'zCldRes-File Path',
    zCldRes.ZFINGERPRINT AS 'zCldRes-Fingerprint',
    zCldRes.ZITEMIDENTIFIER AS 'zCldRes-Item ID',
    zCldRes.ZUNIFORMTYPEIDENTIFIER AS 'zCldRes-UniID',
    zUserFeedback.Z_PK AS 'zUserFeedback.Z_PK',
    zUserFeedback.Z_ENT AS 'zUserFeedback-zENT',
    zUserFeedback.Z_OPT AS 'zUserFeedback-zOPT',
    zUserFeedback.ZFEATURE AS 'zUserFeedback-Feature',
    zUserFeedback.ZTYPE AS 'zUserFeedback-Type',
    zUserFeedback.ZMEMORY AS 'zUserFeedback-Memory=zMemory.Z_PK',
    zUserFeedback.ZPERSON AS 'zUserFeedback-Person=zPerson.Z_PK',
    zUserFeedback.ZLASTMODIFIEDDATE AS 'zUserFeedback-Last Modified Date',
    zUserFeedback.ZCONTEXT AS 'zUserFeedback-Context',
    zUserFeedback.ZCLOUDLOCALSTATE AS 'zUserFeedback-Cloud Local State',
    zUserFeedback.ZCLOUDDELETESTATE AS 'zUserFeedback-Cloud Delete State',
    zUserFeedback.ZUUID AS 'zUserFeedback-UUID'

FROM ZASSET zAsset
    LEFT JOIN ZADDITIONALASSETATTRIBUTES zAddAssetAttr ON zAddAssetAttr.Z_PK = zAsset.ZADDITIONALATTRIBUTES
    LEFT JOIN ZEXTENDEDATTRIBUTES zExtAttr ON zExtAttr.Z_PK = zAsset.ZEXTENDEDATTRIBUTES
    LEFT JOIN ZINTERNALRESOURCE zIntResou ON zIntResou.ZASSET = zAsset.Z_PK
    LEFT JOIN ZSCENEPRINT zSceneP ON zSceneP.Z_PK = zAddAssetAttr.ZSCENEPRINT
    LEFT JOIN Z_28ASSETS z28Assets ON z28Assets.Z_3ASSETS = zAsset.Z_PK
    LEFT JOIN ZGENERICALBUM zGenAlbum ON zGenAlbum.Z_PK = z28Assets.Z_28ALBUMS
    LEFT JOIN Z_27ALBUMLISTS z27AlbumLists ON z27AlbumLists.Z_27ALBUMS = zGenAlbum.Z_PK
    LEFT JOIN ZALBUMLIST zAlbumList ON zAlbumList.Z_PK = z27AlbumLists.Z_2ALBUMLISTS
    LEFT JOIN ZGENERICALBUM ParentzGenAlbum ON ParentzGenAlbum.Z_PK = zGenAlbum.ZPARENTFOLDER
    LEFT JOIN ZASSETDESCRIPTION zAssetDes ON zAssetDes.Z_PK = zAddAssetAttr.ZASSETDESCRIPTION
    LEFT JOIN ZUNMANAGEDADJUSTMENT zUnmAdj ON zAddAssetAttr.ZUNMANAGEDADJUSTMENT = zUnmAdj.Z_PK
    LEFT JOIN ZCLOUDMASTER zCldMast ON zAsset.ZMASTER = zCldMast.Z_PK
    LEFT JOIN ZCLOUDMASTERMEDIAMETADATA AAAzCldMastMedData ON AAAzCldMastMedData.Z_PK = zAddAssetAttr.ZMEDIAMETADATA
    LEFT JOIN ZCLOUDMASTERMEDIAMETADATA CMzCldMastMedData ON CMzCldMastMedData.Z_PK = zCldMast.ZMEDIAMETADATA
    LEFT JOIN ZCLOUDRESOURCE zCldRes ON zCldRes.ZCLOUDMASTER = zCldMast.Z_PK
    LEFT JOIN ZASSETANALYSISSTATE zAssetAnalyState ON zAssetAnalyState.ZASSET = zAsset.Z_PK
    LEFT JOIN ZMEDIAANALYSISASSETATTRIBUTES zMedAnlyAstAttr ON zAsset.ZMEDIAANALYSISATTRIBUTES = zMedAnlyAstAttr.Z_PK
    LEFT JOIN ZPHOTOANALYSISASSETATTRIBUTES zPhotoAnalysisAssetAttr ON zPhotoAnalysisAssetAttr.ZASSET = zAsset.Z_PK
    LEFT JOIN ZCOMPUTEDASSETATTRIBUTES zCompAssetAttr ON zCompAssetAttr.Z_PK = zAsset.ZCOMPUTEDATTRIBUTES
    LEFT JOIN ZCHARACTERRECOGNITIONATTRIBUTES zCharRecogAttr ON zCharRecogAttr.Z_PK = zMedAnlyAstAttr.ZCHARACTERRECOGNITIONATTRIBUTES
    LEFT JOIN ZVISUALSEARCHATTRIBUTES zVisualSearchAttr ON zVisualSearchAttr.Z_PK = zMedAnlyAstAttr.ZVISUALSEARCHATTRIBUTES
    LEFT JOIN ZCLOUDFEEDENTRY zCldFeedEnt ON zAsset.ZCLOUDFEEDASSETSENTRY = zCldFeedEnt.Z_PK
    LEFT JOIN ZCLOUDSHAREDCOMMENT zCldSharedComment ON zAsset.Z_PK = zCldSharedComment.ZCOMMENTEDASSET
    LEFT JOIN ZCLOUDSHAREDCOMMENT zCldSharedCommentLiked ON zAsset.Z_PK = zCldSharedCommentLiked.ZLIKEDASSET
    LEFT JOIN ZCLOUDSHAREDALBUMINVITATIONRECORD zCldShareAlbumInvRec ON zGenAlbum.Z_PK = zCldShareAlbumInvRec.ZALBUM
    LEFT JOIN ZSHARE zShare ON zShare.Z_PK = zAsset.ZMOMENTSHARE
    LEFT JOIN ZSHAREPARTICIPANT zSharePartic ON zSharePartic.ZSHARE = zShare.Z_PK
    LEFT JOIN ZASSETCONTRIBUTOR zAssetContrib ON zAssetContrib.ZPARTICIPANT = zSharePartic.Z_PK
    LEFT JOIN ZDETECTEDFACE zDetFace ON zAsset.Z_PK = zDetFace.ZASSET
    LEFT JOIN ZPERSON zPerson ON zPerson.Z_PK = zDetFace.ZPERSON
    LEFT JOIN ZDETECTEDFACEPRINT zDetFacePrint ON zDetFacePrint.ZFACE = zDetFace.Z_PK
    LEFT JOIN ZFACECROP zFaceCrop ON zPerson.Z_PK = zFaceCrop.ZPERSON
    LEFT JOIN ZDETECTEDFACEGROUP zDetFaceGroup ON zDetFaceGroup.Z_PK = zDetFace.ZFACEGROUP
    LEFT JOIN Z_3MEMORIESBEINGCURATEDASSETS z3MemoryBCAs ON zAsset.Z_PK = z3MemoryBCAs.Z_3CURATEDASSETS
    LEFT JOIN ZMEMORY zMemory ON z3MemoryBCAs.Z_44MEMORIESBEINGCURATEDASSETS = zMemory.Z_PK
    LEFT JOIN Z_3MEMORIESBEINGCUSTOMUSERASSETS z3MemoryBCUAs ON zAsset.Z_PK = z3MemoryBCUAs.Z_3CUSTOMUSERASSETS AND z3MemoryBCUAs.Z_44MEMORIESBEINGCUSTOMUSERASSETS = zMemory.Z_PK
    LEFT JOIN Z_3MEMORIESBEINGEXTENDEDCURATEDASSETS z3MemoryBECAs ON zAsset.Z_PK = z3MemoryBECAs.Z_3EXTENDEDCURATEDASSETS AND z3MemoryBECAs.Z_44MEMORIESBEINGEXTENDEDCURATEDASSETS = zMemory.Z_PK
    LEFT JOIN Z_3MEMORIESBEINGMOVIECURATEDASSETS z3MemoryBMCAs ON zAsset.Z_PK = z3MemoryBMCAs.Z_3MOVIECURATEDASSETS AND z3MemoryBMCAs.Z_44MEMORIESBEINGMOVIECURATEDASSETS = zMemory.Z_PK
    LEFT JOIN Z_3MEMORIESBEINGREPRESENTATIVEASSETS z3MemoryBRAs ON zAsset.Z_PK = z3MemoryBRAs.Z_3REPRESENTATIVEASSETS AND z3MemoryBRAs.Z_44MEMORIESBEINGREPRESENTATIVEASSETS = zMemory.Z_PK
    LEFT JOIN Z_3MEMORIESBEINGUSERCURATEDASSETS z3MemoryBUCAs ON zAsset.Z_PK = z3MemoryBUCAs.Z_3USERCURATEDASSETS AND z3MemoryBUCAs.Z_44MEMORIESBEINGUSERCURATEDASSETS = zMemory.Z_PK
    LEFT JOIN ZUSERFEEDBACK zUserFeedback ON zUserFeedback.ZMEMORY = zMemory.Z_PK
    LEFT JOIN ZMOMENT zMoment ON zMoment.Z_PK = zAsset.ZMOMENT
    LEFT JOIN Z_3SUGGESTIONSBEINGKEYASSETS z3SuggBKA ON z3SuggBKA.Z_3KEYASSETS = zAsset.Z_PK
    LEFT JOIN ZSUGGESTION SBKAzSugg ON SBKAzSugg.Z_PK = z3SuggBKA.Z_58SUGGESTIONSBEINGKEYASSETS
    LEFT JOIN Z_3SUGGESTIONSBEINGREPRESENTATIVEASSETS z3SuggBRA ON z3SuggBRA.Z_3REPRESENTATIVEASSETS1 = zAsset.Z_PK
    LEFT JOIN ZSUGGESTION SBRAzSugg ON SBRAzSugg.Z_PK = z3SuggBRA.Z_58SUGGESTIONSBEINGREPRESENTATIVEASSETS

ORDER BY zAsset.ZADDEDDATE
