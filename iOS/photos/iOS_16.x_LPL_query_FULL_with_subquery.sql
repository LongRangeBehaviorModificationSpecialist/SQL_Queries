/*
[DLU]
    05_Sep-2025
[NOTES]
    Modified from original iOS 15 query copied from: https://github.com/ScottKjr3347/iOS_Local_PL_Photos.sqlite_Queries/blob/main/iOS15/Previous_Queries/iOS15_LPL_Phsql_Basic.txt
*/

WITH joined AS (

    SELECT

        ROW_NUMBER() OVER() AS '001_record_number',
        ZASSET.ZSORTTOKEN AS '002_ZASSET.zsorttoken',
        ZASSET.ZPROMOTIONSCORE AS '003_ZASSET.zpromotionscore',

        CASE ZASSET.ZCOMPLETE
            WHEN 1 THEN 'Yes [1]'
            ELSE 'Unknown Value: ' || ZASSET.ZCOMPLETE
        END AS '004_ZASSET.zcomplete',

        ZASSET.Z_PK AS '005_ZASSET.Z_PK',
        ZADDASSETATTR.Z_PK AS '006_ZADDASSETATTR.z_pk',

        -- [ZCLOUDMASTER.Z_PK = ZASSET.Z_MASTER]
        ZCLOUDMASTER.Z_PK AS '007_ZCLOUDMASTER.z_pk',

        -- [ZASSET.ZMASTER = ZCLOUDMASTER.Z_PK]
        ZASSET.ZMASTER AS '008_ZASSET.zmaster',

        -- [ZASSET.EXTDATTR = ZEXTATTR.Z_PK]
        ZASSET.ZEXTENDEDATTRIBUTES AS '009_ZASSET.zextendedattributes',
        ZEXTATTR.Z_PK AS '010_ZEXTATTR.Z_PK',

        -- [CMZCLDMASTMEDDATA.ZCLOUDMASTER = ZCLOUDMASTER.Z_PK]
        CMZCLDMASTMedData.ZCLOUDMASTER AS '011_CMZCLDMASTMEDDATA.zcloudmaster',

        -- [ZCLOUDMASTER.ZMEDIAMETADATA = ZCLDMASTMEDDATA.Z_PK]
        ZCLOUDMASTER.ZMEDIAMETADATA AS '012_ZCLOUDMASTER.zmediametadata',

        -- [CMZCLDMASTMEDDATA.Z_PK = ZADDASSETATTR&ZCLOUDMASTER.ZMEDIAMETADATA]
        CMZCLDMASTMedData.Z_PK AS '013_CMZCLDMASTMEDDATA.z_pk',
        CMZCLDMASTMedData.Z_ENT AS '014_CMZCLDMASTMEDDATA.z_ent',
        ZASSET.ZUUID AS '015_ZASSET.zuuid',
        ZASSET.ZCLOUDASSETGUID AS '016_ZASSET.zcloudassetguid',
        ZASSET.ZCLOUDCOLLECTIONGUID AS '017_ZASSET.zcloudcollectguid',
        ZCLOUDMASTER.ZCLOUDMASTERGUID AS '018_ZCLOUDMASTER.zcloudmasterguid',
        ZGENALBUM.ZCLOUDGUID AS '019_ZGENALBUM.zcloudguid',
        ZSHARE.ZSCOPEIDENTIFIER AS '020_ZSHARE.zscopeidentifier',
        ZADDASSETATTR.ZORIGINALASSETSUUID AS '021_ZADDASSETATTR.zoriginalassetsuuid',
        ZADDASSETATTR.ZPUBLICGLOBALUUID AS '022_ZADDASSETATTR.zpublicglobaluuid',
        -- ZADDASSETATTR.ZMASTERFINGERPRINT AS '023_ZADDASSETATTR.zmasterfingerprint',
        ZADDASSETATTR.ZORIGINATINGASSETIDENTIFIER AS '024_ZADDASSETATTR.zoriginatingassetidentifier',
        ZCLOUDMASTER.ZORIGINATINGASSETIDENTIFIER AS '025_ZCLOUDMASTER.zoriginatingassetidentifier',

        ZASSET.ZDIRECTORY AS '026_ZASSET.zdirectory',
        ZASSET.ZFILENAME AS '027_ZASSET.zfilename',
        CONCAT(ZASSET.ZDIRECTORY,'/',ZASSET.ZFILENAME) AS filepath,

        ZADDASSETATTR.ZORIGINALFILENAME AS '028_ZADDASSETATTR.zoriginalfilename',
        ZCLOUDMASTER.ZORIGINALFILENAME AS '029_ZCLOUDMASTER.zoriginalfilename',
        ZADDASSETATTR.ZSYNDICATIONIDENTIFIER AS '030_ZADDASSETATTR.zsyndicationidentifier',

        datetime(ZASSET.ZADDEDDATE + 978307200, 'UNIXEPOCH') AS '031_ZASSET.zaddeddate_utc',

        CASE ZADDASSETATTR.ZDATECREATEDSOURCE
            WHEN 0 THEN 'Cloud Asset [0]'
            WHEN 1 THEN 'Local Asset EXIF [1]'
            WHEN 3 THEN 'Local Asset No EXIF [3]'
            ELSE 'Unknown Value: ' || ZADDASSETATTR.ZDATECREATEDSOURCE || ''
        END AS '032_ZADDASSETATTR.zdatecreatedsource',

        datetime(ZASSET.ZDATECREATED + 978307200, 'UNIXEPOCH') AS '033_ZASSET.zdatecreated_utc',
        datetime(ZCLOUDMASTER.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS '034_ZCLOUDMASTER.zcreationdate_utc',
        datetime(ZINTERNALRESOURCE.ZCLOUDMASTERDATECREATED + 978307200, 'UNIXEPOCH') AS '035_ZINTERNALRESOURCE.zcloudmasterdatecreated_utc',

        ZADDASSETATTR.ZTIMEZONENAME AS '036_ZADDASSETATTR.ztimezonename',
        ZADDASSETATTR.ZTIMEZONEOFFSET AS '037_ZADDASSETATTR.ztimezoneoffset',
        ZADDASSETATTR.ZINFERREDTIMEZONEOFFSET AS '038_ZADDASSETATTR.zinferredtimezoneoffset',
        ZADDASSETATTR.ZEXIFTIMESTAMPSTRING AS '039_ZADDASSETATTR.zexiftimestampstring',

        datetime(ZASSET.ZMODIFICATIONDATE + 978307200, 'UNIXEPOCH') AS '040_ZASSET.zmodificationdate_utc',

        ZINTERNALRESOURCE.ZFINGERPRINT AS '041_ZINTERNALRESOURCE.ZFINGERPRINT',
        -- ZADDASSETATTR.ZADJUSTEDFINGERPRINT AS '042_ZADDASSETATTR.zadjustedfingerprint',
        ZUNMADJ.ZOTHERADJUSTMENTSFINGERPRINT AS '043_ZUNMADJ.zotheradjustmentsfingerprint',
        ZUNMADJ.ZSIMILARTOORIGINALADJUSTMENTSFINGERPRINT AS '044_ZUNMADJ.similartoorigadjfingerprint',

        CASE ParentZGENALBUM.ZCLOUDLOCALSTATE
            WHEN 0 THEN 'iCloud Photos ON (Asset In Shared/Other Album) | iCloud Photos OFF (Generic Album) [0]'
            WHEN 1 THEN 'iCloud Photos ON (Asset In Generic Album) [1]'
            ELSE 'Unknown Value: ' || ParentZGENALBUM.ZCLOUDLOCALSTATE || ''
        END AS '045_PARENTZGENALBUM.zcloudlocalstate',

        ParentZGENALBUM.ZTITLE AS '046_PARENTZGENALBUM.ztitle',

        datetime(ParentZGENALBUM.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS '047_PARENTZGENALBUM.zcreationdate_utc',
        datetime(ZGENALBUM.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS '048_ZGENALBUM.zcreationdate_utc',

        CASE ZGENALBUM.ZCLOUDLOCALSTATE
            WHEN 0 THEN 'iCloud Photos ON (Asset In Shared/Other Album) | iCloud Photos OFF (Generic Album) [0]'
            WHEN 1 THEN 'iCloud Photos ON (Asset In Generic Album) [1]'
            ELSE 'Unknown Value: ' || ZGENALBUM.ZCLOUDLOCALSTATE || ''
        END AS '049_ZGENALBUM.zcloudlocalstate',

        ZGENALBUM.ZTITLE AS '050_ZGENALBUM.ztitle',

        CASE ZASSET.ZBUNDLESCOPE
            WHEN 0 THEN 'iCloud Photos ON (Not In Shared Album) | iCloud Photos OFF (On Local Device) [0]'
            WHEN 1 THEN 'SWY Syndication CMMAsset [1]'
            WHEN 2 THEN 'iCloud Photos ON (Asset In Cloud Shared Album) [2]'
            WHEN 3 THEN 'iCloud Photos ON (SWY Syndication-Asset) [3]'
            ELSE 'Unknown Value: ' || ZASSET.ZBUNDLESCOPE || ''
        END AS '051_ZASSET.zbundlescope',

        CASE ZASSET.ZCLOUDISMYASSET
            WHEN 0 THEN 'Not My Asset in Shared Album [0]'
            WHEN 1 THEN 'My Asset in Shared Album [1]'
            ELSE 'Unknown Value: ' || ZASSET.ZCLOUDISMYASSET || ''
        END AS '052_ZASSET.zcloudismyasset',

        CASE ZASSET.ZCLOUDISDELETABLE
            WHEN 0 THEN 'No [0]'
            WHEN 1 THEN 'Yes [1]'
            ELSE 'Unknown Value: ' || ZASSET.ZCLOUDISDELETABLE || ''
        END AS '053_ZASSET.zcloudisdeletable',

        CASE ZASSET.ZCLOUDLOCALSTATE
            WHEN 0 THEN 'iCloud Photos ON (Asset In Shared or Other Album) | iCloud Photos OFF (Not Synced) [0]'
            WHEN 1 THEN 'iCloud Photos ON (Asset Can Be or Has Been Synced with iCloud) [1]'
            ELSE 'Unknown Value: ' || ZASSET.ZCLOUDLOCALSTATE || ''
        END AS '054_ZASSET.zcloudlocalstate',

        -- Indicates whether assets are visible within the Local Photo Library
        CASE ZASSET.ZVISIBILITYSTATE
            WHEN 0 THEN 'Visible Photo Library [0]'
            WHEN 2 THEN 'Not Visible Photo Library [2]'
            ELSE 'Unknown Value: ' || ZASSET.ZVISIBILITYSTATE || ''
        END AS '055_ZASSET.zvisibilitystate',

        ZEXTATTR.ZCAMERAMAKE AS '056_ZEXTATTR.zcameramake',
        ZEXTATTR.ZCAMERAMODEL AS '057_ZEXTATTR.zcameramodel',
        ZEXTATTR.ZLENSMODEL AS '058_ZEXTATTR.zlensmodel',

        CASE ZEXTATTR.ZFLASHFIRED
            WHEN 0 THEN 'No Flash [0]'
            WHEN 1 THEN 'Flash Fired [1]'
            ELSE 'Unknown Value: ' || ZEXTATTR.ZFLASHFIRED || ''
        END AS '059_ZEXTATTR.zflashfired',

        ZEXTATTR.ZFOCALLENGTH AS '060_ZEXTATTR.zfocallength',
        ZEXTATTR.ZFOCALLENGTHIN35MM AS '061_ZEXTATTR.zfocallengthin35mm',
        ZEXTATTR.ZDIGITALZOOMRATIO AS '062_ZEXTATTR.zdigitalzoomratio',

        CASE ZASSET.ZDERIVEDCAMERACAPTUREDEVICE
            WHEN 0 THEN 'Back Camera/Other [0]'
            WHEN 1 THEN 'Front Camera [1]'
            ELSE 'Unknown Value: ' || ZASSET.ZDERIVEDCAMERACAPTUREDEVICE || ''
        END AS '063_ZASSET.zderivedcameracapturedevice',

        CASE ZADDASSETATTR.ZCAMERACAPTUREDEVICE
            WHEN 0 THEN 'Back Camera/Other [0]'
            WHEN 1 THEN 'Front Camera [1]'
            ELSE 'Unknown Value: ' || ZADDASSETATTR.ZCAMERACAPTUREDEVICE || ''
        END AS '064_ZADDASSETATTR.zcameracapturedevice',

        CASE ZADDASSETATTR.ZIMPORTEDBY
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
            ELSE 'Unknown Value: ' || ZADDASSETATTR.ZIMPORTEDBY || ''
        END AS '065_ZADDASSETATTR.zimportedby',

        CASE ZCLOUDMASTER.ZIMPORTEDBY
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
            ELSE 'Unknown Value: ' || ZCLOUDMASTER.ZIMPORTEDBY || ''
        END AS '066_ZCLOUDMASTER.zimportedby',

        ZADDASSETATTR.ZIMPORTEDBYBUNDLEIDENTIFIER AS '067_ZADDASSETATTR.zimportedbybundleidentifier',
        ZADDASSETATTR.ZIMPORTEDBYDISPLAYNAME AS '068_ZADDASSETATTR.zimportedbydisplayname',
        ZCLOUDMASTER.ZIMPORTEDBYBUNDLEIDENTIFIER AS '069_ZCLOUDMASTER.zimportedbybundleidentifier',
        ZCLOUDMASTER.ZIMPORTEDBYDISPLAYNAME AS '070_ZCLOUDMASTER.zimportedbydisplayname',
        -- hex(ZASSET.ZIMAGEREQUESTHINTS) AS '071_ZASSET.ZIMAGEREQUESTHINTS(HEX Path)',

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
        END AS '072_ZASSET.zsavedassettype(lpl)',

        CASE ZINTERNALRESOURCE.ZDATASTORECLASSID
            WHEN 0 THEN 'LPL Asset CPL Asset [0]'
            WHEN 1 THEN 'Still Testing [1]'
            WHEN 2 THEN 'Photo Cloud Sharing Asset [2]'
            WHEN 3 THEN 'SWY Syndication Asset [3]'
            ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZDATASTORECLASSID || ''
        END AS '073_ZINTERNALRESOURCE.zdatastoreclassid',

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
        END AS '074_ZASSET.zcloudplaceholderkind',

        CASE ZINTERNALRESOURCE.ZLOCALAVAILABILITY
            WHEN -1 THEN 'IR Asset Not Avail Locally [-1]'
            WHEN 1 THEN 'IR Asset Avail Locally [1]'
            WHEN -32768 THEN 'IR Asset SWY Linked Asset [-32768]'
            ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZLOCALAVAILABILITY || ''
        END AS '075_ZINTERNALRESOURCE.zlocalavailability',

        CASE ZINTERNALRESOURCE.ZLOCALAVAILABILITYTARGET
            WHEN 0 THEN 'Still Testing [0]'
            ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZLOCALAVAILABILITYTARGET || ''
        END AS '076_ZINTERNALRESOURCE.zlocalavailabilitytarget',

        CASE ZINTERNALRESOURCE.ZCLOUDLOCALSTATE
            WHEN 0 THEN 'IR Asset Not Synced No IR CloudMastDateCreated [0]'
            WHEN 1 THEN 'IR Asset Pending Upload [1]'
            WHEN 2 THEN 'IR Asset Photo Cloud Share Asset On Local Device [2]'
            WHEN 3 THEN 'IR Asset Synced iCloud [3]'
            ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZCLOUDLOCALSTATE || ''
        END AS '077_ZINTERNALRESOURCE.zcloudlocalstate',

        CASE ZINTERNALRESOURCE.ZREMOTEAVAILABILITY
            WHEN 0 THEN 'IR Asset Not Avail Remotely [0]'
            WHEN 1 THEN 'IR Asset Avail Remotely [1]'
            ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZREMOTEAVAILABILITY || ''
        END AS '078_ZINTERNALRESOURCE.zremoteavailability',

        CASE ZINTERNALRESOURCE.ZREMOTEAVAILABILITYTARGET
            WHEN 0 THEN 'Still Testing [0]'
            WHEN 1 THEN 'Still Testing [1]'
            ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZREMOTEAVAILABILITYTARGET || ''
        END AS '079_ZINTERNALRESOURCE.zremoteavailabilitytarget',

        ZINTERNALRESOURCE.ZTRANSIENTCLOUDMASTER AS '080_ZINTERNALRESOURCE.ztransientcloudmaster',
        ZINTERNALRESOURCE.ZSIDECARINDEX AS '081_ZINTERNALRESOURCE.zsidecarindex',
        ZINTERNALRESOURCE.ZFILEID AS '082_ZINTERNALRESOURCE.zfileid',

        CASE ZINTERNALRESOURCE.ZVERSION
            WHEN 0 THEN 'IR Asset Standard [0]'
            WHEN 1 THEN 'Still Testing [1]'
            WHEN 2 THEN 'IR Asset Adjustments Mutation [2]'
            WHEN 3 THEN 'IR Asset No IR Cloud Master Date Created [3]'
            ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZVERSION || ''
        END AS '083_ZINTERNALRESOURCE.zversion',

        printf("%,d", ZADDASSETATTR.ZORIGINALFILESIZE) AS '084_ZADDASSETATTR.zoriginalfilesize_bytes',

        CASE ZINTERNALRESOURCE.ZRESOURCETYPE
            WHEN 0 THEN 'Photo [0]'
            WHEN 1 THEN 'Video [1]'
            WHEN 3 THEN 'Live Photo [3]'
            WHEN 5 THEN 'Adjustment Data [5]'
            WHEN 6 THEN 'Screenshot [6]'
            WHEN 9 THEN 'Alternate Photo 3rd Party App - Still Testing [9]'
            WHEN 13 THEN 'Movie [13]'
            WHEN 14 THEN 'Wallpaper [14]'
            ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZRESOURCETYPE || ''
        END AS '085_ZINTERNALRESOURCE.zresourcetype',

        -- hex(ZINTERNALRESOURCE.ZDATASTOREKEYDATA) AS '086_ZINTERNALRESOURCE.zdatastorekeydata(hex)',

        CASE ZINTERNALRESOURCE.ZDATASTORESUBTYPE
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
            WHEN 10 THEN '3rd Party App thumb - Still Testing [10]'
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
            ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZDATASTORESUBTYPE || ''
        END AS '087_ZINTERNALRESOURCE.zdatastoresubtype',

        CASE ZINTERNALRESOURCE.ZCLOUDSOURCETYPE
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
            WHEN 10 THEN '3rd Party App thumb - Still Testing [10]'
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
            ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZCLOUDSOURCETYPE || ''
        END AS '088_ZINTERNALRESOURCE.zcloudsourcetype',

        ZINTERNALRESOURCE.ZDATALENGTH AS '089_ZINTERNALRESOURCE.zdatalength',

        CASE ZINTERNALRESOURCE.ZRECIPEID
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
            WHEN 327683 THEN '.JPG Thumb for 3rd Party - Still Testing [327683]'
            WHEN 327687 THEN 'Wallpaper Compute Resource [627687]'
            ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZRECIPEID || ''
        END AS '090_ZINTERNALRESOURCE.zrecipeid',

        CASE ZINTERNALRESOURCE.ZCLOUDLASTPREFETCHDATE
            WHEN 0 THEN 'N/A [0]'
            ELSE datetime(ZINTERNALRESOURCE.ZCLOUDLASTPREFETCHDATE + 978307200, 'UNIXEPOCH')
        END AS '091_ZINTERNALRESOURCE.zcloudlastprefetchdate_utc',

        ZINTERNALRESOURCE.ZCLOUDPREFETCHCOUNT AS '092_ZINTERNALRESOURCE.ZCLOUDPREFETCHCOUNT',
        datetime(ZINTERNALRESOURCE.ZCLOUDLASTONDEMANDDOWNLOADDATE + 978307200, 'UNIXEPOCH') AS '093_ZINTERNALRESOURCE.zcloudlastondemanddownloaddate_utc',

        CASE ZINTERNALRESOURCE.ZUTICONFORMANCEHINT
            WHEN 0 THEN 'N/A, Does Not Conform [0]'
            WHEN 1 THEN 'UT Type Image [1]'
            WHEN 2 THEN 'UT Type Pro Raw Photo [2]'
            WHEN 3 THEN 'UT Type Movie [3]'
            ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZUTICONFORMANCEHINT || ''
        END AS '094_ZINTERNALRESOURCE.zuticonformancehint',

        CASE ZINTERNALRESOURCE.ZCOMPACTUTI
            WHEN 1 THEN '.JPEG/.THM [1]'
            WHEN 3 THEN '.HEIC [3]'
            WHEN 6 THEN '.PNG [6]'
            WHEN 7 THEN 'Still Testing [7]'
            WHEN 9 THEN '.DNG [9]'
            WHEN 23 THEN '.JPEG/.HEIC/.mov [23]'
            WHEN 24 THEN '.MPEG4 [24]'
            WHEN 36 THEN 'Wallpaper [36]'
            WHEN 37 THEN 'Adj/Mutation Data [37]'
            ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZCOMPACTUTI || ''
        END AS '095_ZINTERNALRESOURCE.zcompactuti',

        ZASSET.ZUNIFORMTYPEIDENTIFIER AS '096_ZASSET.zuniformtypeidentifier',
        ZASSET.ZORIGINALCOLORSPACE AS '097_ZASSET.zoriginalcolorspace',
        ZCLOUDMASTER.ZUNIFORMTYPEIDENTIFIER AS '098_ZCLOUDMASTER.zuniformtypeidentifier',

        CASE ZCLOUDMASTER.ZFULLSIZEJPEGSOURCE
            WHEN 0 THEN 'Cloud Master .JPEG Source Video - Still Testing [0]'
            WHEN 1 THEN 'Cloud Master .JPEG Source Other - Still Testing [1]'
            ELSE 'Unknown Value: ' || ZCLOUDMASTER.ZFULLSIZEJPEGSOURCE || ''
        END AS '099_ZCLOUDMASTER.zfullsizejpegsource',

        CASE ZCLOUDMASTER.ZCLOUDLOCALSTATE
            WHEN 0 THEN 'Not Synced with Cloud [0]'
            WHEN 1 THEN 'Pending Upload [1]'
            WHEN 2 THEN 'Still Testing [2]'
            WHEN 3 THEN 'Synced with Cloud [3]'
            ELSE 'Unknown Value: ' || ZCLOUDMASTER.ZCLOUDLOCALSTATE || ''
        END AS '100_ZCLOUDMASTER.zcloudlocalstate',

        datetime(ZCLOUDMASTER.ZIMPORTDATE + 978307200, 'UNIXEPOCH') AS '101_ZCLOUDMASTER.zimportdate_utc',

        ZASSET.ZIMPORTSESSION AS '102_ZASSET.zimportsession',
        ZADDASSETATTR.ZIMPORTSESSIONID AS '103_ZADDASSETATTR.zimportsessionid',

        datetime(ZADDASSETATTR.ZALTERNATEIMPORTIMAGEDATE + 978307200, 'UNIXEPOCH') AS '104_ZADDASSETATTR.zalternateimportimagedate_utc',

        ZCLOUDMASTER.ZIMPORTSESSIONID AS '105_ZCLOUDMASTER.zimportsessionid',

        datetime(ZASSET.ZCLOUDBATCHPUBLISHDATE + 978307200, 'UNIXEPOCH') AS '106_ZASSET.zcloudbatchpublishdate_utc',
        datetime(ZASSET.ZCLOUDSERVERPUBLISHDATE + 978307200, 'UNIXEPOCH') AS '107_ZASSET.zcloudserverpublishdate_utc',

        ZASSET.ZCLOUDDOWNLOADREQUESTS AS '108_ZASSET.zclouddownloadrequests',
        ZASSET.ZCLOUDBATCHID AS '109_ZASSET.zcloudbatchid',

        datetime(ZADDASSETATTR.ZLASTUPLOADATTEMPTDATE + 978307200, 'UNIXEPOCH') AS '110_ZADDASSETATTR.zlastuploadattemptdate(swy)_utc',

        ZADDASSETATTR.ZUPLOADATTEMPTS AS '111_ZADDASSETATTR.zuploadattempts',

        CASE ZASSET.ZLATITUDE
            WHEN -180.0 THEN '[-180.0]'
            ELSE ZASSET.ZLATITUDE
        END AS '112_ZASSET.zlatitude',

        CASE ZASSET.ZLONGITUDE
            WHEN -180.0 THEN '[-180.0]'
            ELSE ZASSET.ZLONGITUDE
        END AS '113_ZASSET.zlongitude',

        ZEXTATTR.ZLATITUDE AS '114_ZEXTATTR.zlatitude',
        ZEXTATTR.ZLONGITUDE AS '115_ZEXTATTR.zlongitude',

        CASE ZADDASSETATTR.ZGPSHORIZONTALACCURACY
            WHEN -1.0 THEN '[-1.0]'
            ELSE ZADDASSETATTR.ZGPSHORIZONTALACCURACY
        END AS '116_ZADDASSETATTR.zgpshorizontalaccuracy',

        hex(ZASSET.ZLOCATIONDATA) AS '117_ZASSET.zlocationdata(hex)',
        -- ZADDASSETATTR.ZREVERSELOCATIONDATA AS '118_ZADDASSETATTR.zreverselocationdata(orig-asset, hex nskeyed .plist)',

        CASE ZADDASSETATTR.ZSHIFTEDLOCATIONISVALID
            WHEN 0 THEN 'Shifted Location Not Valid [0]'
            WHEN 1 THEN 'Shifted Location Valid [1]'
        END AS '119_ZADDASSETATTR.zshiftedlocationisvalid',

        ZADDASSETATTR.ZSHIFTEDLOCATIONDATA AS '120_ZADDASSETATTR.zshiftedlocationdata',
        ZADDASSETATTR.ZLOCATIONHASH AS '121_ZADDASSETATTR.zlocationhash',

        CASE AAAZCLDMASTMedData.Z_OPT
            WHEN 1 THEN 'Cloud - Still Testing [1]'
            WHEN 2 THEN 'This Device - Still Testing [2]'
            WHEN 3 THEN 'Muted - Still Testing [3]'
            WHEN 4 THEN 'Unknown - Still Testing [4]'
            WHEN 5 THEN 'Unknown - Still Testing [5]'
            ELSE 'Unknown Value: ' || AAAZCLDMASTMedData.Z_OPT || ''
        END AS '122_AAAZCLDMASTMedData.z_opt',

        ZADDASSETATTR.ZMEDIAMETADATATYPE AS '123_ZADDASSETATTR.zmediametadatatype',
        -- hex(AAAZCLDMASTMedData.ZDATA) AS '124_AAAZCLDMASTMedData.zdata(hex)',

        CASE CMZCLDMASTMedData.Z_OPT
            WHEN 1 THEN 'Has Cloud Master Asset - Still Testing [1]'
            WHEN 2 THEN 'Local Asset - Still Testing [2]'
            WHEN 3 THEN 'Muted - Still Testing [3]'
            WHEN 4 THEN 'Unknown - Still Testing [4]'
            WHEN 5 THEN 'Unknown - Still Testing [5]'
            ELSE 'Unknown Value: ' || CMZCLDMASTMedData.Z_OPT || ''
        END AS '125_CldMasterZCLDMASTMedData.z_opt',

        ZCLOUDMASTER.ZMEDIAMETADATATYPE AS '126_ZCLOUDMASTER.zmediametadatatype',
        -- CMZCLDMASTMedData.ZDATA AS '127_CMZCLDMASTMedData.zdata(hex)',

        CASE ZASSET.ZSEARCHINDEXREBUILDSTATE
            WHEN 0 THEN 'Still Testing [0]'
            ELSE 'Unknown Value: ' || ZASSET.ZSEARCHINDEXREBUILDSTATE || ''
        END AS '128_ZASSET.zsearchindexrebuildstate',

        CASE ZASSET.ZORIENTATION
            WHEN 1 THEN 'Video Default/Adjustment/Horizontal Camera (left) [1]'
            WHEN 2 THEN 'Horizontal Camera (right) [2]'
            WHEN 3 THEN 'Horizontal Camera (right) [3]'
            WHEN 4 THEN 'Horizontal Camera (left) [4]'
            WHEN 5 THEN 'Vertical Camera (top) [5]'
            WHEN 6 THEN 'Vertical Camera (top) [6]'
            WHEN 7 THEN 'Vertical Camera (bottom) [7]'
            WHEN 8 THEN 'Vertical Camera (bottom) [8]'
            ELSE 'Unknown Value: ' || ZASSET.ZORIENTATION || ''
        END AS '129_ZASSET.zorientation',

        CASE ZADDASSETATTR.ZORIGINALORIENTATION
            WHEN 1 THEN 'Video Default/Adjustment/Horizontal Camera (left) [1]'
            WHEN 2 THEN 'Horizontal Camera (right) [2]'
            WHEN 3 THEN 'Horizontal Camera (right) [3]'
            WHEN 4 THEN 'Horizontal Camera (left) [4]'
            WHEN 5 THEN 'Vertical Camera (top) [5]'
            WHEN 6 THEN 'Vertical Camera (top) [6]'
            WHEN 7 THEN 'Vertical Camera (bottom) [7]'
            WHEN 8 THEN 'Vertical Camera (bottom) [8]'
            ELSE 'Unknown Value: ' || ZADDASSETATTR.ZORIGINALORIENTATION || ''
        END AS '130_ZADDASSETATTR.zoriginalorientation',

        CASE ZASSET.ZKIND
            WHEN 0 THEN 'Photo [0]'
            WHEN 1 THEN 'Video [1]'
        END AS '131_ZASSET.zkind',

        CASE ZASSET.ZKINDSUBTYPE
            WHEN 0 THEN 'Still Photo [0]'
            WHEN 2 THEN 'Live Photo [2]'
            WHEN 10 THEN 'SpringBoard Screenshot [10]'
            WHEN 100 THEN 'Video [100]'
            WHEN 101 THEN 'Slow-Mo Video [101]'
            WHEN 102 THEN 'Time-lapse Video [102]'
            WHEN 103 THEN 'Replay Screen Recording [103]'
            ELSE 'Unknown Value: ' || ZASSET.ZKINDSUBTYPE || ''
        END AS '132_ZASSET.zkindsubtype',

        CASE ZADDASSETATTR.ZCLOUDKINDSUBTYPE
            WHEN 0 THEN 'Still Photo [0]'
            WHEN 1 THEN 'Still Testing [1]'
            WHEN 2 THEN 'Live Photo [2]'
            WHEN 3 THEN 'Screenshot [3]'
            WHEN 10 THEN 'SpringBoard Screenshot [10]'
            WHEN 100 THEN 'Video [100]'
            WHEN 101 THEN 'Slow-Mo Video [101]'
            WHEN 102 THEN 'Time-lapse Video [102]'
            WHEN 103 THEN 'Replay Screen Recording [103]'
            ELSE 'Unknown Value: ' || ZADDASSETATTR.ZCLOUDKINDSUBTYPE || ''
        END AS '133_ZADDASSETATTR.zcloudkindsubtype',

        CASE ZASSET.ZPLAYBACKSTYLE
            WHEN 1 THEN 'Image [1]'
            WHEN 2 THEN 'Image Animated [2]'
            WHEN 3 THEN 'Live Photo [3]'
            WHEN 4 THEN 'Video [4]'
            WHEN 5 THEN 'Video Looping [5]'
            ELSE 'Unknown Value: ' || ZASSET.ZPLAYBACKSTYLE || ''
        END AS '134_ZASSET.zplaybackstyle',

        ZASSET.ZPLAYBACKVARIATION AS '135_ZASSET.zplaybackvariation',
        ZASSET.ZDURATION AS '136_ZASSET.zduration',
        ZEXTATTR.ZDURATION AS '137_ZEXTATTR.zduration',
        ZASSET.ZVIDEOCPDURATIONVALUE AS '138_ZASSET.zvideocpdurationvalue',
        ZADDASSETATTR.ZVIDEOCPDURATIONTIMESCALE AS '139_ZADDASSETATTR.zvideocpdurationtimescale',
        ZASSET.ZVIDEOCPVISIBILITYSTATE AS '140_ZASSET.zvideocpvisibilitystate',
        ZADDASSETATTR.ZVIDEOCPDISPLAYVALUE AS '141_ZADDASSETATTR.zvideocpdisplayvalue',
        ZADDASSETATTR.ZVIDEOCPDISPLAYTIMESCALE AS '142_ZADDASSETATTR.zvideocpdisplaytimescale',

        -- [ZINTERNALRESOURCE.ZASSET = ZASSET.Z_PK]
        ZINTERNALRESOURCE.ZASSET AS '143_ZINTERNALRESOURCE.zasset',
        ZINTERNALRESOURCE.Z_PK AS '144_ZINTERNALRESOURCE.z_pk',
        ZINTERNALRESOURCE.Z_ENT AS '145_ZINTERNALRESOURCE.z_ent',
        ZINTERNALRESOURCE.Z_OPT AS '146_ZINTERNALRESOURCE.z_opt',
        ZASSET.ZHDRGAIN AS '147_ZASSET.zhdrgain',

        CASE ZASSET.ZHDRTYPE
            WHEN 0 THEN 'No HDR [0]'
            WHEN 3 THEN 'HDR Photo [3]'
            WHEN 4 THEN 'Non HDR Version [4]'
            WHEN 5 THEN 'HEVC Movie [5]'
            WHEN 6 THEN 'Panorama [6]'
            WHEN 10 THEN 'HDR Gain [10]'
            ELSE 'Unknown Value: ' || ZASSET.ZHDRTYPE || ''
        END AS '148_ZASSET.zhdrtype',

        ZEXTATTR.ZCODEC AS '149_ZEXTATTR.zcodec',
        ZINTERNALRESOURCE.ZCODECFOURCHARCODENAME AS '150_ZINTERNALRESOURCE.zcodecfourcharcodename',
        ZCLOUDMASTER.ZCODECNAME AS '151_ZCLOUDMASTER.zcodecname',
        ZCLOUDMASTER.ZVIDEOFRAMERATE AS '152_ZCLOUDMASTER.zvideoframerate',
        ZCLOUDMASTER.ZPLACEHOLDERSTATE AS '153_ZCLOUDMASTER.zplaceholderstate',

        CASE ZASSET.ZDEPTHTYPE
            WHEN 0 THEN 'Not Portrait [0]'
            ELSE 'Portrait: ' || ZASSET.ZDEPTHTYPE || ''
        END AS '154_ZASSET.zdepthtype',

        ZASSET.ZAVALANCHEUUID AS '155_ZASSET.zavalancheuuid',

        CASE ZASSET.ZAVALANCHEPICKTYPE
            WHEN 0 THEN 'NA/Single Asset Burst UUID [0]'
            WHEN 2 THEN 'Burst Asset Not Selected [2]'
            WHEN 4 THEN 'Burst Asset PhotosApp Picked Key Image [4]'
            WHEN 8 THEN 'Burst Asset Selected for LPL [8]'
            WHEN 16 THEN 'Top Burst Asset inStack Key Image [16]'
            WHEN 32 THEN 'Still Testing [32]'
            WHEN 52 THEN 'Burst Asset Visible LPL [52]'
            ELSE 'Unknown Value: ' || ZASSET.ZAVALANCHEPICKTYPE || ''
        END AS '156_ZASSET.zavalanchepicktype',

        CASE ZADDASSETATTR.ZCLOUDAVALANCHEPICKTYPE
            WHEN 0 THEN 'NA/Single Asset Burst UUID [0]'
            WHEN 2 THEN 'Burst Asset Not Selected [2]'
            WHEN 4 THEN 'Burst Asset PhotosApp Picked Key Image [4]'
            WHEN 8 THEN 'Burst Asset Selected for LPL [8]'
            WHEN 16 THEN 'Top Burst Asset inStack Key Image [16]'
            WHEN 32 THEN 'Still Testing [32]'
            WHEN 52 THEN 'Burst Asset Visible LPL [52]'
            ELSE 'Unknown Value: ' || ZADDASSETATTR.ZCLOUDAVALANCHEPICKTYPE || ''
        END AS '157_ZADDASSETATTR.zcloudavalanchepicktype',

        CASE ZADDASSETATTR.ZCLOUDRECOVERYSTATE
            WHEN 0 THEN 'Still Testing [0]'
            WHEN 1 THEN 'Still Testing [1]'
            ELSE 'Unknown Value: ' || ZADDASSETATTR.ZCLOUDRECOVERYSTATE || ''
        END AS '158_ZADDASSETATTR.zcloudrecoverystate',

        ZADDASSETATTR.ZCLOUDSTATERECOVERYATTEMPTSCOUNT AS '159_ZADDASSETATTR.zcloudstaterecoveryattemptscount',
        ZASSET.ZDEFERREDPROCESSINGNEEDED AS '160_ZASSET.zdeferredprocessingneeded',
        ZASSET.ZVIDEODEFERREDPROCESSINGNEEDED AS '161_ZASSET.zvideodeferredprocessingneeded',
        ZADDASSETATTR.ZDEFERREDPHOTOIDENTIFIER AS '162_ZADDASSETATTR.zdeferredphotoidentifier',
        ZADDASSETATTR.ZDEFERREDPROCESSINGCANDIDATEOPTIONS AS '163_ZADDASSETATTR.zdeferredprocessingcandidateoptions',

        -- CASE ZASSET.ZHASADJUSTMENTS
        --     WHEN 0 THEN '0 [No Adjustments]'
        --     WHEN 1 THEN '1 [Yes Adjustments]'
        --     ELSE 'Unknown Value: ' || ZASSET.ZHASADJUSTMENTS || ''
        -- END AS '164_ZASSET.zhasadjustments',

        -- [ZUNMADJ.ZASSETATTRIBUTES = ZADDASSETATTR.Z_PK]
        ZUNMADJ.ZASSETATTRIBUTES AS '165_ZUNMADJ.zassetattributes',
        -- [ZADDASSETATTR.ZUNMANAGEDADJUSTMENT = ZUNMADJ.Z_PK]
        ZADDASSETATTR.ZUNMANAGEDADJUSTMENT AS '166_ZADDASSETATTR.zunmanagedadjustment',
        -- [ZUNMADJ.Z_PK = ZADDASSETATTR.ZUNMANAGEDADJUSTMENT]
        ZUNMADJ.Z_PK AS '167_ZUNMADJ.z_pk',
        ZUNMADJ.ZUUID AS '168_ZUNMADJ.uuid',
        datetime(ZASSET.ZADJUSTMENTTIMESTAMP + 978307200, 'UNIXEPOCH') AS '169_ZASSET.zadjustmenttimestamp_utc',
        datetime(ZUNMADJ.ZADJUSTMENTTIMESTAMP + 978307200, 'UNIXEPOCH') AS '170_ZUNMADJ.zadjustmenttimestamp_utc',
        ZADDASSETATTR.ZEDITORBUNDLEID AS '171_ZADDASSETATTR.zeditorbundleid',
        ZUNMADJ.ZEDITORLOCALIZEDNAME AS '172_ZUNMADJ.zeditorlocalizedname',
        ZUNMADJ.ZADJUSTMENTFORMATIDENTIFIER AS '173_ZUNMADJ.zadjustmentformatidentifier',
        ZADDASSETATTR.ZMONTAGE AS '174_ZADDASSETATTR.zmontage',

        CASE ZUNMADJ.ZADJUSTMENTRENDERTYPES
            WHEN 0 THEN 'Standard or Portrait with errors [0]'
            WHEN 1 THEN 'Still Testing [1]'
            WHEN 2 THEN 'Portrait [2]'
            WHEN 3 THEN 'Still Testing [3]'
            WHEN 4 THEN 'Still Testing [4]'
            ELSE 'Unknown Value: ' || ZUNMADJ.ZADJUSTMENTRENDERTYPES || ''
        END AS '175_ZUNMADJ.zadjustmentrendertypes',

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
        END AS '176_ZUNMADJ.zadjustmentformatversion',

        ZUNMADJ.ZADJUSTMENTBASEIMAGEFORMAT AS '177_ZUNMADJ.zadjustmentbaseimageformat',

        CASE ZASSET.ZFAVORITE
            WHEN 0 THEN 'Not Favorite [0]'
            WHEN 1 THEN 'Favorite [1]'
        END AS '178_ZASSET.zfavorite',

        CASE ZASSET.ZHIDDEN
            WHEN 0 THEN 'Not Hidden [0]'
            WHEN 1 THEN 'Hidden [1]'
            ELSE 'Unknown Value: ' || ZASSET.ZHIDDEN || ''
        END AS '179_ZASSET.zhidden',

        CASE ZASSET.ZTRASHEDSTATE
            WHEN 0 THEN 'Not In Trash/Recently Deleted [0]'
            WHEN 1 THEN 'In Trash/Recently Deleted [1]'
            ELSE 'Unknown Value: ' || ZASSET.ZTRASHEDSTATE || ''
        END AS '180_ZASSET.ztrashedstate (local asset recently deleted)',

        datetime(ZASSET.ZTRASHEDDATE + 978307200, 'UNIXEPOCH') AS '181_ZASSET.ztrasheddate_utc',

        CASE ZASSET.ZDELETEREASON
            WHEN 1 THEN 'Delete Reason - Still Testing [1]'
            WHEN 2 THEN 'Delete Reason - Still Testing [2]'
            WHEN 3 THEN 'Delete Reason - Still Testing [3]'
            ELSE 'Unknown Value: ' || ZASSET.ZDELETEREASON || ''
        END AS '182_ZASSET.zdeletereason',

        CASE ZASSET.ZTRASHEDBYPARTICIPANT
            WHEN 1 THEN 'Trashed/Recently Deleted by Participant [1]'
            ELSE 'Unknown Value: ' || ZASSET.ZTRASHEDBYPARTICIPANT || ''
        END AS '183_ZASSET.ztrashedbyparticipant',

        CASE ZINTERNALRESOURCE.ZTRASHEDSTATE
            WHEN 0 THEN 'INTRESOU Not In Trash/Recently Deleted [0]'
            WHEN 1 THEN 'INTRESOU In Trash/Recently Deleted [1]'
            ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZTRASHEDSTATE || ''
        END AS '184_ZINTERNALRESOURCE.ztrashedstate',

        datetime(ZINTERNALRESOURCE.ZTRASHEDDATE + 978307200, 'UNIXEPOCH') AS '185_ZINTERNALRESOURCE.ztrasheddate_utc',

        CASE ZASSET.ZCLOUDDELETESTATE
            WHEN 0 THEN 'CLOUD Asset Not Deleted [0]'
            WHEN 1 THEN 'CLOUD Asset Deleted [1]'
            ELSE 'Unknown Value: ' || ZASSET.ZCLOUDDELETESTATE || ''
        END AS '186_ZASSET.zclouddeletestate',

        CASE ZINTERNALRESOURCE.ZCLOUDDELETESTATE
            WHEN 0 THEN 'CLOUD IntResou Not Deleted [0]'
            WHEN 1 THEN 'CLOUD IntResou Deleted [1]'
            ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZCLOUDDELETESTATE || ''
        END AS '187_ZINTERNALRESOURCE.zclouddeletestate',

        CASE ZADDASSETATTR.ZPTPTRASHEDSTATE
            WHEN 0 THEN 'PTP Not in Trash [0]'
            WHEN 1 THEN 'PTP In Trash [1]'
            ELSE 'Unknown Value: ' || ZADDASSETATTR.ZPTPTRASHEDSTATE || ''
        END AS '188_ZADDASSETATTR.zptptrashedstate',

        CASE ZINTERNALRESOURCE.ZPTPTRASHEDSTATE
            WHEN 0 THEN 'PTP IntResou Not in Trash [0]'
            WHEN 1 THEN 'PTP IntResou In Trash [1]'
            ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZPTPTRASHEDSTATE || ''
        END AS '189_ZINTERNALRESOURCE.zptptrashedstate',

        ZINTERNALRESOURCE.ZCLOUDDELETEASSETUUIDWITHRESOURCETYPE AS '190_ZINTERNALRESOURCE.zclouddeleteassetuuidwithresourcetype',

        datetime(ZMEDIAANALYSISASSETATTRIBUTES.ZMEDIAANALYSISTIMESTAMP + 978307200, 'UNIXEPOCH') AS '191_ZMEDIAANALYSISASSETATTRIBUTES.zmediaanalysistimestamp_utc',
        datetime(ZASSET.ZANALYSISSTATEMODIFICATIONDATE + 978307200, 'UNIXEPOCH') AS '192_ZASSET.zanalysisstatemodificationdate_utc',

        ZADDASSETATTR.ZPENDINGVIEWCOUNT AS '193_ZADDASSETATTR.zpendingviewcount',
        ZADDASSETATTR.ZVIEWCOUNT AS '194_ZADDASSETATTR.zviewcount',
        ZADDASSETATTR.ZPENDINGPLAYCOUNT AS '195_ZADDASSETATTR.zpendingplaycount',
        ZADDASSETATTR.ZPLAYCOUNT AS '196_ZADDASSETATTR.zplaycount',
        ZADDASSETATTR.ZPENDINGSHARECOUNT AS '197_ZADDASSETATTR.zpendingsharecount',
        ZADDASSETATTR.ZSHARECOUNT AS '198_ZADDASSETATTR.zsharecount',

        datetime(ZASSET.ZLASTSHAREDDATE + 978307200, 'UNIXEPOCH') AS '199_ZASSET.zlastshareddate_utc',

        ZADDASSETATTR.ZSHAREORIGINATOR AS '200_ZADDASSETATTR.zshareoriginator',

        CASE ZASSET.ZSYNDICATIONSTATE
            WHEN 0 THEN 'Local PL Asset - Syndication State N/A [0]'
            ELSE 'Unknown Value: ' || ZASSET.ZSYNDICATIONSTATE || ''
        END AS '201_ZASSET.zsyndicationstate(lpl)',

        ZADDASSETATTR.ZSYNDICATIONHISTORY AS '202_ZADDASSETATTR.zsyndicationhistory',
        ZMEDIAANALYSISASSETATTRIBUTES.ZSYNDICATIONPROCESSINGVERSION AS '203_ZMEDIAANALYSISASSETATTRIBUTES.zsyndicationprocessingversion',

        CASE ZMEDIAANALYSISASSETATTRIBUTES.ZSYNDICATIONPROCESSINGVALUE
            WHEN 0 THEN 'N/A [0]'
            WHEN 1 THEN 'Wide Camera JPG - Still Testing [1]'
            WHEN 2 THEN 'Telephoto Camera Lens - Still Testing [2]'
            WHEN 4 THEN 'SWY Asset Orig Asset Import System Package App - Still Testing [4]'
            WHEN 16 THEN 'Still Testing [16]'
            WHEN 1024 THEN 'SWY Asset OrigAssetImport Native Camera - Still Testing [1024]'
            WHEN 2048 THEN 'Still Testing [2048]'
            WHEN 4096 THEN 'SWY Asset Manually Saved - Still Testing [4096]'
            ELSE 'Unknown Value: ' || ZMEDIAANALYSISASSETATTRIBUTES.ZSYNDICATIONPROCESSINGVALUE || ''
        END AS '204_ZMEDIAANALYSISASSETATTRIBUTES.zsyndicationprocessingvalue',

        -- datetime(ZMEDIAANALYSISASSETATTRIBUTES.ZVAANALYSISTIMESTAMP + 978307200, 'UNIXEPOCH') AS '205_ZMEDIAANALYSISASSETATTRIBUTES.zvaanalysistimestamp_utc',
        -- ZMEDIAANALYSISASSETATTRIBUTES.ZVAANALYSISVERSION AS '206_ZMEDIAANALYSISASSETATTRIBUTES.zvaanalysisversion',

        CASE ZADDASSETATTR.ZALLOWEDFORANALYSIS
            WHEN 0 THEN 'Asset Not Allowed For Analysis [0]'
            WHEN 1 THEN 'Asset Allowed for Analysis [1]'
            ELSE 'Unknown Value: ' || ZADDASSETATTR.ZALLOWEDFORANALYSIS || ''
        END AS '207_ZADDASSETATTR.zallowedforanalysis',

        ZADDASSETATTR.ZSCENEANALYSISVERSION AS '208_ZADDASSETATTR.zsceneanalysisversion',

        CASE ZADDASSETATTR.ZSCENEANALYSISISFROMPREVIEW
            WHEN 0 THEN 'No [0]'
            ELSE 'Unknown Value: ' || ZADDASSETATTR.ZSCENEANALYSISISFROMPREVIEW || ''
        END AS '209_ZADDASSETATTR.zsceneanalysisisfrompreview',

        datetime(ZADDASSETATTR.ZSCENEANALYSISTIMESTAMP + 978307200, 'UNIXEPOCH') AS '210_ZADDASSETATTR.zsceneanalysistimestamp_utc',

        CASE ZASSET.ZDUPLICATEASSETVISIBILITYSTATE
            WHEN 0 THEN 'No Duplicates [0]'
            WHEN 1 THEN 'Has Duplicate [1]'
            WHEN 2 THEN 'Is a Duplicate [2]'
            ELSE 'Unknown Value: ' || ZASSET.ZDUPLICATEASSETVISIBILITYSTATE || ''
        END AS '211_ZASSET.zduplicateassetvisibilitystate',

        CASE ZADDASSETATTR.ZDESTINATIONASSETCOPYSTATE
            WHEN 0 THEN 'No Copy] [0]'
            WHEN 1 THEN 'Has A Copy [1]'
            WHEN 2 THEN 'Has A Copy [2]'
            ELSE 'Unknown Value: ' || ZADDASSETATTR.ZDESTINATIONASSETCOPYSTATE || ''
        END AS '212_ZADDASSETATTR.ZDESTINATIONASSETCOPYSTATE',

        -- ZSCENEPRINT.ZDATA AS '213_ZSCENEPRINT.zdata(nskeyed .plist)',
        -- ZSCENEPRINT.ZDUPLICATEMATCHINGDATA AS '214_ZSCENEPRINT.zduplicatematchingdata(nskeyed .plist)',
        -- ZSCENEPRINT.ZDUPLICATEMATCHINGALTERNATEDATA AS '215_ZSCENEPRINT.zduplicatematchingalternatedata(nskeyed .plist)',
        ZADDASSETATTR.ZSOURCEASSETFORDUPLICATIONSCOPEIDENTIFIER AS '216_ZADDASSETATTR.zsourceassetforduplicationscopeidentifier',
        ZCLOUDMASTER.ZSOURCEMASTERFORDUPLICATIONSCOPEIDENTIFIER AS '217_ZCLOUDMASTER.zsourcemasterforduplicationscopeidentifier',
        ZADDASSETATTR.ZSOURCEASSETFORDUPLICATIONIDENTIFIER AS '218_ZADDASSETATTR.zsourceassetforduplicationidentifier',
        ZCLOUDMASTER.ZSOURCEMASTERFORDUPLICATIONIDENTIFIER AS '219_ZCLOUDMASTER.zsourcemasterforduplicationidentifier',
        ZEXTATTR.Z_ENT AS '220_ZEXTATTR.z_ent',
        ZEXTATTR.Z_OPT AS '221_ZEXTATTR.z_opt',
        ZADDASSETATTR.ZVARIATIONSUGGESTIONSTATES AS '222_ZADDASSETATTR.zvariationsuggestionstates',
        ZASSET.ZHIGHFRAMERATESTATE AS '223_ZASSET.zhighframeratestate',
        ZASSET.ZVIDEOKEYFRAMETIMESCALE AS '224_ZASSET.zvideokeyframetimescale',
        ZASSET.ZVIDEOKEYFRAMEVALUE AS '225_ZASSET.zvideokeyframevalue',
        ZEXTATTR.ZISO AS '226_ZEXTATTR.ziso',
        ZEXTATTR.ZMETERINGMODE AS '227_ZEXTATTR.zmeteringmode',
        ZEXTATTR.ZSAMPLERATE AS '228_ZEXTATTR.zsamplerate',
        ZEXTATTR.ZTRACKFORMAT AS '229_ZEXTATTR.ztrackformat',
        ZEXTATTR.ZWHITEBALANCE AS '230_ZEXTATTR.zwhitebalance',
        ZEXTATTR.ZASSET AS '231_ZEXTATTR.zasset',
        ZEXTATTR.ZAPERTURE AS '232_ZEXTATTR.zaperture',
        ZEXTATTR.ZBITRATE AS '233_ZEXTATTR.zbitrate',
        ZEXTATTR.ZEXPOSUREBIAS AS '234_ZEXTATTR.zexposurebias',
        ZEXTATTR.ZFPS AS '235_ZEXTATTR.zfps',
        ZEXTATTR.ZSHUTTERSPEED AS '236_ZEXTATTR.zshutterspeed',
        ZEXTATTR.ZSLUSHSCENEBIAS AS '237_ZEXTATTR.zslushscenebias',
        ZEXTATTR.ZSLUSHVERSION AS '238_ZEXTATTR.zslushversion',
        ZEXTATTR.ZSLUSHPRESET AS '239_ZEXTATTR.zslushpreset',
        ZEXTATTR.ZSLUSHWARMTHBIAS AS '240_ZEXTATTR.zslushwarmthbias',
        ZASSET.ZHEIGHT AS '241_ZASSET.zheight',
        ZADDASSETATTR.ZORIGINALHEIGHT AS '242_ZADDASSETATTR.zoriginalheight',
        ZINTERNALRESOURCE.ZUNORIENTEDHEIGHT AS '243_ZINTERNALRESOURCE.zunorientedheight',
        ZASSET.ZWIDTH AS '244_ZASSET.zwidth',
        ZADDASSETATTR.ZORIGINALWIDTH AS '245_ADDASSETATTR.zoriginalwidth',
        ZINTERNALRESOURCE.ZUNORIENTEDWIDTH AS '246_ZINTERNALRESOURCE.zunorientedwidth',
        ZSHARE.ZTHUMBNAILIMAGEDATA AS '247_ZSHARE.zthumbnailimagedata',
        ZASSET.ZTHUMBNAILINDEX AS '248_ZASSET.zthumbnailindex',
        ZADDASSETATTR.ZEMBEDDEDTHUMBNAILHEIGHT AS '249_ZADDASSETATTR.zembeddedthumbnailheight',
        ZADDASSETATTR.ZEMBEDDEDTHUMBNAILLENGTH AS '250_ZADDASSETATTR.zembeddedthumbnaillength',
        ZADDASSETATTR.ZEMBEDDEDTHUMBNAILOFFSET AS '251_ZADDASSETATTR.zembeddedthumbnailoffset',
        ZADDASSETATTR.ZEMBEDDEDTHUMBNAILWIDTH AS '252_ZADDASSETATTR.zembeddedthumbnailwidth',
        ZASSET.ZPACKEDACCEPTABLECROPRECT AS '253_ZASSET.zpackedacceptablecroprect',
        ZASSET.ZPACKEDBADGEATTRIBUTES AS '254_ZASSET.zpackedbadgeattributes',
        ZASSET.ZPACKEDPREFERREDCROPRECT AS '255_ZASSET.zpackedpreferredcroprect',
        ZASSET.ZCURATIONSCORE AS '256_ZASSET.zcurationscore',
        ZASSET.ZCAMERAPROCESSINGADJUSTMENTSTATE AS '257_ZASSET.zcameraprocessingadjustmentstate',
        ZASSET.ZDEPTHTYPE AS '258_ZASSET.zdepthtype',
        ZASSET.ZISMAGICCARPET AS '259_ZASSET.zismagiccarpet',
        ZASSET.ZLIBRARYSCOPE AS '260_ZASSET.zlibraryscope',

        CASE ZASSET.ZLIBRARYSCOPESHARESTATE
            WHEN 0 THEN 'Not Shared - Still Testing [0]'
            ELSE 'Unknown Value: ' || ZASSET.ZLIBRARYSCOPESHARESTATE || ''
        END AS '261_ZASSET.zlibraryscopesharestate',

        ZADDASSETATTR.ZORIGINALRESOURCECHOICE AS '262_ZADDASSETATTR.zoriginalresourcechoice',
        ZADDASSETATTR.ZSPATIALOVERCAPTUREGROUPIDENTIFIER AS '263_ZADDASSETATTR.zspatialovercapturegroupidentifier',
        -- hex(ZADDASSETATTR.ZOBJECTSALIENCYRECTSDATA) AS '264_ZADDASSETATTR.zobjectsaliencyrectsdata(nskeyed .plist)',
        -- hex(ZADDASSETATTR.ZORIGINALHASH) AS '265_ZADDASSETATTR.zoriginalhash(hex)',
        ZADDASSETATTR.ZPLACEANNOTATIONDATA AS '266_ZADDASSETATTR.zplaceannotationdata',
        ZADDASSETATTR.ZDISTANCEIDENTITY AS '267_ZADDASSETATTR.zdistanceidentity',

    /* Source for each line of data */
    -- /LOCAL PHOTO LIBRARY/
    '/private/var/mobile/Media/PhotoData/Photos.sqlite; ZASSET(Z_PK:' || ZASSET.Z_PK || ')' AS 'data_source'


    FROM ZASSET

        LEFT JOIN ZADDITIONALASSETATTRIBUTES ZADDASSETATTR ON ZADDASSETATTR.Z_PK = ZASSET.ZADDITIONALATTRIBUTES
        LEFT JOIN ZEXTENDEDATTRIBUTES ZEXTATTR ON ZEXTATTR.Z_PK = ZASSET.ZEXTENDEDATTRIBUTES
        LEFT JOIN ZINTERNALRESOURCE ON ZINTERNALRESOURCE.ZASSET = ZASSET.Z_PK
        LEFT JOIN ZSCENEPRINT ON ZSCENEPRINT.Z_PK = ZADDASSETATTR.ZSCENEPRINT
        LEFT JOIN Z_30ASSETS ON Z_30ASSETS.Z_3ASSETS = ZASSET.Z_PK
        LEFT JOIN ZGENERICALBUM ZGENALBUM ON ZGENALBUM.Z_PK = Z_30ASSETS.Z_30ALBUMS
        LEFT JOIN ZUNMANAGEDADJUSTMENT ZUNMADJ ON ZADDASSETATTR.ZUNMANAGEDADJUSTMENT = ZUNMADJ.Z_PK
        LEFT JOIN Z_29ALBUMLISTS ON Z_29ALBUMLISTS.Z_29ALBUMS = ZGENALBUM.Z_PK
        LEFT JOIN ZALBUMLIST ON ZALBUMLIST.Z_PK = Z_29ALBUMLISTS.Z_2ALBUMLISTS
        LEFT JOIN ZGENERICALBUM ParentZGENALBUM ON ParentZGENALBUM.Z_PK = ZGENALBUM.ZPARENTFOLDER
        LEFT JOIN ZCLOUDMASTER ON ZASSET.ZMASTER = ZCLOUDMASTER.Z_PK
        LEFT JOIN ZCLOUDMASTERMEDIAMETADATA AAAZCLDMASTMedData ON AAAZCLDMASTMedData.Z_PK = ZADDASSETATTR.ZMEDIAMETADATA
        LEFT JOIN ZCLOUDMASTERMEDIAMETADATA CMZCLDMASTMedData ON CMZCLDMASTMedData.Z_PK = ZCLOUDMASTER.ZMEDIAMETADATA
        LEFT JOIN ZMEDIAANALYSISASSETATTRIBUTES ON ZASSET.ZMEDIAANALYSISATTRIBUTES = ZMEDIAANALYSISASSETATTRIBUTES.Z_PK
        LEFT JOIN ZSHARE ON ZSHARE.Z_PK = ZASSET.ZMOMENTSHARE


    ORDER BY ZASSET.ZADDEDDATE
)


SELECT *


FROM joined


WHERE
    FILEPATH LIKE '%.webp%'