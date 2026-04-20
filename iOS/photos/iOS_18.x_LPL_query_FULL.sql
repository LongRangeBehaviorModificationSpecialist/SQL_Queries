/*
[DLU]
    17-Apr-2026

[NOTES]
    Modified from original iOS 15 query copied from: https://github.com/ScottKjr3347/iOS_Local_PL_Photos.sqlite_Queries/blob/main/iOS15/Previous_Queries/iOS15_LPL_Phsql_Basic.txt
*/

SELECT

    ROW_NUMBER() OVER() AS '001-record_number',

    ZASSET.ZDIRECTORY AS '002-ZASSET.zdirectory',
    ZASSET.ZFILENAME AS '003-ZASSET.zfilename',
    ZADDASSETATTRS.ZORIGINALFILENAME AS '004-ZADDASSETATTRS.zoriginalfilename',
    ZCLDMAST.ZORIGINALFILENAME AS '005-ZCLDMAST.zoriginalfilename',
    ZADDASSETATTRS.ZSYNDICATIONIDENTIFIER AS '006-ZADDASSETATTRS.zsyndicationidentifier',

    datetime(ZASSET.ZADDEDDATE + 978307200, 'UNIXEPOCH') AS '007-ZASSET.zaddeddate(utc)',

    ZASSET.ZSORTTOKEN AS '008-ZASSET.zsorttoken',
    ZASSET.ZPROMOTIONSCORE AS '009-ZASSET.zpromotionscore',

    CASE ZASSET.ZCOMPLETE
        WHEN 1 THEN 'Yes [1]'
        ELSE ZASSET.ZCOMPLETE
    END AS '010-ZASSET.zcomplete',

    ZASSET.Z_PK AS '011-ZASSET.z_pk',
    ZADDASSETATTRS.Z_PK AS '012-ZADDASSETATTRS.z_pk',

    -- [ZCLDMAST.Z_PK = ZASSET.Z_MASTER]
    ZCLDMAST.Z_PK AS '013-ZCLDMAST.z_pk',

    -- [ZASSET.ZMASTER = ZCLDMAST.Z_PK]
    ZASSET.ZMASTER AS '014-ZASSET.zmaster',

    -- [ZASSET.EXTDATTR = ZEXTATTR.Z_PK]
    ZASSET.ZEXTENDEDATTRIBUTES AS '015-ZASSET.zextendedattributes',
    ZEXTATTR.Z_PK AS '016-ZEXTATTR.z_pk',

    -- [CMZCLDMASTMEDDATA.ZCLOUDMASTER = ZCLDMAST.Z_PK]
    CMZCLDMASTMedData.ZCLOUDMASTER AS '017-CMZCLDMASTMEDDATA.zcloudmaster',

    -- [ZCLDMAST.ZMEDIAMETADATA = ZCLDMASTMEDDATA.Z_PK]
    ZCLDMAST.ZMEDIAMETADATA AS '018-ZCLDMAST.zmediametadata',

    -- [CMZCLDMASTMEDDATA.Z_PK = ZADDASSETATTRS&ZCLDMAST.ZMEDIAMETADATA]
    CMZCLDMASTMedData.Z_PK AS '019-CMZCLDMASTMEDDATA.z_pk',

    CMZCLDMASTMedData.Z_ENT AS '020-CMZCLDMASTMEDDATA.z_ent',
    ZASSET.ZUUID AS '021-ZASSET.zuuid',

    -- This value will be the same on two different devices if the asset was synced via iCloud
    ZASSET.ZCLOUDASSETGUID AS '022-ZASSET.zcloudassetguid',
    ZASSET.ZCLOUDCOLLECTIONGUID AS '023-ZASSET.zcloudcollectguid',

    -- This value will be the same on two different devices if the asset was synced via iCloud
    ZCLDMAST.ZCLOUDMASTERGUID AS '024-ZCLDMAST.zcloudmasterguid',
    ZGENALBUM.ZCLOUDGUID AS '025-ZGENALBUM.zcloudguid',
    ZSHARE.ZSCOPEIDENTIFIER AS '026-ZSHARE.zscopeidentifier',
    ZADDASSETATTRS.ZORIGINALASSETSUUID AS '027-ZADDASSETATTRS.zoriginalassetsuuid',
    ZADDASSETATTRS.ZPUBLICGLOBALUUID AS '028-ZADDASSETATTRS.zpublicglobaluuid',
    ZADDASSETATTRS.ZORIGINATINGASSETIDENTIFIER AS '029-ZADDASSETATTRS.zoriginatingassetidentifier',
    ZCLDMAST.ZORIGINATINGASSETIDENTIFIER AS '030-ZCLDMAST.zoriginatingassetidentifier',

    CASE ZADDASSETATTRS.ZDATECREATEDSOURCE
        WHEN 0 THEN 'Cloud Asset [0]'
        WHEN 1 THEN 'Local Asset w/ EXIF [1]'
        WHEN 3 THEN 'Local Asset No EXIF [3]'
        ELSE 'Unknown Value: ' || ZADDASSETATTRS.ZDATECREATEDSOURCE || ''
    END AS '031-ZADDASSETATTRS.zdatecreatedsource',

    datetime(ZASSET.ZDATECREATED + 978307200, 'UNIXEPOCH') AS '032-ZASSET.zdatecreated(utc)',
    datetime(ZCLDMAST.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS '033-ZCLDMAST.zcreationdate(utc)',
    datetime(ZINTRESOU.ZCLOUDMASTERDATECREATED + 978307200, 'UNIXEPOCH') AS '034-ZINTRESOU.zcloudmasterdatecreated(utc)',

    ZADDASSETATTRS.ZTIMEZONENAME AS '035-ZADDASSETATTRS.ztimezonename',
    ZADDASSETATTRS.ZTIMEZONEOFFSET AS '036-ZADDASSETATTRS.ztimezoneoffset',
    ZADDASSETATTRS.ZINFERREDTIMEZONEOFFSET AS '037-ZADDASSETATTRS.zinferredtimezoneoffset',
    ZADDASSETATTRS.ZEXIFTIMESTAMPSTRING AS '038-ZADDASSETATTRS.zexiftimestampstring',

    datetime(ZASSET.ZMODIFICATIONDATE + 978307200, 'UNIXEPOCH') AS '039-ZASSET.zmodificationdate(utc)',
    datetime(ZADDASSETATTRS.ZLASTVIEWEDDATE + 978307200, 'UNIXEPOCH') AS '040-ZADDASSETATTRS.zlastvieweddate(utc)',

    ZINTRESOU.ZFINGERPRINT AS '041-ZINTRESOU.zfingerprint',

    CASE ParentZGENALBUM.ZCLOUDLOCALSTATE
        WHEN 0 THEN 'iCloud Photos ON = Asset In Shared/Other Album | iCloud Photos OFF = Generic Album [0]'
        WHEN 1 THEN 'iCloud Photos ON = Asset In Generic Album [1]'
        ELSE 'Unknown Value: ' || ParentZGENALBUM.ZCLOUDLOCALSTATE || ''
    END AS '042-PARENTZGENALBUM.zcloudlocalstate',

    ParentZGENALBUM.ZTITLE AS '043-PARENTZGENALBUM.ztitle',

    datetime(ParentZGENALBUM.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS '044-PARENTZGENALBUM.zcreationdate(utc)',
    datetime(ZGENALBUM.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS '045-ZGENALBUM.zcreationdate(utc)',

    CASE ZGENALBUM.ZCLOUDLOCALSTATE
        WHEN 0 THEN 'iCloud Photos ON = Asset In Shared/Other Album | iCloud Photos OFF = Generic Album [0]'
        WHEN 1 THEN 'iCloud Photos ON = Asset In Generic Album [1]'
        ELSE 'Unknown Value: ' || ZGENALBUM.ZCLOUDLOCALSTATE || ''
    END AS '046-ZGENALBUM.zcloudlocalstate',

    ZGENALBUM.ZTITLE AS '047-ZGENALBUM.ztitle',

    CASE ZASSET.ZBUNDLESCOPE
        WHEN 0 THEN 'iCloud Photos ON (Not In Shared Album) | iCloud Photos OFF (On Local Device) [0]'
        WHEN 1 THEN 'SWY Syndication CMMAsset [1]'
        WHEN 2 THEN 'iCloud Photos ON (Asset In Cloud Shared Album) [2]'
        WHEN 3 THEN 'iCloud Photos ON (SWY Syndication-Asset) [3]'
        ELSE 'Unknown Value: ' || ZASSET.ZBUNDLESCOPE || ''
    END AS '048-ZASSET.zbundlescope',

    CASE ZASSET.ZCLOUDISMYASSET
        WHEN 0 THEN 'Not My Asset in Shared Album [0]'
        WHEN 1 THEN 'My Asset in Shared Album [1]'
        ELSE 'Unknown Value: ' || ZASSET.ZCLOUDISMYASSET || ''
    END AS '049-ZASSET.zcloudismyasset',

    CASE ZASSET.ZCLOUDISDELETABLE
        WHEN 0 THEN 'No [0]'
        WHEN 1 THEN 'Yes [1]'
        ELSE 'Unknown Value: ' || ZASSET.ZCLOUDISDELETABLE || ''
    END AS '050-ZASSET.zcloudisdeletable',

    CASE ZASSET.ZCLOUDLOCALSTATE
        WHEN 0 THEN 'iCloud Photos ON = Asset In Shared or Other Album) | iCloud Photos OFF = Not Synced [0]'
        WHEN 1 THEN 'iCloud Photos ON = Asset Can Be or Has Been Synced with iCloud [1]'
        ELSE 'Unknown Value: ' || ZASSET.ZCLOUDLOCALSTATE || ''
    END AS '051-ZASSET.zcloudlocalstate',

    -- Indicates whether assets are visible within the Local Photo Library
    CASE ZASSET.ZVISIBILITYSTATE
        WHEN 0 THEN 'Visible Photo Library [0]'
        WHEN 2 THEN 'Not Visible Photo Library [2]'
        ELSE 'Unknown Value: ' || ZASSET.ZVISIBILITYSTATE || ''
    END AS '052-ZASSET.zvisibilitystate',

    ZEXTATTR.ZCAMERAMAKE AS '053-ZEXTATTR.zcameramake',
    ZEXTATTR.ZCAMERAMODEL AS '054-ZEXTATTR.zcameramodel',
    ZEXTATTR.ZLENSMODEL AS '055-ZEXTATTR.zlensmodel',

    CASE ZEXTATTR.ZFLASHFIRED
        WHEN 0 THEN 'No Flash [0]'
        WHEN 1 THEN 'Flash Fired [1]'
        ELSE 'Unknown Value: ' || ZEXTATTR.ZFLASHFIRED || ''
    END AS '056-ZEXTATTR.zflashfired',

    ZEXTATTR.ZFOCALLENGTH AS '057-ZEXTATTR.zfocallength',
    ZEXTATTR.ZFOCALLENGTHIN35MM AS '058-ZEXTATTR.zfocallengthin35mm',
    ZEXTATTR.ZDIGITALZOOMRATIO AS '059-ZEXTATTR.zdigitalzoomratio',

    CASE ZASSET.ZDERIVEDCAMERACAPTUREDEVICE
        WHEN 0 THEN 'Back Camera/Other [0]'
        WHEN 1 THEN 'Front Camera [1]'
        ELSE 'Unknown Value: ' || ZASSET.ZDERIVEDCAMERACAPTUREDEVICE || ''
    END AS '060-ZASSET.zderivedcameracapturedevice',

    CASE ZADDASSETATTRS.ZCAMERACAPTUREDEVICE
        WHEN 0 THEN 'Back Camera/Other [0]'
        WHEN 1 THEN 'Front Camera [1]'
        ELSE 'Unknown Value: ' || ZADDASSETATTRS.ZCAMERACAPTUREDEVICE || ''
    END AS '061-ZADDASSETATTRS.zcameracapturedevice',

    CASE ZADDASSETATTRS.ZIMPORTEDBY
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
        ELSE 'Unknown Value: ' || ZADDASSETATTRS.ZIMPORTEDBY || ''
    END AS '062-ZADDASSETATTRS.zimportedby',

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
    END AS '063-ZCLDMAST.zimportedby',

    ZADDASSETATTRS.ZIMPORTEDBYBUNDLEIDENTIFIER AS '064-ZADDASSETATTRS.zimportedbybundleidentifier',
    ZADDASSETATTRS.ZIMPORTEDBYDISPLAYNAME AS '065-ZADDASSETATTRS.zimportedbydisplayname',
    ZCLDMAST.ZIMPORTEDBYBUNDLEIDENTIFIER AS '066-ZCLDMAST.zimportedbybundleidentifier',
    ZCLDMAST.ZIMPORTEDBYDISPLAYNAME AS '067-ZCLDMAST.zimportedbydisplayname',
    -- hex(ZASSET.ZIMAGEREQUESTHINTS) AS '068-ZASSET.zimagerequesthints(hex path)',

    CASE ZASSET.ZSAVEDASSETTYPE
        WHEN 0 THEN 'Saved via other source [0]'
        WHEN 1 THEN 'Still Testing [1]'
        WHEN 2 THEN 'Photo Streams Data [2]'
        WHEN 3 THEN 'Local Photo Library Asset [3]'
        WHEN 4 THEN 'Photo Cloud Sharing Data Asset [4]'
        WHEN 5 THEN 'PhotoBooth Photo Library Asset [5]'
        WHEN 6 THEN 'Cloud Photo Library Asset [6]'
        WHEN 7 THEN 'Still Testing [7]'
        WHEN 8 THEN 'iCloudLink Cloud Master Moment Asset [8]'
        WHEN 12 THEN 'SWY Syndication PL Asset / Auto Displayed in LPL [12]'
        ELSE 'Unknown Value: ' || ZASSET.ZSAVEDASSETTYPE || ''
    END AS '069-ZASSET.zsavedassettype(lpl)',

    CASE ZINTRESOU.ZDATASTORECLASSID
        WHEN 0 THEN 'LPL Asset CPL Asset [0]'
        WHEN 1 THEN 'Still Testing [1]'
        WHEN 2 THEN 'Photo Cloud Sharing Asset [2]'
        WHEN 3 THEN 'SWY Syndication Asset [3]'
        ELSE 'Unknown Value: ' || ZINTRESOU.ZDATASTORECLASSID || ''
    END AS '070-ZINTRESOU.zdatastoreclassid',

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
    END AS '071-ZASSET.zcloudplaceholderkind',

    CASE ZINTRESOU.ZLOCALAVAILABILITY
        WHEN -1 THEN 'IR Asset Not Avail Locally [-1]'
        WHEN 1 THEN 'IR Asset Avail Locally [1]'
        WHEN -32768 THEN 'IR Asset SWY Linked Asset [-32768]'
        ELSE 'Unknown Value: ' || ZINTRESOU.ZLOCALAVAILABILITY || ''
    END AS '072-ZINTRESOU.zlocalavailability',

    CASE ZINTRESOU.ZLOCALAVAILABILITYTARGET
        WHEN 0 THEN 'Still Testing [0]'
        ELSE 'Unknown Value: ' || ZINTRESOU.ZLOCALAVAILABILITYTARGET || ''
    END AS '073-ZINTRESOU.zlocalavailabilitytarget',

    CASE ZINTRESOU.ZCLOUDLOCALSTATE
        WHEN 0 THEN 'IR Asset Not Synced No IR CloudMastDateCreated [0]'
        WHEN 1 THEN 'IR Asset Pending Upload [1]'
        WHEN 2 THEN 'IR Asset Photo Cloud Share Asset On Local Device [2]'
        WHEN 3 THEN 'IR Asset Synced iCloud [3]'
        ELSE 'Unknown Value: ' || ZINTRESOU.ZCLOUDLOCALSTATE || ''
    END AS '074-ZINTRESOU.zcloudlocalstate',

    CASE ZINTRESOU.ZREMOTEAVAILABILITY
        WHEN 0 THEN 'IR Asset Not Avail Remotely [0]'
        WHEN 1 THEN 'IR Asset Avail Remotely [1]'
        ELSE 'Unknown Value: ' || ZINTRESOU.ZREMOTEAVAILABILITY || ''
    END AS '075-ZINTRESOU.zremoteavailability',

    CASE ZINTRESOU.ZREMOTEAVAILABILITYTARGET
        WHEN 0 THEN 'Still Testing [0]'
        WHEN 1 THEN 'Still Testing [1]'
        ELSE 'Unknown Value: ' || ZINTRESOU.ZREMOTEAVAILABILITYTARGET || ''
    END AS '076-ZINTRESOU.zremoteavailabilitytarget',

    ZINTRESOU.ZTRANSIENTCLOUDMASTER AS '077-ZINTRESOU.ztransientcloudmaster',
    ZINTRESOU.ZSIDECARINDEX AS '078-ZINTRESOU.zsidecarindex',
    ZINTRESOU.ZFILEID AS '079-ZINTRESOU.zfileid',

    CASE ZINTRESOU.ZVERSION
        WHEN 0 THEN 'IR Asset Standard [0]'
        WHEN 1 THEN 'Still Testing [1]'
        WHEN 2 THEN 'IR Asset Adjustments Mutation [2]'
        WHEN 3 THEN 'IR Asset No IR Cloud Master Date Created [3]'
        ELSE 'Unknown Value: ' || ZINTRESOU.ZVERSION || ''
    END AS '080-ZINTRESOU.zversion',

    printf("%,d", ZADDASSETATTRS.ZORIGINALFILESIZE) AS '081-ZADDASSETATTRS.zoriginalfilesize(bytes)',

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
    END AS '082-ZINTRESOU.zresourcetype',

    -- hex(ZINTRESOU.ZDATASTOREKEYDATA) AS '083-ZINTRESOU.zdatastorekeydata(hex)',

    CASE ZINTRESOU.ZDATASTORESUBTYPE
        WHEN 0 THEN 'No Cloud Inter Resource [0]'
        WHEN 1 THEN 'Main Asset Orig Size [1]'
        WHEN 2 THEN 'Photo with Adjustments [2]'
        WHEN 3 THEN '.JPG Large Thumb [3]'
        WHEN 4 THEN '.JPG Med Thumb [4]'
        WHEN 5 THEN '.JPG Small Thumb [5]'
        WHEN 6 THEN 'Video Med Data [6]'
        WHEN 7 THEN 'Video Small Data [7]'
        WHEN 8 THEN '.MP4 Cloud Share [8]'
        WHEN 9 THEN 'Still Testing [9]'
        WHEN 10 THEN '3rd Party App thumb (Still Testing) [10]'
        WHEN 11 THEN 'Still Testing [11]'
        WHEN 12 THEN 'Still Testing [12]'
        WHEN 13 THEN '.PNG Optimized CPL Asset [13]'
        WHEN 14 THEN 'Wallpaper [14]'
        WHEN 15 THEN 'Has Markup and Adjustments [15]'
        WHEN 16 THEN 'Video with Adjustments [16]'
        WHEN 17 THEN 'RAW Photo [17]'
        WHEN 18 THEN 'Live Photo Video Optimized CPL Asset [18]'
        WHEN 19 THEN 'Live Photo with Adjustments [19]'
        WHEN 20 THEN 'Still Testing [20]'
        WHEN 21 THEN '.MOV Optimized HEVC 4K video [21]'
        WHEN 22 THEN 'Adjust Mutation AAE Asset [22]'
        WHEN 23 THEN 'Still Testing [23]'
        WHEN 24 THEN 'Still Testing [24]'
        WHEN 25 THEN 'Still Testing [25]'
        WHEN 26 THEN '.MOV Optimized CPLAsset [26]'
        WHEN 27 THEN 'Still Testing [27]'
        WHEN 28 THEN '.MOV Med HDR Data [28]'
        ELSE 'Unknown Value: ' || ZINTRESOU.ZDATASTORESUBTYPE || ''
    END AS '084-ZINTRESOU.zdatastoresubtype',

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
    END AS '085-ZINTRESOU.zcloudsourcetype',

    ZINTRESOU.ZDATALENGTH AS '086-ZINTRESOU.zdatalength',

    CASE ZINTRESOU.ZRECIPEID
        WHEN 0 THEN 'Orig File Size match Data Length or Optimized [0]'
        WHEN 65737 THEN 'Full .JPG Orig ProRAW DNG [65737]'
        WHEN 65739 THEN '.JPG Large Thumb [65739]'
        WHEN 65741 THEN 'Various Asset Types or Thumbs [65741]'
        WHEN 65743 THEN 'ResouType Photo 5003 or 5005 .JPG Thumb [65743]'
        WHEN 65749 THEN 'LocalVideoKeyFrame .JPG Thumb [65749]'
        WHEN 65938 THEN 'FullSizeRender Photo or .plist [65938]'
        WHEN 131072 THEN 'FullSizeRender Video or .plist [131072]'
        WHEN 131077 THEN 'Medium .MOV HEVC 4K [131077]'
        WHEN 131079 THEN 'Medium .MP4 Adj Mutation Asset [131079]'
        WHEN 131081 THEN 'ResouType Video 5003 or 5005 .JPG Thumb [131081]'
        WHEN 131272 THEN 'FullSizeRender Video Live Photo Adj Mutation [131272]'
        WHEN 131275 THEN 'Medium .MOV LivePhoto [131275]'
        WHEN 131277 THEN 'No IR Asset LivePhoto iCloud Sync Asset [131277]'
        WHEN 131475 THEN 'Medium HDR .MOV [131475]'
        WHEN 327683 THEN '.JPG Thumb for 3rd Party (Still Testing) [327683]'
        WHEN 327687 THEN 'Wallpaper Compute Resource [627687]'
        ELSE 'Unknown Value: ' || ZINTRESOU.ZRECIPEID || ''
    END AS '087-ZINTRESOU.zrecipeid',

    CASE ZINTRESOU.ZCLOUDLASTPREFETCHDATE
        WHEN 0 THEN 'N/A [0]'
        ELSE datetime(ZINTRESOU.ZCLOUDLASTPREFETCHDATE + 978307200, 'UNIXEPOCH')
    END AS '088-ZINTRESOU.zcloudlastprefetchdate(utc)',

    ZINTRESOU.ZCLOUDPREFETCHCOUNT AS '089-ZINTRESOU.zcloudprefetchcount',

    datetime(ZINTRESOU.ZCLOUDLASTONDEMANDDOWNLOADDATE + 978307200, 'UNIXEPOCH') AS '090-ZINTRESOU.zcloudlastondemanddownloaddate(utc)',

    CASE ZINTRESOU.ZUTICONFORMANCEHINT
        WHEN 0 THEN 'N/A, Does not Conform [0]'
        WHEN 1 THEN 'UT Type Image [1]'
        WHEN 2 THEN 'UT Type Pro Raw Photo [2]'
        WHEN 3 THEN 'UT Type Movie [3]'
        ELSE 'Unknown Value: ' || ZINTRESOU.ZUTICONFORMANCEHINT || ''
    END AS '091-ZINTRESOU.zuticonformancehint',

    CASE ZINTRESOU.ZCOMPACTUTI
        WHEN 1 THEN '.JPEG/.THM [1]'
        WHEN 3 THEN '.HEIC [3]'
        WHEN 6 THEN '.PNG [6]'
        WHEN 7 THEN 'Still Testing [7]'
        WHEN 9 THEN '.DNG [9]'
        WHEN 23 THEN '.JPEG/.HEIC/.mov [23]'
        WHEN 24 THEN '.MPEG4 [24]'
        WHEN 36 THEN 'Wallpaper [36]'
        WHEN 37 THEN 'Adj/Mutation Data [37]'
        ELSE 'Unknown Value: ' || ZINTRESOU.ZCOMPACTUTI || ''
    END AS '092-ZINTRESOU.zcompactuti',

    ZASSET.ZUNIFORMTYPEIDENTIFIER AS '093-ZASSET.zuniformtypeidentifier',
    ZASSET.ZORIGINALCOLORSPACE AS '094-ZASSET.zoriginalcolorspace',
    ZCLDMAST.ZUNIFORMTYPEIDENTIFIER AS '095-ZCLDMAST.zuniformtypeidentifier',

    CASE ZCLDMAST.ZFULLSIZEJPEGSOURCE
        WHEN 0 THEN 'Cloud Master .JPEG Source Video (Still Testing) [0]'
        WHEN 1 THEN 'Cloud Master .JPEG Source Other (Still Testing) [1]'
        ELSE 'Unknown Value: ' || ZCLDMAST.ZFULLSIZEJPEGSOURCE || ''
    END AS '096-ZCLDMAST.zfullsizejpegsource',

    CASE ZCLDMAST.ZCLOUDLOCALSTATE
        WHEN 0 THEN 'Not Synced with Cloud [0]'
        WHEN 1 THEN 'Pending Upload [1]'
        WHEN 2 THEN 'Still Testing [2]'
        WHEN 3 THEN 'Synced with Cloud [3]'
        ELSE 'Unknown Value: ' || ZCLDMAST.ZCLOUDLOCALSTATE || ''
    END AS '097-ZCLDMAST.zcloudlocalstate',

    datetime(ZCLDMAST.ZIMPORTDATE + 978307200, 'UNIXEPOCH') AS '098-ZCLDMAST.zimportdate(utc)',

    ZASSET.ZIMPORTSESSION AS '099-ZASSET.zimportsession',
    ZADDASSETATTRS.ZIMPORTSESSIONID AS '100-ZADDASSETATTRS.zimportsessionid',

    datetime(ZADDASSETATTRS.ZALTERNATEIMPORTIMAGEDATE + 978307200, 'UNIXEPOCH') AS '101-ZADDASSETATTRS.zalternateimportimagedate(utc)',

    ZCLDMAST.ZIMPORTSESSIONID AS '102-ZCLDMAST.zimportsessionid',

    datetime(ZASSET.ZCLOUDBATCHPUBLISHDATE + 978307200, 'UNIXEPOCH') AS '103-ZASSET.zcloudbatchpublishdate(utc)',
    datetime(ZASSET.ZCLOUDSERVERPUBLISHDATE + 978307200, 'UNIXEPOCH') AS '104-ZASSET.zcloudserverpublishdate(utc)',

    ZASSET.ZCLOUDDOWNLOADREQUESTS AS '105-ZASSET.zclouddownloadrequests',
    ZASSET.ZCLOUDBATCHID AS '106-ZASSET.zcloudbatchid',

    datetime(ZADDASSETATTRS.ZLASTUPLOADATTEMPTDATE + 978307200, 'UNIXEPOCH') AS '107-ZADDASSETATTRS.zlastuploadattemptdate(swy)(utc)',

    ZADDASSETATTRS.ZUPLOADATTEMPTS AS '108-ZADDASSETATTRS.zuploadattempts',

    CASE ZASSET.ZLATITUDE
        WHEN -180.0 THEN '[-180.0]'
        ELSE ZASSET.ZLATITUDE
    END AS '109-ZASSET.zlatitude',

    ZEXTATTR.ZLATITUDE AS '110-ZEXTATTR.zlatitude',

    CASE ZASSET.ZLONGITUDE
        WHEN -180.0 THEN '[-180.0]'
        ELSE ZASSET.ZLONGITUDE
    END AS '111-ZASSET.zlongitude',

    ZEXTATTR.ZLONGITUDE AS '112-ZEXTATTR.zlongitude',

    CASE ZADDASSETATTRS.ZGPSHORIZONTALACCURACY
        WHEN -1.0 THEN '[-1.0]'
        WHEN NULL THEN NULL
        ELSE ZADDASSETATTRS.ZGPSHORIZONTALACCURACY
    END AS '113-ZADDASSETATTRS.zgpshorizontalaccuracy',

    -- hex(ZASSET.ZLOCATIONDATA) AS '114-ZASSET.zlocationdata(hex)',
    -- ZADDASSETATTRS.ZREVERSELOCATIONDATA AS '115-ZADDASSETATTRS.zreverselocationdata(orig-asset, hex nskeyed .plist)',

    CASE ZADDASSETATTRS.ZSHIFTEDLOCATIONISVALID
        WHEN 0 THEN 'Not Valid [0]'
        WHEN 1 THEN 'Valid [1]'
    END AS '116-ZADDASSETATTRS.zshiftedlocationisvalid',

    ZADDASSETATTRS.ZSHIFTEDLOCATIONDATA AS '117-ZADDASSETATTRS.zshiftedlocationdata',
    ZADDASSETATTRS.ZLOCATIONHASH AS '118-ZADDASSETATTRS.zlocationhash',

    CASE AAAZCLDMASTMedData.Z_OPT
        WHEN 1 THEN 'Cloud (Still Testing) [1]'
        WHEN 2 THEN 'This Device (Still Testing) [2]'
        WHEN 3 THEN 'Muted (Still Testing) [3]'
        WHEN 4 THEN 'Unknown (Still Testing) [4]'
        WHEN 5 THEN 'Unknown (Still Testing) [5]'
        ELSE 'Unknown Value: ' || AAAZCLDMASTMedData.Z_OPT || ''
    END AS '119-AAAZCLDMASTMedData.z_opt',

    ZADDASSETATTRS.ZMEDIAMETADATATYPE AS '120-ZADDASSETATTRS.zmediametadatatype',
    -- hex(AAAZCLDMASTMedData.ZDATA) AS '121-AAAZCLDMASTMedData.zdata(hex)',

    CASE CMZCLDMASTMedData.Z_OPT
        WHEN 1 THEN 'Has Cloud Master Asset (Still Testing) [1]'
        WHEN 2 THEN 'Local Asset (Still Testing) [2]'
        WHEN 3 THEN 'Muted (Still Testing) [3]'
        WHEN 4 THEN 'Unknown (Still Testing) [4]'
        WHEN 5 THEN 'Unknown (Still Testing) [5]'
        ELSE 'Unknown Value: ' || CMZCLDMASTMedData.Z_OPT || ''
    END AS '122-CldMasterZCLDMASTMedData.z_opt',

    ZCLDMAST.ZMEDIAMETADATATYPE AS '123-ZCLDMAST.zmediametadatatype',
    -- hex(CMZCLDMASTMedData.ZDATA) AS '124-CMZCLDMASTMedData.zdata(hex)',

    CASE ZASSET.ZSEARCHINDEXREBUILDSTATE
        WHEN 0 THEN 'Still Testing [0]'
        ELSE 'Unknown Value: ' || ZASSET.ZSEARCHINDEXREBUILDSTATE || ''
    END AS '125-ZASSET.zsearchindexrebuildstate',

        CASE ZASSET.ZORIENTATION
        WHEN 1 THEN 'Horizontal (Left) [1]'
        WHEN 3 THEN 'Horizontal (Right) [3]'
        WHEN 6 THEN 'Vertical (Up) [6]'
        WHEN 8 THEN 'Vertical (Down) [8]'
        ELSE 'Unknown Value: ' || ZASSET.ZORIENTATION
    END AS '126-ZASSET.zorientation',

    CASE ZADDASSETATTRS.ZORIGINALORIENTATION
        WHEN 1 THEN 'Horizontal (Left) [1]'
        WHEN 3 THEN 'Horizontal (Right) [3]'
        WHEN 6 THEN 'Vertical (Up) [6]'
        WHEN 8 THEN 'Vertical (Down) [8]'
        ELSE 'Unknown Value: ' || ZADDASSETATTRS.ZORIGINALORIENTATION
    END AS '127-ZADDASSETATTRS.zoriginalorientation',

    CASE ZASSET.ZKIND
        WHEN 0 THEN 'Photo [0]'
        WHEN 1 THEN 'Video [1]'
    END AS '128-ZASSET.zkind',

    CASE ZASSET.ZKINDSUBTYPE
        WHEN 0 THEN 'Still Photo [0]'
        WHEN 2 THEN 'Live Photo [2]'
        WHEN 10 THEN 'SpringBoard Screenshot [10]'
        WHEN 100 THEN 'Video [100]'
        WHEN 101 THEN 'Slow-Mo Video [101]'
        WHEN 102 THEN 'Time-lapse Video [102]'
        WHEN 103 THEN 'Replay Screen Recording [103]'
        ELSE 'Unknown Value: ' || ZASSET.ZKINDSUBTYPE || ''
    END AS '129-ZASSET.zkindsubtype',

    CASE ZADDASSETATTRS.ZCLOUDKINDSUBTYPE
        WHEN 0 THEN 'Still Photo [0]'
        WHEN 1 THEN 'Still Testing [1]'
        WHEN 2 THEN 'Live Photo [2]'
        WHEN 3 THEN 'Screenshot [3]'
        WHEN 10 THEN 'SpringBoard Screenshot [10]'
        WHEN 100 THEN 'Video [100]'
        WHEN 101 THEN 'Slow-Mo Video [101]'
        WHEN 102 THEN 'Time-lapse Video [102]'
        WHEN 103 THEN 'Replay Screen Recording [103]'
        ELSE 'Unknown Value: ' || ZADDASSETATTRS.ZCLOUDKINDSUBTYPE || ''
    END AS '130-ZADDASSETATTRS.zcloudkindsubtype',

    CASE ZASSET.ZPLAYBACKSTYLE
        WHEN 1 THEN 'Image [1]'
        WHEN 2 THEN 'Image Animated [2]'
        WHEN 3 THEN 'Live Photo [3]'
        WHEN 4 THEN 'Video [4]'
        WHEN 5 THEN 'Video Looping [5]'
        ELSE 'Unknown Value: ' || ZASSET.ZPLAYBACKSTYLE || ''
    END AS '131-ZASSET.zplaybackstyle',

    ZASSET.ZPLAYBACKVARIATION AS '132-ZASSET.zplaybackvariation',
    ZASSET.ZDURATION AS '133-ZASSET.zduration',
    ZEXTATTR.ZDURATION AS '134-ZEXTATTR.zduration',
    -- Duration of the Live Photo in seconds
    ZASSET.ZVIDEOCPDURATIONVALUE AS '135-ZASSET.zvideocpdurationvalue',
    ZADDASSETATTRS.ZVIDEOCPDURATIONTIMESCALE AS '136-ZADDASSETATTRS.zvideocpdurationtimescale',
    ZASSET.ZVIDEOCPVISIBILITYSTATE AS '137-ZASSET.zvideocpvisibilitystate',
    ZADDASSETATTRS.ZVIDEOCPDISPLAYVALUE AS '138-ZADDASSETATTRS.zvideocpdisplayvalue',
    ZADDASSETATTRS.ZVIDEOCPDISPLAYTIMESCALE AS '139-ZADDASSETATTRS.zvideocpdisplaytimescale',

    -- [ZINTRESOU.ZASSET = ZASSET.Z_PK]
    ZINTRESOU.ZASSET AS '140-ZINTRESOU.zasset',
    ZINTRESOU.Z_PK AS '141-ZINTRESOU.z_pk',
    ZINTRESOU.Z_ENT AS '142-ZINTRESOU.z_ent',
    ZINTRESOU.Z_OPT AS '143-ZINTRESOU.z_opt',
    ZASSET.ZHDRGAIN AS '144-ZASSET.zhdrgain',

    CASE ZASSET.ZHDRTYPE
        WHEN 0 THEN 'No HDR [0]'
        WHEN 3 THEN 'HDR Photo [3]'
        WHEN 4 THEN 'Non HDR Version [4]'
        WHEN 5 THEN 'HEVC Movie [5]'
        WHEN 6 THEN 'Panorama [6]'
        WHEN 10 THEN 'HDR Gain [10]'
        ELSE 'Unknown Value: ' || ZASSET.ZHDRTYPE || ''
    END AS '145-ZASSET.zhdrtype',

    ZEXTATTR.ZCODEC AS '146-ZEXTATTR.zcodec',
    ZINTRESOU.ZCODECFOURCHARCODENAME AS '147-ZINTRESOU.zcodecfourcharcodename',
    ZCLDMAST.ZCODECNAME AS '148-ZCLDMAST.zcodecname',
    ZCLDMAST.ZVIDEOFRAMERATE AS '149-ZCLDMAST.zvideoframerate',
    ZCLDMAST.ZPLACEHOLDERSTATE AS '150-ZCLDMAST.zplaceholderstate',

    CASE ZASSET.ZDEPTHTYPE
        WHEN 0 THEN 'Not Portrait [0]'
        ELSE 'Portrait: ' || ZASSET.ZDEPTHTYPE || ''
    END AS '151-ZASSET.zdepthtype',

    ZASSET.ZAVALANCHEUUID AS '152-ZASSET.zavalancheuuid',

    CASE ZASSET.ZAVALANCHEPICKTYPE
        WHEN 0 THEN 'N/A / Single Asset Burst UUID [0]'
        WHEN 2 THEN 'Burst Asset Not Selected [2]'
        WHEN 4 THEN 'Burst Asset PhotosApp Picked Key Image [4]'
        WHEN 8 THEN 'Burst Asset Selected for LPL [8]'
        WHEN 16 THEN 'Top Burst Asset inStack Key Image [16]'
        WHEN 32 THEN 'Still Testing [32]'
        WHEN 52 THEN 'Burst Asset Visible LPL [52]'
        ELSE 'Unknown Value: ' || ZASSET.ZAVALANCHEPICKTYPE || ''
    END AS '153-ZASSET.zavalanchepicktype',

    CASE ZADDASSETATTRS.ZCLOUDAVALANCHEPICKTYPE
        WHEN 0 THEN 'N/A / Single Asset Burst UUID [0]'
        WHEN 2 THEN 'Burst Asset Not Selected [2]'
        WHEN 4 THEN 'Burst Asset PhotosApp Picked Key Image [4]'
        WHEN 8 THEN 'Burst Asset Selected for LPL [8]'
        WHEN 16 THEN 'Top Burst Asset inStack Key Image [16]'
        WHEN 32 THEN 'Still Testing [32]'
        WHEN 52 THEN 'Burst Asset Visible LPL [52]'
        ELSE 'Unknown Value: ' || ZADDASSETATTRS.ZCLOUDAVALANCHEPICKTYPE || ''
    END AS '154-ZADDASSETATTRS.zcloudavalanchepicktype',

    CASE ZADDASSETATTRS.ZCLOUDRECOVERYSTATE
        WHEN 0 THEN 'Still Testing [0]'
        WHEN 1 THEN 'Still Testing [1]'
        ELSE 'Unknown Value: ' || ZADDASSETATTRS.ZCLOUDRECOVERYSTATE || ''
    END AS '155-ZADDASSETATTRS.zcloudrecoverystate',

    ZADDASSETATTRS.ZCLOUDSTATERECOVERYATTEMPTSCOUNT AS '156-ZADDASSETATTRS.zcloudstaterecoveryattemptscount',
    ZASSET.ZDEFERREDPROCESSINGNEEDED AS '157-ZASSET.zdeferredprocessingneeded',
    ZASSET.ZVIDEODEFERREDPROCESSINGNEEDED AS '158-ZASSET.zvideodeferredprocessingneeded',
    ZADDASSETATTRS.ZDEFERREDPHOTOIDENTIFIER AS '159-ZADDASSETATTRS.zdeferredphotoidentifier',
    ZADDASSETATTRS.ZDEFERREDPROCESSINGCANDIDATEOPTIONS AS '160-ZADDASSETATTRS.zdeferredprocessingcandidateoptions',

/*
PERSON IDENTIFICATION SECTION
*/

    ZDETECTEDFACE.Z_PK AS '161-ZDETECTEDFACE.z_pk',
    ZDETECTEDFACEPRINT.ZFACE AS '162-ZDETECTEDFACEPRINT.zface',
    ZFACECROP.ZFACE AS '163-ZFACECROP.zface',
    hex(ZFACECROP.ZRESOURCEDATA) AS '164-ZFACECROP.zresourcedata (as binary)',
    ZPERSON.Z_PK AS '165-ZPERSON.z_pk',
    ZPERSON.ZDISPLAYNAME AS '166-ZPERSON.zdisplayname',
    ZPERSON.ZFULLNAME AS '167-ZPERSON.zfullname',

    CASE ZDETECTEDFACE.ZAGETYPE
        WHEN 1 THEN 'Baby/Toddler [1]'
        WHEN 2 THEN 'Baby/Toddler [2]'
        WHEN 3 THEN 'Child/Young Adult [3]'
        WHEN 4 THEN 'Young Adult/Adult [4]'
        WHEN 5 THEN 'Adult [5]'
        ELSE 'Unknown Value: ' || ZDETECTEDFACE.ZAGETYPE
    END AS '168-ZDETECTEDFACE.zagetype',

    CASE ZDETECTEDFACE.ZGENDERTYPE
        WHEN 1 THEN 'Male [1]'
        WHEN 2 THEN 'Female [2]'
        ELSE 'Unknown Value: ' || ZDETECTEDFACE.ZGENDERTYPE
    END AS '169-ZDETECTEDFACE.zgendertype',

    CASE ZDETECTEDFACE.ZETHNICITYTYPE
        WHEN 1 THEN 'Still Testing [1]'
        WHEN 2 THEN 'Still Testing [2]'
        WHEN 3 THEN 'Still Testing [3]'
        WHEN 4 THEN 'Still Testing [4]'
        WHEN 5 THEN 'Still Testing [5]'
        ELSE 'Unknown Value: ' || ZDETECTEDFACE.ZETHNICITYTYPE
    END AS '170-ZDETECTEDFACE.zethnicitytype',

    CASE ZDETECTEDFACE.ZGLASSESTYPE
        WHEN 1 THEN 'Eye [1]'
        WHEN 2 THEN 'Sun [2]'
        WHEN 3 THEN 'None [3]'
        ELSE 'Unknown Value: ' || ZDETECTEDFACE.ZGLASSESTYPE
    END AS '171-ZDETECTEDFACE.zglassestype',

    CASE ZDETECTEDFACE.ZFACIALHAIRTYPE
        WHEN 1 THEN 'None [1]'
        WHEN 2 THEN 'Beard/Mustache [2]'
        WHEN 3 THEN 'Goatee [3]'
        WHEN 5 THEN 'Stubble [5]'
        ELSE 'Unknown Value: ' || ZDETECTEDFACE.ZFACIALHAIRTYPE
    END AS '172-ZDETECTEDFACE.zfacialhairtype',

    CASE ZDETECTEDFACE.ZHAIRTYPE
        WHEN 2 THEN 'Bald [2]'
        WHEN 3 THEN 'Not Bald [3]'
        ELSE 'Unknown Value: ' || ZDETECTEDFACE.ZHAIRTYPE
    END AS '173-ZDETECTEDFACE.zhairtype',


    -- [ZUNMANAGEDADJUSTMENT.ZASSETATTRIBUTES = ZADDASSETATTRS.Z_PK]
    ZUNMANAGEDADJUSTMENT.ZASSETATTRIBUTES AS '174-ZUNMANAGEDADJUSTMENT.zassetattributes',
    -- [ZADDASSETATTRS.ZUNMANAGEDADJUSTMENT = ZUNMANAGEDADJUSTMENT.Z_PK]
    ZADDASSETATTRS.ZUNMANAGEDADJUSTMENT AS '175-ZADDASSETATTRS.zunmanagedadjustment',
    -- [ZUNMANAGEDADJUSTMENT.Z_PK = ZADDASSETATTRS.ZUNMANAGEDADJUSTMENT]
    ZUNMANAGEDADJUSTMENT.Z_PK AS '176-ZUNMANAGEDADJUSTMENT.z_pk',
    ZUNMANAGEDADJUSTMENT.ZUUID AS '177-ZUNMANAGEDADJUSTMENT.uuid',

    CASE ZASSET.ZADJUSTMENTSSTATE
        WHEN 0 THEN 'No Adjustments [0]'
        WHEN 1 THEN 'Still Testing [1]'
        WHEN 2 THEN 'Still Testing [2]'
        WHEN 3 THEN 'Still Testing [3]'
        ELSE 'Unknown Value: ' || ZASSET.ZADJUSTMENTSSTATE || ''
    END AS '178-ZASSET.zadjustmentsstate',

    datetime(ZASSET.ZADJUSTMENTTIMESTAMP + 978307200, 'UNIXEPOCH') AS '179-ZASSET.zadjustmenttimestamp(utc)',
    datetime(ZUNMANAGEDADJUSTMENT.ZADJUSTMENTTIMESTAMP + 978307200, 'UNIXEPOCH') AS '180-ZUNMANAGEDADJUSTMENT.zadjustmenttimestamp(utc)',

    ZADDASSETATTRS.ZEDITORBUNDLEID AS '181-ZADDASSETATTRS.zeditorbundleid',
    ZUNMANAGEDADJUSTMENT.ZEDITORLOCALIZEDNAME AS '182-ZUNMANAGEDADJUSTMENT.zeditorlocalizedname',
    ZUNMANAGEDADJUSTMENT.ZADJUSTMENTFORMATIDENTIFIER AS '183-ZUNMANAGEDADJUSTMENT.zadjustmentformatidentifier',
    ZADDASSETATTRS.ZMONTAGE AS '184-ZADDASSETATTRS.zmontage',

    CASE ZUNMANAGEDADJUSTMENT.ZADJUSTMENTRENDERTYPES
        WHEN 0 THEN 'Standard or Portrait with errors [0]'
        WHEN 1 THEN 'Still Testing [1]'
        WHEN 2 THEN 'Portrait [2]'
        WHEN 3 THEN 'Still Testing [3]'
        WHEN 4 THEN 'Still Testing [4]'
        ELSE 'Unknown Value: ' || ZUNMANAGEDADJUSTMENT.ZADJUSTMENTRENDERTYPES || ''
    END AS '185-ZUNMANAGEDADJUSTMENT.zadjustmentrendertypes',

    CASE ZUNMANAGEDADJUSTMENT.ZADJUSTMENTFORMATVERSION
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
        ELSE 'Unknown Value: ' || ZUNMANAGEDADJUSTMENT.ZADJUSTMENTFORMATVERSION || ''
    END AS '186-ZUNMANAGEDADJUSTMENT.zadjustmentformatversion',

    ZUNMANAGEDADJUSTMENT.ZADJUSTMENTBASEIMAGEFORMAT AS '187-ZUNMANAGEDADJUSTMENT.zadjustmentbaseimageformat',
    ZUNMANAGEDADJUSTMENT.ZOTHERADJUSTMENTSFINGERPRINT AS '188-ZUNMANAGEDADJUSTMENT.zotheradjustmentsfingerprint',
    ZUNMANAGEDADJUSTMENT.ZSIMILARTOORIGINALADJUSTMENTSFINGERPRINT AS '189-ZUNMANAGEDADJUSTMENT.similartoorigadjfingerprint',

    CASE ZASSET.ZFAVORITE
        WHEN 0 THEN 'Not Favorite [0]'
        WHEN 1 THEN 'Favorite [1]'
    END AS '190-ZASSET.zfavorite',

    CASE ZASSET.ZHIDDEN
        WHEN 0 THEN 'Not Hidden [0]'
        WHEN 1 THEN 'Hidden [1]'
        ELSE 'Unknown Value: ' || ZASSET.ZHIDDEN || ''
    END AS '191-ZASSET.zhidden',

    CASE ZASSET.ZTRASHEDSTATE
        WHEN 0 THEN 'Not In Trash/Recently Deleted [0]'
        WHEN 1 THEN 'In Trash/Recently Deleted [1]'
        ELSE 'Unknown Value: ' || ZASSET.ZTRASHEDSTATE || ''
    END AS '192-ZASSET.ztrashedstate (local asset recently deleted)',

    datetime(ZASSET.ZTRASHEDDATE + 978307200, 'UNIXEPOCH') AS '193-ZASSET.ztrasheddate(utc)',

    CASE ZASSET.ZDELETEREASON
        WHEN 1 THEN 'Delete Reason (Still Testing) [1]'
        WHEN 2 THEN 'Delete Reason (Still Testing) [2]'
        WHEN 3 THEN 'Delete Reason (Still Testing) [3]'
        ELSE 'Unknown Value: ' || ZASSET.ZDELETEREASON || ''
    END AS '194-ZASSET.zdeletereason',

    CASE ZASSET.ZTRASHEDBYPARTICIPANT
        WHEN 1 THEN 'Trashed/Recently Deleted by Participant [1]'
        ELSE 'Unknown Value: ' || ZASSET.ZTRASHEDBYPARTICIPANT || ''
    END AS '195-ZASSET.ztrashedbyparticipant',

    CASE ZINTRESOU.ZTRASHEDSTATE
        WHEN 0 THEN 'INTRESOU Not In Trash/Recently Deleted [0]'
        WHEN 1 THEN 'INTRESOU In Trash/Recently Deleted [1]'
        ELSE 'Unknown Value: ' || ZINTRESOU.ZTRASHEDSTATE || ''
    END AS '196-ZINTRESOU.ztrashedstate',

    datetime(ZINTRESOU.ZTRASHEDDATE + 978307200, 'UNIXEPOCH') AS '197-ZINTRESOU.ztrasheddate(utc)',

    CASE ZASSET.ZCLOUDDELETESTATE
        WHEN 0 THEN 'CLOUD Asset Not Deleted [0]'
        WHEN 1 THEN 'CLOUD Asset Deleted [1]'
        ELSE 'Unknown Value: ' || ZASSET.ZCLOUDDELETESTATE || ''
    END AS '198-ZASSET.zclouddeletestate',

    CASE ZINTRESOU.ZCLOUDDELETESTATE
        WHEN 0 THEN 'CLOUD IntResou Not Deleted [0]'
        WHEN 1 THEN 'CLOUD IntResou Deleted [1]'
        ELSE 'Unknown Value: ' || ZINTRESOU.ZCLOUDDELETESTATE || ''
    END AS '199-ZINTRESOU.zclouddeletestate',

    CASE ZADDASSETATTRS.ZPTPTRASHEDSTATE
        WHEN 0 THEN 'PTP Not in Trash [0]'
        WHEN 1 THEN 'PTP In Trash [1]'
        ELSE 'Unknown Value: ' || ZADDASSETATTRS.ZPTPTRASHEDSTATE || ''
    END AS '200-ZADDASSETATTRS.zptptrashedstate',

    CASE ZINTRESOU.ZPTPTRASHEDSTATE
        WHEN 0 THEN 'PTP IntResou Not in Trash [0]'
        WHEN 1 THEN 'PTP IntResou In Trash [1]'
        ELSE 'Unknown Value: ' || ZINTRESOU.ZPTPTRASHEDSTATE || ''
    END AS '201-ZINTRESOU.zptptrashedstate',

    ZINTRESOU.ZCLOUDDELETEASSETUUIDWITHRESOURCETYPE AS '202-ZINTRESOU.zclouddeleteassetuuidwithresourcetype',

    datetime(ZMEDANLYASTATTR.ZMEDIAANALYSISTIMESTAMP + 978307200, 'UNIXEPOCH') AS '203-ZMEDANLYASTATTR.zmediaanalysistimestamp(utc)',
    datetime(ZASSET.ZANALYSISSTATEMODIFICATIONDATE + 978307200, 'UNIXEPOCH') AS '204-ZASSET.zanalysisstatemodificationdate(utc)',

    ZADDASSETATTRS.ZPENDINGVIEWCOUNT AS '205-ZADDASSETATTRS.zpendingviewcount',
    ZADDASSETATTRS.ZVIEWCOUNT AS '206-ZADDASSETATTRS.zviewcount',
    ZADDASSETATTRS.ZPENDINGPLAYCOUNT AS '207-ZADDASSETATTRS.zpendingplaycount',
    ZADDASSETATTRS.ZPLAYCOUNT AS '208-ZADDASSETATTRS.zplaycount',
    ZADDASSETATTRS.ZPENDINGSHARECOUNT AS '209-ZADDASSETATTRS.zpendingsharecount',
    ZADDASSETATTRS.ZSHARECOUNT AS '210-ZADDASSETATTRS.zsharecount',

    datetime(ZASSET.ZLASTSHAREDDATE + 978307200, 'UNIXEPOCH') AS '211-ZASSET.zlastshareddate(utc)',

    ZADDASSETATTRS.ZSHAREORIGINATOR AS '212-ZADDASSETATTRS.zshareoriginator',

    CASE ZASSET.ZSYNDICATIONSTATE
        WHEN 0 THEN 'Local PL Asset Syndication State N/A [0]'
        ELSE 'Unknown Value: ' || ZASSET.ZSYNDICATIONSTATE || ''
    END AS '213-ZASSET.zsyndicationstate(lpl)',

    ZADDASSETATTRS.ZSYNDICATIONHISTORY AS '214-ZADDASSETATTRS.zsyndicationhistory',
    ZMEDANLYASTATTR.ZSYNDICATIONPROCESSINGVERSION AS '215-ZMEDANLYASTATTR.zsyndicationprocessingversion',

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
    END AS '216-ZMEDANLYASTATTR.zsyndicationprocessingvalue',

    datetime(ZMEDANLYASTATTR.ZVAANALYSISTIMESTAMP + 978307200, 'UNIXEPOCH') AS '217-ZMEDANLYASTATTR.zvaanalysistimestamp(utc)',

    ZMEDANLYASTATTR.ZVAANALYSISVERSION AS '218-ZMEDANLYASTATTR.zvaanalysisversion',

    CASE ZADDASSETATTRS.ZALLOWEDFORANALYSIS
        WHEN 0 THEN 'Asset Not Allowed For Analysis [0]'
        WHEN 1 THEN 'Asset Allowed for Analysis [1]'
        ELSE 'Unknown Value: ' || ZADDASSETATTRS.ZALLOWEDFORANALYSIS || ''
    END AS '219-ZADDASSETATTRS.zallowedforanalysis',

    ZADDASSETATTRS.ZSCENEANALYSISVERSION AS '220-ZADDASSETATTRS.zsceneanalysisversion',

    CASE ZADDASSETATTRS.ZSCENEANALYSISISFROMPREVIEW
        WHEN 0 THEN 'No [0]'
        ELSE 'Unknown Value: ' || ZADDASSETATTRS.ZSCENEANALYSISISFROMPREVIEW || ''
    END AS '221-ZADDASSETATTRS.zsceneanalysisisfrompreview',

    datetime(ZADDASSETATTRS.ZSCENEANALYSISTIMESTAMP + 978307200, 'UNIXEPOCH') AS '222-ZADDASSETATTRS.zsceneanalysistimestamp(utc)',

    CASE ZASSET.ZDUPLICATEASSETVISIBILITYSTATE
        WHEN 0 THEN 'No Duplicates [0]'
        WHEN 1 THEN 'Has Duplicate [1]'
        WHEN 2 THEN 'Is a Duplicate [2]'
        ELSE 'Unknown Value: ' || ZASSET.ZDUPLICATEASSETVISIBILITYSTATE || ''
    END AS '223-ZASSET.zduplicateassetvisibilitystate',

    CASE ZADDASSETATTRS.ZDESTINATIONASSETCOPYSTATE
        WHEN 0 THEN 'No Copy [0]'
        WHEN 1 THEN 'Has A Copy [1]'
        WHEN 2 THEN 'Has A Copy [2]'
        ELSE 'Unknown Value: ' || ZADDASSETATTRS.ZDESTINATIONASSETCOPYSTATE || ''
    END AS '224-ZADDASSETATTRS.zdestinationassetcopystate',

    -- hex(ZSCENEP.ZDATA) AS '225-ZSCENEP.zdata (hex nskeyed .plist)',
    -- hex(ZSCENEP.ZDUPLICATEMATCHINGDATA) AS '226-ZSCENEP.zduplicatematchingdata (hex nskeyed .plist)',
    -- hex(ZSCENEP.ZDUPLICATEMATCHINGALTERNATEDATA) AS '227-ZSCENEP.zduplicatematchingalternatedata (hex nskeyed .plist)',
    ZADDASSETATTRS.ZSOURCEASSETFORDUPLICATIONSCOPEIDENTIFIER AS '228-ZADDASSETATTRS.zsourceassetforduplicationscopeidentifier',
    ZCLDMAST.ZSOURCEMASTERFORDUPLICATIONSCOPEIDENTIFIER AS '229-ZCLDMAST.zsourcemasterforduplicationscopeidentifier',
    ZADDASSETATTRS.ZSOURCEASSETFORDUPLICATIONIDENTIFIER AS '230-ZADDASSETATTRS.zsourceassetforduplicationidentifier',
    ZCLDMAST.ZSOURCEMASTERFORDUPLICATIONIDENTIFIER AS '231-ZCLDMAST.zsourcemasterforduplicationidentifier',
    ZEXTATTR.Z_ENT AS '232-ZEXTATTR.z_ent',
    ZEXTATTR.Z_OPT AS '233-ZEXTATTR.z_opt',
    ZADDASSETATTRS.ZVARIATIONSUGGESTIONSTATES AS '234-ZADDASSETATTRS.zvariationsuggestionstates',
    ZASSET.ZHIGHFRAMERATESTATE AS '235-ZASSET.zhighframeratestate',
    ZASSET.ZVIDEOKEYFRAMETIMESCALE AS '236-ZASSET.zvideokeyframetimescale',
    ZASSET.ZVIDEOKEYFRAMEVALUE AS '237-ZASSET.zvideokeyframevalue',
    ZEXTATTR.ZISO AS '238-ZEXTATTR.ziso',
    ZEXTATTR.ZMETERINGMODE AS '239-ZEXTATTR.zmeteringmode',
    ZEXTATTR.ZSAMPLERATE AS '240-ZEXTATTR.zsamplerate',
    ZEXTATTR.ZTRACKFORMAT AS '241-ZEXTATTR.ztrackformat',
    ZEXTATTR.ZWHITEBALANCE AS '242-ZEXTATTR.zwhitebalance',
    ZEXTATTR.ZASSET AS '243-ZEXTATTR.zasset',
    ZEXTATTR.ZAPERTURE AS '244-ZEXTATTR.zaperture',
    ZEXTATTR.ZBITRATE AS '245-ZEXTATTR.zbitrate',
    ZEXTATTR.ZEXPOSUREBIAS AS '246-ZEXTATTR.zexposurebias',
    ZEXTATTR.ZFPS AS '247-ZEXTATTR.zfps',
    ZEXTATTR.ZSHUTTERSPEED AS '248-ZEXTATTR.zshutterspeed',
    ZEXTATTR.ZSLUSHSCENEBIAS AS '249-ZEXTATTR.zslushscenebias',
    ZEXTATTR.ZSLUSHVERSION AS '250-ZEXTATTR.zslushversion',
    ZEXTATTR.ZSLUSHPRESET AS '251-ZEXTATTR.zslushpreset',
    ZEXTATTR.ZSLUSHWARMTHBIAS AS '252-ZEXTATTR.zslushwarmthbias',
    ZASSET.ZHEIGHT AS '253-ZASSET.zheight',
    ZADDASSETATTRS.ZORIGINALHEIGHT AS '254-ZADDASSETATTRS.zoriginalheight',
    ZINTRESOU.ZUNORIENTEDHEIGHT AS '255-ZINTRESOU.zunorientedheight',
    ZASSET.ZWIDTH AS '256-ZASSET.zwidth',
    ZADDASSETATTRS.ZORIGINALWIDTH AS '257-ADDASSETATTR.zoriginalwidth',
    ZINTRESOU.ZUNORIENTEDWIDTH AS '258-ZINTRESOU.zunorientedwidth',
    ZSHARE.ZTHUMBNAILIMAGEDATA AS '259-ZSHARE.zthumbnailimagedata',
    ZASSET.ZTHUMBNAILINDEX AS '260-ZASSET.zthumbnailindex',
    ZADDASSETATTRS.ZEMBEDDEDTHUMBNAILHEIGHT AS '261-ZADDASSETATTRS.zembeddedthumbnailheight',
    ZADDASSETATTRS.ZEMBEDDEDTHUMBNAILLENGTH AS '262-ZADDASSETATTRS.zembeddedthumbnaillength',
    ZADDASSETATTRS.ZEMBEDDEDTHUMBNAILOFFSET AS '263-ZADDASSETATTRS.zembeddedthumbnailoffset',
    ZADDASSETATTRS.ZEMBEDDEDTHUMBNAILWIDTH AS '264-ZADDASSETATTRS.zembeddedthumbnailwidth',
    ZASSET.ZPACKEDACCEPTABLECROPRECT AS '265-ZASSET.zpackedacceptablecroprect',
    ZASSET.ZPACKEDBADGEATTRIBUTES AS '266-ZASSET.zpackedbadgeattributes',
    ZASSET.ZPACKEDPREFERREDCROPRECT AS '267-ZASSET.zpackedpreferredcroprect',
    ZASSET.ZCURATIONSCORE AS '268-ZASSET.zcurationscore',
    ZASSET.ZCAMERAPROCESSINGADJUSTMENTSTATE AS '269-ZASSET.zcameraprocessingadjustmentstate',
    ZASSET.ZDEPTHTYPE AS '270-ZASSET.zdepthtype',
    ZASSET.ZISMAGICCARPET AS '271-ZASSET.zismagiccarpet',
    ZASSET.ZLIBRARYSCOPE AS '272-ZASSET.zlibraryscope',

    CASE ZASSET.ZLIBRARYSCOPESHARESTATE
        WHEN 0 THEN 'Not Shared (Still Testing) [0]'
        ELSE 'Unknown Value: ' || ZASSET.ZLIBRARYSCOPESHARESTATE || ''
    END AS '273-ZASSET.zlibraryscopesharestate',

    ZADDASSETATTRS.ZORIGINALRESOURCECHOICE AS '274-ZADDASSETATTRS.zoriginalresourcechoice',
    ZADDASSETATTRS.ZSPATIALOVERCAPTUREGROUPIDENTIFIER AS '275-ZADDASSETATTRS.zspatialovercapturegroupidentifier',
    -- hex(ZADDASSETATTRS.ZOBJECTSALIENCYRECTSDATA) AS '276-ZADDASSETATTRS.zobjectsaliencyrectsdata(HEX NSKeyed .plist)',
    -- hex(ZADDASSETATTRS.ZORIGINALHASH) AS '277-ZADDASSETATTRS.zoriginalhash(HEX)',
    ZADDASSETATTRS.ZPLACEANNOTATIONDATA AS '278-ZADDASSETATTRS.zplaceannotationdata',
    ZADDASSETATTRS.ZDISTANCEIDENTITY AS '279-ZADDASSETATTRS.zdistanceidentity'


FROM ZASSET

    LEFT JOIN ZADDITIONALASSETATTRIBUTES ZADDASSETATTRS ON ZADDASSETATTRS.Z_PK = ZASSET.ZADDITIONALATTRIBUTES
    LEFT JOIN ZEXTENDEDATTRIBUTES ZEXTATTR ON ZEXTATTR.Z_PK = ZASSET.ZEXTENDEDATTRIBUTES
    LEFT JOIN ZINTERNALRESOURCE ZINTRESOU ON ZINTRESOU.ZASSET = ZASSET.Z_PK
    LEFT JOIN ZSCENEPRINT ZSCENEP ON ZSCENEP.Z_PK = ZADDASSETATTRS.ZSCENEPRINT
    LEFT JOIN Z_30ASSETS ON Z_30ASSETS.Z_3ASSETS = ZASSET.Z_PK
    LEFT JOIN ZGENERICALBUM ZGENALBUM ON ZGENALBUM.Z_PK = Z_30ASSETS.Z_30ALBUMS
    LEFT JOIN ZUNMANAGEDADJUSTMENT ON ZADDASSETATTRS.ZUNMANAGEDADJUSTMENT = ZUNMANAGEDADJUSTMENT.Z_PK
    LEFT JOIN Z_29ALBUMLISTS ON Z_29ALBUMLISTS.Z_29ALBUMS = ZGENALBUM.Z_PK
    LEFT JOIN ZALBUMLIST ON ZALBUMLIST.Z_PK = Z_29ALBUMLISTS.Z_2ALBUMLISTS
    LEFT JOIN ZGENERICALBUM ParentZGENALBUM ON ParentZGENALBUM.Z_PK = ZGENALBUM.ZPARENTFOLDER
    LEFT JOIN ZCLOUDMASTER ZCLDMAST ON ZASSET.ZMASTER = ZCLDMAST.Z_PK
    LEFT JOIN ZCLOUDMASTERMEDIAMETADATA AAAZCLDMASTMedData ON AAAZCLDMASTMedData.Z_PK = ZADDASSETATTRS.ZMEDIAMETADATA
    LEFT JOIN ZCLOUDMASTERMEDIAMETADATA CMZCLDMASTMedData ON CMZCLDMASTMedData.Z_PK = ZCLDMAST.ZMEDIAMETADATA
    LEFT JOIN ZMEDIAANALYSISASSETATTRIBUTES ZMEDANLYASTATTR ON ZASSET.ZMEDIAANALYSISATTRIBUTES = ZMEDANLYASTATTR.Z_PK
    LEFT JOIN ZSHARE ON ZSHARE.Z_PK = ZASSET.ZMOMENTSHARE
    LEFT JOIN ZDETECTEDFACE ON ZASSET.Z_PK = ZDETECTEDFACE.ZASSETFORFACE
    -- LEFT JOIN ZDETECTEDFACE ON ZASSET.Z_PK = ZDETECTEDFACE.ZASSET
    LEFT JOIN ZPERSON ON ZPERSON.Z_PK = ZDETECTEDFACE.ZPERSONFORFACE
	LEFT JOIN ZDETECTEDFACEPRINT ON ZDETECTEDFACEPRINT.ZFACE = ZDETECTEDFACE.Z_PK
	LEFT JOIN ZFACECROP ON ZPERSON.Z_PK = ZFACECROP.ZPERSON


WHERE
    ZASSET.ZFILENAME IS 'IMG_8224.MOV' OR
    ZASSET.ZFILENAME IS 'IMG_8225.MP4' OR
    ZASSET.ZFILENAME IS '3e2cb810d62ecf8e429185a184abe84c' OR
    ZASSET.ZFILENAME IS 'd9cadb7c7196c06cf0eda7b3d2f3c94a' OR
    ZASSET.ZFILENAME IS '6EB3A423-E433-40E8-A03A-5C807423D008.mp4'


ORDER BY ZASSET.ZADDEDDATE
