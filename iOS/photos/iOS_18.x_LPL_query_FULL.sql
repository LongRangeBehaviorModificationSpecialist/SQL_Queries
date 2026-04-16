/*
[DLU]
    05-Sep-2025

[NOTES]
    Modified from original iOS 15 query copied from: https://github.com/ScottKjr3347/iOS_Local_PL_Photos.sqlite_Queries/blob/main/iOS15/Previous_Queries/iOS15_LPL_Phsql_Basic.txt
*/

SELECT

    ROW_NUMBER() OVER() AS '001_record_number',

    ZASSET.ZDIRECTORY AS '002-ZASSET.zdirectory',
    ZASSET.ZFILENAME AS '003-ZASSET.zfilename',
    ZADDASSETADDRS.ZORIGINALFILENAME AS '004-ZADDASSETADDRS.zoriginalfilename',
    ZCLDMAST.ZORIGINALFILENAME AS '005-ZCLDMAST.zoriginalfilename',
    ZADDASSETADDRS.ZSYNDICATIONIDENTIFIER AS '006-ZADDASSETADDRS.zsyndicationidentifier',

    datetime(ZASSET.ZADDEDDATE + 978307200, 'UNIXEPOCH') AS '007-ZASSET.zaddeddate(utc)',

    ZASSET.ZSORTTOKEN AS '002-ZASSET.zsorttoken',
    ZASSET.ZPROMOTIONSCORE AS '003-ZASSET.zpromotionscore',

    CASE ZASSET.ZCOMPLETE
        WHEN 1 THEN 'Yes [1]'
        ELSE ZASSET.ZCOMPLETE
    END AS '004-ZASSET.zcomplete',

    ZASSET.Z_PK AS '005-ZASSET.z_pk',
    ZADDASSETADDRS.Z_PK AS '006-ZADDASSETADDRS.z_pk',

    -- [ZCLDMAST.Z_PK = ZASSET.Z_MASTER]
    ZCLDMAST.Z_PK AS '007-ZCLDMAST.z_pk',

    -- [ZASSET.ZMASTER = ZCLDMAST.Z_PK]
    ZASSET.ZMASTER AS '008-ZASSET.zmaster',

    -- [ZASSET.EXTDATTR = ZEXTATTR.Z_PK]
    ZASSET.ZEXTENDEDATTRIBUTES AS '009-ZASSET.zextendedattributes',
    ZEXTATTR.Z_PK AS '010-ZEXTATTR.z_pk',

    -- [CMZCLDMASTMEDDATA.ZCLOUDMASTER = ZCLDMAST.Z_PK]
    CMZCLDMASTMedData.ZCLOUDMASTER AS '011-CMZCLDMASTMEDDATA.zcloudmaster',

    -- [ZCLDMAST.ZMEDIAMETADATA = ZCLDMASTMEDDATA.Z_PK]
    ZCLDMAST.ZMEDIAMETADATA AS '012-ZCLDMAST.zmediametadata',

    -- [CMZCLDMASTMEDDATA.Z_PK = ZADDASSETADDRS&ZCLDMAST.ZMEDIAMETADATA]
    CMZCLDMASTMedData.Z_PK AS '013-CMZCLDMASTMEDDATA.z_pk',

    CMZCLDMASTMedData.Z_ENT AS '014-CMZCLDMASTMEDDATA.z_ent',
    ZASSET.ZUUID AS '015-ZASSET.zuuid',

    -- This value will be the same on two different devices if the asset was synced via iCloud
    ZASSET.ZCLOUDASSETGUID AS '016-ZASSET.zcloudassetguid',
    ZASSET.ZCLOUDCOLLECTIONGUID AS '017-ZASSET.zcloudcollectguid',

    -- This value will be the same on two different devices if the asset was synced via iCloud
    ZCLDMAST.ZCLOUDMASTERGUID AS '018-ZCLDMAST.zcloudmasterguid',
    ZGENALBUM.ZCLOUDGUID AS '019-ZGENALBUM.zcloudguid',
    ZSHARE.ZSCOPEIDENTIFIER AS '020-ZSHARE.zscopeidentifier',
    ZADDASSETADDRS.ZORIGINALASSETSUUID AS '021-ZADDASSETADDRS.zoriginalassetsuuid',
    ZADDASSETADDRS.ZPUBLICGLOBALUUID AS '022-ZADDASSETADDRS.zpublicglobaluuid',
    -- ZADDASSETADDRS.ZMASTERFINGERPRINT AS '023-ZADDASSETADDRS.ZMASTERFINGERPRINT',
    ZADDASSETADDRS.ZORIGINATINGASSETIDENTIFIER AS '024-ZADDASSETADDRS.zoriginatingassetidentifier',
    ZCLDMAST.ZORIGINATINGASSETIDENTIFIER AS '025-ZCLDMAST.zoriginatingassetidentifier',

    CASE ZADDASSETADDRS.ZDATECREATEDSOURCE
        WHEN 0 THEN 'Cloud Asset [0]'
        WHEN 1 THEN 'Local Asset EXIF [1]'
        WHEN 3 THEN 'Local Asset No EXIF [3]'
        ELSE 'Unknown Value: ' || ZADDASSETADDRS.ZDATECREATEDSOURCE || ''
    END AS '032-ZADDASSETADDRS.zdatecreatedsource',

    datetime(ZASSET.ZDATECREATED + 978307200, 'UNIXEPOCH') AS '033-ZASSET.zdatecreated(utc)',
    datetime(ZCLDMAST.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS '034-ZCLDMAST.zcreationdate(utc)',
    datetime(ZINTRESOU.ZCLOUDMASTERDATECREATED + 978307200, 'UNIXEPOCH') AS '035-ZINTRESOU.zcloudmasterdatecreated(utc)',

    ZADDASSETADDRS.ZTIMEZONENAME AS '036-ZADDASSETADDRS.ztimezonename',
    ZADDASSETADDRS.ZTIMEZONEOFFSET AS '037-ZADDASSETADDRS.ztimezoneoffset',
    ZADDASSETADDRS.ZINFERREDTIMEZONEOFFSET AS '038-ZADDASSETADDRS.zinferredtimezoneoffset',
    ZADDASSETADDRS.ZEXIFTIMESTAMPSTRING AS '039-ZADDASSETADDRS.zexiftimestampstring',

    datetime(ZASSET.ZMODIFICATIONDATE + 978307200, 'UNIXEPOCH') AS '040-ZASSET.zmodificationdate(utc)',

    ZINTRESOU.ZFINGERPRINT AS '041-ZINTRESOU.zfingerprint',
    -- ZADDASSETADDRS.ZADJUSTEDFINGERPRINT AS '042-ZADDASSETADDRS.zadjustedfingerprint',
    ZUNMADJ.ZOTHERADJUSTMENTSFINGERPRINT AS '043-ZUNMADJ.zotheradjustmentsfingerprint',
    ZUNMADJ.ZSIMILARTOORIGINALADJUSTMENTSFINGERPRINT AS '044-ZUNMADJ.similartoorigadjfingerprint',

    CASE ParentZGENALBUM.ZCLOUDLOCALSTATE
        WHEN 0 THEN 'iCloud Photos ON (Asset In Shared/Other Album) | iCloud Photos OFF (Generic Album) [0]'
        WHEN 1 THEN 'iCloud Photos ON (Asset In Generic Album) [1]'
        ELSE 'Unknown Value: ' || ParentZGENALBUM.ZCLOUDLOCALSTATE || ''
    END AS '045-PARENTZGENALBUM.zcloudlocalstate',

    ParentZGENALBUM.ZTITLE AS '046-PARENTZGENALBUM.ztitle',

    datetime(ParentZGENALBUM.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS '047-PARENTZGENALBUM.zcreationdate(utc)',
    datetime(ZGENALBUM.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS '048-ZGENALBUM.zcreationdate(utc)',

    CASE ZGENALBUM.ZCLOUDLOCALSTATE
        WHEN 0 THEN 'iCloud Photos ON (Asset In Shared/Other Album) | iCloud Photos OFF (Generic Album) [0]'
        WHEN 1 THEN 'iCloud Photos ON (Asset In Generic Album) [1]'
        ELSE 'Unknown Value: ' || ZGENALBUM.ZCLOUDLOCALSTATE || ''
    END AS '049-ZGENALBUM.zcloudlocalstate',

    ZGENALBUM.ZTITLE AS '050-ZGENALBUM.ztitle',

    CASE ZASSET.ZBUNDLESCOPE
        WHEN 0 THEN 'iCloud Photos ON (Not In Shared Album) | iCloud Photos OFF (On Local Device) [0]'
        WHEN 1 THEN 'SWY Syndication CMMAsset [1]'
        WHEN 2 THEN 'iCloud Photos ON (Asset In Cloud Shared Album) [2]'
        WHEN 3 THEN 'iCloud Photos ON (SWY Syndication-Asset) [3]'
        ELSE 'Unknown Value: ' || ZASSET.ZBUNDLESCOPE || ''
    END AS '051-ZASSET.zbundlescope',

    CASE ZASSET.ZCLOUDISMYASSET
        WHEN 0 THEN 'Not My Asset in Shared Album [0]'
        WHEN 1 THEN 'My Asset in Shared Album [1]'
        ELSE 'Unknown Value: ' || ZASSET.ZCLOUDISMYASSET || ''
    END AS '052-ZASSET.zcloudismyasset',

    CASE ZASSET.ZCLOUDISDELETABLE
        WHEN 0 THEN 'No [0]'
        WHEN 1 THEN 'Yes [1]'
        ELSE 'Unknown Value: ' || ZASSET.ZCLOUDISDELETABLE || ''
    END AS '053-ZASSET.zcloudisdeletable',

    CASE ZASSET.ZCLOUDLOCALSTATE
        WHEN 0 THEN 'iCloud Photos ON (Asset In Shared or Other Album) | iCloud Photos OFF (Not Synced) [0]'
        WHEN 1 THEN 'iCloud Photos ON (Asset Can Be or Has Been Synced with iCloud) [1]'
        ELSE 'Unknown Value: ' || ZASSET.ZCLOUDLOCALSTATE || ''
    END AS '054-ZASSET.zcloudlocalstate',

    -- Indicates whether assets are visible within the Local Photo Library
    CASE ZASSET.ZVISIBILITYSTATE
        WHEN 0 THEN 'Visible Photo Library [0]'
        WHEN 2 THEN 'Not Visible Photo Library [2]'
        ELSE 'Unknown Value: ' || ZASSET.ZVISIBILITYSTATE || ''
    END AS '055-ZASSET.zvisibilitystate',

    ZEXTATTR.ZCAMERAMAKE AS '056-ZEXTATTR.zcameramake',
    ZEXTATTR.ZCAMERAMODEL AS '057-ZEXTATTR.zcameramodel',
    ZEXTATTR.ZLENSMODEL AS '058-ZEXTATTR.zlensmodel',

    CASE ZEXTATTR.ZFLASHFIRED
        WHEN 0 THEN 'No Flash [0]'
        WHEN 1 THEN 'Flash Fired [1]'
        ELSE 'Unknown Value: ' || ZEXTATTR.ZFLASHFIRED || ''
    END AS '059-ZEXTATTR.zflashfired',

    ZEXTATTR.ZFOCALLENGTH AS '060-ZEXTATTR.zfocallength',
    ZEXTATTR.ZFOCALLENGTHIN35MM AS '061-ZEXTATTR.zfocallengthin35mm',
    ZEXTATTR.ZDIGITALZOOMRATIO AS '062-ZEXTATTR.zdigitalzoomratio',

    CASE ZASSET.ZDERIVEDCAMERACAPTUREDEVICE
        WHEN 0 THEN 'Back Camera/Other [0]'
        WHEN 1 THEN 'Front Camera [1]'
        ELSE 'Unknown Value: ' || ZASSET.ZDERIVEDCAMERACAPTUREDEVICE || ''
    END AS '063-ZASSET.zderivedcameracapturedevice',

    CASE ZADDASSETADDRS.ZCAMERACAPTUREDEVICE
        WHEN 0 THEN 'Back Camera/Other [0]'
        WHEN 1 THEN 'Front Camera [1]'
        ELSE 'Unknown Value: ' || ZADDASSETADDRS.ZCAMERACAPTUREDEVICE || ''
    END AS '064-ZADDASSETADDRS.zcameracapturedevice',

    CASE ZADDASSETADDRS.ZIMPORTEDBY
        WHEN 0 THEN 'Cloud Other [0]'
        WHEN 1 THEN 'Native Back Camera [1]'
        WHEN 2 THEN 'Native Front Camera [2]'
        WHEN 3 THEN 'Third Party App [3]'
        WHEN 4 THEN 'Still Testing [4]'
        WHEN 5 THEN 'PhotoBooth PL Asset [5]'
        WHEN 6 THEN 'Third Party App [6]'
        WHEN 7 THEN 'iCloud Share Link CMM Asset [7]'
        WHEN 8 THEN 'System Package App [8]'
        WHEN 9 THEN 'Native App [9]'
        WHEN 10 THEN 'Still Testing [10]'
        WHEN 11 THEN 'Still Testing [11]'
        WHEN 12 THEN 'SWY Syndication PL [12]'
        ELSE 'Unknown Value: ' || ZADDASSETADDRS.ZIMPORTEDBY || ''
    END AS '065-ZADDASSETADDRS.zimportedby',

    CASE ZCLDMAST.ZIMPORTEDBY
        WHEN 0 THEN 'Cloud Other [0]'
        WHEN 1 THEN 'Native Back Camera [1]'
        WHEN 2 THEN 'Native Front Camera [2]'
        WHEN 3 THEN 'Third Party App [3]'
        WHEN 4 THEN 'Still Testing [4]'
        WHEN 5 THEN 'PhotoBooth PL Asset [5]'
        WHEN 6 THEN 'Third Party App [6]'
        WHEN 7 THEN 'iCloud Share Link CMM Asset [7]'
        WHEN 8 THEN 'System Package App [8]'
        WHEN 9 THEN 'Native App [9]'
        WHEN 10 THEN 'Still Testing [10]'
        WHEN 11 THEN 'Still Testing [11]'
        WHEN 12 THEN 'SWY Syndication PL [12]'
        ELSE 'Unknown Value: ' || ZCLDMAST.ZIMPORTEDBY || ''
    END AS '066-ZCLDMAST.zimportedby',

    ZADDASSETADDRS.ZIMPORTEDBYBUNDLEIDENTIFIER AS '067-ZADDASSETADDRS.zimportedbybundleidentifier',
    ZADDASSETADDRS.ZIMPORTEDBYDISPLAYNAME AS '068-ZADDASSETADDRS.zimportedbydisplayname',
    ZCLDMAST.ZIMPORTEDBYBUNDLEIDENTIFIER AS '069-ZCLDMAST.zimportedbybundleidentifier',
    ZCLDMAST.ZIMPORTEDBYDISPLAYNAME AS '070-ZCLDMAST.zimportedbydisplayname',
    -- hex(ZASSET.ZIMAGEREQUESTHINTS) AS '071-ZASSET.zimagerequesthints(hex path)',

    CASE ZASSET.ZSAVEDASSETTYPE
        WHEN 0 THEN 'Saved via other source [0]'
        WHEN 2 THEN 'Still Testing [1]'
        WHEN 1 THEN 'Still Testing [2]'
        WHEN 3 THEN 'Local Photo Library Asset [3]'
        WHEN 4 THEN 'Photo Cloud Sharing Data Asset [4]'
        WHEN 5 THEN 'PhotoBooth Photo Library Asset [5]'
        WHEN 6 THEN 'Cloud Photo Library Asset [6]'
        WHEN 7 THEN 'Still Testing [7]'
        WHEN 8 THEN 'iCloudLink Cloud Master Moment Asset [8]'
        WHEN 12 THEN 'SWY Syndication PL Asset/Auto Displayed in LPL [12]'
        ELSE 'Unknown Value: ' || ZASSET.ZSAVEDASSETTYPE || ''
    END AS '072-ZASSET.zsavedassettype(lpl)',

    CASE ZINTRESOU.ZDATASTORECLASSID
        WHEN 0 THEN 'LPL Asset CPL Asset [0]'
        WHEN 1 THEN 'Still Testing [1]'
        WHEN 2 THEN 'Photo Cloud Sharing Asset [2]'
        WHEN 3 THEN 'SWY Syndication Asset [3]'
        ELSE 'Unknown Value: ' || ZINTRESOU.ZDATASTORECLASSID || ''
    END AS '073-ZINTRESOU.zdatastoreclassid',

    CASE ZASSET.ZCLOUDPLACEHOLDERKIND
        WHEN 0 THEN 'Local & Cloud Master Asset [0]'
        WHEN 1 THEN 'Still Testing [1]'
        WHEN 2 THEN 'Still Testing [2]'
        WHEN 3 THEN '.JPG Asset Only PhDa/Thumb/V2 [3]'
        WHEN 4 THEN 'LPL .JPG Asset CPL Asset Other Type [4]'
        WHEN 5 THEN 'Asset synced CPL to Device [5]'
        WHEN 6 THEN 'Still Testing [6]'
        WHEN 7 THEN 'LPL poster JPG Asset CPL Asset .MP4 [7]'
        WHEN 8 THEN 'LPL .JPG Asset CPL Asset Live Photo .MOV [8]'
        WHEN 9 THEN 'CPL .MP4 Asset Saved to LPL [9]'
        ELSE 'Unknown Value: ' || ZASSET.ZCLOUDPLACEHOLDERKIND || ''
    END AS '074-ZASSET.zcloudplaceholderkind',

    CASE ZINTRESOU.ZLOCALAVAILABILITY
        WHEN -1 THEN 'IR Asset Not Avail Locally [-1]'
        WHEN 1 THEN 'IR Asset Avail Locally [1]'
        WHEN -32768 THEN 'IR Asset SWY Linked Asset [-32768]'
        ELSE 'Unknown Value: ' || ZINTRESOU.ZLOCALAVAILABILITY || ''
    END AS '075-ZINTRESOU.zlocalavailability',

    CASE ZINTRESOU.ZLOCALAVAILABILITYTARGET
        WHEN 0 THEN 'Still Testing [0]'
        ELSE 'Unknown Value: ' || ZINTRESOU.ZLOCALAVAILABILITYTARGET || ''
    END AS '076-ZINTRESOU.zlocalavailabilitytarget',

    CASE ZINTRESOU.ZCLOUDLOCALSTATE
        WHEN 0 THEN 'IR Asset Not Synced No IR CloudMastDateCreated [0]'
        WHEN 1 THEN 'IR Asset Pending Upload [1]'
        WHEN 2 THEN 'IR Asset Photo Cloud Share Asset On Local Device [2]'
        WHEN 3 THEN 'IR Asset Synced iCloud [3]'
        ELSE 'Unknown Value: ' || ZINTRESOU.ZCLOUDLOCALSTATE || ''
    END AS '077-ZINTRESOU.zcloudlocalstate',

    CASE ZINTRESOU.ZREMOTEAVAILABILITY
        WHEN 0 THEN 'IR Asset Not Avail Remotely [0]'
        WHEN 1 THEN 'IR Asset Avail Remotely [1]'
        ELSE 'Unknown Value: ' || ZINTRESOU.ZREMOTEAVAILABILITY || ''
    END AS '078-ZINTRESOU.zremoteavailability',

    CASE ZINTRESOU.ZREMOTEAVAILABILITYTARGET
        WHEN 0 THEN 'Still Testing [0]'
        WHEN 1 THEN 'Still Testing [1]'
        ELSE 'Unknown Value: ' || ZINTRESOU.ZREMOTEAVAILABILITYTARGET || ''
    END AS '079-ZINTRESOU.zremoteavailabilitytarget',

    ZINTRESOU.ZTRANSIENTCLOUDMASTER AS '080-ZINTRESOU.ztransientcloudmaster',
    ZINTRESOU.ZSIDECARINDEX AS '081-ZINTRESOU.zsidecarindex',
    ZINTRESOU.ZFILEID AS '082-ZINTRESOU.zfileid',

    CASE ZINTRESOU.ZVERSION
        WHEN 0 THEN 'IR Asset Standard [0]'
        WHEN 1 THEN 'Still Testing [1]'
        WHEN 2 THEN 'IR Asset Adjustments Mutation [2]'
        WHEN 3 THEN 'IR Asset No IR Cloud Master Date Created [3]'
        ELSE 'Unknown Value: ' || ZINTRESOU.ZVERSION || ''
    END AS '083-ZINTRESOU.zversion',

    printf("%,d", ZADDASSETADDRS.ZORIGINALFILESIZE) AS '084-ZADDASSETADDRS.zoriginalfilesize(bytes)',

    CASE ZINTRESOU.ZRESOURCETYPE
        WHEN 0 THEN 'Photo [0]'
        WHEN 1 THEN 'Video [1]'
        WHEN 3 THEN 'Live Photo [3]'
        WHEN 5 THEN 'HEIC with Adjustment Made Prior to Capture [5]'
        WHEN 6 THEN 'Screenshot [6]'
        WHEN 9 THEN 'Alternate Photo 3rd Party App (Still Testing) [9]'
        WHEN 13 THEN 'Movie [13]'
        WHEN 14 THEN 'Wallpaper [14]'
        ELSE 'Unknown Value: ' || ZINTRESOU.ZRESOURCETYPE || ''
    END AS '085-ZINTRESOU.zresourcetype',

    -- hex(ZINTRESOU.ZDATASTOREKEYDATA) AS '086-ZINTRESOU.zdatastorekeydata(hex)',

    CASE ZINTRESOU.ZDATASTORESUBTYPE
        WHEN 0 THEN '0 [No Cloud Inter Resource]'
        WHEN 1 THEN '1 [Main Asset Orig Size]'
        WHEN 2 THEN '2 [Photo with Adjustments]'
        WHEN 3 THEN '3 [.JPG Large Thumb]'
        WHEN 4 THEN '4 [.JPG Med Thumb]'
        WHEN 5 THEN '5 [.JPG Small Thumb]'
        WHEN 6 THEN '6 [Video Med Data]'
        WHEN 7 THEN '7 [Video Small Data]'
        WHEN 8 THEN '8 [.MP4 Cloud Share]'
        WHEN 9 THEN '9 [Still Testing]'
        WHEN 10 THEN '10 [3rd Party App thumb (Still Testing)]'
        WHEN 11 THEN '11 [Still Testing]'
        WHEN 12 THEN '12 [Still Testing]'
        WHEN 13 THEN '13 [.PNG Optimized CPL Asset]'
        WHEN 14 THEN '14 [Wallpaper]'
        WHEN 15 THEN '15 [Has Markup and Adjustments]'
        WHEN 16 THEN '16 [Video with Adjustments]'
        WHEN 17 THEN '17 [RAW Photo]'
        WHEN 18 THEN '18 [Live Photo Video Optimized CPL Asset]'
        WHEN 19 THEN '19 [Live Photo with Adjustments]'
        WHEN 20 THEN '20 [Still Testing]'
        WHEN 21 THEN '21 [.MOV Optimized HEVC 4K video]'
        WHEN 22 THEN '22 [Adjust Mutation AAE Asset]'
        WHEN 23 THEN '23 [Still Testing]'
        WHEN 24 THEN '24 [Still Testing]'
        WHEN 25 THEN '25 [Still Testing]'
        WHEN 26 THEN '26 [.MOV Optimized CPLAsset]'
        WHEN 27 THEN '27 [Still Testing]'
        WHEN 28 THEN '28 [.MOV Med HDR Data]'
        ELSE 'Unknown Value: ' || ZINTRESOU.ZDATASTORESUBTYPE || ''
    END AS '087-ZINTRESOU.zdatastoresubtype',

    CASE ZINTRESOU.ZCLOUDSOURCETYPE
        WHEN 0 THEN 'N/A [0]'
        WHEN 1 THEN 'Main Asset Orig Size [1]'
        WHEN 2 THEN 'Photo with Adjustments [2]'
        WHEN 3 THEN '.JPG Large Thumb [3]'
        WHEN 4 THEN '.JPG Med Thumb [4]'
        WHEN 5 THEN '.JPG Small Thumb [5]'
        WHEN 6 THEN 'Video Med Data [6]'
        WHEN 7 THEN 'Video Small Data [7]'
        WHEN 8 THEN '.MP4 Cloud Share [8]'
        WHEN 9 THEN 'Still Testing [9]'
        WHEN 10 THEN '[3rd Party App thumb (Still Testing) [10]'
        WHEN 11 THEN '[Still Testing [11]'
        WHEN 12 THEN '[Still Testing [12]'
        WHEN 13 THEN '[.PNG Optimized CPL Asset [13]'
        WHEN 14 THEN '[Wallpaper [14]'
        WHEN 15 THEN '[Has Markup and Adjustments [15]'
        WHEN 16 THEN '[Video with Adjustments [16]'
        WHEN 17 THEN '[RAW Photo [17]'
        WHEN 18 THEN '[Live Photo Video Optimized CPL Asset [18]'
        WHEN 19 THEN '[Live Photo with Adjustments [19]'
        WHEN 20 THEN '[Still Testing [20]'
        WHEN 21 THEN '[.MOV Optimized HEVC 4K video [21]'
        WHEN 22 THEN '[Adjust Mutation AAE Asset [22]'
        WHEN 23 THEN '[Still Testing [23]'
        WHEN 24 THEN '[Still Testing [24]'
        WHEN 25 THEN '[Still Testing [25]'
        WHEN 26 THEN '[.MOV Optimized CPLAsset [26]'
        WHEN 27 THEN '[Still Testing [27]'
        WHEN 28 THEN '[.MOV Med HDR Data [28]'
        ELSE 'Unknown Value: ' || ZINTRESOU.ZCLOUDSOURCETYPE || ''
    END AS '088-ZINTRESOU.zcloudsourcetype',

    ZINTRESOU.ZDATALENGTH AS '089-ZINTRESOU.zdatalength',

    CASE ZINTRESOU.ZRECIPEID
        WHEN 0 THEN '0 [Orig File Size match Data Length or Optimized]'
        WHEN 65737 THEN '65737 [Full .JPG Orig ProRAW DNG]'
        WHEN 65739 THEN '65739 [.JPG Large Thumb]'
        WHEN 65741 THEN '65741 [Various Asset Types or Thumbs]'
        WHEN 65743 THEN '65743 [ResouType Photo 5003 or 5005 .JPG Thumb]'
        WHEN 65749 THEN '65749 [LocalVideoKeyFrame .JPG Thumb]'
        WHEN 65938 THEN '65938 [FullSizeRender Photo or .plist]'
        WHEN 131072 THEN '131072 [FullSizeRender Video or .plist]'
        WHEN 131077 THEN '131077 [Medium .MOV HEVC 4K]'
        WHEN 131079 THEN '131079 [Medium .MP4 Adj Mutation Asset]'
        WHEN 131081 THEN '131081 [ResouType Video 5003 or 5005 .JPG Thumb]'
        WHEN 131272 THEN '131272 [FullSizeRender Video Live Photo Adj Mutation]'
        WHEN 131275 THEN '131275 [Medium .MOV LivePhoto]'
        WHEN 131277 THEN '131277 [No IR Asset LivePhoto iCloud Sync Asset]'
        WHEN 131475 THEN '131475 [Medium HDR .MOV]'
        WHEN 327683 THEN '327683 [.JPG Thumb for 3rd Party (Still Testing)]'
        WHEN 327687 THEN '627687 [Wallpaper Compute Resource]'
        ELSE 'Unknown Value: ' || ZINTRESOU.ZRECIPEID || ''
    END AS '090-ZINTRESOU.zrecipeid',

    CASE ZINTRESOU.ZCLOUDLASTPREFETCHDATE
        WHEN 0 THEN 'N/A [0]'
        ELSE datetime(ZINTRESOU.ZCLOUDLASTPREFETCHDATE + 978307200, 'UNIXEPOCH')
    END AS '091-ZINTRESOU.zcloudlastprefetchdate(utc)',

    ZINTRESOU.ZCLOUDPREFETCHCOUNT AS '092-ZINTRESOU.zcloudprefetchcount',

    datetime(ZINTRESOU.ZCLOUDLASTONDEMANDDOWNLOADDATE + 978307200, 'UNIXEPOCH') AS '093-ZINTRESOU.zcloudlastondemanddownloaddate(utc)',

    CASE ZINTRESOU.ZUTICONFORMANCEHINT
        WHEN 0 THEN 'N/A, Does not Conform [0]'
        WHEN 1 THEN 'UT Type Image [1]'
        WHEN 2 THEN 'UT Type Pro Raw Photo [2]'
        WHEN 3 THEN 'UT Type Movie [3]'
        ELSE 'Unknown Value: ' || ZINTRESOU.ZUTICONFORMANCEHINT || ''
    END AS '094-ZINTRESOU.zuticonformancehint',

    CASE ZINTRESOU.ZCOMPACTUTI
        WHEN 1 THEN '1 [.JPEG/.THM]'
        WHEN 3 THEN '3 [.HEIC]'
        WHEN 6 THEN '6 [.PNG]'
        WHEN 7 THEN '7 [Still Testing]'
        WHEN 9 THEN '9 [.DNG]'
        WHEN 23 THEN '23 [.JPEG/.HEIC/.mov]'
        WHEN 24 THEN '24 [.MPEG4]'
        WHEN 36 THEN '36 [Wallpaper]'
        WHEN 37 THEN '37 [Adj/Mutation Data]'
        ELSE 'Unknown Value: ' || ZINTRESOU.ZCOMPACTUTI || ''
    END AS '095-ZINTRESOU.zcompactuti',

    ZASSET.ZUNIFORMTYPEIDENTIFIER AS '096-ZASSET.zuniformtypeidentifier',
    ZASSET.ZORIGINALCOLORSPACE AS '097-ZASSET.zoriginalcolorspace',
    ZCLDMAST.ZUNIFORMTYPEIDENTIFIER AS '098-ZCLDMAST.zuniformtypeidentifier',

    CASE ZCLDMAST.ZFULLSIZEJPEGSOURCE
        WHEN 0 THEN 'Cloud Master .JPEG Source Video (Still Testing) [0]'
        WHEN 1 THEN 'Cloud Master .JPEG Source Other (Still Testing) [1]'
        ELSE 'Unknown Value: ' || ZCLDMAST.ZFULLSIZEJPEGSOURCE || ''
    END AS '099-ZCLDMAST.zfullsizejpegsource',

    CASE ZCLDMAST.ZCLOUDLOCALSTATE
        WHEN 0 THEN 'Not Synced with Cloud [0]'
        WHEN 1 THEN 'Pending Upload [1]'
        WHEN 2 THEN 'Still Testing [2]'
        WHEN 3 THEN 'Synced with Cloud [3]'
        ELSE 'Unknown Value: ' || ZCLDMAST.ZCLOUDLOCALSTATE || ''
    END AS '100-ZCLDMAST.zcloudlocalstate',

    datetime(ZCLDMAST.ZIMPORTDATE + 978307200, 'UNIXEPOCH') AS '101-ZCLDMAST.zimportdate(utc)',

    ZASSET.ZIMPORTSESSION AS '102-ZASSET.zimportsession',
    ZADDASSETADDRS.ZIMPORTSESSIONID AS '103-ZADDASSETADDRS.zimportsessionid',

    datetime(ZADDASSETADDRS.ZALTERNATEIMPORTIMAGEDATE + 978307200, 'UNIXEPOCH') AS '104-ZADDASSETADDRS.zalternateimportimagedate(utc)',

    ZCLDMAST.ZIMPORTSESSIONID AS '105-ZCLDMAST.zimportsessionid',

    datetime(ZASSET.ZCLOUDBATCHPUBLISHDATE + 978307200, 'UNIXEPOCH') AS '106-ZASSET.zcloudbatchpublishdate(utc)',
    datetime(ZASSET.ZCLOUDSERVERPUBLISHDATE + 978307200, 'UNIXEPOCH') AS '107-ZASSET.zcloudserverpublishdate(utc)',

    ZASSET.ZCLOUDDOWNLOADREQUESTS AS '108-ZASSET.zclouddownloadrequests',
    ZASSET.ZCLOUDBATCHID AS '109-ZASSET.zcloudbatchid',

    datetime(ZADDASSETADDRS.ZLASTUPLOADATTEMPTDATE + 978307200, 'UNIXEPOCH') AS '110-ZADDASSETADDRS.zlastuploadattemptdate(swy)(utc)',

    ZADDASSETADDRS.ZUPLOADATTEMPTS AS '111-ZADDASSETADDRS.zuploadattempts',

    CASE ZASSET.ZLATITUDE
        WHEN -180.0 THEN '[-180.0]'
        ELSE ZASSET.ZLATITUDE
    END AS '112-ZASSET.zlatitude',

    ZEXTATTR.ZLATITUDE AS '113-ZEXTATTR.zlatitude',

    CASE ZASSET.ZLONGITUDE
        WHEN -180.0 THEN '[-180.0]'
        ELSE ZASSET.ZLONGITUDE
    END AS '114-ZASSET.zlongitude',

    ZEXTATTR.ZLONGITUDE AS '115-ZEXTATTR.zlongitude',

    CASE ZADDASSETADDRS.ZGPSHORIZONTALACCURACY
        WHEN -1.0 THEN '[-1.0]'
        WHEN NULL THEN NULL
        ELSE ZADDASSETADDRS.ZGPSHORIZONTALACCURACY
    END AS '116-ZADDASSETADDRS.zgpshorizontalaccuracy',

    -- hex(ZASSET.ZLOCATIONDATA) AS '117-ZASSET.zlocationdata(hex)',
    -- ZADDASSETADDRS.ZREVERSELOCATIONDATA AS '118-ZADDASSETADDRS.zreverselocationdata(orig-asset, hex nskeyed .plist)',

    CASE ZADDASSETADDRS.ZSHIFTEDLOCATIONISVALID
        WHEN 0 THEN 'Shifted Location Not Valid [0]'
        WHEN 1 THEN 'Shifted Location Valid [1]'
    END AS '119-ZADDASSETADDRS.zshiftedlocationisvalid',

    ZADDASSETADDRS.ZSHIFTEDLOCATIONDATA AS '120-ZADDASSETADDRS.zshiftedlocationdata',
    ZADDASSETADDRS.ZLOCATIONHASH AS '121-ZADDASSETADDRS.zlocationhash',

    CASE AAAZCLDMASTMedData.Z_OPT
        WHEN 1 THEN '1 [Cloud (Still Testing)]'
        WHEN 2 THEN '2 [This Device (Still Testing)]'
        WHEN 3 THEN '3 [Muted (Still Testing)]'
        WHEN 4 THEN '4 [Unknown (Still Testing)]'
        WHEN 5 THEN '5 [Unknown (Still Testing)]'
        ELSE 'Unknown Value: ' || AAAZCLDMASTMedData.Z_OPT || ''
    END AS '122-AAAZCLDMASTMedData.z_opt',

    ZADDASSETADDRS.ZMEDIAMETADATATYPE AS '123-ZADDASSETADDRS.zmediametadatatype',
    -- hex(AAAZCLDMASTMedData.ZDATA) AS '124-AAAZCLDMASTMedData.zdata(hex)',

    CASE CMZCLDMASTMedData.Z_OPT
        WHEN 1 THEN '1 [Has Cloud Master Asset (Still Testing)]'
        WHEN 2 THEN '2 [Local Asset (Still Testing)]'
        WHEN 3 THEN '3 [Muted (Still Testing)]'
        WHEN 4 THEN '4 [Unknown (Still Testing)]'
        WHEN 5 THEN '5 [Unknown (Still Testing)]'
        ELSE 'Unknown Value: ' || CMZCLDMASTMedData.Z_OPT || ''
    END AS '125-CldMasterZCLDMASTMedData.z_opt',

    ZCLDMAST.ZMEDIAMETADATATYPE AS '126-ZCLDMAST.zmediametadatatype',
    -- hex(CMZCLDMASTMedData.ZDATA) AS '127-CMZCLDMASTMedData.zdata(hex)',

    CASE ZASSET.ZSEARCHINDEXREBUILDSTATE
        WHEN 0 THEN 'Still Testing [0]'
        ELSE 'Unknown Value: ' || ZASSET.ZSEARCHINDEXREBUILDSTATE || ''
    END AS '128-ZASSET.zsearchindexrebuildstate',

    CASE ZASSET.ZORIENTATION
        WHEN 1 THEN '1 [Video Default/Adjustment/Horizontal Camera (left)]'
        WHEN 2 THEN '2 [Horizontal Camera (right)]'
        WHEN 3 THEN '3 [Horizontal Camera (right)]'
        WHEN 4 THEN '4 [Horizontal Camera (left)]'
        WHEN 5 THEN '5 [Vertical Camera (top)]'
        WHEN 6 THEN '6 [Vertical Camera (top)]'
        WHEN 7 THEN '7 [Vertical Camera (bottom)]'
        WHEN 8 THEN '8 [Vertical Camera (bottom)]'
        ELSE 'Unknown Value: ' || ZASSET.ZORIENTATION || ''
    END AS '129-ZASSET.zorientation',

    CASE ZADDASSETADDRS.ZORIGINALORIENTATION
        WHEN 1 THEN '1 [Video Default/Adjustment/Horizontal Camera (left)]'
        WHEN 2 THEN '2 [Horizontal Camera (right)]'
        WHEN 3 THEN '3 [Horizontal Camera (right)]'
        WHEN 4 THEN '4 [Horizontal Camera (left)]'
        WHEN 5 THEN '5 [Vertical Camera (top)]'
        WHEN 6 THEN '6 [Vertical Camera (top)]'
        WHEN 7 THEN '7 [Vertical Camera (bottom)]'
        WHEN 8 THEN '8 [Vertical Camera (bottom)]'
        ELSE 'Unknown Value: ' || ZADDASSETADDRS.ZORIGINALORIENTATION || ''
    END AS '130-ZADDASSETADDRS.zoriginalorientation',

    CASE ZASSET.ZKIND
        WHEN 0 THEN 'Photo [0]'
        WHEN 1 THEN 'Video [1]'
    END AS '131-ZASSET.zkind',

    CASE ZASSET.ZKINDSUBTYPE
        WHEN 0 THEN 'Still Photo [0]'
        WHEN 2 THEN 'Live Photo [2]'
        WHEN 10 THEN 'SpringBoard Screenshot [10]'
        WHEN 100 THEN 'Video [100]'
        WHEN 101 THEN 'Slow-Mo Video [101]'
        WHEN 102 THEN 'Time-lapse Video [102]'
        WHEN 103 THEN 'Replay Screen Recording [103]'
        ELSE 'Unknown Value: ' || ZASSET.ZKINDSUBTYPE || ''
    END AS '132-ZASSET.zkindsubtype',

    CASE ZADDASSETADDRS.ZCLOUDKINDSUBTYPE
        WHEN 0 THEN 'Still Photo [0]'
        WHEN 1 THEN 'Still Testing [1]'
        WHEN 2 THEN 'Live Photo [2]'
        WHEN 3 THEN 'Screenshot [3]'
        WHEN 10 THEN 'SpringBoard Screenshot [10]'
        WHEN 100 THEN 'Video [100]'
        WHEN 101 THEN 'Slow-Mo Video [101]'
        WHEN 102 THEN 'Time-lapse Video [102]'
        WHEN 103 THEN 'Replay Screen Recording [103]'
        ELSE 'Unknown Value: ' || ZADDASSETADDRS.ZCLOUDKINDSUBTYPE || ''
    END AS '133-ZADDASSETADDRS.zcloudkindsubtype',

    CASE ZASSET.ZPLAYBACKSTYLE
        WHEN 1 THEN 'Image [1]'
        WHEN 2 THEN 'Image Animated [2]'
        WHEN 3 THEN 'Live Photo [3]'
        WHEN 4 THEN 'Video [4]'
        WHEN 5 THEN 'Video Looping [5]'
        ELSE 'Unknown Value: ' || ZASSET.ZPLAYBACKSTYLE || ''
    END AS '134-ZASSET.zplaybackstyle',

    ZASSET.ZPLAYBACKVARIATION AS '135-ZASSET.zplaybackvariation',
    ZASSET.ZDURATION AS '136-ZASSET.zduration',
    ZEXTATTR.ZDURATION AS '137-ZEXTATTR.zduration',
    -- Duration of the Live Photo in seconds
    ZASSET.ZVIDEOCPDURATIONVALUE AS '138-ZASSET.zvideocpdurationvalue',
    ZADDASSETADDRS.ZVIDEOCPDURATIONTIMESCALE AS '139-ZADDASSETADDRS.zvideocpdurationtimescale',
    ZASSET.ZVIDEOCPVISIBILITYSTATE AS '140-ZASSET.zvideocpvisibilitystate',
    ZADDASSETADDRS.ZVIDEOCPDISPLAYVALUE AS '141-ZADDASSETADDRS.zvideocpdisplayvalue',
    ZADDASSETADDRS.ZVIDEOCPDISPLAYTIMESCALE AS '142-ZADDASSETADDRS.zvideocpdisplaytimescale',

    -- [ZINTRESOU.ZASSET = ZASSET.Z_PK]
    ZINTRESOU.ZASSET AS '143-ZINTRESOU.zasset',
    ZINTRESOU.Z_PK AS '144-ZINTRESOU.z_pk',
    ZINTRESOU.Z_ENT AS '145-ZINTRESOU.z_ent',
    ZINTRESOU.Z_OPT AS '146-ZINTRESOU.z_opt',
    ZASSET.ZHDRGAIN AS '147-ZASSET.zhdrgain',

    CASE ZASSET.ZHDRTYPE
        WHEN 0 THEN 'No HDR [0]'
        WHEN 3 THEN 'HDR Photo [3]'
        WHEN 4 THEN 'Non HDR Version [4]'
        WHEN 5 THEN 'HEVC Movie [5]'
        WHEN 6 THEN 'Panorama [6]'
        WHEN 10 THEN 'HDR Gain [10]'
        ELSE 'Unknown Value: ' || ZASSET.ZHDRTYPE || ''
    END AS '148-ZASSET.zhdrtype',

    ZEXTATTR.ZCODEC AS '149-ZEXTATTR.zcodec',
    ZINTRESOU.ZCODECFOURCHARCODENAME AS '150-ZINTRESOU.zcodecfourcharcodename',
    ZCLDMAST.ZCODECNAME AS '151-ZCLDMAST.zcodecname',
    ZCLDMAST.ZVIDEOFRAMERATE AS '152-ZCLDMAST.zvideoframerate',
    ZCLDMAST.ZPLACEHOLDERSTATE AS '153-ZCLDMAST.zplaceholderstate',

    CASE ZASSET.ZDEPTHTYPE
        WHEN 0 THEN 'Not Portrait [0]'
        ELSE 'Portrait: ' || ZASSET.ZDEPTHTYPE || ''
    END AS '154-ZASSET.zdepthtype',

    ZASSET.ZAVALANCHEUUID AS '155-ZASSET.zavalancheuuid',

    CASE ZASSET.ZAVALANCHEPICKTYPE
        WHEN 0 THEN '0 [NA/Single Asset Burst UUID]'
        WHEN 2 THEN '2 [Burst Asset Not Selected]'
        WHEN 4 THEN '4 [Burst Asset PhotosApp Picked Key Image]'
        WHEN 8 THEN '8 [Burst Asset Selected for LPL]'
        WHEN 16 THEN '16 [Top Burst Asset inStack Key Image]'
        WHEN 32 THEN '32 [Still Testing]'
        WHEN 52 THEN '52 [Burst Asset Visible LPL]'
        ELSE 'Unknown Value: ' || ZASSET.ZAVALANCHEPICKTYPE || ''
    END AS '156-ZASSET.zavalanchepicktype',

    CASE ZADDASSETADDRS.ZCLOUDAVALANCHEPICKTYPE
        WHEN 0 THEN 'N/A / Single Asset Burst UUID [0]'
        WHEN 2 THEN 'Burst Asset Not Selected [2]'
        WHEN 4 THEN 'Burst Asset PhotosApp Picked Key Image [4]'
        WHEN 8 THEN 'Burst Asset Selected for LPL [8]'
        WHEN 16 THEN 'Top Burst Asset inStack Key Image [16]'
        WHEN 32 THEN 'Still Testing [32]'
        WHEN 52 THEN 'Burst Asset Visible LPL [52]'
        ELSE 'Unknown Value: ' || ZADDASSETADDRS.ZCLOUDAVALANCHEPICKTYPE || ''
    END AS '157-ZADDASSETADDRS.zcloudavalanchepicktype',

    CASE ZADDASSETADDRS.ZCLOUDRECOVERYSTATE
        WHEN 0 THEN 'Still Testing [0]'
        WHEN 1 THEN 'Still Testing [1]'
        ELSE 'Unknown Value: ' || ZADDASSETADDRS.ZCLOUDRECOVERYSTATE || ''
    END AS '158-ZADDASSETADDRS.zcloudrecoverystate',

    ZADDASSETADDRS.ZCLOUDSTATERECOVERYATTEMPTSCOUNT AS '159-ZADDASSETADDRS.zcloudstaterecoveryattemptscount',
    ZASSET.ZDEFERREDPROCESSINGNEEDED AS '160-ZASSET.zdeferredprocessingneeded',
    ZASSET.ZVIDEODEFERREDPROCESSINGNEEDED AS '161-ZASSET.zvideodeferredprocessingneeded',
    ZADDASSETADDRS.ZDEFERREDPHOTOIDENTIFIER AS '162-ZADDASSETADDRS.zdeferredphotoidentifier',
    ZADDASSETADDRS.ZDEFERREDPROCESSINGCANDIDATEOPTIONS AS '163-ZADDASSETADDRS.zdeferredprocessingcandidateoptions',

    -- CASE ZASSET.ZHASADJUSTMENTS
    --     WHEN 0 THEN 'No [0]'
    --     WHEN 1 THEN 'Yes [1]'
    --     ELSE 'Unknown Value: ' || ZASSET.ZHASADJUSTMENTS || ''
    -- END AS '164-ZASSET.zhasadjustments',

    -- [ZUNMADJ.ZASSETATTRIBUTES = ZADDASSETADDRS.Z_PK]
    ZUNMADJ.ZASSETATTRIBUTES AS '165-ZUNMADJ.zassetattributes',
    -- [ZADDASSETADDRS.ZUNMANAGEDADJUSTMENT = ZUNMADJ.Z_PK]
    ZADDASSETADDRS.ZUNMANAGEDADJUSTMENT AS '166-ZADDASSETADDRS.zunmanagedadjustment',
    -- [ZUNMADJ.Z_PK = ZADDASSETADDRS.ZUNMANAGEDADJUSTMENT]
    ZUNMADJ.Z_PK AS '167-ZUNMADJ.z_pk',
    ZUNMADJ.ZUUID AS '168-ZUNMADJ.uuid',

    datetime(ZASSET.ZADJUSTMENTTIMESTAMP + 978307200, 'UNIXEPOCH') AS '169-ZASSET.zadjustmenttimestamp(utc)',
    datetime(ZUNMADJ.ZADJUSTMENTTIMESTAMP + 978307200, 'UNIXEPOCH') AS '170-ZUNMADJ.zadjustmenttimestamp(utc)',

    ZADDASSETADDRS.ZEDITORBUNDLEID AS '171-ZADDASSETADDRS.zeditorbundleid',
    ZUNMADJ.ZEDITORLOCALIZEDNAME AS '172-ZUNMADJ.zeditorlocalizedname',
    ZUNMADJ.ZADJUSTMENTFORMATIDENTIFIER AS '173-ZUNMADJ.zadjustmentformatidentifier',
    ZADDASSETADDRS.ZMONTAGE AS '174-ZADDASSETADDRS.zmontage',

    CASE ZUNMADJ.ZADJUSTMENTRENDERTYPES
        WHEN 0 THEN 'Standard or Portrait with errors [0]'
        WHEN 1 THEN 'Still Testing [1]'
        WHEN 2 THEN 'Portrait [2]'
        WHEN 3 THEN 'Still Testing [3]'
        WHEN 4 THEN 'Still Testing [4]'
        ELSE 'Unknown Value: ' || ZUNMADJ.ZADJUSTMENTRENDERTYPES || ''
    END AS '175-ZUNMADJ.zadjustmentrendertypes',

    CASE ZUNMADJ.ZADJUSTMENTFORMATVERSION
        WHEN 1.0 THEN 'Markup [1.0]'
        WHEN 1.1 THEN 'Slow-Mo [1.1]'
        WHEN 1.2 THEN 'Still Testing [1.2]'
        WHEN 1.3 THEN 'Still Testing [1.3]'
        WHEN 1.4 THEN 'Filter [1.4]'
        WHEN 1.5 THEN 'Adjust [1.5]'
        WHEN 1.6 THEN 'Video Trim [1.6]'
        WHEN 1.7 THEN 'Still Testing [1.7]'
        WHEN 1.8 THEN 'Still Testing [1.8]'
        WHEN 1.9 THEN 'Still Testing [1.9]'
        WHEN 2.0 THEN 'Screenshot Services [2.0]'
        ELSE 'Unknown Value: ' || ZUNMADJ.ZADJUSTMENTFORMATVERSION || ''
    END AS '176-ZUNMADJ.zadjustmentformatversion',

    ZUNMADJ.ZADJUSTMENTBASEIMAGEFORMAT AS '177-ZUNMADJ.zadjustmentbaseimageformat',

    CASE ZASSET.ZFAVORITE
        WHEN 0 THEN 'Not Favorite [0]'
        WHEN 1 THEN 'Favorite [1]'
    END AS '178-ZASSET.zfavorite',

    CASE ZASSET.ZHIDDEN
        WHEN 0 THEN 'Not Hidden [0]'
        WHEN 1 THEN 'Hidden [1]'
        ELSE 'Unknown Value: ' || ZASSET.ZHIDDEN || ''
    END AS '179-ZASSET.zhidden',

    CASE ZASSET.ZTRASHEDSTATE
        WHEN 0 THEN 'Not In Trash/Recently Deleted [0]'
        WHEN 1 THEN 'In Trash/Recently Deleted [1]'
        ELSE 'Unknown Value: ' || ZASSET.ZTRASHEDSTATE || ''
    END AS '180-ZASSET.ztrashedstate (local asset recently deleted)',

    datetime(ZASSET.ZTRASHEDDATE + 978307200, 'UNIXEPOCH') AS '181-ZASSET.ztrasheddate(utc)',

    CASE ZASSET.ZDELETEREASON
        WHEN 1 THEN 'Delete Reason (Still Testing) [1]'
        WHEN 2 THEN 'Delete Reason (Still Testing) [2]'
        WHEN 3 THEN 'Delete Reason (Still Testing) [3]'
        ELSE 'Unknown Value: ' || ZASSET.ZDELETEREASON || ''
    END AS '182-ZASSET.zdeletereason',

    CASE ZASSET.ZTRASHEDBYPARTICIPANT
        WHEN 1 THEN 'Trashed/Recently Deleted by Participant [1]'
        ELSE 'Unknown Value: ' || ZASSET.ZTRASHEDBYPARTICIPANT || ''
    END AS '183-ZASSET.ztrashedbyparticipant',

    CASE ZINTRESOU.ZTRASHEDSTATE
        WHEN 0 THEN 'INTRESOU Not In Trash/Recently Deleted [0]'
        WHEN 1 THEN 'INTRESOU In Trash/Recently Deleted [1]'
        ELSE 'Unknown Value: ' || ZINTRESOU.ZTRASHEDSTATE || ''
    END AS '184-ZINTRESOU.ztrashedstate',

    datetime(ZINTRESOU.ZTRASHEDDATE + 978307200, 'UNIXEPOCH') AS '185-ZINTRESOU.ztrasheddate(utc)',

    CASE ZASSET.ZCLOUDDELETESTATE
        WHEN 0 THEN 'CLOUD Asset Not Deleted [0]'
        WHEN 1 THEN 'CLOUD Asset Deleted [1]'
        ELSE 'Unknown Value: ' || ZASSET.ZCLOUDDELETESTATE || ''
    END AS '186-ZASSET.zclouddeletestate',

    CASE ZINTRESOU.ZCLOUDDELETESTATE
        WHEN 0 THEN 'CLOUD IntResou Not Deleted [0]'
        WHEN 1 THEN 'CLOUD IntResou Deleted [1]'
        ELSE 'Unknown Value: ' || ZINTRESOU.ZCLOUDDELETESTATE || ''
    END AS '187-ZINTRESOU.zclouddeletestate',

    CASE ZADDASSETADDRS.ZPTPTRASHEDSTATE
        WHEN 0 THEN 'PTP Not in Trash [0]'
        WHEN 1 THEN 'PTP In Trash [1]'
        ELSE 'Unknown Value: ' || ZADDASSETADDRS.ZPTPTRASHEDSTATE || ''
    END AS '188-ZADDASSETADDRS.zptptrashedstate',

    CASE ZINTRESOU.ZPTPTRASHEDSTATE
        WHEN 0 THEN 'PTP IntResou Not in Trash [0]'
        WHEN 1 THEN 'PTP IntResou In Trash [1]'
        ELSE 'Unknown Value: ' || ZINTRESOU.ZPTPTRASHEDSTATE || ''
    END AS '189-ZINTRESOU.zptptrashedstate',

    ZINTRESOU.ZCLOUDDELETEASSETUUIDWITHRESOURCETYPE AS '190-ZINTRESOU.zclouddeleteassetuuidwithresourcetype',

    datetime(ZMEDANLYASTATTR.ZMEDIAANALYSISTIMESTAMP + 978307200, 'UNIXEPOCH') AS '191-ZMEDANLYASTATTR.zmediaanalysistimestamp(utc)',
    datetime(ZASSET.ZANALYSISSTATEMODIFICATIONDATE + 978307200, 'UNIXEPOCH') AS '192-ZASSET.zanalysisstatemodificationdate(utc)',

    ZADDASSETADDRS.ZPENDINGVIEWCOUNT AS '193-ZADDASSETADDRS.zpendingviewcount',
    ZADDASSETADDRS.ZVIEWCOUNT AS '194-ZADDASSETADDRS.zviewcount',
    ZADDASSETADDRS.ZPENDINGPLAYCOUNT AS '195-ZADDASSETADDRS.zpendingplaycount',
    ZADDASSETADDRS.ZPLAYCOUNT AS '196-ZADDASSETADDRS.zplaycount',
    ZADDASSETADDRS.ZPENDINGSHARECOUNT AS '197-ZADDASSETADDRS.zpendingsharecount',
    ZADDASSETADDRS.ZSHARECOUNT AS '198-ZADDASSETADDRS.zsharecount',

    datetime(ZASSET.ZLASTSHAREDDATE + 978307200, 'UNIXEPOCH') AS '199-ZASSET.zlastshareddate(utc)',

    ZADDASSETADDRS.ZSHAREORIGINATOR AS '200-ZADDASSETADDRS.zshareoriginator',

    CASE ZASSET.ZSYNDICATIONSTATE
        WHEN 0 THEN 'Local PL Asset Syndication State NA [0]'
        ELSE 'Unknown Value: ' || ZASSET.ZSYNDICATIONSTATE || ''
    END AS '201-ZASSET.zsyndicationstate(lpl)',

    ZADDASSETADDRS.ZSYNDICATIONHISTORY AS '202-ZADDASSETADDRS.zsyndicationhistory',
    ZMEDANLYASTATTR.ZSYNDICATIONPROCESSINGVERSION AS '203-ZMEDANLYASTATTR.zsyndicationprocessingversion',

    CASE ZMEDANLYASTATTR.ZSYNDICATIONPROCESSINGVALUE
        WHEN 0 THEN 'N/A [0]'
        WHEN 1 THEN 'Wide Camera JPG (Still Testing) [1]'
        WHEN 2 THEN 'Telephoto Camera Lens (Still Testing) [2]'
        WHEN 4 THEN 'SWY Asset Orig Asset Import System Package App (Still Testing) [4]'
        WHEN 16 THEN 'Still Testing [16]'
        WHEN 1024 THEN 'SWY Asset OrigAssetImport Native Camera (Still Testing) [1024]'
        WHEN 2048 THEN 'Still Testing [2048]'
        WHEN 4096 THEN 'SWY Asset Manually Saved (Still Testing) [4096]'
        ELSE 'Unknown Value: ' || ZMEDANLYASTATTR.ZSYNDICATIONPROCESSINGVALUE || ''
    END AS '204-ZMEDANLYASTATTR.zsyndicationprocessingvalue',

    datetime(ZMEDANLYASTATTR.ZVAANALYSISTIMESTAMP + 978307200, 'UNIXEPOCH') AS '205-ZMEDANLYASTATTR.zvaanalysistimestamp(utc)',

    ZMEDANLYASTATTR.ZVAANALYSISVERSION AS '206-ZMEDANLYASTATTR.zvaanalysisversion',

    CASE ZADDASSETADDRS.ZALLOWEDFORANALYSIS
        WHEN 0 THEN 'Asset Not Allowed For Analysis [0]'
        WHEN 1 THEN 'Asset Allowed for Analysis [1]'
        ELSE 'Unknown Value: ' || ZADDASSETADDRS.ZALLOWEDFORANALYSIS || ''
    END AS '207-ZADDASSETADDRS.zallowedforanalysis',

    ZADDASSETADDRS.ZSCENEANALYSISVERSION AS '208-ZADDASSETADDRS.zsceneanalysisversion',

    CASE ZADDASSETADDRS.ZSCENEANALYSISISFROMPREVIEW
        WHEN 0 THEN 'No [0]'
        ELSE 'Unknown Value: ' || ZADDASSETADDRS.ZSCENEANALYSISISFROMPREVIEW || ''
    END AS '209-ZADDASSETADDRS.zsceneanalysisisfrompreview',

    datetime(ZADDASSETADDRS.ZSCENEANALYSISTIMESTAMP + 978307200, 'UNIXEPOCH') AS '210-ZADDASSETADDRS.zsceneanalysistimestamp(utc)',

    CASE ZASSET.ZDUPLICATEASSETVISIBILITYSTATE
        WHEN 0 THEN 'No Duplicates [0]'
        WHEN 1 THEN 'Has Duplicate [1]'
        WHEN 2 THEN 'Is a Duplicate [2]'
        ELSE 'Unknown Value: ' || ZASSET.ZDUPLICATEASSETVISIBILITYSTATE || ''
    END AS '211-ZASSET.zduplicateassetvisibilitystate',

    CASE ZADDASSETADDRS.ZDESTINATIONASSETCOPYSTATE
        WHEN 0 THEN 'No Copy [0]'
        WHEN 1 THEN 'Has A Copy [1]'
        WHEN 2 THEN 'Has A Copy [2]'
        ELSE 'Unknown Value: ' || ZADDASSETADDRS.ZDESTINATIONASSETCOPYSTATE || ''
    END AS '212-ZADDASSETADDRS.zdestinationassetcopystate',

    -- hex(ZSCENEP.ZDATA) AS '213-ZSCENEP.zdata (hex nskeyed .plist)',
    -- hex(ZSCENEP.ZDUPLICATEMATCHINGDATA) AS '214-ZSCENEP.zduplicatematchingdata (hex nskeyed .plist)',
    -- hex(ZSCENEP.ZDUPLICATEMATCHINGALTERNATEDATA) AS '215-ZSCENEP.zduplicatematchingalternatedata (hex nskeyed .plist)',
    ZADDASSETADDRS.ZSOURCEASSETFORDUPLICATIONSCOPEIDENTIFIER AS '216-ZADDASSETADDRS.zsourceassetforduplicationscopeidentifier',
    ZCLDMAST.ZSOURCEMASTERFORDUPLICATIONSCOPEIDENTIFIER AS '217-ZCLDMAST.zsourcemasterforduplicationscopeidentifier',
    ZADDASSETADDRS.ZSOURCEASSETFORDUPLICATIONIDENTIFIER AS '218-ZADDASSETADDRS.zsourceassetforduplicationidentifier',
    ZCLDMAST.ZSOURCEMASTERFORDUPLICATIONIDENTIFIER AS '219-ZCLDMAST.zsourcemasterforduplicationidentifier',
    ZEXTATTR.Z_ENT AS '220-ZEXTATTR.z_ent',
    ZEXTATTR.Z_OPT AS '221-ZEXTATTR.z_opt',
    ZADDASSETADDRS.ZVARIATIONSUGGESTIONSTATES AS '222-ZADDASSETADDRS.zvariationsuggestionstates',
    ZASSET.ZHIGHFRAMERATESTATE AS '223-ZASSET.zhighframeratestate',
    ZASSET.ZVIDEOKEYFRAMETIMESCALE AS '224-ZASSET.zvideokeyframetimescale',
    ZASSET.ZVIDEOKEYFRAMEVALUE AS '225-ZASSET.zvideokeyframevalue',
    ZEXTATTR.ZISO AS '226-ZEXTATTR.ziso',
    ZEXTATTR.ZMETERINGMODE AS '227-ZEXTATTR.zmeteringmode',
    ZEXTATTR.ZSAMPLERATE AS '228-ZEXTATTR.zsamplerate',
    ZEXTATTR.ZTRACKFORMAT AS '229-ZEXTATTR.ztrackformat',
    ZEXTATTR.ZWHITEBALANCE AS '230-ZEXTATTR.zwhitebalance',
    ZEXTATTR.ZASSET AS '231-ZEXTATTR.zasset',
    ZEXTATTR.ZAPERTURE AS '232-ZEXTATTR.zaperture',
    ZEXTATTR.ZBITRATE AS '233-ZEXTATTR.zbitrate',
    ZEXTATTR.ZEXPOSUREBIAS AS '234-ZEXTATTR.zexposurebias',
    ZEXTATTR.ZFPS AS '235-ZEXTATTR.zfps',
    ZEXTATTR.ZSHUTTERSPEED AS '236-ZEXTATTR.zshutterspeed',
    ZEXTATTR.ZSLUSHSCENEBIAS AS '237-ZEXTATTR.zslushscenebias',
    ZEXTATTR.ZSLUSHVERSION AS '238-ZEXTATTR.zslushversion',
    ZEXTATTR.ZSLUSHPRESET AS '239-ZEXTATTR.zslushpreset',
    ZEXTATTR.ZSLUSHWARMTHBIAS AS '240-ZEXTATTR.zslushwarmthbias',
    ZASSET.ZHEIGHT AS '241-ZASSET.zheight',
    ZADDASSETADDRS.ZORIGINALHEIGHT AS '242-ZADDASSETADDRS.zoriginalheight',
    ZINTRESOU.ZUNORIENTEDHEIGHT AS '243-ZINTRESOU.zunorientedheight',
    ZASSET.ZWIDTH AS '244-ZASSET.zwidth',
    ZADDASSETADDRS.ZORIGINALWIDTH AS '245-ADDASSETATTR.zoriginalwidth',
    ZINTRESOU.ZUNORIENTEDWIDTH AS '246-ZINTRESOU.zunorientedwidth',
    ZSHARE.ZTHUMBNAILIMAGEDATA AS '247-ZSHARE.zthumbnailimagedata',
    ZASSET.ZTHUMBNAILINDEX AS '248-ZASSET.zthumbnailindex',
    ZADDASSETADDRS.ZEMBEDDEDTHUMBNAILHEIGHT AS '249-ZADDASSETADDRS.zembeddedthumbnailheight',
    ZADDASSETADDRS.ZEMBEDDEDTHUMBNAILLENGTH AS '250-ZADDASSETADDRS.zembeddedthumbnaillength',
    ZADDASSETADDRS.ZEMBEDDEDTHUMBNAILOFFSET AS '251-ZADDASSETADDRS.zembeddedthumbnailoffset',
    ZADDASSETADDRS.ZEMBEDDEDTHUMBNAILWIDTH AS '252-ZADDASSETADDRS.zembeddedthumbnailwidth',
    ZASSET.ZPACKEDACCEPTABLECROPRECT AS '253-ZASSET.zpackedacceptablecroprect',
    ZASSET.ZPACKEDBADGEATTRIBUTES AS '254-ZASSET.zpackedbadgeattributes',
    ZASSET.ZPACKEDPREFERREDCROPRECT AS '255-ZASSET.zpackedpreferredcroprect',
    ZASSET.ZCURATIONSCORE AS '256-ZASSET.zcurationscore',
    ZASSET.ZCAMERAPROCESSINGADJUSTMENTSTATE AS '257-ZASSET.zcameraprocessingadjustmentstate',
    ZASSET.ZDEPTHTYPE AS '258-ZASSET.zdepthtype',
    ZASSET.ZISMAGICCARPET AS '259-ZASSET.zismagiccarpet',
    ZASSET.ZLIBRARYSCOPE AS '260-ZASSET.zlibraryscope',

    CASE ZASSET.ZLIBRARYSCOPESHARESTATE
        WHEN 0 THEN 'Not Shared (Still Testing) [0]'
        ELSE 'Unknown Value: ' || ZASSET.ZLIBRARYSCOPESHARESTATE || ''
    END AS '261-ZASSET.zlibraryscopesharestate',

    ZADDASSETADDRS.ZORIGINALRESOURCECHOICE AS '262-ZADDASSETADDRS.zoriginalresourcechoice',
    ZADDASSETADDRS.ZSPATIALOVERCAPTUREGROUPIDENTIFIER AS '263-ZADDASSETADDRS.zspatialovercapturegroupidentifier',
    -- hex(ZADDASSETADDRS.ZOBJECTSALIENCYRECTSDATA) AS '264-ZADDASSETADDRS.ZOBJECTSALIENCYRECTSDATA(HEX NSKeyed .plist)',
    -- hex(ZADDASSETADDRS.ZORIGINALHASH) AS '265-ZADDASSETADDRS.ZORIGINALHASH(HEX)',
    ZADDASSETADDRS.ZPLACEANNOTATIONDATA AS '266-ZADDASSETADDRS.zplaceannotationdata',
    ZADDASSETADDRS.ZDISTANCEIDENTITY AS '267-ZADDASSETADDRS.zdistanceidentity'


FROM ZASSET

    LEFT JOIN ZADDITIONALASSETATTRIBUTES ZADDASSETADDRS ON ZADDASSETADDRS.Z_PK = ZASSET.ZADDITIONALATTRIBUTES
    LEFT JOIN ZEXTENDEDATTRIBUTES ZEXTATTR ON ZEXTATTR.Z_PK = ZASSET.ZEXTENDEDATTRIBUTES
    LEFT JOIN ZINTERNALRESOURCE ZINTRESOU ON ZINTRESOU.ZASSET = ZASSET.Z_PK
    LEFT JOIN ZSCENEPRINT ZSCENEP ON ZSCENEP.Z_PK = ZADDASSETADDRS.ZSCENEPRINT
    LEFT JOIN Z_30ASSETS ON Z_30ASSETS.Z_3ASSETS = ZASSET.Z_PK
    LEFT JOIN ZGENERICALBUM ZGENALBUM ON ZGENALBUM.Z_PK = Z_30ASSETS.Z_30ALBUMS
    LEFT JOIN ZUNMANAGEDADJUSTMENT ZUNMADJ ON ZADDASSETADDRS.ZUNMANAGEDADJUSTMENT = ZUNMADJ.Z_PK
    LEFT JOIN Z_29ALBUMLISTS ON Z_29ALBUMLISTS.Z_29ALBUMS = ZGENALBUM.Z_PK
    LEFT JOIN ZALBUMLIST ON ZALBUMLIST.Z_PK = Z_29ALBUMLISTS.Z_2ALBUMLISTS
    LEFT JOIN ZGENERICALBUM ParentZGENALBUM ON ParentZGENALBUM.Z_PK = ZGENALBUM.ZPARENTFOLDER
    LEFT JOIN ZCLOUDMASTER ZCLDMAST ON ZASSET.ZMASTER = ZCLDMAST.Z_PK
    LEFT JOIN ZCLOUDMASTERMEDIAMETADATA AAAZCLDMASTMedData ON AAAZCLDMASTMedData.Z_PK = ZADDASSETADDRS.ZMEDIAMETADATA
    LEFT JOIN ZCLOUDMASTERMEDIAMETADATA CMZCLDMASTMedData ON CMZCLDMASTMedData.Z_PK = ZCLDMAST.ZMEDIAMETADATA
    LEFT JOIN ZMEDIAANALYSISASSETATTRIBUTES ZMEDANLYASTATTR ON ZASSET.ZMEDIAANALYSISATTRIBUTES = ZMEDANLYASTATTR.Z_PK
    LEFT JOIN ZSHARE ON ZSHARE.Z_PK = ZASSET.ZMOMENTSHARE


WHERE
    ZASSET.ZFILENAME IS 'IMG_8224.MOV' OR
    ZASSET.ZFILENAME IS 'IMG_8225.MP4' OR
    ZASSET.ZFILENAME IS '3e2cb810d62ecf8e429185a184abe84c' OR
    ZASSET.ZFILENAME IS 'd9cadb7c7196c06cf0eda7b3d2f3c94a' OR
    ZASSET.ZFILENAME IS '6EB3A423-E433-40E8-A03A-5C807423D008.mp4'


ORDER BY ZASSET.ZADDEDDATE
