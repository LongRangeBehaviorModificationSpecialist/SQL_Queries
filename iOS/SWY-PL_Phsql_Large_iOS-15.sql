/*
Query copied from https://github.com/ScottKjr3347/iOS_SWY_PL_Photos.sqlite_Queries/blob/main/iOS15/iOS15_SWY-PL_Phsql_Large.txt
*/

SELECT
    ROW_NUMBER() OVER() AS 'Record #',
    zAsset.ZSORTTOKEN AS 'zAsset-Sort Token',
    zAsset.ZPROMOTIONSCORE AS 'zAsset-Promotion Score',
    CASE zAsset.ZCOMPLETE
        WHEN 1 THEN '1-Yes-1'
    END AS 'zAsset Complete',
    zAsset.Z_PK AS 'zAsset-zPK',
    zAddAssetAttr.Z_PK AS 'zAddAssetAttr-zPK',
    zCldMast.Z_PK AS 'zCldMast-zPK=zAsset-Master',
    zAsset.ZMASTER AS 'zAsset-Master=zCldMast-zPK',
    zAsset.ZEXTENDEDATTRIBUTES AS 'zAsset-Extended Attributes=zExtAttr-zPK',
    zExtAttr.Z_PK AS 'zExtAttr-zPK=zAsset-zExtendedAttributes',
    CMzCldMastMedData.ZCLOUDMASTER AS 'CMzCldMastMedData-CldMast=zCldMast-zPK',
    zCldMast.ZMEDIAMETADATA AS 'zCldMast-Media Metadata Key=zCldMastMedData.zPK',
    CMzCldMastMedData.Z_PK AS 'CMzCldMastMedData-zPK=zAddAssetAttr&zCldMast-MediaMetaData Key',
    CMzCldMastMedData.Z_ENT AS 'CMzCldMastMedData-zENT',
    zAsset.ZUUID AS 'zAsset-UUID = store.cloudphotodb',
    zAsset.ZCLOUDASSETGUID AS 'zAsset-Cloud_Asset_GUID = store.cloudphotodb',
    zAsset.ZCLOUDCOLLECTIONGUID AS 'zAsset.Cloud Collection GUID',
    zCldMast.ZCLOUDMASTERGUID AS 'zCldMast-Cloud_Master_GUID = store.cloudphotodb',
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
    CASE zAddAssetAttr.ZDESTINATIONASSETCOPYSTATE
        WHEN 0 THEN '0-No Copy-0'
        WHEN 1 THEN '1-Has A Copy-1'
        WHEN 2 THEN '2-Has A Copy-2'
        ELSE 'Unknown-New-Value!: ' || zAddAssetAttr.ZDESTINATIONASSETCOPYSTATE || ''
    END AS 'zAddAssetAttr-Destination Asset Copy State',
    zSceneP.ZDATA AS 'zSceneP-Data/HEX NSKeyed Plist',
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
    zDetFace.ZSOURCEHEIGHT AS 'zDetFace-Source Height',
    zDetFace.ZSOURCEWIDTH AS 'zDetFace-Source Width',
    zAsset.ZPACKEDACCEPTABLECROPRECT AS 'zAsset-Packed Acceptable Crop Rect',
    zAsset.ZPACKEDBADGEATTRIBUTES AS 'zAsset-Packed Badge Attributes',
    zAsset.ZPACKEDPREFERREDCROPRECT AS 'zAsset-Packed Preferred Crop Rect',
    zAsset.ZCURATIONSCORE AS 'zAsset-Curation Score',
    zAsset.ZCAMERAPROCESSINGADJUSTMENTSTATE AS 'zAsset-Camera Processing Adjustment State',
    zAsset.ZDEPTHTYPE AS 'zAsset-Depth Type',
    zAsset.ZISMAGICCARPET AS 'zAsset-Is Magic Carpet',
    zAsset.ZLIBRARYSCOPE AS 'zAsset-Library Scope Key',
    zAsset.ZLIBRARYSCOPEORIGINATOR AS 'zAsset-Library Scope Originator Key',
    zAddAssetAttr.ZORIGINALRESOURCECHOICE AS 'zAddAssetAttr-Orig Resource Choice',
    zAddAssetAttr.ZSNOWDAYSNOWPLOWIDENTIFIER AS 'zAddAssetAttr-Snow Day Snow Plow ID',
    zAddAssetAttr.ZSPATIALOVERCAPTUREGROUPIDENTIFIER AS 'zAddAssetAttr-Spatial Over Capture Group ID',
    zAddAssetAttr.ZOBJECTSALIENCYRECTSDATA AS 'zAddAssetAttr-Object Saliency Rects Data/HEX NSKeyed Plist',
    zAddAssetAttr.ZORIGINALHASH AS 'zAddAssetAttr-Original Hash/HEX',
    zAddAssetAttr.ZPLACEANNOTATIONDATA AS 'zAddAssetAttr-Place Annotation Data',
    zAddAssetAttr.ZDISTANCEIDENTITY AS 'zAddAssetAttr-Distance Identity',
    zAssetDes.ZASSETATTRIBUTES AS 'zAssetDes-Asset Attributes Key=zAddAssetAttr-zPK',
    zAssetDes.ZLONGDESCRIPTION AS 'zAssetDes-Long Description',
    zAddAssetAttr.ZASSETDESCRIPTION AS 'zAddAssetAttr-Asset Description',
    zAddAssetAttr.ZTITLE AS 'zAddAssetAttr-Title/Comments via Cloud Website',
    zAddAssetAttr.ZACCESSIBILITYDESCRIPTION AS 'zAddAssetAttr-Accessibility Description',
    zAsset.ZCONVERSATION AS 'zAsset-Conversation',
    zAddAssetAttr.ZPHOTOSTREAMTAGID AS 'zAddAssetAttr-Photo Stream Tag ID',
    zAsset.ZMEDIAGROUPUUID AS 'zAsset-Media Group UUID',
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
    zCldFeedEnt.Z_PK AS 'zCldFeedEnt-zPK',
    zCldFeedEnt.Z_ENT AS 'zCldFeedEnt-zENT',
    zCldFeedEnt.Z_OPT AS 'zCldFeedEnt-zOPT',
    zAsset.Z_FOK_CLOUDFEEDASSETSENTRY AS 'zAsset-FOK-Cloud Feed Asset Entry Key',
    z27Assets.Z_FOK_3ASSETS AS 'z27Asset-FOK-3Assets=zAsset.Z_FOK_CLOUDFEEDASSETSENTRY',
    zCldSharedComment.ZCLOUDGUID AS 'zCldSharedComment-Cloud GUID',
    zCldSharedComment.ZCLOUDFEEDCOMMENTENTRY AS 'zCldSharedComment-CldFeedCommentEntry=zCldFeedEnt.zPK',
    zCldSharedComment.Z_PK AS 'zCldSharedComment-zPK',
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
    zSharePartic.Z_PK AS 'zSharePartic-zPK',
    zSharePartic.Z_ENT AS 'zSharePartic-zENT',
    zSharePartic.Z_OPT AS 'zSharePartic-zOPT',
    zSharePartic.ZROLE AS 'zSharePartic-Role',
    zSharePartic.ZSHARE AS 'zSharePartic-Share Key =zShare-zPK',
    zSharePartic.ZUSERIDENTIFIER AS 'zSharePartic-User ID',
    zSharePartic.ZACCEPTANCESTATUS AS 'zSharePartic-Acceptance Status',
    zSharePartic.ZEMAILADDRESS AS 'zSharePartic-Email Address',
    zSharePartic.ZPHONENUMBER AS 'zSharePartic-Phone Number',
    zSharePartic.ZUUID AS 'zSharePartic-UUID',
    zSharePartic.ZNAMECOMPONENTS AS 'zSharePartic-Name Components',
    zSharePartic.Z51_SHARE AS 'zSharePartic-54Share',
    zSharePartic.ZPERMISSION AS 'zSharePartic-Premission',
    zSharePartic.ZISCURRENTUSER AS 'zSharePartic-Is Current User',
    ParentzGenAlbum.ZUUID AS 'ParentzGenAlbum-UUID',
    ParentzGenAlbum.ZCLOUDGUID AS 'ParentzGenAlbum-Cloud GUID',
    ParentzGenAlbum.Z_PK AS 'ParentzGenAlbum-zPK',
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
    z27Assets.Z_27ALBUMS AS 'z27Assets-27Albums=zGenAlbum-zPK',
    z26AlbumLists.Z_26ALBUMS AS 'z26AlbumList-26Albums=zGenAlbum-zPK',
    zGenAlbum.Z_PK AS 'zGenAlbum-zPK=26AlbumLists=26Albums',
    zGenAlbum.Z_ENT AS 'zGenAlbum-zEnt',
    zGenAlbum.Z_OPT AS 'zGenAlbum-zOpt',
    zGenAlbum.ZKEYASSET AS 'zGenAlbum-Key Asset/Key zAsset-zPK',
    z27Assets.Z_3ASSETS AS 'z27Assets-3Asset Key=zAsset-zPK in the Album',
    z27Assets.Z_FOK_3ASSETS AS 'z27Assets-FOK3Assets Key',
    zGenAlbum.ZSECONDARYKEYASSET AS 'zGenAlbum-Secondary Key Asset',
    zGenAlbum.ZTERTIARYKEYASSET AS 'zGenAlbum-Tertiary Key Asset',
    zGenAlbum.ZCUSTOMKEYASSET AS 'zGenAlbum-Custom Key Asset',
    zGenAlbum.ZSYNDICATE AS 'zGenAlbum-zSyndicate',
    zGenAlbum.ZIMPORTEDBYBUNDLEIDENTIFIER AS 'zGenAlbum-Imported by Bundle Identifier',
    zGenAlbum.ZIMPORTSESSIONID AS 'zGenAlbum-Import Session ID',
    zGenAlbum.ZPARENTFOLDER AS 'zGenAlbum-Parent Folder Key=zGenAlbum-zPK',
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
    zAlbumList.ZUUID AS 'zAlbumList-UUID',
    z26AlbumLists.Z_2ALBUMLISTS AS 'z26AlbumList-Album List Key',
    z26AlbumLists.Z_FOK_26ALBUMS AS 'z26AlbumList-FOK26Albums Key',
    zAlbumList.Z_PK AS 'zAlbumList-zPK/Album List Key',
    zAlbumList.Z_ENT AS 'zAlbumList-zENT',
    zAlbumList.Z_OPT AS 'zAlbumList-zOPT',
    zAlbumList.ZIDENTIFIER AS 'zAlbumList-ID Key',
    CASE zAlbumList.ZNEEDSREORDERINGNUMBER
        WHEN 1 THEN '1-Yes-1'
        ELSE 'Unknown-New-Value!: ' || zAlbumList.ZNEEDSREORDERINGNUMBER || ''
    END AS 'zAlbumList-Needs Reordering Number',
    zCldShareAlbumInvRec.ZALBUM AS 'zCldShareAlbumInvRec-Album Key',
    zCldShareAlbumInvRec.Z_PK AS 'zCldShareAlbumInvRec-zPK',
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
    zCldMast.ZMOMENTSHARE AS 'zCldMast-Moment Share Key=zShare-zPK',
    zAsset.ZMOMENTSHARE AS 'zAsset-Moment Share Key=zShare-zPK',
    zShare.Z_PK AS 'zShare-zPK',
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
    zShare.ZASSETCOUNT AS 'zShare-Asset Count-iCldLnk-Asset Count',
    zShare.ZUPLOADEDPHOTOSCOUNT AS 'zShare-Uploaded Photos Count-iCldLnk-Photos Upload Count',
    zShare.ZVIDEOSCOUNT AS 'zShare-Videos Count-iCldLnk-Videos Count',
    zShare.ZUPLOADEDVIDEOSCOUNT AS 'zShare-Uploaded Videos Count-iCldLnk-Videos Upload Count',
    zShare.ZFORCESYNCATTEMPTED AS 'zShare-Force Sync Attempted-iCldLnk-Force Sync',
    zShare.ZAUTOSHAREPOLICY AS 'zShare-Auto Share Policy',
    zShare.ZRULESDATA AS 'zShare-Rules Data/HEX',
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
    zGenAlbum.ZKEYASSETFACEIDENTIFIER AS 'zGenAlbum-Key Asset Face ID',
    CASE
        WHEN zAsset.ZFACEAREAPOINTS > 0 THEN 'Face Area Points Detected in zAsset'
        ELSE 'Face Area Points Not Detected in zAsset'
    END AS 'zFaceCrop-Face Area Points',
    zAsset.ZFACEADJUSTMENTVERSION AS 'zAsset-Face Adjustment Version',
    zAddAssetAttr.ZFACEANALYSISVERSION AS 'zAddAssetAttr-Face Analysis Version',
    zAddAssetAttr.ZFACEREGIONS AS 'zAddAssetAttr-Face Regions HEX',
    zDetFace.ZASSET AS 'zDetFace-Asset=zAsset-zPK/Asset Containing Face',
    CASE zDetFace.ZASSETVISIBLE
        WHEN 0 THEN 'Asset Not Visible Photo Library-0'
        WHEN 1 THEN 'Asset Visible Photo Library-1'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZASSETVISIBLE || ''
    END AS 'zDetFace-Asset Visible',
    zDetFacePrint.ZDATA AS 'zDetFacePrint-Data HEX',
    zPerson.ZCONTACTMATCHINGDICTIONARY AS 'zPerson-Contact Matching Dictionary HEX',
    zDetFace.Z_PK AS 'zDetFace-zPK',
    zDetFacePrint.ZFACE AS 'zDetFacePrint-Face Key',
    zPerson.ZKEYFACE AS 'zPerson-KeyFace=zDetFace-zPK',
    zDetFace.ZFACEPRINT AS 'zDetFace-Face Print',
    zDetFacePrint.Z_PK AS 'zDetFacePrint-zPK',
    zPerson.Z_PK AS 'zPerson-zPK=zDetFace-Person',
    zDetFace.ZPERSON AS 'zDetFace-Person=zPerson-zPK',
    zPerson.ZFACECOUNT AS 'zPerson-Face Count',
    zDetFace.ZPERSONBEINGKEYFACE AS 'zDetFace-Person Being Key Face',
    zFaceCrop.ZPERSON AS 'zFaceCrop-Person=zPerson-zPK&zDetFace-Person-Key',
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
    zDetFace.ZMOUTHX AS 'zDetFace-Mouth X',
    zDetFace.ZMOUTHY AS 'zDetFace-Mouth Y',
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
    zDetFace.ZLEFTEYEX AS 'zDetFace-Left Eye X',
    zDetFace.ZLEFTEYEY AS 'zDetFace-Left Eye Y',
    CASE zDetFace.ZISRIGHTEYECLOSED
        WHEN 0 THEN 'Right Eye Open-0'
        WHEN 1 THEN 'Right Eye Closed-1'
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZISRIGHTEYECLOSED || ''
    END AS 'zDetFace-Is Right Eye Closed',
    zDetFace.ZRIGHTEYEX AS 'zDetFace-Right Eye X',
    zDetFace.ZRIGHTEYEY AS 'zDetFace-Right Eye Y',
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
        ELSE 'Unknown-New-Value!: ' || zDetFace.ZTRAININGTYPE || ''
    END AS 'zDetFace-Training Type',
    zDetFace.ZPOSEYAW AS 'zDetFace.Pose Yaw',
    zDetFace.ZBODYCENTERX AS 'zDetFace-Body Center X',
    zDetFace.ZBODYCENTERY AS 'zDetFace-Body Center Y',
    zDetFace.ZBODYHEIGHT AS 'zDetFace-Body Height',
    zDetFace.ZBODYWIDTH AS 'zDetFace-Body Width',
    zDetFace.ZROLL AS 'zDetFace-Roll',
    zDetFace.ZSIZE AS 'zDetFace-Size',
    zDetFace.ZYAW AS 'zDetFace-Yaw',
    zDetFace.ZCLUSTERSEQUENCENUMBER AS 'zDetFace-Cluster Squence Number',
    zDetFace.ZBLURSCORE AS 'zDetFace-Blur Score',
    zDetFacePrint.ZFACEPRINTVERSION AS 'zDetFacePrint-Face Print Version',
    zMedAnlyAstAttr.ZFACECOUNT AS 'zMedAnlyAstAttr-Face Count',
    zDetFaceGroup.Z_PK AS 'zDetFaceGroup-zPK',
    zDetFaceGroup.Z_ENT AS 'zDetFaceGroup-zENT',
    zDetFaceGroup.Z_OPT AS 'zDetFaceGroup-zOPT',
    zDetFace.ZFACEGROUPBEINGKEYFACE AS 'zDetFace-FaceGroupBeingKeyFace=zDetFaceGroup-zPK',
    zDetFace.ZFACEGROUP AS 'zDetFace-FaceGroup=zDetFaceGroup-zPK',
    zPerson.ZASSOCIATEDFACEGROUP AS 'zPerson-Assoc Face Group Key',
    zDetFaceGroup.ZKEYFACE AS 'zDetFaceGroup-KeyFace=zDetFace-zPK',
    zDetFaceGroup.ZASSOCIATEDPERSON AS 'zDetFaceGroup-AssocPerson=zPerson-zPK',
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
        ELSE 'Unknown-New-Value!: ' || zPerson.ZCLOUDLOCALSTATE || ''
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
    zMemory.Z_PK AS 'zMemory-zPK',
    zMemory.Z_ENT AS 'zMemory-zENT',
    zMemory.Z_OPT AS 'zMemory-zOPT',
    z3MemoryBCAs.Z_3CURATEDASSETS AS 'z3MemoryBCAs-3CuratedAssets=zAsset-zPK',
    z3MemoryBCAs.Z_42MEMORIESBEINGCURATEDASSETS AS 'z3MemoryBCAs-42MemoriesBeingCuratedAssets=zMemory-zPK',
    z3MemoryBECAs.Z_3EXTENDEDCURATEDASSETS AS 'z3MemoryBECAs-3ExtCuratedAssets=zAsset-zPK',
    z3MemoryBECAs.Z_42MEMORIESBEINGEXTENDEDCURATEDASSETS AS 'z3MemoryBECAs-42MemoriesBeingExtCuratedAssets=zMemory-zPK',
    z3MemoryBMCAs.Z_3MOVIECURATEDASSETS AS 'z3MemoryBMCAs-3MovieCuratedAssets=zAsset-zPK',
    z3MemoryBMCAs.Z_42MEMORIESBEINGMOVIECURATEDASSETS AS 'z3MemoryBMCAs-42MemoriesBeingMovieCuratedAssets=zMemory-zPK',
    z3MemoryBRAs.Z_3REPRESENTATIVEASSETS AS 'z3MemoryBRAs-3RepresentativeAssets=zAsset-zPK',
    z3MemoryBRAs.Z_42MEMORIESBEINGREPRESENTATIVEASSETS AS 'z3MemoryBRAs-42RepresentativeAssets=zMemory-zPK',
    z3MemoryBUCAs.Z_3USERCURATEDASSETS AS 'z3MemoryBUCAs-3UserCuratedAssets=zAsset-zPK',
    z3MemoryBUCAs.Z_42MEMORIESBEINGUSERCURATEDASSETS AS 'z3MemoryBUCAs-42MemoriesBeingUserCuratedAssets=zMemory-zPK',
    zMemory.ZKEYASSET AS 'zMemory-Key Asset=zAsset-zPK',
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
    zMemory.ZPHOTOSGRAPHDATA AS 'zMemory-PhotosGraphData/HEX NSKeyed Plist',
    zMemory.ZMOVIEASSETSTATE AS 'zMemory-MovieAssetState/HEX NSKeyed Plist',
    zMemory.ZMOVIEDATA AS 'zMemory-MovieData/HEX NSKeyed Plist',
    datetime(zMemory.ZLASTMOVIEPLAYEDDATE + 978307200, 'UNIXEPOCH') AS 'zMemory-Last Movie Play Date',
    datetime(zMemory.ZLASTVIEWEDDATE + 978307200, 'UNIXEPOCH') AS 'zMemory-Last Viewed Date',
    zMemory.ZPENDINGPLAYCOUNT AS 'zMemory-Pending Play Count Memory',
    zMemory.ZPENDINGSHARECOUNT AS 'zMemory-Pending Share Count Memory',
    zMemory.ZPENDINGVIEWCOUNT AS 'zMemory-Pending View Count Memory',
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
    zMemory.ZBLACKLISTEDFEATURE AS 'zMemory-Black Listed Feature',
    zMoment.ZUUID AS 'zMoment-UUID',
    zMoment.Z_PK AS 'zMoment-zPK',
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
    zAsset.ZHIGHLIGHTVISIBILITYSCORE AS 'zAsset-Highlight Visibility Score',
    YearParzPhotosHigh.ZUUID AS 'YearParzPhotosHigh-UUID',
    YearParzPhotosHigh.Z_PK AS 'YearParzPhotosHigh-zPK',
    YearParzPhotosHigh.Z_ENT AS 'YearParzPhotosHigh-zENT',
    YearParzPhotosHigh.Z_OPT AS 'YearParzPhotosHigh-zOPT',
    YearParzPhotosHigh.ZPROMOTIONSCORE AS 'YearParzPhotosHigh-Promotion Score',
    YearParzPhotosHigh.ZTITLE AS 'YearParzPhotosHigh-Title',
    YearParzPhotosHigh.ZVERBOSESMARTDESCRIPTION AS 'YearParzPhotosHigh-Verbose Smart Description',
    datetime(YearParzPhotosHigh.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'YearParzPhotosHigh-Start Date',
    datetime(YearParzPhotosHigh.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'YearParzPhotosHigh-End Date',
    YearParzPhotosHigh.ZYEARKEYASSET AS 'YearParzPhotosHigh-Year Key Asset',
    CASE YearParzPhotosHigh.ZKIND
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN 'Year&Month Photo Highlights-1'
        WHEN 2 THEN 'Year Photo Highlights-2'
        WHEN 3 THEN 'Day Group Assets Photo Highlights-3'
        ELSE 'Unknown-New-Value!: ' || YearParzPhotosHigh.ZKIND || ''
    END AS 'YearParzPhotosHigh-Kind',
    CASE YearParzPhotosHigh.ZCATEGORY
        WHEN 0 THEN '0-Past Highlights'
        WHEN 1 THEN '1-Todays Highlights'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        ELSE 'Unknown-New-Value!: ' || YearParzPhotosHigh.ZCATEGORY || ''
    END AS 'YearParzPhotosHigh-Category',
    CASE YearParzPhotosHigh.ZVISIBILITYSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-Year&Month No Asset Count'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-Visible via For You'
        ELSE 'Unknown-New-Value!: ' || YearParzPhotosHigh.ZVISIBILITYSTATE || ''
    END AS 'YearParzPhotosHigh-Visibility State',
    CASE YearParzPhotosHigh.ZENRICHMENTSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        ELSE 'Unknown-New-Value!: ' || YearParzPhotosHigh.ZENRICHMENTSTATE || ''
    END AS 'YearParzPhotosHigh-Enrichment State',
    YearParzPhotosHigh.ZENRICHMENTVERSION AS 'YearParzPhotosHigh-Enrichment Version',
    YearParzPhotosHigh.ZHIGHLIGHTVERSION AS 'YearParzPhotosHigh-Highlight Version',
    YMParzPhotosHigh.ZUUID AS 'YMParzPhotosHigh-UUID',
    YMParzPhotosHigh.Z_PK AS 'YMParzPhotosHigh-zPK',
    YMParzPhotosHigh.ZPARENTPHOTOSHIGHLIGHT AS 'YMParzPhotosHigh-Parent PH Key',
    YMParzPhotosHigh.Z_ENT AS 'YMParzPhotosHigh-zENT',
    YMParzPhotosHigh.Z_OPT AS 'YMParzPhotosHigh-zOPT',
    YMParzPhotosHigh.ZPROMOTIONSCORE AS 'YMParzPhotosHigh-Promotion Score',
    YMParzPhotosHigh.ZTITLE AS 'YMParzPhotosHigh-Title',
    YMParzPhotosHigh.ZSUBTITLE AS 'YMParzPhotosHigh-Subtitle',
    YMParzPhotosHigh.ZVERBOSESMARTDESCRIPTION AS 'YMParzPhotosHigh-Verbose Smart Description',
    datetime(YMParzPhotosHigh.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'YMParzPhotosHigh-Start Date',
    datetime(YMParzPhotosHigh.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'YMParzPhotosHigh-End Date',
    YMParzPhotosHigh.ZMONTHFIRSTASSET AS 'YMParzPhotosHigh-Month First Asset',
    YMParzPhotosHigh.ZMONTHKEYASSET AS 'YMParzPhotosHigh-Month Key Asset',
    CASE YMParzPhotosHigh.ZKIND
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN 'Year&Month Photo Highlights-1'
        WHEN 2 THEN 'Year Photo Highlights-2'
        WHEN 3 THEN 'Day Group Assets Photo Highlights-3'
        ELSE 'Unknown-New-Value!: ' || YMParzPhotosHigh.ZKIND || ''
    END AS 'YMParzPhotosHigh-Kind',
    CASE YMParzPhotosHigh.ZCATEGORY
        WHEN 0 THEN '0-Past Highlights'
        WHEN 1 THEN '1-Todays Highlights'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        ELSE 'Unknown-New-Value!: ' || YMParzPhotosHigh.ZCATEGORY || ''
    END AS 'YMParzPhotosHigh-Category',
    CASE YMParzPhotosHigh.ZVISIBILITYSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-Year&Month No Asset Count'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        ELSE 'Unknown-New-Value!: ' || YMParzPhotosHigh.ZVISIBILITYSTATE || ''
    END AS 'YMParzPhotosHigh-Visibility State',
    CASE YMParzPhotosHigh.ZENRICHMENTSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        ELSE 'Unknown-New-Value!: ' || YMParzPhotosHigh.ZENRICHMENTSTATE || ''
    END AS 'YMParzPhotosHigh-Enrichment State',
    YMParzPhotosHigh.ZENRICHMENTVERSION AS 'YMParzPhotosHigh-Enrichment Version',
    YMParzPhotosHigh.ZHIGHLIGHTVERSION AS 'YMParzPhotosHigh-Highlight Version',
    DGParzPhotosHigh.ZUUID AS 'DGParzPhotosHigh-UUID',
    DGParzPhotosHigh.Z_PK AS 'DGParzPhotosHigh-zPK',
    DGParzPhotosHigh.ZPARENTPHOTOSHIGHLIGHT AS 'DGParzPhotosHigh-Parent PH Key',
    DGParzPhotosHigh.Z_ENT AS 'DGParzPhotosHigh-zENT',
    DGParzPhotosHigh.Z_OPT AS 'DGParzPhotosHigh-zOPT',
    DGParzPhotosHigh.ZPROMOTIONSCORE AS 'DGParzPhotosHigh-Promotion Score',
    DGParzPhotosHigh.ZTITLE AS 'DGParzPhotosHigh-Title',
    DGParzPhotosHigh.ZSUBTITLE AS 'DGParzPhotosHigh-Subtitle',
    DGParzPhotosHigh.ZVERBOSESMARTDESCRIPTION AS 'DGParzPhotosHigh-Verbose Smart Description',
    datetime(DGParzPhotosHigh.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'DGParzPhotosHigh-Start Date',
    datetime(DGParzPhotosHigh.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'DGParzPhotosHigh-End Date',
    DGParzPhotosHigh.ZMONTHFIRSTASSET AS 'DGParzPhotosHigh-Month First Asset',
    DGParzPhotosHigh.ZMONTHKEYASSET AS 'DGParzPhotosHigh-Month Key Asset',
    CASE DGParzPhotosHigh.ZKIND
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN 'Year&Month Photo Highlights-1'
        WHEN 2 THEN 'Year Photo Highlights-2'
        WHEN 3 THEN 'Day Group Assets Photo Highlights-3'
        ELSE 'Unknown-New-Value!: ' || DGParzPhotosHigh.ZKIND || ''
    END AS 'DGParzPhotosHigh-Kind',
    CASE DGParzPhotosHigh.ZCATEGORY
        WHEN 0 THEN '0-Past Highlights'
        WHEN 1 THEN '1-Todays Highlights'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        ELSE 'Unknown-New-Value!: ' || DGParzPhotosHigh.ZCATEGORY || ''
    END AS 'DGParzPhotosHigh-Category',
    CASE DGParzPhotosHigh.ZVISIBILITYSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-Year&Month No Asset Count'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        ELSE 'Unknown-New-Value!: ' || DGParzPhotosHigh.ZVISIBILITYSTATE || ''
    END AS 'DGParzPhotosHigh-Visibility State',
    CASE DGParzPhotosHigh.ZENRICHMENTSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        ELSE 'Unknown-New-Value!: ' || DGParzPhotosHigh.ZENRICHMENTSTATE || ''
    END AS 'DGParzPhotosHigh-Enrichment State',
    DGParzPhotosHigh.ZENRICHMENTVERSION AS 'DGParzPhotosHigh-Enrichment Version',
    DGParzPhotosHigh.ZHIGHLIGHTVERSION AS 'DGParzPhotosHigh-Highlight Version',
    zAsset.ZHIGHLIGHTBEINGASSETS AS 'zAsset-Highlight Being Assets Key',
    HBAzPhotosHigh.ZUUID AS 'HBAzPhotosHigh-UUID',
    HBAzPhotosHigh.Z_PK AS 'HBAzPhotosHigh-zPK',
    HBAzPhotosHigh.ZPARENTPHOTOSHIGHLIGHT AS 'HBAzPhotosHigh-Parent PH Key',
    HBAzPhotosHigh.Z_ENT AS 'HBAzPhotosHigh-zENT',
    HBAzPhotosHigh.Z_OPT AS 'HBAzPhotosHigh-zOPT',
    HBAzPhotosHigh.ZPROMOTIONSCORE AS 'HBAzPhotosHigh-Promotion Score',
    HBAzPhotosHigh.ZTITLE AS 'HBAzPhotosHigh-Title',
    HBAzPhotosHigh.ZSUBTITLE AS 'HBAzPhotosHigh-Subtitle',
    HBAzPhotosHigh.ZVERBOSESMARTDESCRIPTION AS 'HBAzPhotosHigh-Verbose Smart Description',
    datetime(HBAzPhotosHigh.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'HBAzPhotosHigh-Start Date',
    HBAzPhotosHigh.ZSTARTTIMEZONEOFFSET AS 'HBAzPhotosHigh Start-Timezone Offset',
    HBAzPhotosHigh.ZENDTIMEZONEOFFSET AS 'HBAzPhotosHigh-End Timezone Offset',
    datetime(HBAzPhotosHigh.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'HBAzPhotosHigh-End Date',
    HBAzPhotosHigh.ZASSETSCOUNT AS 'HBAzPhotosHigh-Asset Count',
    HBAzPhotosHigh.ZSUMMARYCOUNT AS 'HBAzPhotosHigh-Summary Count',
    HBAzPhotosHigh.ZEXTENDEDCOUNT AS 'HBAzPhotosHigh-Extended Count',
    HBAzPhotosHigh.ZDAYGROUPASSETSCOUNT AS 'HBAzPhotosHigh-Day Group Assets Count',
    HBAzPhotosHigh.ZDAYGROUPEXTENDEDASSETSCOUNT AS 'HBAzPhotosHigh-Day Group Ext Assets Count',
    HBAzPhotosHigh.ZDAYGROUPSUMMARYASSETSCOUNT AS 'HBAzPhotosHigh-Day Group Summary Assets Count',
    HBAzPhotosHigh.ZKEYASSET AS 'HBAzPhotosHigh-Key Asset',
    CASE HBAzPhotosHigh.ZTYPE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-Photos Highlights Day Group'
        WHEN 4 THEN '4-StillTesting'
        WHEN 5 THEN '5-StillTesting'
        WHEN 6 THEN '6-Parent Day Group Photos Highlight'
        ELSE 'Unknown-New-Value!: ' || HBAzPhotosHigh.ZTYPE || ''
    END AS 'HBAzPhotosHigh-Type',
    CASE HBAzPhotosHigh.ZKIND
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN 'Year&Month Photo Highlights-1'
        WHEN 2 THEN 'Year Photo Highlights-2'
        WHEN 3 THEN 'Day Group Assets Photo Highlights-3'
        ELSE 'Unknown-New-Value!: ' || HBAzPhotosHigh.ZKIND || ''
    END AS 'HBAzPhotosHigh-Kind',
    CASE HBAzPhotosHigh.ZCATEGORY
        WHEN 0 THEN '0-Past Highlights'
        WHEN 1 THEN '1-Todays Highlights'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        ELSE 'Unknown-New-Value!: ' || HBAzPhotosHigh.ZCATEGORY || ''
    END AS 'HBAzPhotosHigh-Category',
    CASE HBAzPhotosHigh.ZVISIBILITYSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-Year&Month No Asset Count'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        ELSE 'Unknown-New-Value!: ' || HBAzPhotosHigh.ZVISIBILITYSTATE || ''
    END AS 'HBAzPhotosHigh-Visibility State',
    CASE HBAzPhotosHigh.ZMOOD
        WHEN 0 THEN '0-None'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        WHEN 16 THEN '16-StillTesting'
        WHEN 32 THEN '32-StillTesting'
        WHEN 64 THEN '64-StillTesting'
        WHEN 128 THEN '128-StillTesting'
        WHEN 512 THEN '512-StillTesting'
        ELSE 'Unknown-New-Value!: ' || HBAzPhotosHigh.ZMOOD || ''
    END AS 'HBAzPhotosHigh-Mood',
    CASE HBAzPhotosHigh.ZENRICHMENTSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        ELSE 'Unknown-New-Value!: ' || HBAzPhotosHigh.ZENRICHMENTSTATE || ''
    END AS 'HBAzPhotosHigh-Enrichment State',
    HBAzPhotosHigh.ZENRICHMENTVERSION AS 'HBAzPhotosHigh-Enrichment Version',
    HBAzPhotosHigh.ZHIGHLIGHTVERSION AS 'HBAzPhotosHigh-Highlight Version',
    zAsset.ZHIGHLIGHTBEINGEXTENDEDASSETS AS 'zAsset-Highlight Being Extended Assets Key',
    HBEAzPhotosHigh.ZUUID AS 'HBEAzPhotosHigh-UUID',
    HBEAzPhotosHigh.Z_PK AS 'HBEAzPhotosHigh-zPK',
    HBEAzPhotosHigh.Z_ENT AS 'HBEAzPhotosHigh-zENT',
    HBEAzPhotosHigh.Z_OPT AS 'HBEAzPhotosHigh-zOPT',
    HBEAzPhotosHigh.ZPROMOTIONSCORE AS 'HBEAzPhotosHigh-Promotion Score',
    HBEAzPhotosHigh.ZTITLE AS 'HBEAzPhotosHigh-Title',
    HBEAzPhotosHigh.ZSUBTITLE AS 'HBEAzPhotosHigh-Subtitle',
    HBEAzPhotosHigh.ZVERBOSESMARTDESCRIPTION AS 'HBEAzPhotosHigh-Verbose Smart Description',
    datetime(HBEAzPhotosHigh.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'HBEAzPhotosHigh-Start Date',
    HBEAzPhotosHigh.ZSTARTTIMEZONEOFFSET AS 'HBEAzPhotosHigh-Start Timezone Offset',
    HBEAzPhotosHigh.ZENDTIMEZONEOFFSET AS 'HBEAzPhotosHigh-End Timezone Offset',
    datetime(HBEAzPhotosHigh.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'HBEAzPhotosHigh-End Date',
    HBEAzPhotosHigh.ZASSETSCOUNT AS 'HBEAzPhotosHigh-Asset Count',
    HBEAzPhotosHigh.ZSUMMARYCOUNT AS 'HBEAzPhotosHigh-Summary Count',
    HBEAzPhotosHigh.ZEXTENDEDCOUNT AS 'HBEAzPhotosHigh-Extended Count',
    HBEAzPhotosHigh.ZDAYGROUPASSETSCOUNT AS 'HBEAzPhotosHigh-Day Group Assets Count',
    HBEAzPhotosHigh.ZDAYGROUPEXTENDEDASSETSCOUNT AS 'HBEAzPhotosHigh-Day Group Ext Assets Count',
    HBEAzPhotosHigh.ZDAYGROUPSUMMARYASSETSCOUNT AS 'HBEAzPhotosHigh-Day Group Summary Assets Count',
    HBEAzPhotosHigh.ZPARENTPHOTOSHIGHLIGHT AS 'HBEAzPhotosHigh-Parent PH Key',
    HBEAzPhotosHigh.ZYEARKEYASSET AS 'HBEAzPhotosHigh-Year Key Asset',
    HBEAzPhotosHigh.ZMONTHFIRSTASSET AS 'HBEAzPhotosHigh-Month First Asset',
    HBEAzPhotosHigh.ZMONTHKEYASSET AS 'HBEAzPhotosHigh-Month Key Asset',
    HBEAzPhotosHigh.ZKEYASSET AS 'HBEAzPhotosHigh-Key Asset',
    HBEAzPhotosHigh.ZPARENTDAYGROUPPHOTOSHIGHLIGHT AS 'HBEAzPhotosHigh-Parent Day Group PH Key',
    HBEAzPhotosHigh.ZDAYGROUPKEYASSET AS 'HBEAzPhotosHigh-Day Group Key Asset',
    CASE HBEAzPhotosHigh.ZTYPE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-Photos Highlights Day Group'
        WHEN 4 THEN '4-StillTesting'
        WHEN 5 THEN '5-StillTesting'
        WHEN 6 THEN '6-Parent Day Group Photos Highlight'
        ELSE 'Unknown-New-Value!: ' || HBEAzPhotosHigh.ZTYPE || ''
    END AS 'HBEAzPhotosHigh-Type',
    CASE HBEAzPhotosHigh.ZKIND
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN 'Year&Month Photo Highlights-1'
        WHEN 2 THEN 'Year Photo Highlights-2'
        WHEN 3 THEN 'Day Group Assets Photo Highlights-3'
        ELSE 'Unknown-New-Value!: ' || HBEAzPhotosHigh.ZKIND || ''
    END AS 'HBEAzPhotosHigh-Kind',
    CASE HBEAzPhotosHigh.ZCATEGORY
        WHEN 0 THEN '0-Past Highlights'
        WHEN 1 THEN '1-Todays Highlights'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        ELSE 'Unknown-New-Value!: ' || HBEAzPhotosHigh.ZCATEGORY || ''
    END AS 'HBEAzPhotosHigh-Category',
    CASE HBEAzPhotosHigh.ZVISIBILITYSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-Year&Month No Asset Count'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        ELSE 'Unknown-New-Value!: ' || HBEAzPhotosHigh.ZVISIBILITYSTATE || ''
    END AS 'HBEAzPhotosHigh-Visibility State',
    CASE HBEAzPhotosHigh.ZMOOD
        WHEN 0 THEN '0-None'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        WHEN 16 THEN '16-StillTesting'
        WHEN 32 THEN '32-StillTesting'
        WHEN 64 THEN '64-StillTesting'
        WHEN 128 THEN '128-StillTesting'
        WHEN 512 THEN '512-StillTesting'
        ELSE 'Unknown-New-Value!: ' || HBEAzPhotosHigh.ZMOOD || ''
    END AS 'HBEAzPhotosHigh-Mood',
    CASE HBEAzPhotosHigh.ZENRICHMENTSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        ELSE 'Unknown-New-Value!: ' || HBEAzPhotosHigh.ZENRICHMENTSTATE || ''
    END AS 'HBEAzPhotosHigh-Enrichment State',
    HBEAzPhotosHigh.ZENRICHMENTVERSION AS 'HBEAzPhotosHigh-Enrichment Version',
    HBEAzPhotosHigh.ZHIGHLIGHTVERSION AS 'HBEAzPhotosHigh-Highlight Version',
    zAsset.ZHIGHLIGHTBEINGSUMMARYASSETS AS 'zAsset-Highlight Being Summary Assets Key',
    HBSAzPhotosHigh.ZUUID AS 'HBSAzPhotosHigh-UUID',
    HBSAzPhotosHigh.Z_PK AS 'HBSAzPhotosHigh-zPK',
    HBSAzPhotosHigh.Z_ENT AS 'HBSAzPhotosHigh-zENT',
    HBSAzPhotosHigh.Z_OPT AS 'HBSAzPhotosHigh-zOPT',
    HBSAzPhotosHigh.ZPROMOTIONSCORE AS 'HBSAzPhotosHigh-Promotion Score',
    HBSAzPhotosHigh.ZTITLE AS 'HBSAzPhotosHigh-Title',
    HBSAzPhotosHigh.ZSUBTITLE AS 'HBSAzPhotosHigh-Subtitle',
    HBSAzPhotosHigh.ZVERBOSESMARTDESCRIPTION AS 'HBSAzPhotosHigh-Verbose Smart Description',
    datetime(HBSAzPhotosHigh.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'HBSAzPhotosHigh-Start Date',
    HBSAzPhotosHigh.ZSTARTTIMEZONEOFFSET AS 'HBSAzPhotosHigh-Start Timezone Offset',
    HBSAzPhotosHigh.ZENDTIMEZONEOFFSET AS 'HBSAzPhotosHigh-End Timezone Offset',
    datetime(HBSAzPhotosHigh.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'HBSAzPhotosHigh-End Date',
    HBSAzPhotosHigh.ZASSETSCOUNT AS 'HBSAzPhotosHigh-Asset Count',
    HBSAzPhotosHigh.ZSUMMARYCOUNT AS 'HBSAzPhotosHigh-Summary Count',
    HBSAzPhotosHigh.ZEXTENDEDCOUNT AS 'HBSAzPhotosHigh-Extended Count',
    HBSAzPhotosHigh.ZDAYGROUPASSETSCOUNT AS 'HBSAzPhotosHigh-Day Group Assets Count',
    HBSAzPhotosHigh.ZDAYGROUPEXTENDEDASSETSCOUNT AS 'HBSAzPhotosHigh-Day Group Ext Assets Count',
    HBSAzPhotosHigh.ZDAYGROUPSUMMARYASSETSCOUNT AS 'HBSAzPhotosHigh-Day Group Summary Assets Count',
    HBSAzPhotosHigh.ZPARENTPHOTOSHIGHLIGHT AS 'HBSAzPhotosHigh-Parent PH Key',
    HBSAzPhotosHigh.ZYEARKEYASSET AS 'HBSAzPhotosHigh-Year Key Asset',
    HBSAzPhotosHigh.ZMONTHFIRSTASSET AS 'HBSAzPhotosHigh-Month First Asset',
    HBSAzPhotosHigh.ZMONTHKEYASSET AS 'HBSAzPhotosHigh-Month Key Asset',
    HBSAzPhotosHigh.ZKEYASSET AS 'HBSAzPhotosHigh-Key Asset',
    HBSAzPhotosHigh.ZPARENTDAYGROUPPHOTOSHIGHLIGHT AS 'HBSAzPhotosHigh-Parent Day Group PH Key',
    HBSAzPhotosHigh.ZDAYGROUPKEYASSET AS 'HBSAzPhotosHigh-Day Group Key Asset',
    CASE HBSAzPhotosHigh.ZTYPE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-Photos Highlights Day Group'
        WHEN 4 THEN '4-StillTesting'
        WHEN 5 THEN '5-StillTesting'
        WHEN 6 THEN '6-Parent Day Group Photos Highlight'
        ELSE 'Unknown-New-Value!: ' || HBSAzPhotosHigh.ZTYPE || ''
    END AS 'HBSAzPhotosHigh-Type',
    CASE HBSAzPhotosHigh.ZKIND
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN 'Year&Month Photo Highlights-1'
        WHEN 2 THEN 'Year Photo Highlights-2'
        WHEN 3 THEN 'Day Group Assets Photo Highlights-3'
        ELSE 'Unknown-New-Value!: ' || HBSAzPhotosHigh.ZKIND || ''
    END AS 'HBSAzPhotosHigh-Kind',
    CASE HBSAzPhotosHigh.ZCATEGORY
        WHEN 0 THEN '0-Past Highlights'
        WHEN 1 THEN '1-Todays Highlights'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        ELSE 'Unknown-New-Value!: ' || HBSAzPhotosHigh.ZCATEGORY || ''
    END AS 'HBSAzPhotosHigh-Category',
    CASE HBSAzPhotosHigh.ZVISIBILITYSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-Year&Month No Asset Count'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        ELSE 'Unknown-New-Value!: ' || HBSAzPhotosHigh.ZVISIBILITYSTATE || ''
    END AS 'HBSAzPhotosHigh-Visibility State',
    CASE HBSAzPhotosHigh.ZMOOD
        WHEN 0 THEN '0-None'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        WHEN 16 THEN '16-StillTesting'
        WHEN 32 THEN '32-StillTesting'
        WHEN 64 THEN '64-StillTesting'
        WHEN 128 THEN '128-StillTesting'
        WHEN 512 THEN '512-StillTesting'
        ELSE 'Unknown-New-Value!: ' || HBSAzPhotosHigh.ZMOOD || ''
    END AS 'HBSAzPhotosHigh-Mood',
    CASE HBSAzPhotosHigh.ZENRICHMENTSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        ELSE 'Unknown-New-Value!: ' || HBSAzPhotosHigh.ZENRICHMENTSTATE || ''
    END AS 'HBSAzPhotosHigh-Enrichment State',
    HBSAzPhotosHigh.ZENRICHMENTVERSION AS 'HBSAzPhotosHigh-Enrichment Version',
    HBSAzPhotosHigh.ZHIGHLIGHTVERSION AS 'HBSAzPhotosHigh-Highlight Version',
    zAsset.ZHIGHLIGHTBEINGKEYASSET AS 'zAsset-Highlight Being Key Asset Key',
    HBKAzPhotosHigh.ZUUID AS 'HBKAzPhotosHigh-UUID',
    HBKAzPhotosHigh.Z_PK AS 'HBKAzPhotosHigh-zPK',
    HBKAzPhotosHigh.Z_ENT AS 'HBKAzPhotosHigh-zENT',
    HBKAzPhotosHigh.Z_OPT AS 'HBKAzPhotosHigh-zOPT',
    HBKAzPhotosHigh.ZPROMOTIONSCORE AS 'HBKAzPhotosHigh-Promotion Score',
    HBKAzPhotosHigh.ZTITLE AS 'HBKAzPhotosHigh-Title',
    HBKAzPhotosHigh.ZSUBTITLE AS 'HBKAzPhotosHigh-Subtitle',
    HBKAzPhotosHigh.ZVERBOSESMARTDESCRIPTION AS 'HBKAzPhotosHigh-Verbose Smart Description',
    datetime(HBKAzPhotosHigh.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'HBKAzPhotosHigh-Start Date',
    HBKAzPhotosHigh.ZSTARTTIMEZONEOFFSET AS 'HBKAzPhotosHigh-Start Timezone Offset',
    HBKAzPhotosHigh.ZENDTIMEZONEOFFSET AS 'HBKAzPhotosHigh-End Timezone Offset',
    datetime(HBKAzPhotosHigh.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'HBKAzPhotosHigh-End Date',
    HBKAzPhotosHigh.ZASSETSCOUNT AS 'HBKAzPhotosHigh-Asset Count',
    HBKAzPhotosHigh.ZSUMMARYCOUNT AS 'HBKAzPhotosHigh-Summary Count',
    HBKAzPhotosHigh.ZEXTENDEDCOUNT AS 'HBKAzPhotosHigh-Extended Count',
    HBKAzPhotosHigh.ZDAYGROUPASSETSCOUNT AS 'HBKAzPhotosHigh-Day Group Assets Count',
    HBKAzPhotosHigh.ZDAYGROUPEXTENDEDASSETSCOUNT AS 'HBKAzPhotosHigh-Day Group Ext Assets Count',
    HBKAzPhotosHigh.ZDAYGROUPSUMMARYASSETSCOUNT AS 'HBKAzPhotosHigh-Day Group Summary Assets Count',
    HBKAzPhotosHigh.ZPARENTPHOTOSHIGHLIGHT AS 'HBKAzPhotosHigh-Parent PH Key',
    HBKAzPhotosHigh.ZYEARKEYASSET AS 'HBKAzPhotosHigh-Year Key Asset',
    HBKAzPhotosHigh.ZMONTHFIRSTASSET AS 'HBKAzPhotosHigh-Month First Asset',
    HBKAzPhotosHigh.ZMONTHKEYASSET AS 'HBKAzPhotosHigh-Month Key Asset',
    HBKAzPhotosHigh.ZKEYASSET AS 'HBKAzPhotosHigh-Key Asset',
    HBKAzPhotosHigh.ZPARENTDAYGROUPPHOTOSHIGHLIGHT AS 'HBKAzPhotosHigh-Parent Day Group PH Key',
    HBKAzPhotosHigh.ZDAYGROUPKEYASSET AS 'HBKAzPhotosHigh-Day Group Key Asset',
    CASE HBKAzPhotosHigh.ZTYPE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-Photos Highlights Day Group'
        WHEN 4 THEN '4-StillTesting'
        WHEN 5 THEN '5-StillTesting'
        WHEN 6 THEN '6-Parent Day Group Photos Highlight'
        ELSE 'Unknown-New-Value!: ' || HBKAzPhotosHigh.ZTYPE || ''
    END AS 'HBKAzPhotosHigh-Type',
    CASE HBKAzPhotosHigh.ZKIND
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN 'Year&Month Photo Highlights-1'
        WHEN 2 THEN 'Year Photo Highlights-2'
        WHEN 3 THEN 'Day Group Assets Photo Highlights-3'
        ELSE 'Unknown-New-Value!: ' || HBKAzPhotosHigh.ZKIND || ''
    END AS 'HBKAzPhotosHigh-Kind',
    CASE HBKAzPhotosHigh.ZCATEGORY
        WHEN 0 THEN '0-Past Highlights'
        WHEN 1 THEN '1-Todays Highlights'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        ELSE 'Unknown-New-Value!: ' || HBKAzPhotosHigh.ZCATEGORY || ''
    END AS 'HBKAzPhotosHigh-Category',
    CASE HBKAzPhotosHigh.ZVISIBILITYSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-Year&Month No Asset Count'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        ELSE 'Unknown-New-Value!: ' || HBKAzPhotosHigh.ZVISIBILITYSTATE || ''
    END AS 'HBKAzPhotosHigh-Visibility State',
    CASE HBKAzPhotosHigh.ZMOOD
        WHEN 0 THEN '0-None'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        WHEN 16 THEN '16-StillTesting'
        WHEN 32 THEN '32-StillTesting'
        WHEN 64 THEN '64-StillTesting'
        WHEN 128 THEN '128-StillTesting'
        WHEN 512 THEN '512-StillTesting'
        ELSE 'Unknown-New-Value!: ' || HBKAzPhotosHigh.ZMOOD || ''
    END AS 'HBKAzPhotosHigh-Mood',
    CASE HBKAzPhotosHigh.ZENRICHMENTSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        ELSE 'Unknown-New-Value!: ' || HBKAzPhotosHigh.ZENRICHMENTSTATE || ''
    END AS 'HBKAzPhotosHigh-Enrichment State',
    HBKAzPhotosHigh.ZENRICHMENTVERSION AS 'HBKAzPhotosHigh-Enrichment Version',
    HBKAzPhotosHigh.ZHIGHLIGHTVERSION AS 'HBKAzPhotosHigh-Highlight Version',
    zAsset.ZDAYGROUPHIGHLIGHTBEINGASSETS AS 'zAsset-Day Group Highlight Being Assets Key',
    DGHBAzPhotosHigh.ZUUID AS 'DGHBAzPhotosHigh-UUID',
    DGHBAzPhotosHigh.Z_PK AS 'DGHBAzPhotosHigh-zPK',
    DGHBAzPhotosHigh.Z_ENT AS 'DGHBAzPhotosHigh-zENT',
    DGHBAzPhotosHigh.Z_OPT AS 'DGHBAzPhotosHigh-zOPT',
    DGHBAzPhotosHigh.ZPROMOTIONSCORE AS 'DGHBAzPhotosHigh-Promotion Score',
    DGHBAzPhotosHigh.ZTITLE AS 'DGHBAzPhotosHigh-Title',
    DGHBAzPhotosHigh.ZSUBTITLE AS 'DGHBAzPhotosHigh-Subtitle',
    DGHBAzPhotosHigh.ZVERBOSESMARTDESCRIPTION AS 'DGHBAzPhotosHigh-Verbose Smart Description',
    datetime(DGHBAzPhotosHigh.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'DGHBAzPhotosHigh-Start Date',
    DGHBAzPhotosHigh.ZSTARTTIMEZONEOFFSET AS 'DGHBAzPhotosHigh-Start Timezone Offset',
    DGHBAzPhotosHigh.ZENDTIMEZONEOFFSET AS 'DGHBAzPhotosHigh-End Timezone Offset',
    datetime(DGHBAzPhotosHigh.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'DGHBAzPhotosHigh-End Date',
    DGHBAzPhotosHigh.ZASSETSCOUNT AS 'DGHBAzPhotosHigh-Asset Count',
    DGHBAzPhotosHigh.ZSUMMARYCOUNT AS 'DGHBAzPhotosHigh-Summary Count',
    DGHBAzPhotosHigh.ZEXTENDEDCOUNT AS 'DGHBAzPhotosHigh-Extended Count',
    DGHBAzPhotosHigh.ZDAYGROUPASSETSCOUNT AS 'DGHBAzPhotosHigh-Day Group Assets Count',
    DGHBAzPhotosHigh.ZDAYGROUPEXTENDEDASSETSCOUNT AS 'DGHBAzPhotosHigh-Day Group Ext Assets Count',
    DGHBAzPhotosHigh.ZDAYGROUPSUMMARYASSETSCOUNT AS 'DGHBAzPhotosHigh-Day Group Summary Assets Count',
    DGHBAzPhotosHigh.ZPARENTPHOTOSHIGHLIGHT AS 'DGHBAzPhotosHigh-Parent PH Key',
    DGHBAzPhotosHigh.ZYEARKEYASSET AS 'DGHBAzPhotosHigh-Year Key Asset',
    DGHBAzPhotosHigh.ZMONTHFIRSTASSET AS 'DGHBAzPhotosHigh-Month First Asset',
    DGHBAzPhotosHigh.ZMONTHKEYASSET AS 'DGHBAzPhotosHigh-Month Key Asset',
    DGHBAzPhotosHigh.ZKEYASSET AS 'DGHBAzPhotosHigh-Key Asset',
    DGHBAzPhotosHigh.ZPARENTDAYGROUPPHOTOSHIGHLIGHT AS 'DGHBAzPhotosHigh-Parent Day Group PH Key',
    DGHBAzPhotosHigh.ZDAYGROUPKEYASSET AS 'DGHBAzPhotosHigh-Day Group Key Asset',
    CASE DGHBAzPhotosHigh.ZTYPE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-Photos Highlights Day Group'
        WHEN 4 THEN '4-StillTesting'
        WHEN 5 THEN '5-StillTesting'
        WHEN 6 THEN '6-Parent Day Group Photos Highlight'
        ELSE 'Unknown-New-Value!: ' || DGHBAzPhotosHigh.ZTYPE || ''
    END AS 'DGHBAzPhotosHigh-Type',
    CASE DGHBAzPhotosHigh.ZKIND
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN 'Year&Month Photo Highlights-1'
        WHEN 2 THEN 'Year Photo Highlights-2'
        WHEN 3 THEN 'Day Group Assets Photo Highlights-3'
        ELSE 'Unknown-New-Value!: ' || DGHBAzPhotosHigh.ZKIND || ''
    END AS 'DGHBAzPhotosHigh-Kind',
    CASE DGHBAzPhotosHigh.ZCATEGORY
        WHEN 0 THEN '0-Past Highlights'
        WHEN 1 THEN '1-Todays Highlights'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        ELSE 'Unknown-New-Value!: ' || DGHBAzPhotosHigh.ZCATEGORY || ''
    END AS 'DGHBAzPhotosHigh-Category',
    CASE DGHBAzPhotosHigh.ZVISIBILITYSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-Year&Month No Asset Count'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        ELSE 'Unknown-New-Value!: ' || DGHBAzPhotosHigh.ZVISIBILITYSTATE || ''
    END AS 'DGHBAzPhotosHigh-Visibility State',
    CASE DGHBAzPhotosHigh.ZMOOD
        WHEN 0 THEN '0-None'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        WHEN 16 THEN '16-StillTesting'
        WHEN 32 THEN '32-StillTesting'
        WHEN 64 THEN '64-StillTesting'
        WHEN 128 THEN '128-StillTesting'
        WHEN 512 THEN '512-StillTesting'
        ELSE 'Unknown-New-Value!: ' || DGHBAzPhotosHigh.ZMOOD || ''
    END AS 'DGHBAzPhotosHigh-Mood',
    CASE DGHBAzPhotosHigh.ZENRICHMENTSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        ELSE 'Unknown-New-Value!: ' || DGHBAzPhotosHigh.ZENRICHMENTSTATE || ''
    END AS 'DGHBAzPhotosHigh-Enrichment State',
    DGHBAzPhotosHigh.ZENRICHMENTVERSION AS 'DGHBAzPhotosHigh-Enrichment Version',
    DGHBAzPhotosHigh.ZHIGHLIGHTVERSION AS 'DGHBAzPhotosHigh-Highlight Version',
    zAsset.ZDAYGROUPHIGHLIGHTBEINGEXTENDEDASSETS AS 'zAsset-Day Group Highlight Being Extended Assets Key',
    DGHBEAzPhotosHigh.ZUUID AS 'DGHBEAzPhotosHigh-UUID',
    DGHBEAzPhotosHigh.Z_PK AS 'DGHBEAzPhotosHigh-zPK',
    DGHBEAzPhotosHigh.Z_ENT AS 'DGHBEAzPhotosHigh-zENT',
    DGHBEAzPhotosHigh.Z_OPT AS 'DGHBEAzPhotosHigh-zOPT',
    DGHBEAzPhotosHigh.ZPROMOTIONSCORE AS 'DGHBEAzPhotosHigh-Promotion Score',
    DGHBEAzPhotosHigh.ZTITLE AS 'DGHBEAzPhotosHigh-Title',
    DGHBEAzPhotosHigh.ZSUBTITLE AS 'DGHBEAzPhotosHigh-Subtitle',
    DGHBEAzPhotosHigh.ZVERBOSESMARTDESCRIPTION AS 'DGHBEAzPhotosHigh-Verbose Smart Description',
    datetime(DGHBEAzPhotosHigh.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'DGHBEAzPhotosHigh-Start Date',
    DGHBEAzPhotosHigh.ZSTARTTIMEZONEOFFSET AS 'DGHBEAzPhotosHigh-Start Timezone Offset',
    DGHBEAzPhotosHigh.ZENDTIMEZONEOFFSET AS 'DGHBEAzPhotosHigh-End Timezone Offset',
    datetime(DGHBEAzPhotosHigh.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'DGHBEAzPhotosHigh-End Date',
    DGHBEAzPhotosHigh.ZASSETSCOUNT AS 'DGHBEAzPhotosHigh-Asset Count',
    DGHBEAzPhotosHigh.ZSUMMARYCOUNT AS 'DGHBEAzPhotosHigh-Summary Count',
    DGHBEAzPhotosHigh.ZEXTENDEDCOUNT AS 'DGHBEAzPhotosHigh-Extended Count',
    DGHBEAzPhotosHigh.ZDAYGROUPASSETSCOUNT AS 'DGHBEAzPhotosHigh-Day Group Assets Count',
    DGHBEAzPhotosHigh.ZDAYGROUPEXTENDEDASSETSCOUNT AS 'DGHBEAzPhotosHigh-Day Group Ext Assets Count',
    DGHBEAzPhotosHigh.ZDAYGROUPSUMMARYASSETSCOUNT AS 'DGHBEAzPhotosHigh-Day Group Summary Assets Count',
    DGHBEAzPhotosHigh.ZPARENTPHOTOSHIGHLIGHT AS 'DGHBEAzPhotosHigh-Parent PH Key',
    DGHBEAzPhotosHigh.ZYEARKEYASSET AS 'DGHBEAzPhotosHigh-Year Key Asset',
    DGHBEAzPhotosHigh.ZMONTHFIRSTASSET AS 'DGHBEAzPhotosHigh-Month First Asset',
    DGHBEAzPhotosHigh.ZMONTHKEYASSET AS 'DGHBEAzPhotosHigh-Month Key Asset',
    DGHBEAzPhotosHigh.ZKEYASSET AS 'DGHBEAzPhotosHigh-Key Asset',
    DGHBEAzPhotosHigh.ZPARENTDAYGROUPPHOTOSHIGHLIGHT AS 'DGHBEAzPhotosHigh-Parent Day Group PH Key',
    DGHBEAzPhotosHigh.ZDAYGROUPKEYASSET AS 'DGHBEAzPhotosHigh-Day Group Key Asset',
    CASE DGHBEAzPhotosHigh.ZTYPE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-Photos Highlights Day Group'
        WHEN 4 THEN '4-StillTesting'
        WHEN 5 THEN '5-StillTesting'
        WHEN 6 THEN '6-Parent Day Group Photos Highlight'
        ELSE 'Unknown-New-Value!: ' || DGHBEAzPhotosHigh.ZTYPE || ''
    END AS 'DGHBEAzPhotosHigh-Type',
    CASE DGHBEAzPhotosHigh.ZKIND
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN 'Year&Month Photo Highlights-1'
        WHEN 2 THEN 'Year Photo Highlights-2'
        WHEN 3 THEN 'Day Group Assets Photo Highlights-3'
        ELSE 'Unknown-New-Value!: ' || DGHBEAzPhotosHigh.ZKIND || ''
    END AS 'DGHBEAzPhotosHigh-Kind',
    CASE DGHBEAzPhotosHigh.ZCATEGORY
        WHEN 0 THEN '0-Past Highlights'
        WHEN 1 THEN '1-Todays Highlights'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        ELSE 'Unknown-New-Value!: ' || DGHBEAzPhotosHigh.ZCATEGORY || ''
    END AS 'DGHBEAzPhotosHigh-Category',
    CASE DGHBEAzPhotosHigh.ZVISIBILITYSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-Year&Month No Asset Count'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        ELSE 'Unknown-New-Value!: ' || DGHBEAzPhotosHigh.ZVISIBILITYSTATE || ''
    END AS 'DGHBEAzPhotosHigh-Visibility State',
    CASE DGHBEAzPhotosHigh.ZMOOD
        WHEN 0 THEN '0-None'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        WHEN 16 THEN '16-StillTesting'
        WHEN 32 THEN '32-StillTesting'
        WHEN 64 THEN '64-StillTesting'
        WHEN 128 THEN '128-StillTesting'
        WHEN 512 THEN '512-StillTesting'
        ELSE 'Unknown-New-Value!: ' || DGHBEAzPhotosHigh.ZMOOD || ''
    END AS 'DGHBEAzPhotosHigh-Mood',
    CASE DGHBEAzPhotosHigh.ZENRICHMENTSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        ELSE 'Unknown-New-Value!: ' || DGHBEAzPhotosHigh.ZENRICHMENTSTATE || ''
    END AS 'DGHBEAzPhotosHigh-Enrichment State',
    DGHBEAzPhotosHigh.ZENRICHMENTVERSION AS 'DGHBEAzPhotosHigh-Enrichment Version',
    DGHBEAzPhotosHigh.ZHIGHLIGHTVERSION AS 'DGHBEAzPhotosHigh-Highlight Version',
    zAsset.ZDAYGROUPHIGHLIGHTBEINGKEYASSET AS 'zAsset-Day Group Highlight Being Key Asset',
    DGHBKAzPhotosHigh.ZUUID AS 'DGHBKAzPhotosHigh-UUID',
    DGHBKAzPhotosHigh.Z_PK AS 'DGHBKAzPhotosHigh-zPK',
    DGHBKAzPhotosHigh.Z_ENT AS 'DGHBKAzPhotosHigh-zENT',
    DGHBKAzPhotosHigh.Z_OPT AS 'DGHBKAzPhotosHigh-zOPT',
    DGHBKAzPhotosHigh.ZPROMOTIONSCORE AS 'DGHBKAzPhotosHigh-Promotion Score',
    DGHBKAzPhotosHigh.ZTITLE AS 'DGHBKAzPhotosHigh-Title',
    DGHBKAzPhotosHigh.ZSUBTITLE AS 'DGHBKAzPhotosHigh-Subtitle',
    DGHBKAzPhotosHigh.ZVERBOSESMARTDESCRIPTION AS 'DGHBKAzPhotosHigh-Verbose Smart Description',
    datetime(DGHBKAzPhotosHigh.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'DGHBKAzPhotosHigh-Start Date',
    DGHBKAzPhotosHigh.ZSTARTTIMEZONEOFFSET AS 'DGHBKAzPhotosHigh-Start Timezone Offset',
    DGHBKAzPhotosHigh.ZENDTIMEZONEOFFSET AS 'DGHBKAzPhotosHigh-End Timezone Offset',
    datetime(DGHBKAzPhotosHigh.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'DGHBKAzPhotosHigh-End Date',
    DGHBKAzPhotosHigh.ZASSETSCOUNT AS 'DGHBKAzPhotosHigh-Asset Count',
    DGHBKAzPhotosHigh.ZSUMMARYCOUNT AS 'DGHBKAzPhotosHigh-Summary Count',
    DGHBKAzPhotosHigh.ZEXTENDEDCOUNT AS 'DGHBKAzPhotosHigh-Extended Count',
    DGHBKAzPhotosHigh.ZDAYGROUPASSETSCOUNT AS 'DGHBKAzPhotosHigh-Day Group Assets Count',
    DGHBKAzPhotosHigh.ZDAYGROUPEXTENDEDASSETSCOUNT AS 'DGHBKAzPhotosHigh-Day Group Ext Assets Count',
    DGHBKAzPhotosHigh.ZDAYGROUPSUMMARYASSETSCOUNT AS 'DGHBKAzPhotosHigh-Day Group Summary Assets Count',
    DGHBKAzPhotosHigh.ZPARENTPHOTOSHIGHLIGHT AS 'DGHBKAzPhotosHigh-Parent PH Key',
    DGHBKAzPhotosHigh.ZYEARKEYASSET AS 'DGHBKAzPhotosHigh-Year Key Asset',
    DGHBKAzPhotosHigh.ZMONTHFIRSTASSET AS 'DGHBKAzPhotosHigh-Month First Asset',
    DGHBKAzPhotosHigh.ZMONTHKEYASSET AS 'DGHBKAzPhotosHigh-Month Key Asset',
    DGHBKAzPhotosHigh.ZKEYASSET AS 'DGHBKAzPhotosHigh-Key Asset',
    DGHBKAzPhotosHigh.ZPARENTDAYGROUPPHOTOSHIGHLIGHT AS 'DGHBKAzPhotosHigh-Parent Day Group PH Key',
    DGHBKAzPhotosHigh.ZDAYGROUPKEYASSET AS 'DGHBKAzPhotosHigh-Day Group Key Asset',
    CASE DGHBKAzPhotosHigh.ZTYPE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-Photos Highlights Day Group'
        WHEN 4 THEN '4-StillTesting'
        WHEN 5 THEN '5-StillTesting'
        WHEN 6 THEN '6-Parent Day Group Photos Highlight'
        ELSE 'Unknown-New-Value!: ' || DGHBKAzPhotosHigh.ZTYPE || ''
    END AS 'DGHBKAzPhotosHigh-Type',
    CASE DGHBKAzPhotosHigh.ZKIND
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN 'Year&Month Photo Highlights-1'
        WHEN 2 THEN 'Year Photo Highlights-2'
        WHEN 3 THEN 'Day Group Assets Photo Highlights-3'
        ELSE 'Unknown-New-Value!: ' || DGHBKAzPhotosHigh.ZKIND || ''
    END AS 'DGHBKAzPhotosHigh-Kind',
    CASE DGHBKAzPhotosHigh.ZCATEGORY
        WHEN 0 THEN '0-Past Highlights'
        WHEN 1 THEN '1-Todays Highlights'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        ELSE 'Unknown-New-Value!: ' || DGHBKAzPhotosHigh.ZCATEGORY || ''
    END AS 'DGHBKAzPhotosHigh-Category',
    CASE DGHBKAzPhotosHigh.ZVISIBILITYSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-Year&Month No Asset Count'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        ELSE 'Unknown-New-Value!: ' || DGHBKAzPhotosHigh.ZVISIBILITYSTATE || ''
    END AS 'DGHBKAzPhotosHigh-Visibility State',
    CASE DGHBKAzPhotosHigh.ZMOOD
        WHEN 0 THEN '0-None'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        WHEN 16 THEN '16-StillTesting'
        WHEN 32 THEN '32-StillTesting'
        WHEN 64 THEN '64-StillTesting'
        WHEN 128 THEN '128-StillTesting'
        WHEN 512 THEN '512-StillTesting'
        ELSE 'Unknown-New-Value!: ' || DGHBKAzPhotosHigh.ZMOOD || ''
    END AS 'DGHBKAzPhotosHigh-Mood',
    CASE DGHBKAzPhotosHigh.ZENRICHMENTSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        ELSE 'Unknown-New-Value!: ' || DGHBKAzPhotosHigh.ZENRICHMENTSTATE || ''
    END AS 'DGHBKAzPhotosHigh-Enrichment State',
    DGHBKAzPhotosHigh.ZENRICHMENTVERSION AS 'DGHBKAzPhotosHigh-Enrichment Version',
    DGHBKAzPhotosHigh.ZHIGHLIGHTVERSION AS 'DGHBKAzPhotosHigh-Highlight Version',
    zAsset.ZDAYGROUPHIGHLIGHTBEINGSUMMARYASSETS AS 'zAsset-Day Group Highlight Being Summary Assets Key',
    DGHBSAzPhotosHigh.ZUUID AS 'DGHBSAzPhotosHigh-UUID',
    DGHBSAzPhotosHigh.Z_PK AS 'DGHBSAzPhotosHigh-zPK',
    DGHBSAzPhotosHigh.Z_ENT AS 'DGHBSAzPhotosHigh-zENT',
    DGHBSAzPhotosHigh.Z_OPT AS 'DGHBSAzPhotosHigh-zOPT',
    DGHBSAzPhotosHigh.ZPROMOTIONSCORE AS 'DGHBSAzPhotosHigh-Promotion Score',
    DGHBSAzPhotosHigh.ZTITLE AS 'DGHBSAzPhotosHigh-Title',
    DGHBSAzPhotosHigh.ZSUBTITLE AS 'DGHBSAzPhotosHigh-Subtitle',
    DGHBSAzPhotosHigh.ZVERBOSESMARTDESCRIPTION AS 'DGHBSAzPhotosHigh-Verbose Smart Description',
    datetime(DGHBSAzPhotosHigh.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'DGHBSAzPhotosHigh-Start Date',
    DGHBSAzPhotosHigh.ZSTARTTIMEZONEOFFSET AS 'DGHBSAzPhotosHigh-Start Timezone Offset',
    DGHBSAzPhotosHigh.ZENDTIMEZONEOFFSET AS 'DGHBSAzPhotosHigh-End Timezone Offset',
    datetime(DGHBSAzPhotosHigh.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'DGHBSAzPhotosHigh-End Date',
    DGHBSAzPhotosHigh.ZASSETSCOUNT AS 'DGHBSAzPhotosHigh-Asset Count',
    DGHBSAzPhotosHigh.ZSUMMARYCOUNT AS 'DGHBSAzPhotosHigh-Summary Count',
    DGHBSAzPhotosHigh.ZEXTENDEDCOUNT AS 'DGHBSAzPhotosHigh-Extended Count',
    DGHBSAzPhotosHigh.ZDAYGROUPASSETSCOUNT AS 'DGHBSAzPhotosHigh-Day Group Assets Count',
    DGHBSAzPhotosHigh.ZDAYGROUPEXTENDEDASSETSCOUNT AS 'DGHBSAzPhotosHigh-Day Group Ext Assets Count',
    DGHBSAzPhotosHigh.ZDAYGROUPSUMMARYASSETSCOUNT AS 'DGHBSAzPhotosHigh-Day Group Summary Assets Count',
    DGHBSAzPhotosHigh.ZPARENTPHOTOSHIGHLIGHT AS 'DGHBSAzPhotosHigh-Parent PH Key',
    DGHBSAzPhotosHigh.ZYEARKEYASSET AS 'DGHBSAzPhotosHigh-Year Key Asset',
    DGHBSAzPhotosHigh.ZMONTHFIRSTASSET AS 'DGHBSAzPhotosHigh-Month First Asset',
    DGHBSAzPhotosHigh.ZMONTHKEYASSET AS 'DGHBSAzPhotosHigh-Month Key Asset',
    DGHBSAzPhotosHigh.ZKEYASSET AS 'DGHBSAzPhotosHigh-Key Asset',
    DGHBSAzPhotosHigh.ZPARENTDAYGROUPPHOTOSHIGHLIGHT AS 'DGHBSAzPhotosHigh-Parent Day Group PH Key',
    DGHBSAzPhotosHigh.ZDAYGROUPKEYASSET AS 'DGHBSAzPhotosHigh-Day Group Key Asset',
    CASE DGHBSAzPhotosHigh.ZTYPE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-Photos Highlights Day Group'
        WHEN 4 THEN '4-StillTesting'
        WHEN 5 THEN '5-StillTesting'
        WHEN 6 THEN '6-Parent Day Group Photos Highlight'
        ELSE 'Unknown-New-Value!: ' || DGHBSAzPhotosHigh.ZTYPE || ''
    END AS 'DGHBSAzPhotosHigh-Type',
    CASE DGHBSAzPhotosHigh.ZKIND
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN 'Year&Month Photo Highlights-1'
        WHEN 2 THEN 'Year Photo Highlights-2'
        WHEN 3 THEN 'Day Group Assets Photo Highlights-3'
        ELSE 'Unknown-New-Value!: ' || DGHBSAzPhotosHigh.ZKIND || ''
    END AS 'DGHBSAzPhotosHigh-Kind',
    CASE DGHBSAzPhotosHigh.ZCATEGORY
        WHEN 0 THEN '0-Past Highlights'
        WHEN 1 THEN '1-Todays Highlights'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        ELSE 'Unknown-New-Value!: ' || DGHBSAzPhotosHigh.ZCATEGORY || ''
    END AS 'DGHBSAzPhotosHigh-Category',
    CASE DGHBSAzPhotosHigh.ZVISIBILITYSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-Year&Month No Asset Count'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        ELSE 'Unknown-New-Value!: ' || DGHBSAzPhotosHigh.ZVISIBILITYSTATE || ''
    END AS 'DGHBSAzPhotosHigh-Visibility State',
    CASE DGHBSAzPhotosHigh.ZMOOD
        WHEN 0 THEN '0-None'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        WHEN 16 THEN '16-StillTesting'
        WHEN 32 THEN '32-StillTesting'
        WHEN 64 THEN '64-StillTesting'
        WHEN 128 THEN '128-StillTesting'
        WHEN 512 THEN '512-StillTesting'
        ELSE 'Unknown-New-Value!: ' || DGHBSAzPhotosHigh.ZMOOD || ''
    END AS 'DGHBSAzPhotosHigh-Mood',
    CASE DGHBSAzPhotosHigh.ZENRICHMENTSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        ELSE 'Unknown-New-Value!: ' || DGHBSAzPhotosHigh.ZENRICHMENTSTATE || ''
    END AS 'DGHBSAzPhotosHigh-Enrichment State',
    DGHBSAzPhotosHigh.ZENRICHMENTVERSION AS 'DGHBSAzPhotosHigh-Enrichment Version',
    DGHBSAzPhotosHigh.ZHIGHLIGHTVERSION AS 'DGHBSAzPhotosHigh-Highlight Version',
    zAsset.ZMONTHHIGHLIGHTBEINGFIRSTASSET AS 'zAsset-Month Highlight Being First Asset Key',
    MHBFAzPhotosHigh.ZUUID AS 'MHBFAzPhotosHigh-UUID',
    MHBFAzPhotosHigh.Z_PK AS 'MHBFAzPhotosHigh-zPK',
    MHBFAzPhotosHigh.Z_ENT AS 'MHBFAzPhotosHigh-zENT',
    MHBFAzPhotosHigh.Z_OPT AS 'MHBFAzPhotosHigh-zOPT',
    MHBFAzPhotosHigh.ZPROMOTIONSCORE AS 'MHBFAzPhotosHigh-Promotion Score',
    MHBFAzPhotosHigh.ZTITLE AS 'MHBFAzPhotosHigh-Title',
    MHBFAzPhotosHigh.ZSUBTITLE AS 'MHBFAzPhotosHigh-Subtitle',
    MHBFAzPhotosHigh.ZVERBOSESMARTDESCRIPTION AS 'MHBFAzPhotosHigh-Verbose Smart Description',
    datetime(MHBFAzPhotosHigh.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'MHBFAzPhotosHigh-Start Date',
    MHBFAzPhotosHigh.ZSTARTTIMEZONEOFFSET AS 'MHBFAzPhotosHigh-Start Timezone Offset',
    MHBFAzPhotosHigh.ZENDTIMEZONEOFFSET AS 'MHBFAzPhotosHigh-End Timezone Offset',
    datetime(MHBFAzPhotosHigh.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'MHBFAzPhotosHigh-End Date',
    MHBFAzPhotosHigh.ZASSETSCOUNT AS 'MHBFAzPhotosHigh-Asset Count',
    MHBFAzPhotosHigh.ZSUMMARYCOUNT AS 'MHBFAzPhotosHigh-Summary Count',
    MHBFAzPhotosHigh.ZEXTENDEDCOUNT AS 'MHBFAzPhotosHigh-Extended Count',
    MHBFAzPhotosHigh.ZDAYGROUPASSETSCOUNT AS 'MHBFAzPhotosHigh-Day Group Assets Count',
    MHBFAzPhotosHigh.ZDAYGROUPEXTENDEDASSETSCOUNT AS 'MHBFAzPhotosHigh-Day Group Ext Assets Count',
    MHBFAzPhotosHigh.ZDAYGROUPSUMMARYASSETSCOUNT AS 'MHBFAzPhotosHigh-Day Group Summary Assets Count',
    MHBFAzPhotosHigh.ZPARENTPHOTOSHIGHLIGHT AS 'MHBFAzPhotosHigh-Parent PH Key',
    MHBFAzPhotosHigh.ZYEARKEYASSET AS 'MHBFAzPhotosHigh-Year Key Asset',
    MHBFAzPhotosHigh.ZMONTHFIRSTASSET AS 'MHBFAzPhotosHigh-Month First Asset',
    MHBFAzPhotosHigh.ZMONTHKEYASSET AS 'MHBFAzPhotosHigh-Month Key Asset',
    MHBFAzPhotosHigh.ZKEYASSET AS 'MHBFAzPhotosHigh-Key Asset',
    MHBFAzPhotosHigh.ZPARENTDAYGROUPPHOTOSHIGHLIGHT AS 'MHBFAzPhotosHigh-Parent Day Group PH Key',
    MHBFAzPhotosHigh.ZDAYGROUPKEYASSET AS 'MHBFAzPhotosHigh-Day Group Key Asset',
    CASE MHBFAzPhotosHigh.ZTYPE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-Photos Highlights Day Group'
        WHEN 4 THEN '4-StillTesting'
        WHEN 5 THEN '5-StillTesting'
        WHEN 6 THEN '6-Parent Day Group Photos Highlight'
        ELSE 'Unknown-New-Value!: ' || MHBFAzPhotosHigh.ZTYPE || ''
    END AS 'MHBFAzPhotosHigh-Type',
    CASE MHBFAzPhotosHigh.ZKIND
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN 'Year&Month Photo Highlights-1'
        WHEN 2 THEN 'Year Photo Highlights-2'
        WHEN 3 THEN 'Day Group Assets Photo Highlights-3'
        ELSE 'Unknown-New-Value!: ' || MHBFAzPhotosHigh.ZKIND || ''
    END AS 'MHBFAzPhotosHigh-Kind',
    CASE MHBFAzPhotosHigh.ZCATEGORY
        WHEN 0 THEN '0-Past Highlights'
        WHEN 1 THEN '1-Todays Highlights'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        ELSE 'Unknown-New-Value!: ' || MHBFAzPhotosHigh.ZCATEGORY || ''
    END AS 'MHBFAzPhotosHigh-Category',
    CASE MHBFAzPhotosHigh.ZVISIBILITYSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-Year&Month No Asset Count'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        ELSE 'Unknown-New-Value!: ' || MHBFAzPhotosHigh.ZVISIBILITYSTATE || ''
    END AS 'MHBFAzPhotosHigh-Visibility State',
    CASE MHBFAzPhotosHigh.ZMOOD
        WHEN 0 THEN '0-None'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        WHEN 16 THEN '16-StillTesting'
        WHEN 32 THEN '32-StillTesting'
        WHEN 64 THEN '64-StillTesting'
        WHEN 128 THEN '128-StillTesting'
        WHEN 512 THEN '512-StillTesting'
        ELSE 'Unknown-New-Value!: ' || MHBFAzPhotosHigh.ZMOOD || ''
    END AS 'MHBFAzPhotosHigh-Mood',
    CASE MHBFAzPhotosHigh.ZENRICHMENTSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        ELSE 'Unknown-New-Value!: ' || MHBFAzPhotosHigh.ZENRICHMENTSTATE || ''
    END AS 'MHBFAzPhotosHigh-Enrichment State',
    MHBFAzPhotosHigh.ZENRICHMENTVERSION AS 'MHBFAzPhotosHigh-Enrichment Version',
    MHBFAzPhotosHigh.ZHIGHLIGHTVERSION AS 'MHBFAzPhotosHigh-Highlight Version',
    zAsset.ZMONTHHIGHLIGHTBEINGKEYASSET AS 'zAsset-Month Highlight Being Key Asset',
    MHBKAzPhotosHigh.ZUUID AS 'MHBKAzPhotosHigh-UUID',
    MHBKAzPhotosHigh.Z_PK AS 'MHBKAzPhotosHigh-zPK',
    MHBKAzPhotosHigh.Z_ENT AS 'MHBKAzPhotosHigh-zENT',
    MHBKAzPhotosHigh.Z_OPT AS 'MHBKAzPhotosHigh-zOPT',
    MHBKAzPhotosHigh.ZPROMOTIONSCORE AS 'MHBKAzPhotosHigh-Promotion Score',
    MHBKAzPhotosHigh.ZTITLE AS 'MHBKAzPhotosHigh-Title',
    MHBKAzPhotosHigh.ZSUBTITLE AS 'MHBKAzPhotosHigh-Subtitle',
    MHBKAzPhotosHigh.ZVERBOSESMARTDESCRIPTION AS 'MHBKAzPhotosHigh-Verbose Smart Description',
    datetime(MHBKAzPhotosHigh.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'MHBKAzPhotosHigh-Start Date',
    MHBKAzPhotosHigh.ZSTARTTIMEZONEOFFSET AS 'MHBKAzPhotosHigh-Start Timezone Offset',
    MHBKAzPhotosHigh.ZENDTIMEZONEOFFSET AS 'MHBKAzPhotosHigh-End Timezone Offset',
    datetime(MHBKAzPhotosHigh.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'MHBKAzPhotosHigh-End Date',
    MHBKAzPhotosHigh.ZASSETSCOUNT AS 'MHBKAzPhotosHigh-Asset Count',
    MHBKAzPhotosHigh.ZSUMMARYCOUNT AS 'MHBKAzPhotosHigh-Summary Count',
    MHBKAzPhotosHigh.ZEXTENDEDCOUNT AS 'MHBKAzPhotosHigh-Extended Count',
    MHBKAzPhotosHigh.ZDAYGROUPASSETSCOUNT AS 'MHBKAzPhotosHigh-Day Group Assets Count',
    MHBKAzPhotosHigh.ZDAYGROUPEXTENDEDASSETSCOUNT AS 'MHBKAzPhotosHigh-Day Group Ext Assets Count',
    MHBKAzPhotosHigh.ZDAYGROUPSUMMARYASSETSCOUNT AS 'MHBKAzPhotosHigh-Day Group Summary Assets Count',
    MHBKAzPhotosHigh.ZPARENTPHOTOSHIGHLIGHT AS 'MHBKAzPhotosHigh-Parent PH Key',
    MHBKAzPhotosHigh.ZYEARKEYASSET AS 'MHBKAzPhotosHigh-Year Key Asset',
    MHBKAzPhotosHigh.ZMONTHFIRSTASSET AS 'MHBKAzPhotosHigh-Month First Asset',
    MHBKAzPhotosHigh.ZMONTHKEYASSET AS 'MHBKAzPhotosHigh-Month Key Asset',
    MHBKAzPhotosHigh.ZKEYASSET AS 'MHBKAzPhotosHigh-Key Asset',
    MHBKAzPhotosHigh.ZPARENTDAYGROUPPHOTOSHIGHLIGHT AS 'MHBKAzPhotosHigh-Parent Day Group PH Key',
    MHBKAzPhotosHigh.ZDAYGROUPKEYASSET AS 'MHBKAzPhotosHigh-Day Group Key Asset',
    CASE MHBKAzPhotosHigh.ZTYPE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-Photos Highlights Day Group'
        WHEN 4 THEN '4-StillTesting'
        WHEN 5 THEN '5-StillTesting'
        WHEN 6 THEN '6-Parent Day Group Photos Highlight'
        ELSE 'Unknown-New-Value!: ' || MHBKAzPhotosHigh.ZTYPE || ''
    END AS 'MHBKAzPhotosHigh-Type',
    CASE MHBKAzPhotosHigh.ZKIND
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN 'Year&Month Photo Highlights-1'
        WHEN 2 THEN 'Year Photo Highlights-2'
        WHEN 3 THEN 'Day Group Assets Photo Highlights-3'
        ELSE 'Unknown-New-Value!: ' || MHBKAzPhotosHigh.ZKIND || ''
    END AS 'MHBKAzPhotosHigh-Kind',
    CASE MHBKAzPhotosHigh.ZCATEGORY
        WHEN 0 THEN '0-Past Highlights'
        WHEN 1 THEN '1-Todays Highlights'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        ELSE 'Unknown-New-Value!: ' || MHBKAzPhotosHigh.ZCATEGORY || ''
    END AS 'MHBKAzPhotosHigh-Category',
    CASE MHBKAzPhotosHigh.ZVISIBILITYSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-Year&Month No Asset Count'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        ELSE 'Unknown-New-Value!: ' || MHBKAzPhotosHigh.ZVISIBILITYSTATE || ''
    END AS 'MHBKAzPhotosHigh-Visibility State',
    CASE MHBKAzPhotosHigh.ZMOOD
        WHEN 0 THEN '0-None'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        WHEN 16 THEN '16-StillTesting'
        WHEN 32 THEN '32-StillTesting'
        WHEN 64 THEN '64-StillTesting'
        WHEN 128 THEN '128-StillTesting'
        WHEN 512 THEN '512-StillTesting'
        ELSE 'Unknown-New-Value!: ' || MHBKAzPhotosHigh.ZMOOD || ''
    END AS 'MHBKAzPhotosHigh-Mood',
    CASE MHBKAzPhotosHigh.ZENRICHMENTSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        ELSE 'Unknown-New-Value!: ' || MHBKAzPhotosHigh.ZENRICHMENTSTATE || ''
    END AS 'MHBKAzPhotosHigh-Enrichment State',
    MHBKAzPhotosHigh.ZENRICHMENTVERSION AS 'MHBKAzPhotosHigh-Enrichment Version',
    MHBKAzPhotosHigh.ZHIGHLIGHTVERSION AS 'MHBKAzPhotosHigh-Highlight Version',
    zAsset.ZYEARHIGHLIGHTBEINGKEYASSET AS 'zAsset-Year Highlight Being Key Asset',
    YHBKAzPhotosHigh.ZUUID AS 'YHBKAzPhotosHigh-UUID',
    YHBKAzPhotosHigh.Z_PK AS 'YHBKAzPhotosHigh-zPK',
    YHBKAzPhotosHigh.Z_ENT AS 'YHBKAzPhotosHigh-zENT',
    YHBKAzPhotosHigh.Z_OPT AS 'YHBKAzPhotosHigh-zOPT',
    YHBKAzPhotosHigh.ZPROMOTIONSCORE AS 'YHBKAzPhotosHigh-Promotion Score',
    YHBKAzPhotosHigh.ZTITLE AS 'YHBKAzPhotosHigh-Title',
    YHBKAzPhotosHigh.ZSUBTITLE AS 'YHBKAzPhotosHigh-Subtitle',
    YHBKAzPhotosHigh.ZVERBOSESMARTDESCRIPTION AS 'YHBKAzPhotosHigh-Verbose Smart Description',
    datetime(YHBKAzPhotosHigh.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'YHBKAzPhotosHigh-Start Date',
    YHBKAzPhotosHigh.ZSTARTTIMEZONEOFFSET AS 'YHBKAzPhotosHigh-Start Timezone Offset',
    YHBKAzPhotosHigh.ZENDTIMEZONEOFFSET AS 'YHBKAzPhotosHigh-End Timezone Offset',
    datetime(YHBKAzPhotosHigh.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'YHBKAzPhotosHigh-End Date',
    YHBKAzPhotosHigh.ZASSETSCOUNT AS 'YHBKAzPhotosHigh-Asset Count',
    YHBKAzPhotosHigh.ZSUMMARYCOUNT AS 'YHBKAzPhotosHigh-Summary Count',
    YHBKAzPhotosHigh.ZEXTENDEDCOUNT AS 'YHBKAzPhotosHigh-Extended Count',
    YHBKAzPhotosHigh.ZDAYGROUPASSETSCOUNT AS 'YHBKAzPhotosHigh-Day Group Assets Count',
    YHBKAzPhotosHigh.ZDAYGROUPEXTENDEDASSETSCOUNT AS 'YHBKAzPhotosHigh-Day Group Ext Assets Count',
    YHBKAzPhotosHigh.ZDAYGROUPSUMMARYASSETSCOUNT AS 'YHBKAzPhotosHigh-Day Group Summary Assets Count',
    YHBKAzPhotosHigh.ZPARENTPHOTOSHIGHLIGHT AS 'YHBKAzPhotosHigh-Parent PH Key',
    YHBKAzPhotosHigh.ZYEARKEYASSET AS 'YHBKAzPhotosHigh-Year Key Asset',
    YHBKAzPhotosHigh.ZMONTHFIRSTASSET AS 'YHBKAzPhotosHigh-Month First Asset',
    YHBKAzPhotosHigh.ZMONTHKEYASSET AS 'YHBKAzPhotosHigh-Month Key Asset',
    YHBKAzPhotosHigh.ZKEYASSET AS 'YHBKAzPhotosHigh-Key Asset',
    YHBKAzPhotosHigh.ZPARENTDAYGROUPPHOTOSHIGHLIGHT AS 'YHBKAzPhotosHigh-Parent Day Group PH Key',
    YHBKAzPhotosHigh.ZDAYGROUPKEYASSET AS 'YHBKAzPhotosHigh-Day Group Key Asset',
    CASE YHBKAzPhotosHigh.ZTYPE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-Photos Highlights Day Group'
        WHEN 4 THEN '4-StillTesting'
        WHEN 5 THEN '5-StillTesting'
        WHEN 6 THEN '6-Parent Day Group Photos Highlight'
        ELSE 'Unknown-New-Value!: ' || YHBKAzPhotosHigh.ZTYPE || ''
    END AS 'YHBKAzPhotosHigh-Type',
    CASE YHBKAzPhotosHigh.ZKIND
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN 'Year&Month Photo Highlights-1'
        WHEN 2 THEN 'Year Photo Highlights-2'
        WHEN 3 THEN 'Day Group Assets Photo Highlights-3'
        ELSE 'Unknown-New-Value!: ' || YHBKAzPhotosHigh.ZKIND || ''
    END AS 'YHBKAzPhotosHigh-Kind',
    CASE YHBKAzPhotosHigh.ZCATEGORY
        WHEN 0 THEN '0-Past Highlights'
        WHEN 1 THEN '1-Todays Highlights'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        ELSE 'Unknown-New-Value!: ' || YHBKAzPhotosHigh.ZCATEGORY || ''
    END AS 'YHBKAzPhotosHigh-Category',
    CASE YHBKAzPhotosHigh.ZVISIBILITYSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-Year&Month No Asset Count'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        ELSE 'Unknown-New-Value!: ' || YHBKAzPhotosHigh.ZVISIBILITYSTATE || ''
    END AS 'YHBKAzPhotosHigh-Visibility State',
    CASE YHBKAzPhotosHigh.ZMOOD
        WHEN 0 THEN '0-None'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        WHEN 16 THEN '16-StillTesting'
        WHEN 32 THEN '32-StillTesting'
        WHEN 64 THEN '64-StillTesting'
        WHEN 128 THEN '128-StillTesting'
        WHEN 512 THEN '512-StillTesting'
        ELSE 'Unknown-New-Value!: ' || YHBKAzPhotosHigh.ZMOOD || ''
    END AS 'YHBKAzPhotosHigh-Mood',
    CASE YHBKAzPhotosHigh.ZENRICHMENTSTATE
        WHEN 0 THEN '0-StillTesting'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-StillTesting'
        WHEN 4 THEN '4-StillTesting'
        ELSE 'Unknown-New-Value!: ' || YHBKAzPhotosHigh.ZENRICHMENTSTATE || ''
    END AS 'YHBKAzPhotosHigh-Enrichment State',
    YHBKAzPhotosHigh.ZENRICHMENTVERSION AS 'YHBKAzPhotosHigh-Enrichment Version',
    YHBKAzPhotosHigh.ZHIGHLIGHTVERSION AS 'YHBKAzPhotosHigh-Highlight Version',
    z3SuggBKA.Z_3KEYASSETS AS 'z3SuggBKA-3KeyAssets=zAsset-zPK',
    z3SuggBKA.Z_55SUGGESTIONSBEINGKEYASSETS AS 'z3SuggBKA-55SuggBeingKeyAssets=zSugg-zPK',
    SBKAzSugg.Z_PK AS 'SBKAzSugg-zPK',
    SBKAzSugg.Z_ENT AS 'SBKAzSugg-zENT',
    SBKAzSugg.Z_OPT AS 'SBKAzSugg-zOPT',
    SBKAzSugg.ZUUID AS 'SBKAzSugg-UUID',
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
    z3SuggBRA.Z_55SUGGESTIONSBEINGREPRESENTATIVEASSETS AS 'z3SuggBRA-55SuggBeingRepAssets',
    SBRAzSugg.Z_PK AS 'SBRAzSugg-zPK',
    SBRAzSugg.Z_ENT AS 'SBRAzSugg-zENT',
    SBRAzSugg.Z_OPT AS 'SBRAzSugg-zOPT',
    SBRAzSugg.ZUUID AS 'SBRAzSugg-UUID',
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
    zMedAnlyAstAttr.ZMEDIAANALYSISVERSION AS 'zMedAnlyAstAttr-Media Analysis Version',
    zMedAnlyAstAttr.ZAUDIOCLASSIFICATION AS 'zMedAnlyAstAttr-Audio Classification',
    zMedAnlyAstAttr.ZBESTVIDEORANGEDURATIONTIMESCALE AS 'zMedAnlyAstAttr-Best Video Range Duration Time Scale',
    zMedAnlyAstAttr.ZBESTVIDEORANGESTARTTIMESCALE AS 'zMedAnlyAstAttr-Best Video Range Start Time Scale',
    zMedAnlyAstAttr.ZBESTVIDEORANGEDURATIONVALUE AS 'zMedAnlyAstAttr-Best Video Range Duration Value',
    zMedAnlyAstAttr.ZBESTVIDEORANGESTARTVALUE AS 'zMedAnlyAstAttr-Best Video Range Start Value',
    zMedAnlyAstAttr.ZPACKEDBESTPLAYBACKRECT AS 'zMedAnlyAstAttr-Packed Best Playback Rect',
    zMedAnlyAstAttr.ZACTIVITYSCORE AS 'zMedAnlyAstAttr-Activity Score',
    zMedAnlyAstAttr.ZVIDEOSCORE AS 'zMedAnlyAstAttr-Video Score',
    zMedAnlyAstAttr.ZAUTOPLAYSUGGESTIONSCORE AS 'zMedAnlyAstAttr-AutoPlay Suggestion Score',
    zMedAnlyAstAttr.ZBLURRINESSSCORE AS 'zMedAnlyAstAttr-Blurriness Score',
    zMedAnlyAstAttr.ZEXPOSURESCORE AS 'zMedAnlyAstAttr-Exposure Score',
    zMedAnlyAstAttr.ZPROBABLEROTATIONDIRECTIONCONFIDENCE AS 'zMedAnlyAstAttr-Probable Rotation Direction Confidence',
    zMedAnlyAstAttr.ZPROBABLEROTATIONDIRECTION AS 'zMedAnlyAstAttr-Probable Rotation Direction',
    zMedAnlyAstAttr.ZSCREENTIMEDEVICEIMAGESENSITIVITY AS 'zMedAnlyAstAttr-Screen Time Device Image Sensitivity',
    zMedAnlyAstAttr.ZCOLORNORMALIZATIONDATA AS 'zMedAnlyAstAttr-Color Normalization Data',
    zAssetAnalyState.Z_PK AS 'zAssetAnalyState-zPK',
    zAssetAnalyState.ZANALYSISSTATE AS 'zAssetAnalyState-Analyisis State',
    zAssetAnalyState.ZWORKERFLAGS AS 'zAssetAnalyState-Worker Flags',
    zAssetAnalyState.ZWORKERTYPE AS 'zAssetAnalyState-Worker Type',
    zAssetAnalyState.ZASSET AS 'zAssetAnalyState-Asset=zAsset-zPK',
    datetime(zAssetAnalyState.ZIGNOREUNTILDATE + 978307200, 'UNIXEPOCH') AS 'zAssetAnalyState-Ignore Until Date',
    datetime(zAssetAnalyState.ZLASTIGNOREDDATE + 978307200, 'UNIXEPOCH') AS 'zAssetAnalyState-Last Ignored Date',
    zAssetAnalyState.ZSORTTOKEN AS 'zAssetAnalyState-Sort Token',
    zAssetAnalyState.ZASSETUUID AS 'zAssetAnalyState-Asset UUID',
    zMedAnlyAstAttr.ZCHARACTERRECOGNITIONATTRIBUTES AS 'zMedAnlyAstAttr-Character Recognition Attr',
    zCharRecogAttr.Z_PK AS 'zCharRecogAttr-zPK',
    zCharRecogAttr.Z_ENT AS 'zCharRecogAttr-zENT',
    zCharRecogAttr.Z_OPT AS 'zCharRecogAttr-zOPT',
    zCharRecogAttr.ZALGORITHMVERSION AS 'zCharRecogAttr-Algorithm Version',
    zCharRecogAttr.ZMEDIAANALYSISASSETATTRIBUTES AS 'zCharRecogAttr-MedAssetAttr=zMedAnlyAstAttr-zPK',
    zCharRecogAttr.ZADJUSTMENTVERSION AS 'zCharRecogAttr-Adjustment Version',
    zCharRecogAttr.ZCHARACTERRECOGNITIONDATA AS 'zCharRecogAttr-Character Recogition Data/HEX',
    zCharRecogAttr.ZMACHINEREADABLECODEDATA AS 'zCharRecogAttr-Machine Readable Code Data/HEX',
    zMedAnlyAstAttr.ZVISUALSEARCHATTRIBUTES AS 'zMedAnlyAstAttr-Visual Search Attributes',
    zVisualSearchAttr.Z_PK AS 'zVisualSearchAttr-zPK',
    zVisualSearchAttr.Z_ENT AS 'zVisualSearchAttr-zENT',
    zVisualSearchAttr.Z_OPT AS 'zVisualSearchAttr-zOPT',
    zVisualSearchAttr.ZALGORITHMVERSION AS 'zVisualSearchAttr-Algorithm Version',
    zVisualSearchAttr.ZMEDIAANALYSISASSETATTRIBUTES AS 'zVisualSearchAttr-MedAssetAttr=zMedAnlyAstAttr-zPK',
    zVisualSearchAttr.ZADJUSTMENTVERSION AS 'zVisualSearchAttr-Adjustment Version',
    zVisualSearchAttr.ZVISUALSEARCHDATA AS 'zVisualSearchAttr-Visual Search Data/HEX',
    zCompAssetAttr.ZASSET AS 'zCompAssetAttr-Asset Key',
    zCompAssetAttr.Z_PK AS 'zCompAssetAttr-zPK',
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
    zCldRes.Z_PK AS 'zCldRes-zPK',
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
    zCldRes.ZASSET AS 'zCldRes-Asset=zAsset-zPK',
    zCldRes.ZCLOUDMASTER AS 'zCldRes-Cloud Master=zCldMast-zPK',
    zCldRes.ZDATECREATED AS 'zCldRes-Date Created',
    zCldRes.ZLASTONDEMANDDOWNLOADDATE AS 'zCldRes-Last OnDemand Download Date',
    zCldRes.ZLASTPREFETCHDATE AS 'zCldRes-Last Prefetch Date',
    zCldRes.ZPRUNEDAT AS 'zCldRes-Prunedat',
    zCldRes.ZASSETUUID AS 'zCldRes-Asset UUID',
    zCldRes.ZFILEPATH AS 'zCldRes-File Path',
    zCldRes.ZFINGERPRINT AS 'zCldRes-Fingerprint',
    zCldRes.ZITEMIDENTIFIER AS 'zCldRes-Item ID',
    zCldRes.ZUNIFORMTYPEIDENTIFIER AS 'zCldRes-UniID',
    zUserFeedback.Z_PK AS 'zUserFeedback-zPK',
    zUserFeedback.Z_ENT AS 'zUserFeedback-zENT',
    zUserFeedback.Z_OPT AS 'zUserFeedback-zOPT',
    zUserFeedback.ZFEATURE AS 'zUserFeedback-Feature',
    zUserFeedback.ZTYPE AS 'zUserFeedback-Type',
    zUserFeedback.ZMEMORY AS 'zUserFeedback-Memory=zMemory-zPK',
    zUserFeedback.ZPERSON AS 'zUserFeedback-Person=zPerson-zPK',
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
    LEFT JOIN Z_27ASSETS z27Assets ON z27Assets.Z_3ASSETS = zAsset.Z_PK
    LEFT JOIN ZGENERICALBUM zGenAlbum ON zGenAlbum.Z_PK = z27Assets.Z_27ALBUMS
    LEFT JOIN Z_26ALBUMLISTS z26AlbumLists ON z26AlbumLists.Z_26ALBUMS = zGenAlbum.Z_PK
    LEFT JOIN ZALBUMLIST zAlbumList ON zAlbumList.Z_PK = z26AlbumLists.Z_2ALBUMLISTS
    LEFT JOIN ZGENERICALBUM ParentzGenAlbum ON ParentzGenAlbum.Z_PK = zGenAlbum.ZPARENTFOLDER
    LEFT JOIN ZASSETDESCRIPTION zAssetDes ON zAssetDes.Z_PK = zAddAssetAttr.ZASSETDESCRIPTION
    LEFT JOIN ZUNMANAGEDADJUSTMENT zUnmAdj ON zAddAssetAttr.ZUNMANAGEDADJUSTMENT = zUnmAdj.Z_PK
    LEFT JOIN ZCLOUDMASTER zCldMast ON zAsset.ZMASTER = zCldMast.Z_PK
    LEFT JOIN ZCLOUDMASTERMEDIAMETADATA AAAzCldMastMedData ON AAAzCldMastMedData.Z_PK = zAddAssetAttr.ZMEDIAMETADATA
    LEFT JOIN ZCLOUDMASTERMEDIAMETADATA CMzCldMastMedData ON CMzCldMastMedData.Z_PK = zCldMast.ZMEDIAMETADATA
    LEFT JOIN ZCLOUDRESOURCE zCldRes ON zCldRes.ZCLOUDMASTER = zCldMast.Z_PK
    LEFT JOIN ZASSETANALYSISSTATE zAssetAnalyState ON zAssetAnalyState.ZASSET = zAsset.Z_PK
    LEFT JOIN ZMEDIAANALYSISASSETATTRIBUTES zMedAnlyAstAttr ON zAsset.ZMEDIAANALYSISATTRIBUTES = zMedAnlyAstAttr.Z_PK
    LEFT JOIN ZCOMPUTEDASSETATTRIBUTES zCompAssetAttr ON zCompAssetAttr.Z_PK = zAsset.ZCOMPUTEDATTRIBUTES
    LEFT JOIN ZCHARACTERRECOGNITIONATTRIBUTES zCharRecogAttr ON zCharRecogAttr.Z_PK = zMedAnlyAstAttr.ZCHARACTERRECOGNITIONATTRIBUTES
    LEFT JOIN ZVISUALSEARCHATTRIBUTES zVisualSearchAttr ON zVisualSearchAttr.Z_PK = zMedAnlyAstAttr.ZVISUALSEARCHATTRIBUTES
    LEFT JOIN ZCLOUDFEEDENTRY zCldFeedEnt ON zAsset.ZCLOUDFEEDASSETSENTRY = zCldFeedEnt.Z_PK
    LEFT JOIN ZCLOUDSHAREDCOMMENT zCldSharedComment ON zAsset.Z_PK = zCldSharedComment.ZCOMMENTEDASSET
    LEFT JOIN ZCLOUDSHAREDCOMMENT zCldSharedCommentLiked ON zAsset.Z_PK = zCldSharedCommentLiked.ZLIKEDASSET
    LEFT JOIN ZCLOUDSHAREDALBUMINVITATIONRECORD zCldShareAlbumInvRec ON zGenAlbum.Z_PK = zCldShareAlbumInvRec.ZALBUM
    LEFT JOIN ZSHARE zShare ON zShare.Z_PK = zAsset.ZMOMENTSHARE
    LEFT JOIN ZSHAREPARTICIPANT zSharePartic ON zSharePartic.ZSHARE = zShare.Z_PK
    LEFT JOIN ZDETECTEDFACE zDetFace ON zAsset.Z_PK = zDetFace.ZASSET
    LEFT JOIN ZPERSON zPerson ON zPerson.Z_PK = zDetFace.ZPERSON
    LEFT JOIN ZDETECTEDFACEPRINT zDetFacePrint ON zDetFacePrint.ZFACE = zDetFace.Z_PK
    LEFT JOIN ZFACECROP zFaceCrop ON zPerson.Z_PK = zFaceCrop.ZPERSON
    LEFT JOIN ZDETECTEDFACEGROUP zDetFaceGroup ON zDetFaceGroup.Z_PK = zDetFace.ZFACEGROUP
    LEFT JOIN Z_3MEMORIESBEINGCURATEDASSETS z3MemoryBCAs ON zAsset.Z_PK = z3MemoryBCAs.Z_3CURATEDASSETS
    LEFT JOIN ZMEMORY zMemory ON z3MemoryBCAs.Z_42MEMORIESBEINGCURATEDASSETS = zMemory.Z_PK
    LEFT JOIN Z_3MEMORIESBEINGEXTENDEDCURATEDASSETS z3MemoryBECAs ON zAsset.Z_PK = z3MemoryBECAs.Z_3EXTENDEDCURATEDASSETS AND z3MemoryBECAs.Z_42MEMORIESBEINGEXTENDEDCURATEDASSETS = zMemory.Z_PK
    LEFT JOIN Z_3MEMORIESBEINGMOVIECURATEDASSETS z3MemoryBMCAs ON zAsset.Z_PK = z3MemoryBMCAs.Z_3MOVIECURATEDASSETS AND z3MemoryBMCAs.Z_42MEMORIESBEINGMOVIECURATEDASSETS = zMemory.Z_PK
    LEFT JOIN Z_3MEMORIESBEINGREPRESENTATIVEASSETS z3MemoryBRAs ON zAsset.Z_PK = z3MemoryBRAs.Z_3REPRESENTATIVEASSETS AND z3MemoryBRAs.Z_42MEMORIESBEINGREPRESENTATIVEASSETS = zMemory.Z_PK
    LEFT JOIN Z_3MEMORIESBEINGUSERCURATEDASSETS z3MemoryBUCAs ON zAsset.Z_PK = z3MemoryBUCAs.Z_3USERCURATEDASSETS AND z3MemoryBUCAs.Z_42MEMORIESBEINGUSERCURATEDASSETS = zMemory.Z_PK
    LEFT JOIN ZUSERFEEDBACK zUserFeedback ON zUserFeedback.ZMEMORY = zMemory.Z_PK
    LEFT JOIN ZMOMENT zMoment ON zMoment.Z_PK = zAsset.ZMOMENT
    LEFT JOIN ZPHOTOSHIGHLIGHT HBAzPhotosHigh ON HBAzPhotosHigh.Z_PK = zAsset.ZHIGHLIGHTBEINGASSETS
    LEFT JOIN ZPHOTOSHIGHLIGHT HBEAzPhotosHigh ON HBEAzPhotosHigh.Z_PK = zAsset.ZHIGHLIGHTBEINGEXTENDEDASSETS
    LEFT JOIN ZPHOTOSHIGHLIGHT HBKAzPhotosHigh ON HBKAzPhotosHigh.Z_PK = zAsset.ZHIGHLIGHTBEINGKEYASSET
    LEFT JOIN ZPHOTOSHIGHLIGHT HBSAzPhotosHigh ON HBSAzPhotosHigh.Z_PK = zAsset.ZHIGHLIGHTBEINGSUMMARYASSETS
    LEFT JOIN ZPHOTOSHIGHLIGHT YHBKAzPhotosHigh ON YHBKAzPhotosHigh.Z_PK = zAsset.ZYEARHIGHLIGHTBEINGKEYASSET
    LEFT JOIN ZPHOTOSHIGHLIGHT MHBFAzPhotosHigh ON MHBFAzPhotosHigh.Z_PK = zAsset.ZMONTHHIGHLIGHTBEINGFIRSTASSET
    LEFT JOIN ZPHOTOSHIGHLIGHT MHBKAzPhotosHigh ON MHBKAzPhotosHigh.Z_PK = zAsset.ZMONTHHIGHLIGHTBEINGKEYASSET
    LEFT JOIN ZPHOTOSHIGHLIGHT DGHBAzPhotosHigh ON DGHBAzPhotosHigh.Z_PK = zAsset.ZDAYGROUPHIGHLIGHTBEINGASSETS
    LEFT JOIN ZPHOTOSHIGHLIGHT DGHBEAzPhotosHigh ON DGHBEAzPhotosHigh.Z_PK = zAsset.ZDAYGROUPHIGHLIGHTBEINGEXTENDEDASSETS
    LEFT JOIN ZPHOTOSHIGHLIGHT DGHBKAzPhotosHigh ON DGHBKAzPhotosHigh.Z_PK = zAsset.ZDAYGROUPHIGHLIGHTBEINGKEYASSET
    LEFT JOIN ZPHOTOSHIGHLIGHT DGHBSAzPhotosHigh ON DGHBSAzPhotosHigh.Z_PK = zAsset.ZDAYGROUPHIGHLIGHTBEINGSUMMARYASSETS
    LEFT JOIN ZPHOTOSHIGHLIGHT YMParzPhotosHigh ON YMParzPhotosHigh.Z_PK = HBAzPhotosHigh.ZPARENTPHOTOSHIGHLIGHT
    LEFT JOIN ZPHOTOSHIGHLIGHT YearParzPhotosHigh ON YearParzPhotosHigh.Z_PK = YMParzPhotosHigh.ZPARENTPHOTOSHIGHLIGHT
    LEFT JOIN ZPHOTOSHIGHLIGHT DGParzPhotosHigh ON DGParzPhotosHigh.Z_PK = HBAzPhotosHigh.ZPARENTDAYGROUPPHOTOSHIGHLIGHT
    LEFT JOIN Z_3SUGGESTIONSBEINGKEYASSETS z3SuggBKA ON z3SuggBKA.Z_3KEYASSETS = zAsset.Z_PK
    LEFT JOIN ZSUGGESTION SBKAzSugg ON SBKAzSugg.Z_PK = z3SuggBKA.Z_55SUGGESTIONSBEINGKEYASSETS
    LEFT JOIN Z_3SUGGESTIONSBEINGREPRESENTATIVEASSETS z3SuggBRA ON z3SuggBRA.Z_3REPRESENTATIVEASSETS1 = zAsset.Z_PK
    LEFT JOIN ZSUGGESTION SBRAzSugg ON SBRAzSugg.Z_PK = z3SuggBRA.Z_55SUGGESTIONSBEINGREPRESENTATIVEASSETS

ORDER BY zAsset.ZADDEDDATE
