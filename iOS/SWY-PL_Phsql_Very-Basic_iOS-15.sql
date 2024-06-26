/*
Query copied from https://github.com/ScottKjr3347/iOS_SWY_PL_Photos.sqlite_Queries/blob/main/iOS15/iOS15_SWY-PL_Phsql_Very-Basic.txt
*/

SELECT
    ROW_NUMBER() OVER() AS 'Record #',
    zAsset.Z_PK AS 'zAsset-zPK',
    zAddAssetAttr.Z_PK AS 'zAddAssetAttr-zPK',
    zAsset.ZUUID AS 'zAsset-UUID = store.cloudphotodb',
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
    zAddAssetAttr.ZORIGINALFILESIZE AS 'zAddAssetAttr-Original File Size',
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
    zAddAssetAttr.ZTIMEZONENAME AS 'zAddAssetAttr-Time Zone Name',
    zAddAssetAttr.ZTIMEZONEOFFSET AS 'zAddAssetAttr-Time Zone Offset',
    zAddAssetAttr.ZEXIFTIMESTAMPSTRING AS 'zAddAssetAttr-EXIF-String',
    datetime(zAsset.ZMODIFICATIONDATE + 978307200, 'UNIXEPOCH') AS 'zAsset-Modification Date',
    CASE zCldMast.ZCLOUDLOCALSTATE
        WHEN 0 THEN '0-Not Synced with Cloud-0'
        WHEN 1 THEN '1-Pending Upload-1'
        WHEN 2 THEN '2-StillTesting'
        WHEN 3 THEN '3-Synced with Cloud-3'
        ELSE 'Unknown-New-Value!: ' || zCldMast.ZCLOUDLOCALSTATE || ''
    END AS 'zCldMast-Cloud Local State',
    zAddAssetAttr.ZMEDIAMETADATATYPE AS 'zAddAssetAttr-Media Metadata Type',
    zCldMastMedData.ZDATA AS 'AAAzCldMastMedData-Data/HEX',
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
    END AS 'zAsset-Cloud Placeholder Kind'

FROM ZASSET zAsset
    LEFT JOIN ZADDITIONALASSETATTRIBUTES zAddAssetAttr ON zAddAssetAttr.Z_PK = zAsset.ZADDITIONALATTRIBUTES
    LEFT JOIN ZEXTENDEDATTRIBUTES zExtAttr ON zExtAttr.Z_PK = zAsset.ZEXTENDEDATTRIBUTES
    LEFT JOIN ZCLOUDMASTER zCldMast ON zAsset.ZMASTER = zCldMast.Z_PK
    LEFT JOIN ZCLOUDMASTERMEDIAMETADATA zCldMastMedData ON zCldMastMedData.Z_PK = zAddAssetAttr.ZMEDIAMETADATA
    LEFT JOIN ZMEDIAANALYSISASSETATTRIBUTES zMedAnlyAstAttr ON zAsset.ZMEDIAANALYSISATTRIBUTES = zMedAnlyAstAttr.Z_PK

ORDER BY zAsset.ZADDEDDATE
