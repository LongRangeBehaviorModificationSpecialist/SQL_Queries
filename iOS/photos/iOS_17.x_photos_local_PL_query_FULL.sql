/*
  [DLU]
    2024-10-04

  [NOTES]
    Modified from original iOS 15 query copied from: https://github.com/ScottKjr3347/iOS_Local_PL_Photos.sqlite_Queries/blob/main/iOS15/Previous_Queries/iOS15_LPL_Phsql_Basic.txt
*/

SELECT

    ZASSET.Z_PK AS 'ZASSET-zPK',
    ZASSET.ZSORTTOKEN AS 'ZASSET-Sort Token',
    ZASSET.ZPROMOTIONSCORE AS 'ZASSET-Promotion Score',

    CASE ZASSET.ZCOMPLETE
        WHEN 1 THEN '1-Yes-1'
    END AS 'ZASSET Complete',

    ZADDITIONALASSETATTRIBUTES.Z_PK AS 'zAddAssetAttr-zPK',
    ZCLOUDMASTER.Z_PK AS 'ZCLOUDMASTER-zPK=ZASSET-Master',
    ZASSET.ZMASTER AS 'ZASSET-Master=ZCLOUDMASTER-zPK',
    ZASSET.ZEXTENDEDATTRIBUTES AS 'ZASSET-Extended Attributes=ZEXTENDEDATTRIBUTES-zPK',
    ZEXTENDEDATTRIBUTES.Z_PK AS 'ZEXTENDEDATTRIBUTES-zPK=ZASSET-zExtendedAttributes',
    CMzCldMastMedData.ZCLOUDMASTER AS 'CMzCldMastMedData-CldMast=zCldMast-zPK',
    ZCLOUDMASTER.ZMEDIAMETADATA AS 'zCldMast-Media Metadata Key=zCldMastMedData.zPK',
    CMzCldMastMedData.Z_PK AS 'CMzCldMastMedData-zPK=zAddAssetAttr&zCldMast-MediaMetaData Key',
    CMzCldMastMedData.Z_ENT AS 'CMzCldMastMedData-zENT',
    ZASSET.ZUUID AS 'ZASSET-UUID = store.cloudphotodb',
    ZASSET.ZCLOUDASSETGUID AS 'ZASSET-Cloud_Asset_GUID = store.cloudphotodb',
    ZASSET.ZCLOUDCOLLECTIONGUID AS 'ZASSET.Cloud Collection GUID',
    ZCLOUDMASTER.ZCLOUDMASTERGUID AS 'zCldMast-Cloud_Master_GUID = store.cloudphotodb',
    ZGENERICALBUM.ZCLOUDGUID AS 'ZGENERICALBUM-Cloud_GUID = store.cloudphotodb',
    ZSHARE.ZSCOPEIDENTIFIER AS 'ZSHARE-Scope ID = store.cloudphotodb',
    ZADDITIONALASSETATTRIBUTES.ZORIGINALASSETSUUID AS 'zAddAssetAttr-Original Assets UUID',
    ZADDITIONALASSETATTRIBUTES.ZPUBLICGLOBALUUID AS 'zAddAssetAttr-Public Global UUID',
    ZADDITIONALASSETATTRIBUTES.ZMASTERFINGERPRINT AS 'zAddAssetAttr-Master Fingerprint',
    ZADDITIONALASSETATTRIBUTES.ZORIGINATINGASSETIDENTIFIER AS 'zAddAssetAttr-Originating Asset Identifier',
    ZCLOUDMASTER.ZORIGINATINGASSETIDENTIFIER AS 'zCldMast-Originating Asset ID',
    --ZINTERNALRESOURCE.ZFINGERPRINT AS 'ZINTERNALRESOURCE-Fingerprint',
    ZADDITIONALASSETATTRIBUTES.ZADJUSTEDFINGERPRINT AS 'ZADDITIONALASSETATTRIBUTES.Adjusted Fingerprint',
    ZUNMANAGEDADJUSTMENT.ZOTHERADJUSTMENTSFINGERPRINT AS 'ZUNMANAGEDADJUSTMENT-Other Adjustments Fingerprint',
    ZUNMANAGEDADJUSTMENT.ZSIMILARTOORIGINALADJUSTMENTSFINGERPRINT AS 'ZUNMANAGEDADJUSTMENT-Similar to Orig Adjustments Fingerprint',

    CASE ParentzGenAlbum.ZCLOUDLOCALSTATE
        WHEN 0 THEN '0-iCldPhotos-ON=Asset_In_Shared/Other-Album/iCldPhotos-OFF=Generic_Album-0'
        WHEN 1 THEN '1-iCldPhotos-ON=Asset_In_Generic Album-1'
        ELSE 'Unknown-New-Value!: ' || ParentzGenAlbum.ZCLOUDLOCALSTATE || ''
    END AS 'ParentzGenAlbum-Cloud-Local-State-4Start',

    ParentzGenAlbum.ZTITLE AS 'ParentzGenAlbum-Title-4Start',
    DateTime(ParentzGenAlbum.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'ParentzGenAlbum-Creation Date-4Start',
    DateTime(ZGENERICALBUM.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'ZGENERICALBUM-Creation Date-4Start',

    CASE ZGENERICALBUM.ZCLOUDLOCALSTATE
        WHEN 0 THEN '0-iCldPhotos-ON=Asset_In_Shared/Other-Album/iCldPhotos-OFF=Generic_Album-0'
        WHEN 1 THEN '1-iCldPhotos-ON=Asset_In_Generic_ Album-1'
        ELSE 'Unknown-New-Value!: ' || ZGENERICALBUM.ZCLOUDLOCALSTATE || ''
  END AS 'ZGENERICALBUM-Cloud_Local_State-4Start',

    ZGENERICALBUM.ZTITLE AS 'ZGENERICALBUM-Title-4Start',

    CASE ZASSET.ZBUNDLESCOPE
        WHEN 0 THEN '0-iCldPhotos-ON=Not-In-Shared-Album_iCldPhotos-OFF=On-Local-Device-0'
        WHEN 1 THEN '1-SWY-Syndication_CMMAsset-1'
        WHEN 2 THEN '2-iCldPhotos-ON=Asset-In-Cloud-Shared-Album-2'
        WHEN 3 THEN '3-iCldPhotos-ON=SWY-Syndication-Asset-3'
        ELSE 'Unknown-New-Value!: ' || ZASSET.ZBUNDLESCOPE || ''
    END AS 'ZASSET-Bundle Scope',

    CASE ZASSET.ZCLOUDISMYASSET
        WHEN 0 THEN '0-Not_My_Asset_in_Shared_Album-0'
        WHEN 1 THEN '1-My_Asset_in_Shared_Album-1'
        ELSE 'Unknown-New-Value!: ' || ZASSET.ZCLOUDISMYASSET || ''
    END AS 'ZASSET-Cloud is My Asset',

    CASE ZASSET.ZCLOUDISDELETABLE
        WHEN 0 THEN '0-No-0'
        WHEN 1 THEN '1-Yes-1'
        ELSE 'Unknown-New-Value!: ' || ZASSET.ZCLOUDISDELETABLE || ''
    END AS 'ZASSET-Cloud is deletable/Asset',

    CASE ZASSET.ZCLOUDLOCALSTATE
        WHEN 0 THEN 'iCldPhotos ON=Asset_In_Shared-or-OtherAlbum/iCldPhotos_OFF=Not_Synced-0'
        WHEN 1 THEN 'iCldPhotos ON=Asset_Can-Be-or-Has-Been_Synced_with_iCloud-1'
        ELSE 'Unknown-New-Value!: ' || ZASSET.ZCLOUDLOCALSTATE || ''
    END AS 'ZASSET-Cloud_Local_State',

    CASE ZASSET.ZVISIBILITYSTATE
        WHEN 0 THEN '0-Visible-Photo-Library-0'
        WHEN 2 THEN '2-Not-Visible-Photo-Library-2'
        ELSE 'Unknown-New-Value!: ' || ZASSET.ZVISIBILITYSTATE || ''
    END AS 'ZASSET-Visibility State',

    ZEXTENDEDATTRIBUTES.ZCAMERAMAKE AS 'ZEXTENDEDATTRIBUTES-Camera Make',
    ZEXTENDEDATTRIBUTES.ZCAMERAMODEL AS 'ZEXTENDEDATTRIBUTES-Camera Model',
    ZEXTENDEDATTRIBUTES.ZLENSMODEL AS 'ZEXTENDEDATTRIBUTES-Lens Model',

    CASE ZEXTENDEDATTRIBUTES.ZFLASHFIRED
        WHEN 0 THEN '0-No Flash-0'
        WHEN 1 THEN '1-Flash Fired-1'
        ELSE 'Unknown-New-Value!: ' || ZEXTENDEDATTRIBUTES.ZFLASHFIRED || ''
    END AS 'ZEXTENDEDATTRIBUTES-Flash Fired',

    ZEXTENDEDATTRIBUTES.ZFOCALLENGTH AS 'ZEXTENDEDATTRIBUTES-Focal Lenght',
    ZEXTENDEDATTRIBUTES.ZFOCALLENGTHIN35MM AS 'ZEXTENDEDATTRIBUTES-Focal Lenth in 35MM',
    ZEXTENDEDATTRIBUTES.ZDIGITALZOOMRATIO AS 'ZEXTENDEDATTRIBUTES-Digital Zoom Ratio',

    CASE ZASSET.ZDERIVEDCAMERACAPTUREDEVICE
        WHEN 0 THEN '0-Back-Camera/Other-0'
        WHEN 1 THEN '1-Front-Camera-1'
        ELSE 'Unknown-New-Value!: ' || ZASSET.ZDERIVEDCAMERACAPTUREDEVICE || ''
    END AS 'ZASSET-Derived Camera Capture Device',

    CASE ZADDITIONALASSETATTRIBUTES.ZCAMERACAPTUREDEVICE
        WHEN 0 THEN '0-Back-Camera/Other-0'
        WHEN 1 THEN '1-Front-Camera-1'
        ELSE 'Unknown-New-Value!: ' || ZADDITIONALASSETATTRIBUTES.ZCAMERACAPTUREDEVICE || ''
    END AS 'zAddAssetAttr-Camera Captured Device',

    CASE ZADDITIONALASSETATTRIBUTES.ZIMPORTEDBY
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
        ELSE 'Unknown-New-Value!: ' || ZADDITIONALASSETATTRIBUTES.ZIMPORTEDBY || ''
    END AS 'zAddAssetAttr-Imported by',

    CASE ZCLOUDMASTER.ZIMPORTEDBY
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
        ELSE 'Unknown-New-Value!: ' || ZCLOUDMASTER.ZIMPORTEDBY || ''
    END AS 'zCldMast-Imported By',

    ZADDITIONALASSETATTRIBUTES.ZIMPORTEDBYBUNDLEIDENTIFIER AS 'ZADDITIONALASSETATTRIBUTES.Imported by Bundle Identifier',
    ZADDITIONALASSETATTRIBUTES.ZIMPORTEDBYDISPLAYNAME AS 'zAddAssetAttr-Imported By Display Name',
    ZCLOUDMASTER.ZIMPORTEDBYBUNDLEIDENTIFIER AS 'zCldMast-Imported by Bundle ID',
    ZCLOUDMASTER.ZIMPORTEDBYDISPLAYNAME AS 'zCldMast-Imported by Display Name',
    ZASSET.ZIMAGEREQUESTHINTS AS 'ZASSET-ImageRequestHints/HEX-Path',

    CASE ZASSET.ZSAVEDASSETTYPE
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
        ELSE 'Unknown-New-Value!: ' || ZASSET.ZSAVEDASSETTYPE || ''
    END AS 'ZASSET-Saved Asset Type-LPL',

    ZASSET.ZDIRECTORY AS 'ZASSET-Directory/Path',
    ZASSET.ZFILENAME AS 'ZASSET-Filename',
    ZADDITIONALASSETATTRIBUTES.ZORIGINALFILENAME AS 'zAddAssetAttr-Original Filename',
    ZCLOUDMASTER.ZORIGINALFILENAME AS 'zCldMast-Orig Filename',
    ZADDITIONALASSETATTRIBUTES.ZSYNDICATIONIDENTIFIER AS 'zAddAssetAttr-Syndication Identifier',
    DateTime(ZASSET.ZADDEDDATE + 978307200, 'UNIXEPOCH') AS 'ZASSET-Add Date',

    CASE ZADDITIONALASSETATTRIBUTES.ZDATECREATEDSOURCE
        WHEN 0 THEN '0-Cloud-Asset-0'
        WHEN 1 THEN '1-Local_Asset_EXIF-1'
        WHEN 3 THEN '3-Local_Asset_No_EXIF-3'
        ELSE 'Unknown-New-Value!: ' || ZADDITIONALASSETATTRIBUTES.ZDATECREATEDSOURCE || ''
    END AS 'zAddAssetAttr-Date Created Source',

    DateTime(ZASSET.ZDATECREATED + 978307200, 'UNIXEPOCH') AS 'ZASSET-Date Created',
    DateTime(ZCLOUDMASTER.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'zCldMast-Creation Date',
    DateTime(ZINTERNALRESOURCE.ZCLOUDMASTERDATECREATED + 978307200, 'UNIXEPOCH') AS 'ZINTERNALRESOURCE-CldMst Date Created',
    ZADDITIONALASSETATTRIBUTES.ZTIMEZONENAME AS 'zAddAssetAttr-Time Zone Name',
    ZADDITIONALASSETATTRIBUTES.ZTIMEZONEOFFSET AS 'zAddAssetAttr-Time Zone Offset',
    ZADDITIONALASSETATTRIBUTES.ZINFERREDTIMEZONEOFFSET AS 'zAddAssetAttr-Inferred Time Zone Offset',
    ZADDITIONALASSETATTRIBUTES.ZEXIFTIMESTAMPSTRING AS 'zAddAssetAttr-EXIF-String',
    DateTime(ZASSET.ZMODIFICATIONDATE + 978307200, 'UNIXEPOCH') AS 'ZASSET-Modification Date',

    CASE ZCLOUDMASTER.ZCLOUDLOCALSTATE
        WHEN 0 THEN '0-Not Synced with Cloud-0'
        WHEN 1 THEN '1-Pending Upload-1'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-Synced with Cloud-3'
        ELSE 'Unknown-New-Value!: ' || ZCLOUDMASTER.ZCLOUDLOCALSTATE || ''
    END AS 'zCldMast-Cloud Local State',

    DateTime(ZCLOUDMASTER.ZIMPORTDATE + 978307200, 'UNIXEPOCH') AS 'zCldMast-Import Date',
    ZASSET.ZIMPORTSESSION AS 'ZASSET-Import Session',
    ZADDITIONALASSETATTRIBUTES.ZIMPORTSESSIONID AS 'zAddAssetAttr-Import Session ID',
    DateTime(ZADDITIONALASSETATTRIBUTES.ZALTERNATEIMPORTIMAGEDATE + 978307200, 'UNIXEPOCH') AS 'zAddAssetAttr-Alt Import Image Date',
    ZCLOUDMASTER.ZIMPORTSESSIONID AS 'zCldMast-Import Session ID',
    DateTime(ZASSET.ZCLOUDBATCHPUBLISHDATE + 978307200, 'UNIXEPOCH') AS 'ZASSET-Cloud Batch Publish Date',
    DateTime(ZASSET.ZCLOUDSERVERPUBLISHDATE + 978307200, 'UNIXEPOCH') AS 'ZASSET-Cloud Server Publish Date',
    ZASSET.ZCLOUDDOWNLOADREQUESTS AS 'ZASSET-Cloud Download Requests',
    ZASSET.ZCLOUDBATCHID AS 'ZASSET-Cloud Batch ID',
    DateTime(ZADDITIONALASSETATTRIBUTES.ZLASTUPLOADATTEMPTDATE + 978307200, 'UNIXEPOCH') AS 'zAddAssetAttr-Last Upload Attempt Date-SWY',
    ZADDITIONALASSETATTRIBUTES.ZUPLOADATTEMPTS AS 'zAddAssetAttr-Upload Attempts',

    CASE ZASSET.ZLATITUDE
        WHEN -180.0 THEN '-180.0'
        ELSE ZASSET.ZLATITUDE
    END AS 'ZASSET-Latitude',

    ZEXTENDEDATTRIBUTES.ZLATITUDE AS 'ZEXTENDEDATTRIBUTES-Latitude',

    CASE ZASSET.ZLONGITUDE
        WHEN -180.0 THEN '-180.0'
        ELSE ZASSET.ZLONGITUDE
    END AS 'ZASSET-Longitude',

    ZEXTENDEDATTRIBUTES.ZLONGITUDE AS 'ZEXTENDEDATTRIBUTES-Longitude',

    CASE ZADDITIONALASSETATTRIBUTES.ZGPSHORIZONTALACCURACY
        WHEN -1.0 THEN '-1.0'
        ELSE ZADDITIONALASSETATTRIBUTES.ZGPSHORIZONTALACCURACY
    END AS 'zAddAssetAttr-GPS Horizontal Accuracy',

    ZASSET.ZLOCATIONDATA AS 'ZASSET-Location Data/HEX',
    -- ZADDITIONALASSETATTRIBUTES.ZREVERSELOCATIONDATA AS 'zAddAssetAttr-Reverse Location Data/Orig-Asset/HEX NSKeyed Plist',

    CASE ZADDITIONALASSETATTRIBUTES.ZSHIFTEDLOCATIONISVALID
        WHEN 0 THEN '0-Shifted Location Not Valid-0'
        WHEN 1 THEN '1-Shifted Location Valid-1'
    END AS 'zAddAssetAttr-Shifted Location Valid',

    ZADDITIONALASSETATTRIBUTES.ZSHIFTEDLOCATIONDATA AS 'zAddAssetAttr-Shifted Location Data',
    ZADDITIONALASSETATTRIBUTES.ZLOCATIONHASH AS 'zAddAssetAttr-Location Hash',

    CASE AAAzCldMastMedData.Z_OPT
        WHEN 1 THEN '1-StillTesting-Cloud-1'
        WHEN 2 THEN '2-StillTesting-This Device-2'
        WHEN 3 THEN '3-StillTesting-Muted-3'
        WHEN 4 THEN '4-StillTesting-Unknown-4'
        WHEN 5 THEN '5-StillTesting-Unknown-5'
        ELSE 'Unknown-New-Value!: ' || AAAzCldMastMedData.Z_OPT || ''
    END AS 'AAAzCldMastMedData-zOPT',

    ZADDITIONALASSETATTRIBUTES.ZMEDIAMETADATATYPE AS 'zAddAssetAttr-Media Metadata Type',
    AAAzCldMastMedData.ZDATA AS 'AAAzCldMastMedData-Data/HEX',

    CASE CMzCldMastMedData.Z_OPT
        WHEN 1 THEN '1-StillTesting-Has_CldMastAsset-1'
        WHEN 2 THEN '2-StillTesting-Local_Asset-2'
        WHEN 3 THEN '3-StillTesting-Muted-3'
        WHEN 4 THEN '4-StillTesting-Unknown-4'
        WHEN 5 THEN '5-StillTesting-Unknown-5'
        ELSE 'Unknown-New-Value!: ' || CMzCldMastMedData.Z_OPT || ''
    END AS 'CldMasterzCldMastMedData-zOPT',

    ZCLOUDMASTER.ZMEDIAMETADATATYPE AS 'zCldMast-Media Metadata Type',
    CMzCldMastMedData.ZDATA AS 'CMzCldMastMedData-Data/HEX',

    CASE ZASSET.ZORIENTATION
        WHEN 1 THEN '1-Video-Default/Adjustment/Horizontal-Camera-(left)-1'
        WHEN 2 THEN '2-Horizontal-Camera-(right)-2'
        WHEN 3 THEN '3-Horizontal-Camera-(right)-3'
        WHEN 4 THEN '4-Horizontal-Camera-(left)-4'
        WHEN 5 THEN '5-Vertical-Camera-(top)-5'
        WHEN 6 THEN '6-Vertical-Camera-(top)-6'
        WHEN 7 THEN '7-Vertical-Camera-(bottom)-7'
        WHEN 8 THEN '8-Vertical-Camera-(bottom)-8'
        ELSE 'Unknown-New-Value!: ' || ZASSET.ZORIENTATION || ''
    END AS 'ZASSET-Orientation',

    CASE ZADDITIONALASSETATTRIBUTES.ZORIGINALORIENTATION
        WHEN 1 THEN '1-Video-Default/Adjustment/Horizontal-Camera-(left)-1'
        WHEN 2 THEN '2-Horizontal-Camera-(right)-2'
        WHEN 3 THEN '3-Horizontal-Camera-(right)-3'
        WHEN 4 THEN '4-Horizontal-Camera-(left)-4'
        WHEN 5 THEN '5-Vertical-Camera-(top)-5'
        WHEN 6 THEN '6-Vertical-Camera-(top)-6'
        WHEN 7 THEN '7-Vertical-Camera-(bottom)-7'
        WHEN 8 THEN '8-Vertical-Camera-(bottom)-8'
        ELSE 'Unknown-New-Value!: ' || ZASSET.ZORIENTATION || ''
    END AS 'zAddAssetAttr-Original Orientation',

    /*CASE ZINTERNALRESOURCE.ZORIENTATION
        WHEN 0 THEN '0-NA-0'
        WHEN 1 THEN '1-Video-Default/Adjustment/Horizontal-Camera-(left)-1'
        WHEN 2 THEN '2-Horizontal-Camera-(right)-2'
        WHEN 3 THEN '3-Horizontal-Camera-(right)-3'
        WHEN 4 THEN '4-Horizontal-Camera-(left)-4'
        WHEN 5 THEN '5-Vertical-Camera-(top)-5'
        WHEN 6 THEN '6-Vertical-Camera-(top)-6'
        WHEN 7 THEN '7-Vertical-Camera-(bottom)-7'
        WHEN 8 THEN '8-Vertical-Camera-(bottom)-8'
        ELSE 'Unknown-New-Value!: ' || ZINTERNALRESOURCE.ZORIENTATION || ''
    END AS 'ZINTERNALRESOURCE-Orientation', */

    CASE ZASSET.ZKIND
        WHEN 0 THEN '0-Photo-0'
        WHEN 1 THEN '1-Video-1'
    END AS 'ZASSET-Kind',

    CASE ZASSET.ZKINDSUBTYPE
        WHEN 0 THEN '0-Still-Photo-0'
        WHEN 2 THEN '2-Live-Photo-2'
        WHEN 10 THEN '10-SpringBoard-Screenshot-10'
        WHEN 100 THEN '100-Video-100'
        WHEN 101 THEN '101-Slow-Mo-Video-101'
        WHEN 102 THEN '102-Time-lapse-Video-102'
        WHEN 103 THEN '103-Replay_Screen_Recording-103'
        ELSE 'Unknown-New-Value!: ' || ZASSET.ZKINDSUBTYPE || ''
    END AS 'ZASSET-Kind-Sub-Type',

    CASE ZADDITIONALASSETATTRIBUTES.ZCLOUDKINDSUBTYPE
        WHEN 0 THEN '0-Still-Photo-0'
        WHEN 1 THEN '1-StillTesting'
        WHEN 2 THEN '2-Live-Photo-2'
        WHEN 3 THEN '3-Screenshot-3'
        WHEN 10 THEN '10-SpringBoard-Screenshot-10'
        WHEN 100 THEN '100-Video-100'
        WHEN 101 THEN '101-Slow-Mo-Video-101'
        WHEN 102 THEN '102-Time-lapse-Video-102'
        WHEN 103 THEN '103-Replay_Screen_Recording-103'
        ELSE 'Unknown-New-Value!: ' || ZADDITIONALASSETATTRIBUTES.ZCLOUDKINDSUBTYPE || ''
    END AS 'zAddAssetAttr-Cloud Kind Sub Type',

    CASE ZASSET.ZPLAYBACKSTYLE
        WHEN 1 THEN '1-Image-1'
        WHEN 2 THEN '2-Image-Animated-2'
        WHEN 3 THEN '3-Live-Photo-3'
        WHEN 4 THEN '4-Video-4'
        WHEN 5 THEN '5-Video-Looping-5'
        ELSE 'Unknown-New-Value!: ' || ZASSET.ZPLAYBACKSTYLE || ''
    END AS 'ZASSET-Playback Style',

    ZASSET.ZPLAYBACKVARIATION AS 'ZASSET-Playback Variation',
    ZASSET.ZDURATION AS 'ZASSET-Video Duration',
    ZEXTENDEDATTRIBUTES.ZDURATION AS 'ZEXTENDEDATTRIBUTES-Duration',
    ZASSET.ZVIDEOCPDURATIONVALUE AS 'ZASSET-Video CP Duration',
    ZADDITIONALASSETATTRIBUTES.ZVIDEOCPDURATIONTIMESCALE AS 'zAddAssetAttr-Video CP Duration Time Scale',
    ZASSET.ZVIDEOCPVISIBILITYSTATE AS 'ZASSET-Video CP Visibility State',
    ZADDITIONALASSETATTRIBUTES.ZVIDEOCPDISPLAYVALUE AS 'zAddAssetAttr-Video CP Display Value',
    ZADDITIONALASSETATTRIBUTES.ZVIDEOCPDISPLAYTIMESCALE AS 'zAddAssetAttr-Video CP Display Time Scale',
    ZINTERNALRESOURCE.ZASSET AS 'ZINTERNALRESOURCE-Asset=ZASSET.zPK',
    ZINTERNALRESOURCE.Z_PK AS 'ZINTERNALRESOURCE-zPK',
    ZINTERNALRESOURCE.Z_ENT AS 'ZINTERNALRESOURCE-zENT',
    ZINTERNALRESOURCE.Z_OPT AS 'ZINTERNALRESOURCE-zOPT',
    --ZINTERNALRESOURCE.ZQUALITYSORTVALUE AS 'ZINTERNALRESOURCE-Quality Sort Value Key',

    CASE ZINTERNALRESOURCE.ZDATASTORECLASSID
        WHEN 0 THEN '0-LPL-Asset_CPL-Asset-0'
        WHEN 1 THEN '1-StillTesting-1'
        WHEN 2 THEN '2-Photo-Cloud-Sharing-Asset-2'
        WHEN 3 THEN '3-SWY_Syndication_Asset-3'
        ELSE 'Unknown-New-Value!: ' || ZINTERNALRESOURCE.ZDATASTORECLASSID || ''
    END AS 'ZINTERNALRESOURCE-Datastore Class ID',

    CASE ZASSET.ZCLOUDPLACEHOLDERKIND
        WHEN 0 THEN '0-Local&CloudMaster Asset-0'
        WHEN 1 THEN '1-StillTesting-1'
        WHEN 2 THEN '2-StillTesting-2'
        WHEN 3 THEN '3-JPG-Asset_Only_PhDa/Thumb/V2-3'
        WHEN 4 THEN '4-LPL-JPG-Asset_CPLAsset-OtherType-4'
        WHEN 5 THEN '5-Asset_synced_CPL_2_Device-5'
        WHEN 6 THEN '6-StillTesting-6'
        WHEN 7 THEN '7-LPL-poster-JPG-Asset_CPLAsset-MP4-7'
        WHEN 8 THEN '8-LPL-JPG_Asset_CPLAsset-LivePhoto-MOV-8'
        WHEN 9 THEN '9-CPL_MP4_Asset_Saved_2_LPL-9'
        ELSE 'Unknown-New-Value!: ' || ZASSET.ZCLOUDPLACEHOLDERKIND || ''
    END AS 'ZASSET-Cloud Placeholder Kind',

    CASE ZINTERNALRESOURCE.ZLOCALAVAILABILITY
        WHEN -1 THEN '(-1)-IR_Asset_Not_Avail_Locally(-1)'
        WHEN 1 THEN '1-IR_Asset_Avail_Locally-1'
        WHEN -32768 THEN '(-32768)_IR_Asset-SWY-Linked_Asset(-32768)'
        ELSE 'Unknown-New-Value!: ' || ZINTERNALRESOURCE.ZLOCALAVAILABILITY || ''
    END AS 'ZINTERNALRESOURCE-Local Availability',

    CASE ZINTERNALRESOURCE.ZLOCALAVAILABILITYTARGET
        WHEN 0 THEN '0-StillTesting-0'
        ELSE 'Unknown-New-Value!: ' || ZINTERNALRESOURCE.ZLOCALAVAILABILITYTARGET || ''
    END AS 'ZINTERNALRESOURCE-Local Availability Target',

    CASE ZINTERNALRESOURCE.ZCLOUDLOCALSTATE
        WHEN 0 THEN '0-IR_Asset_Not_Synced_No_IR-CldMastDateCreated-0'
        WHEN 1 THEN '1-IR_Asset_Pening-Upload-1'
        WHEN 2 THEN '2-IR_Asset_Photo_Cloud_Share_Asset_On-Local-Device-2'
        WHEN 3 THEN '3-IR_Asset_Synced_iCloud-3'
        ELSE 'Unknown-New-Value!: ' || ZINTERNALRESOURCE.ZCLOUDLOCALSTATE || ''
    END AS 'ZINTERNALRESOURCE-Cloud Local State',

    CASE ZINTERNALRESOURCE.ZREMOTEAVAILABILITY
        WHEN 0 THEN '0-IR_Asset-Not-Avail-Remotely-0'
        WHEN 1 THEN '1-IR_Asset_Avail-Remotely-1'
        ELSE 'Unknown-New-Value!: ' || ZINTERNALRESOURCE.ZREMOTEAVAILABILITY || ''
    END AS 'ZINTERNALRESOURCE-Remote Availability',

    CASE ZINTERNALRESOURCE.ZREMOTEAVAILABILITYTARGET
        WHEN 0 THEN '0-StillTesting-0'
        WHEN 1 THEN '1-StillTesting-1'
        ELSE 'Unknown-New-Value!: ' || ZINTERNALRESOURCE.ZREMOTEAVAILABILITYTARGET || ''
    END AS 'ZINTERNALRESOURCE-Remote Availability Target',

    ZINTERNALRESOURCE.ZTRANSIENTCLOUDMASTER AS 'ZINTERNALRESOURCE-Transient Cloud Master',
    ZINTERNALRESOURCE.ZSIDECARINDEX AS 'ZINTERNALRESOURCE-Side Car Index',
    ZINTERNALRESOURCE.ZFILEID AS 'ZINTERNALRESOURCE- File ID',

    CASE ZINTERNALRESOURCE.ZVERSION
        WHEN 0 THEN '0-IR_Asset_Standard-0'
        WHEN 1 THEN '1-StillTesting-1'
        WHEN 2 THEN '2-IR_Asset_Adjustments-Mutation-2'
        WHEN 3 THEN '3-IR_Asset_No_IR-CldMastDateCreated-3'
        ELSE 'Unknown-New-Value!: ' || ZINTERNALRESOURCE.ZVERSION || ''
    END AS 'ZINTERNALRESOURCE-Version',

    ZADDITIONALASSETATTRIBUTES.ZORIGINALFILESIZE AS 'zAddAssetAttr- Original-File-Size',

    CASE ZINTERNALRESOURCE.ZRESOURCETYPE
        WHEN 0 THEN '0-Photo-0'
        WHEN 1 THEN '1-Video-1'
        WHEN 3 THEN '3-Live-Photo-3'
        WHEN 5 THEN '5-Adjustement-Data-5'
        WHEN 6 THEN '6-Screenshot-6'
        WHEN 9 THEN '9-AlternatePhoto-3rdPartyApp-StillTesting-9'
        WHEN 13 THEN '13-Movie-13'
        WHEN 14 THEN '14-Wallpaper-14'
        ELSE 'Unknown-New-Value!: ' || ZINTERNALRESOURCE.ZRESOURCETYPE || ''
    END AS 'ZINTERNALRESOURCE-Resource Type',

    ZINTERNALRESOURCE.ZDATASTOREKEYDATA AS 'ZINTERNALRESOURCE-DataStoreKeyData/HEX',

    CASE ZINTERNALRESOURCE.ZDATASTORESUBTYPE
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
        WHEN 21 THEN '21-MOV-Optimized_HEVC-4K_video-21'
        WHEN 22 THEN '22-Adjust-Mutation_AAE_Asset-22'
        WHEN 23 THEN '23-StillTesting'
        WHEN 24 THEN '24-StillTesting'
        WHEN 25 THEN '25-StillTesting'
        WHEN 26 THEN '26-MOV-Optimized_CPLAsset-26'
        WHEN 27 THEN '27-StillTesting'
        WHEN 28 THEN '28-MOV-Med-hdr-Data-28'
        ELSE 'Unknown-New-Value!: ' || ZINTERNALRESOURCE.ZDATASTORESUBTYPE || ''
    END AS 'ZINTERNALRESOURCE-Datastore Sub-Type',

    CASE ZINTERNALRESOURCE.ZCLOUDSOURCETYPE
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
        WHEN 21 THEN '21-MOV-Optimized_HEVC-4K_video-21'
        WHEN 22 THEN '22-Adjust-Mutation_AAE_Asset-22'
        WHEN 23 THEN '23-StillTesting'
        WHEN 24 THEN '24-StillTesting'
        WHEN 25 THEN '25-StillTesting'
        WHEN 26 THEN '26-MOV-Optimized_CPLAsset-26'
        WHEN 27 THEN '27-StillTesting'
        WHEN 28 THEN '28-MOV-Med-hdr-Data-28'
        ELSE 'Unknown-New-Value!: ' || ZINTERNALRESOURCE.ZCLOUDSOURCETYPE || ''
    END AS 'ZINTERNALRESOURCE-Cloud Source Type',

    ZINTERNALRESOURCE.ZDATALENGTH AS 'ZINTERNALRESOURCE-Data Length',

    CASE ZINTERNALRESOURCE.ZRECIPEID
        WHEN 0 THEN '0-OrigFileSize_match_DataLength_or_Optimized-0'
        WHEN 65737 THEN '65737-full-JPG_Orig-ProRAW_DNG-65737'
        WHEN 65739 THEN '65739-JPG_Large_Thumb-65739'
        WHEN 65741 THEN '65741-Various_Asset_Types-or-Thumbs-65741'
        WHEN 65743 THEN '65743-ResouType-Photo_5003-or-5005-JPG_Thumb-65743'
        WHEN 65749 THEN '65749-LocalVideoKeyFrame-JPG_Thumb-65749'
        WHEN 65938 THEN '65938-FullSizeRender-Photo-or-plist-65938'
        WHEN 131072 THEN '131072-FullSizeRender-Video-or-plist-131072'
        WHEN 131077 THEN '131077-medium-MOV_HEVC-4K-131077'
        WHEN 131079 THEN '131079-medium-MP4_Adj-Mutation_Asset-131079'
        WHEN 131081 THEN '131081-ResouType-Video_5003-or-5005-JPG_Thumb-131081'
        WHEN 131272 THEN '131272-FullSizeRender-Video_LivePhoto_Adj-Mutation-131272'
        WHEN 131275 THEN '131275-medium-MOV_LivePhoto-131275'
        WHEN 131277 THEN '131277-No-IR-Asset_LivePhoto-iCloud_Sync_Asset-131277'
        WHEN 131475 THEN '131475-medium-hdr-MOV-131475'
        WHEN 327683 THEN '327683-JPG-Thumb_for_3rdParty-StillTesting-327683'
        WHEN 327687 THEN '627687-WallpaperComputeResource-627687'
        ELSE 'Unknown-New-Value!: ' || ZINTERNALRESOURCE.ZRECIPEID || ''
    END AS 'ZINTERNALRESOURCE-Recipe ID',

    CASE ZINTERNALRESOURCE.ZCLOUDLASTPREFETCHDATE
        WHEN 0 THEN '0-NA-0'
        ELSE DateTime(ZINTERNALRESOURCE.ZCLOUDLASTPREFETCHDATE + 978307200, 'UNIXEPOCH')
    END AS 'ZINTERNALRESOURCE-Cloud Last Prefetch Date',

    ZINTERNALRESOURCE.ZCLOUDPREFETCHCOUNT AS 'ZINTERNALRESOURCE-Cloud Prefetch Count',
    DateTime(ZINTERNALRESOURCE.ZCLOUDLASTONDEMANDDOWNLOADDATE + 978307200, 'UNIXEPOCH') AS 'ZINTERNALRESOURCE- Cloud-Last-OnDemand Download-Date',

    CASE ZINTERNALRESOURCE.ZUTICONFORMANCEHINT
        WHEN 0 THEN '0-NA/Doesnt_Conform-0'
        WHEN 1 THEN '1-UTTypeImage-1'
        WHEN 2 THEN '2-UTTypeProRawPhoto-2'
        WHEN 3 THEN '3-UTTypeMovie-3'
        ELSE 'Unknown-New-Value!: ' || ZINTERNALRESOURCE.ZUTICONFORMANCEHINT || ''
    END AS 'ZINTERNALRESOURCE-UniformTypeID_UTI_Conformance_Hint',

    CASE ZINTERNALRESOURCE.ZCOMPACTUTI
        WHEN 1 THEN '1-JPEG/THM-1'
        WHEN 3 THEN '3-HEIC-3'
        WHEN 6 THEN '6-PNG-6'
        WHEN 7 THEN '7-StillTesting'
        WHEN 9 THEN '9-DNG-9'
        WHEN 23 THEN '23-JPEG/HEIC/quicktime-mov-23'
        WHEN 24 THEN '24-MPEG4-24'
        WHEN 36 THEN '36-Wallpaper-36'
        WHEN 37 THEN '37-Adj/Mutation_Data-37'
        ELSE 'Unknown-New-Value!: ' || ZINTERNALRESOURCE.ZCOMPACTUTI || ''
    END AS 'ZINTERNALRESOURCE-Compact-UTI',

    ZASSET.ZUNIFORMTYPEIDENTIFIER AS 'ZASSET-Uniform Type ID',
    ZASSET.ZORIGINALCOLORSPACE AS 'ZASSET-Original Color Space',
    ZCLOUDMASTER.ZUNIFORMTYPEIDENTIFIER AS 'zCldMast-Uniform_Type_ID',

    CASE ZCLOUDMASTER.ZFULLSIZEJPEGSOURCE
        WHEN 0 THEN '0-CldMast-JPEG-Source-Video Still-Testing-0'
        WHEN 1 THEN '1-CldMast-JPEG-Source-Other- Still-Testing-1'
        ELSE 'Unknown-New-Value!: ' || ZCLOUDMASTER.ZFULLSIZEJPEGSOURCE || ''
    END AS 'zCldMast-Full Size JPEG Source',

    ZASSET.ZHDRGAIN AS 'ZASSET-HDR Gain',

    CASE ZASSET.ZHDRTYPE
        WHEN 0 THEN '0-No-HDR-0'
        WHEN 3 THEN '3-HDR_Photo-3_RT'
        WHEN 4 THEN '4-Non-HDR_Version-4_RT'
        WHEN 5 THEN '5-HEVC_Movie-5'
        WHEN 6 THEN '6-Panorama-6_RT'
        WHEN 10 THEN '10-HDR-Gain-10'
        ELSE 'Unknown-New-Value!: ' || ZASSET.ZHDRTYPE || ''
    END AS 'ZASSET-zHDR_Type',

  ZEXTENDEDATTRIBUTES.ZCODEC AS 'ZEXTENDEDATTRIBUTES-Codec',
  ZINTERNALRESOURCE.ZCODECFOURCHARCODENAME AS 'ZINTERNALRESOURCE-Codec Four Char Code Name',
  ZCLOUDMASTER.ZCODECNAME AS 'zCldMast-Codec Name',
  ZCLOUDMASTER.ZVIDEOFRAMERATE AS 'zCldMast-Video Frame Rate',
  ZCLOUDMASTER.ZPLACEHOLDERSTATE AS 'zCldMast-Placeholder State',

    CASE ZASSET.ZDEPTHTYPE
        WHEN 0 THEN '0-Not_Portrait-0_RT'
        ELSE 'Portrait: ' || ZASSET.ZDEPTHTYPE || ''
    END AS 'ZASSET-Depth_Type',

    ZASSET.ZAVALANCHEUUID AS 'ZASSET-Avalanche UUID',

    CASE ZASSET.ZAVALANCHEPICKTYPE
        WHEN 0 THEN '0-NA/Single_Asset_Burst_UUID-0_RT'
        WHEN 2 THEN '2-Burst_Asset_Not_Selected-2_RT'
        WHEN 4 THEN '4-Burst_Asset_PhotosApp_Picked_KeyImage-4_RT'
        WHEN 8 THEN '8-Burst_Asset_Selected_for_LPL-8_RT'
        WHEN 16 THEN '16-Top_Burst_Asset_inStack_KeyImage-16_RT'
        WHEN 32 THEN '32-StillTesting-32_RT'
        WHEN 52 THEN '52-Burst_Asset_Visible_LPL-52'
        ELSE 'Unknown-New-Value!: ' || ZASSET.ZAVALANCHEPICKTYPE || ''
    END AS 'ZASSET-Avalanche_Pick_Type/BurstAsset',

    CASE ZADDITIONALASSETATTRIBUTES.ZCLOUDAVALANCHEPICKTYPE
        WHEN 0 THEN '0-NA/Single_Asset_Burst_UUID-0_RT'
        WHEN 2 THEN '2-Burst_Asset_Not_Selected-2_RT'
        WHEN 4 THEN '4-Burst_Asset_PhotosApp_Picked_KeyImage-4_RT'
        WHEN 8 THEN '8-Burst_Asset_Selected_for_LPL-8_RT'
        WHEN 16 THEN '16-Top_Burst_Asset_inStack_KeyImage-16_RT'
        WHEN 32 THEN '32-StillTesting-32_RT'
        WHEN 52 THEN '52-Burst_Asset_Visible_LPL-52'
        ELSE 'Unknown-New-Value!: ' || ZADDITIONALASSETATTRIBUTES.ZCLOUDAVALANCHEPICKTYPE || ''
    END AS 'zAddAssetAttr-Cloud_Avalanche_Pick_Type/BurstAsset',

    CASE ZADDITIONALASSETATTRIBUTES.ZCLOUDRECOVERYSTATE
        WHEN 0 THEN '0-StillTesting-0'
        WHEN 1 THEN '1-StillTesting-1'
        ELSE 'Unknown-New-Value!: ' || ZADDITIONALASSETATTRIBUTES.ZCLOUDRECOVERYSTATE || ''
    END AS 'zAddAssetAttr-Cloud Recovery State',

    ZADDITIONALASSETATTRIBUTES.ZCLOUDSTATERECOVERYATTEMPTSCOUNT AS 'zAddAssetAttr-Cloud State Recovery Attempts Count',
    ZASSET.ZDEFERREDPROCESSINGNEEDED AS 'ZASSET-Deferred Processing Needed',
    ZASSET.ZVIDEODEFERREDPROCESSINGNEEDED AS 'ZASSET-Video Deferred Processing Needed',
    ZADDITIONALASSETATTRIBUTES.ZDEFERREDPHOTOIDENTIFIER AS 'zAddAssetAttr-Deferred Photo Identifier',
    ZADDITIONALASSETATTRIBUTES.ZDEFERREDPROCESSINGCANDIDATEOPTIONS AS 'zAddAssetAttr-Deferred Processing Candidate Options',

    CASE ZASSET.ZHASADJUSTMENTS
        WHEN 0 THEN '0-No-Adjustments-0'
        WHEN 1 THEN '1-Yes-Adjustments-1'
        ELSE 'Unknown-New-Value!: ' || ZASSET.ZHASADJUSTMENTS || ''
    END AS 'ZASSET-Has Adjustments/Camera-Effects-Filters',

    ZUNMANAGEDADJUSTMENT.ZASSETATTRIBUTES AS 'ZUNMANAGEDADJUSTMENT-Asset Attributes=ZADDITIONALASSETATTRIBUTES.zPK',
    ZADDITIONALASSETATTRIBUTES.ZUNMANAGEDADJUSTMENT AS 'zAddAssetAttr-UnmanAdjust Key=ZUNMANAGEDADJUSTMENT.zPK',
    ZUNMANAGEDADJUSTMENT.Z_PK AS 'ZUNMANAGEDADJUSTMENT-zPK=ZADDITIONALASSETATTRIBUTES.ZUnmanAdj Key',
    ZUNMANAGEDADJUSTMENT.ZUUID AS 'ZUNMANAGEDADJUSTMENT-UUID',
    DateTime(ZASSET.ZADJUSTMENTTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'ZASSET-Adjustment Timestamp',
    DateTime(ZUNMANAGEDADJUSTMENT.ZADJUSTMENTTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'ZUNMANAGEDADJUSTMENT-Adjustment Timestamp',
    ZADDITIONALASSETATTRIBUTES.ZEDITORBUNDLEID AS 'zAddAssetAttr-Editor Bundle ID',
    ZUNMANAGEDADJUSTMENT.ZEDITORLOCALIZEDNAME AS 'ZUNMANAGEDADJUSTMENT-Editor Localized Name',
    ZUNMANAGEDADJUSTMENT.ZADJUSTMENTFORMATIDENTIFIER AS 'ZUNMANAGEDADJUSTMENT-Adjustment Format ID',
    ZADDITIONALASSETATTRIBUTES.ZMONTAGE AS 'zAddAssetAttr-Montage',

    CASE ZUNMANAGEDADJUSTMENT.ZADJUSTMENTRENDERTYPES
        WHEN 0 THEN '0-Standard or Portrait with erros-0'
        WHEN 1 THEN '1-StillTesting-1'
        WHEN 2 THEN '2-Portrait-2'
        WHEN 3 THEN '3-StillTesting-3'
        WHEN 4 THEN '4-StillTesting-4'
        ELSE 'Unknown-New-Value!: ' || ZUNMANAGEDADJUSTMENT.ZADJUSTMENTRENDERTYPES || ''
    END AS 'ZUNMANAGEDADJUSTMENT-Adjustment Render Types',

    CASE ZUNMANAGEDADJUSTMENT.ZADJUSTMENTFORMATVERSION
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
        ELSE 'Unknown-New-Value!: ' || ZUNMANAGEDADJUSTMENT.ZADJUSTMENTFORMATVERSION || ''
    END AS 'ZUNMANAGEDADJUSTMENT-Adjustment Format Version',

    ZUNMANAGEDADJUSTMENT.ZADJUSTMENTBASEIMAGEFORMAT AS 'ZUNMANAGEDADJUSTMENT-Adjustment Base Image Format',

    CASE ZASSET.ZFAVORITE
        WHEN 0 THEN '0-Asset Not Favorite-0'
        WHEN 1 THEN '1-Asset Favorite-1'
    END AS 'ZASSET-Favorite',

    CASE ZASSET.ZHIDDEN
        WHEN 0 THEN '0-Asset Not Hidden-0'
        WHEN 1 THEN '1-Asset Hidden-1'
        ELSE 'Unknown-New-Value!: ' || ZASSET.ZHIDDEN || ''
    END AS 'ZASSET-Hidden',

    CASE ZASSET.ZTRASHEDSTATE
        WHEN 0 THEN '0-Asset Not In Trash/Recently Deleted-0'
        WHEN 1 THEN '1-Asset In Trash/Recently Deleted-1'
        ELSE 'Unknown-New-Value!: ' || ZASSET.ZTRASHEDSTATE || ''
    END AS 'ZASSET-Trashed State/LocalAssetRecentlyDeleted',

    DateTime(ZASSET.ZTRASHEDDATE + 978307200, 'UNIXEPOCH') AS 'ZASSET-Trashed Date',

    CASE ZINTERNALRESOURCE.ZTRASHEDSTATE
        WHEN 0 THEN '0-ZINTERNALRESOURCE-Not In Trash/Recently Deleted-0'
        WHEN 1 THEN '1-ZINTERNALRESOURCE-In Trash/Recently Deleted-1'
        ELSE 'Unknown-New-Value!: ' || ZINTERNALRESOURCE.ZTRASHEDSTATE || ''
    END AS 'ZINTERNALRESOURCE-Trash State',

     DateTime(ZINTERNALRESOURCE.ZTRASHEDDATE + 978307200, 'UNIXEPOCH') AS 'ZINTERNALRESOURCE-Trashed Date',

    CASE ZASSET.ZCLOUDDELETESTATE
        WHEN 0 THEN '0-Cloud Asset Not Deleted-0'
        WHEN 1 THEN '1-Cloud Asset Deleted-1'
        ELSE 'Unknown-New-Value!: ' || ZASSET.ZCLOUDDELETESTATE || ''
    END AS 'ZASSET-Cloud Delete State',

    CASE ZINTERNALRESOURCE.ZCLOUDDELETESTATE
        WHEN 0 THEN '0-Cloud IntResou Not Deleted-0'
        WHEN 1 THEN '1-Cloud IntResou Deleted-1'
        ELSE 'Unknown-New-Value!: ' || ZINTERNALRESOURCE.ZCLOUDDELETESTATE || ''
    END AS 'ZINTERNALRESOURCE-Cloud Delete State',

    CASE ZADDITIONALASSETATTRIBUTES.ZPTPTRASHEDSTATE
        WHEN 0 THEN '0-PTP Not in Trash-0'
        WHEN 1 THEN '1-PTP In Trash-1'
        ELSE 'Unknown-New-Value!: ' || ZADDITIONALASSETATTRIBUTES.ZPTPTRASHEDSTATE || ''
    END AS 'zAddAssetAttr-PTP Trashed State',

    CASE ZINTERNALRESOURCE.ZPTPTRASHEDSTATE
        WHEN 0 THEN '0-PTP IntResou Not in Trash-0'
        WHEN 1 THEN '1-PTP IntResou In Trash-1'
        ELSE 'Unknown-New-Value!: ' || ZINTERNALRESOURCE.ZPTPTRASHEDSTATE || ''
    END AS 'ZINTERNALRESOURCE-PTP Trashed State',

    ZINTERNALRESOURCE.ZCLOUDDELETEASSETUUIDWITHRESOURCETYPE AS 'ZINTERNALRESOURCE-Cloud Delete Asset UUID With Resource Type',
    DateTime(ZMEDIAANALYSISASSETATTRIBUTES.ZMEDIAANALYSISTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'ZMEDIAANALYSISASSETATTRIBUTES-Media Analysis Timestamp',
    DateTime(ZASSET.ZANALYSISSTATEMODIFICATIONDATE + 978307200, 'UNIXEPOCH') AS 'ZASSET-Analysis State Modificaion Date',
    ZADDITIONALASSETATTRIBUTES.ZPENDINGVIEWCOUNT AS 'zAddAssetAttr-Pending View Count',
    ZADDITIONALASSETATTRIBUTES.ZVIEWCOUNT AS 'zAddAssetAttr-View Count',
    ZADDITIONALASSETATTRIBUTES.ZPENDINGPLAYCOUNT AS 'zAddAssetAttr-Pending Play Count',
    ZADDITIONALASSETATTRIBUTES.ZPLAYCOUNT AS 'zAddAssetAttr-Play Count',
    ZADDITIONALASSETATTRIBUTES.ZPENDINGSHARECOUNT AS 'zAddAssetAttr-Pending Share Count',
    ZADDITIONALASSETATTRIBUTES.ZSHARECOUNT AS 'zAddAssetAttr-Share Count',
    DateTime(ZASSET.ZLASTSHAREDDATE + 978307200, 'UNIXEPOCH') AS 'ZASSET-Last Shared Date',
    ZADDITIONALASSETATTRIBUTES.ZSHAREORIGINATOR AS 'zAddAssetAttr-Share Originator',

    CASE ZASSET.ZSYNDICATIONSTATE
        WHEN 0 THEN '0-Local-PL_Asset_Syndication_State_NA-0'
        ELSE 'Unknown-New-Value!: ' || ZASSET.ZSYNDICATIONSTATE || ''
    END AS 'ZASSET-Syndication State-LPL',

    ZADDITIONALASSETATTRIBUTES.ZSYNDICATIONHISTORY AS 'zAddAssetAttr-Syndication History',
    ZMEDIAANALYSISASSETATTRIBUTES.ZSYNDICATIONPROCESSINGVERSION AS 'ZMEDIAANALYSISASSETATTRIBUTES-Syndication Processing Version',

    CASE ZMEDIAANALYSISASSETATTRIBUTES.ZSYNDICATIONPROCESSINGVALUE
        WHEN 0 THEN '0-NA-0'
        WHEN 1 THEN '1-STILLTESTING_Wide-Camera_JPG-1'
        WHEN 2 THEN '2-STILLTESTING_Telephoto_Camear_Lens-2'
        WHEN 4 THEN '4-STILLTESTING_SWY_Asset_OrigAssetImport_SystemPackageApp-4'
        WHEN 16 THEN '16-STILLTESTING-16'
        WHEN 1024 THEN '1024-STILLTESTING_SWY_Asset_OrigAssetImport_NativeCamera-1024'
        WHEN 2048 THEN '2048-STILLTESTING-2048'
        WHEN 4096 THEN '4096-STILLTESTING_SWY_Asset_Manually_Saved-4096'
        ELSE 'Unknown-New-Value!: ' || ZMEDIAANALYSISASSETATTRIBUTES.ZSYNDICATIONPROCESSINGVALUE || ''
    END AS 'ZMEDIAANALYSISASSETATTRIBUTES-Syndication Processing Value',

    CASE ZADDITIONALASSETATTRIBUTES.ZALLOWEDFORANALYSIS
        WHEN 0 THEN '0-Asset Not Allowed For Analysis-0'
        WHEN 1 THEN '1-Asset Allowed for Analysis-1'
        ELSE 'Unknown-New-Value!: ' || ZADDITIONALASSETATTRIBUTES.ZALLOWEDFORANALYSIS || ''
    END AS 'zAddAssetAttr-Allowed for Analysis',

    ZADDITIONALASSETATTRIBUTES.ZSCENEANALYSISVERSION AS 'zAddAssetAttr-Scene Analysis Version',

    CASE ZADDITIONALASSETATTRIBUTES.ZSCENEANALYSISISFROMPREVIEW
        WHEN 0 THEN '0-No-0'
        ELSE 'Unknown-New-Value!: ' || ZADDITIONALASSETATTRIBUTES.ZSCENEANALYSISISFROMPREVIEW || ''
    END AS 'zAddAssetAttr-Scene Analysis is From Preview',

    DateTime(ZADDITIONALASSETATTRIBUTES.ZSCENEANALYSISTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'zAddAssetAttr-Scene Analysis Timestamp',

    CASE ZADDITIONALASSETATTRIBUTES.ZDESTINATIONASSETCOPYSTATE
        WHEN 0 THEN '0-No Copy-0'
        WHEN 1 THEN '1-Has A Copy-1'
        WHEN 2 THEN '2-Has A Copy-2'
        ELSE 'Unknown-New-Value!: ' || ZADDITIONALASSETATTRIBUTES.ZDESTINATIONASSETCOPYSTATE || ''
    END AS 'zAddAssetAttr-Destination Asset Copy State',

    -- ZSCENEPRINT.ZDATA AS 'ZSCENEPRINT-Data/HEX NSKeyed Plist',
    ZADDITIONALASSETATTRIBUTES.ZSOURCEASSETFORDUPLICATIONSCOPEIDENTIFIER AS 'zAddAssetAttr-Source Asset for Duplication Scope ID',
    ZCLOUDMASTER.ZSOURCEMASTERFORDUPLICATIONSCOPEIDENTIFIER AS 'zCldMast-Source Master For Duplication Scope ID',
    ZADDITIONALASSETATTRIBUTES.ZSOURCEASSETFORDUPLICATIONIDENTIFIER AS 'zAddAssetAttr-Source Asset For Duplication ID',
    ZCLOUDMASTER.ZSOURCEMASTERFORDUPLICATIONIDENTIFIER AS 'zCldMast-Source Master for Duplication ID'


FROM ZASSET
    LEFT JOIN ZADDITIONALASSETATTRIBUTES ON
        ZADDITIONALASSETATTRIBUTES.Z_PK = ZASSET.ZADDITIONALATTRIBUTES
    LEFT JOIN ZEXTENDEDATTRIBUTES ON
        ZEXTENDEDATTRIBUTES.Z_PK = ZASSET.ZEXTENDEDATTRIBUTES
    LEFT JOIN ZINTERNALRESOURCE ON
        ZINTERNALRESOURCE.ZASSET = ZASSET.Z_PK
    LEFT JOIN ZSCENEPRINT ON
        ZSCENEPRINT.Z_PK = ZADDITIONALASSETATTRIBUTES.ZSCENEPRINT
    LEFT JOIN Z_28ASSETS ON
        Z_28ASSETS.Z_3ASSETS = ZASSET.Z_PK
    LEFT JOIN ZGENERICALBUM ON
        ZGENERICALBUM.Z_PK = Z_28ASSETS.Z_28ALBUMS
    LEFT JOIN ZUNMANAGEDADJUSTMENT ON
        ZADDITIONALASSETATTRIBUTES.ZUNMANAGEDADJUSTMENT = ZUNMANAGEDADJUSTMENT.Z_PK
    LEFT JOIN Z_27ALBUMLISTS ON
        Z_27ALBUMLISTS.Z_27ALBUMS = ZGENERICALBUM.Z_PK
    LEFT JOIN ZALBUMLIST ON
        ZALBUMLIST.Z_PK = Z_27ALBUMLISTS.Z_2ALBUMLISTS
    LEFT JOIN ZGENERICALBUM ParentzGenAlbum ON
        ParentzGenAlbum.Z_PK = ZGENERICALBUM.ZPARENTFOLDER
    LEFT JOIN ZCLOUDMASTER ON
        ZASSET.ZMASTER = ZCLOUDMASTER.Z_PK
    LEFT JOIN ZCLOUDMASTERMEDIAMETADATA AAAzCldMastMedData ON
        AAAzCldMastMedData.Z_PK = ZADDITIONALASSETATTRIBUTES.ZMEDIAMETADATA
    LEFT JOIN ZCLOUDMASTERMEDIAMETADATA CMzCldMastMedData ON
        CMzCldMastMedData.Z_PK = ZCLOUDMASTER.ZMEDIAMETADATA
    LEFT JOIN ZMEDIAANALYSISASSETATTRIBUTES ON
        ZASSET.ZMEDIAANALYSISATTRIBUTES = ZMEDIAANALYSISASSETATTRIBUTES.Z_PK
    LEFT JOIN ZSHARE ON
        ZSHARE.Z_PK = ZASSET.ZMOMENTSHARE


ORDER BY ZASSET.ZADDEDDATE