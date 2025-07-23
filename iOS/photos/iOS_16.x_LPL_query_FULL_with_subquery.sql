/*
[DLU]
    14-Jul-2025

[NOTES]
    Modified from original iOS 15 query copied from: https://github.com/ScottKjr3347/iOS_Local_PL_Photos.sqlite_Queries/blob/main/iOS15/Previous_Queries/iOS15_LPL_Phsql_Basic.txt
*/

WITH joined AS (

    SELECT

        ROW_NUMBER() OVER() AS '001-RECORD',
        ZASSET.ZSORTTOKEN AS '002-ZASSET.ZSORTTOKEN',
        ZASSET.ZPROMOTIONSCORE AS '003-ZASSET.ZPROMOTIONSCORE',

        CASE ZASSET.ZCOMPLETE
            WHEN 1 THEN '1  [Yes]'
            ELSE ZASSET.ZCOMPLETE
        END AS '004-ZASSET.ZCOMPLETE',

        ZASSET.Z_PK AS '005-ZASSET.Z_PK',
        ZADDASSETATTR.Z_PK AS '006-ZADDASSETATTR.Z_PK',

        -- [ZCLDMAST.Z_PK = ZASSET.Z_MASTER]
        ZCLDMAST.Z_PK AS '007-ZCLDMAST.Z_PK',

        -- [ZASSET.ZMASTER = ZCLDMAST.Z_PK]
        ZASSET.ZMASTER AS '008-ZASSET.ZMASTER',

        -- [ZASSET.EXTDATTR = ZEXTATTR.Z_PK]
        ZASSET.ZEXTENDEDATTRIBUTES AS '009-ZASSET.ZEXTENDEDATTRIBUTES',
        ZEXTATTR.Z_PK AS '010-ZEXTATTR.Z_PK',

        -- [CMZCLDMASTMEDDATA.ZCLOUDMASTER = ZCLDMAST.Z_PK]
        CMZCLDMASTMedData.ZCLOUDMASTER AS '011-CMZCLDMASTMEDDATA.ZCLOUDMASTER',

        -- [ZCLDMAST.ZMEDIAMETADATA = ZCLDMASTMEDDATA.Z_PK]
        ZCLDMAST.ZMEDIAMETADATA AS '012-ZCLDMAST.ZMEDIAMETADATA',

        -- [CMZCLDMASTMEDDATA.Z_PK = ZADDASSETATTR&ZCLDMAST.ZMEDIAMETADATA]
        CMZCLDMASTMedData.Z_PK AS '013-CMZCLDMASTMEDDATA.Z_PK',
        CMZCLDMASTMedData.Z_ENT AS '014-CMZCLDMASTMEDDATA.Z_ENT',
        ZASSET.ZUUID AS '015-ZASSET.ZUUID',
        ZASSET.ZCLOUDASSETGUID AS '016-ZASSET.ZCLOUDASSETGUID',
        ZASSET.ZCLOUDCOLLECTIONGUID AS '017-ZASSET.ZCLOUDCOLLECTGUID',
        ZCLDMAST.ZCLOUDMASTERGUID AS '018-ZCLDMAST.ZCLOUDMASTERGUID',
        ZGENALBUM.ZCLOUDGUID AS '019-ZGENALBUM.ZCLOUDGUID',
        ZSHARE.ZSCOPEIDENTIFIER AS '020-ZSHARE.ZSCOPEIDENTIFIER',
        ZADDASSETATTR.ZORIGINALASSETSUUID AS '021-ZADDASSETATTR.ZORIGINALASSETSUUID',
        ZADDASSETATTR.ZPUBLICGLOBALUUID AS '022-ZADDASSETATTR.ZPUBLICGLOBALUUID',
        ZADDASSETATTR.ZMASTERFINGERPRINT AS '023-ZADDASSETATTR.ZMASTERFINGERPRINT',
        ZADDASSETATTR.ZORIGINATINGASSETIDENTIFIER AS '024-ZADDASSETATTR.ZORIGINATINGASSETIDENTIFIER',
        ZCLDMAST.ZORIGINATINGASSETIDENTIFIER AS '025-ZCLDMAST.ZORIGINATINGASSETIDENTIFIER',


        ZASSET.ZDIRECTORY AS '026-ZASSET.ZDIRECTORY',
        ZASSET.ZFILENAME AS '027-ZASSET.ZFILENAME',
        CONCAT(ZASSET.ZDIRECTORY,'/',ZASSET.ZFILENAME) AS FILEPATH,

        ZADDASSETATTR.ZORIGINALFILENAME AS '028-ZADDASSETATTR.ZORIGINALFILENAME',
        ZCLDMAST.ZORIGINALFILENAME AS '029-ZCLDMAST.ZORIGINALFILENAME',
        ZADDASSETATTR.ZSYNDICATIONIDENTIFIER AS '030-ZADDASSETATTR.ZSYNDICATIONIDENTIFIER',

        datetime(ZASSET.ZADDEDDATE + 978307200, 'UNIXEPOCH') AS '031-ZASSET.ZADDEDDATE(UTC)',

        CASE ZADDASSETATTR.ZDATECREATEDSOURCE
            WHEN 0 THEN '0  [Cloud Asset]'
            WHEN 1 THEN '1  [Local Asset EXIF]'
            WHEN 3 THEN '3  [Local Asset No EXIF]'
            ELSE 'Unknown Value: ' || ZADDASSETATTR.ZDATECREATEDSOURCE || ''
        END AS '032-ZADDASSETATTR.ZDATECREATEDSOURCE',

        datetime(ZASSET.ZDATECREATED + 978307200, 'UNIXEPOCH') AS '033-ZASSET.ZDATECREATED(UTC)',
        datetime(ZCLDMAST.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS '034-ZCLDMAST.ZCREATIONDATE(UTC)',
        datetime(ZINTRESOU.ZCLOUDMASTERDATECREATED + 978307200, 'UNIXEPOCH') AS '035-ZINTRESOU.ZCLOUDMASTERDATECREATED(UTC)',

        ZADDASSETATTR.ZTIMEZONENAME AS '036-ZADDASSETATTR.ZTIMEZONENAME',
        ZADDASSETATTR.ZTIMEZONEOFFSET AS '037-ZADDASSETATTR.ZTIMEZONEOFFSET',
        ZADDASSETATTR.ZINFERREDTIMEZONEOFFSET AS '038-ZADDASSETATTR.ZINFERREDTIMEZONEOFFSET',
        ZADDASSETATTR.ZEXIFTIMESTAMPSTRING AS '039-ZADDASSETATTR.ZEXIFTIMESTAMPSTRING',

        datetime(ZASSET.ZMODIFICATIONDATE + 978307200, 'UNIXEPOCH') AS '040-ZASSET.ZMODIFICATIONDATE(UTC)',

        ZINTRESOU.ZFINGERPRINT AS '041-ZINTRESOU.ZFINGERPRINT',
        ZADDASSETATTR.ZADJUSTEDFINGERPRINT AS '042-ZADDASSETATTR.ZADJUSTEDFINGERPRINT',
        ZUNMADJ.ZOTHERADJUSTMENTSFINGERPRINT AS '043-ZUNMADJ.ZOTHERADJUSTMENTSFINGERPRINT',
        ZUNMADJ.ZSIMILARTOORIGINALADJUSTMENTSFINGERPRINT AS '044-ZUNMADJ.SIMILARTOORIGADJFINGERPRINT',

        CASE ParentZGENALBUM.ZCLOUDLOCALSTATE
            WHEN 0 THEN '0  [iCloud Photos ON (Asset In Shared/Other Album) | iCloud Photos OFF (Generic Album)]'
            WHEN 1 THEN '1  [iCloud Photos ON (Asset In Generic Album)]'
            ELSE 'Unknown Value: ' || ParentZGENALBUM.ZCLOUDLOCALSTATE || ''
        END AS '045-PARENTZGENALBUM.ZCLOUDLOCALSTATE',

        ParentZGENALBUM.ZTITLE AS '046-PARENTZGENALBUM.ZTITLE',

        datetime(ParentZGENALBUM.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS '047-PARENTZGENALBUM.ZCREATIONDATE(UTC)',
        datetime(ZGENALBUM.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS '048-ZGENALBUM.ZCREATIONDATE(UTC)',

        CASE ZGENALBUM.ZCLOUDLOCALSTATE
            WHEN 0 THEN '0  [iCloud Photos ON (Asset In Shared/Other Album) | iCloud Photos OFF (Generic Album)]'
            WHEN 1 THEN '1  [iCloud Photos ON (Asset In Generic Album)]'
            ELSE 'Unknown Value: ' || ZGENALBUM.ZCLOUDLOCALSTATE || ''
        END AS '049-ZGENALBUM.ZCLOUDLOCALSTATE',

        ZGENALBUM.ZTITLE AS '050-ZGENALBUM.ZTITLE',

        CASE ZASSET.ZBUNDLESCOPE
            WHEN 0 THEN '0  [iCloud Photos ON (Not In Shared Album) | iCloud Photos OFF (On Local Device)]'
            WHEN 1 THEN '1  [SWY Syndication CMMAsset]'
            WHEN 2 THEN '2  [iCloud Photos ON (Asset In Cloud Shared Album)]'
            WHEN 3 THEN '3  [iCloud Photos ON (SWY Syndication-Asset)]'
            ELSE 'Unknown Value: ' || ZASSET.ZBUNDLESCOPE || ''
        END AS '051-ZASSET.ZBUNDLESCOPE',

        CASE ZASSET.ZCLOUDISMYASSET
            WHEN 0 THEN '0  [Not My Asset in Shared Album]'
            WHEN 1 THEN '1  [My Asset in Shared Album]'
            ELSE 'Unknown Value: ' || ZASSET.ZCLOUDISMYASSET || ''
        END AS '052-ZASSET.ZCLOUDISMYASSET',

        CASE ZASSET.ZCLOUDISDELETABLE
            WHEN 0 THEN '0  [No]'
            WHEN 1 THEN '1  [Yes]'
            ELSE 'Unknown Value: ' || ZASSET.ZCLOUDISDELETABLE || ''
        END AS '053-ZASSET.ZCLOUDISDELETABLE',

        CASE ZASSET.ZCLOUDLOCALSTATE
            WHEN 0 THEN '0  [iCloud Photos ON (Asset In Shared or Other Album) | iCloud Photos OFF (Not Synced)]'
            WHEN 1 THEN '1  [iCloud Photos ON (Asset Can Be or Has Been Synced with iCloud)]'
            ELSE 'Unknown Value: ' || ZASSET.ZCLOUDLOCALSTATE || ''
        END AS '054-ZASSET.ZCLOUDLOCALSTATE',

        -- Indicates whether assets are visible within the Local Photo Library
        CASE ZASSET.ZVISIBILITYSTATE
            WHEN 0 THEN '0  [Visible Photo Library]'
            WHEN 2 THEN '2  [Not Visible Photo Library]'
            ELSE 'Unknown Value: ' || ZASSET.ZVISIBILITYSTATE || ''
        END AS '055-ZASSET.ZVISIBILITYSTATE',

        ZEXTATTR.ZCAMERAMAKE AS '056-ZEXTATTR.ZCAMERAMAKE',
        ZEXTATTR.ZCAMERAMODEL AS '057-ZEXTATTR.ZCAMERAMODEL',
        ZEXTATTR.ZLENSMODEL AS '058-ZEXTATTR.ZLENSMODEL',

        CASE ZEXTATTR.ZFLASHFIRED
            WHEN 0 THEN '0  [No Flash]'
            WHEN 1 THEN '1  [Flash Fired]'
            ELSE 'Unknown Value: ' || ZEXTATTR.ZFLASHFIRED || ''
        END AS '059-ZEXTATTR.ZFLASHFIRED',

        ZEXTATTR.ZFOCALLENGTH AS '060-ZEXTATTR.ZFOCALLENGTH',
        ZEXTATTR.ZFOCALLENGTHIN35MM AS '061-ZEXTATTR.ZFOCALLENGTHIN35MM',
        ZEXTATTR.ZDIGITALZOOMRATIO AS '062-ZEXTATTR.ZDIGITALZOOMRATIO',

        CASE ZASSET.ZDERIVEDCAMERACAPTUREDEVICE
            WHEN 0 THEN '0  [Back Camera/Other]'
            WHEN 1 THEN '1  [Front Camera]'
            ELSE 'Unknown Value: ' || ZASSET.ZDERIVEDCAMERACAPTUREDEVICE || ''
        END AS '063-ZASSET.ZDERIVEDCAMERACAPTUREDEVICE',

        CASE ZADDASSETATTR.ZCAMERACAPTUREDEVICE
            WHEN 0 THEN '0  [Back Camera/Other]'
            WHEN 1 THEN '1  [Front Camera]'
            ELSE 'Unknown Value: ' || ZADDASSETATTR.ZCAMERACAPTUREDEVICE || ''
        END AS '064-ZADDASSETATTR.ZCAMERACAPTUREDEVICE',

        CASE ZADDASSETATTR.ZIMPORTEDBY
            WHEN 0 THEN '0  [Cloud Other]'
            WHEN 1 THEN '1  [Native Back Camera]'
            WHEN 2 THEN '2  [Native Front Camera]'
            WHEN 3 THEN '3  [Third Party App]'
            WHEN 4 THEN '4  [Still Testing]'
            WHEN 5 THEN '5  [PhotoBooth PL Asset]'
            WHEN 6 THEN '6  [Third Party App]'
            WHEN 7 THEN '7  [iCloud Share Link CMM Asset]'
            WHEN 8 THEN '8  [System Package App]'
            WHEN 9 THEN '9  [Native App]'
            WHEN 10 THEN '10  [Still Testing]'
            WHEN 11 THEN '11  [Still Testing]'
            WHEN 12 THEN '12  [SWY Syndication PL]'
            ELSE 'Unknown Value: ' || ZADDASSETATTR.ZIMPORTEDBY || ''
        END AS '065-ZADDASSETATTR.ZIMPORTEDBY',

        CASE ZCLDMAST.ZIMPORTEDBY
            WHEN 0 THEN '0  [Cloud Other]'
            WHEN 1 THEN '1  [Native Back Camera]'
            WHEN 2 THEN '2  [Native Front Camera]'
            WHEN 3 THEN '3  [Third Party App]'
            WHEN 4 THEN '4  [Still Testing]'
            WHEN 5 THEN '5  [PhotoBooth PL Asset]'
            WHEN 6 THEN '6  [Third Party App]'
            WHEN 7 THEN '7  [iCloud Share Link CMM Asset]'
            WHEN 8 THEN '8  [System Package App]'
            WHEN 9 THEN '9  [Native App]'
            WHEN 10 THEN '10  [Still Testing]'
            WHEN 11 THEN '11  [Still Testing]'
            WHEN 12 THEN '12  [SWY Syndication PL]'
            ELSE 'Unknown Value: ' || ZCLDMAST.ZIMPORTEDBY || ''
        END AS '066-ZCLDMAST.ZIMPORTEDBY',

        ZADDASSETATTR.ZIMPORTEDBYBUNDLEIDENTIFIER AS '067-ZADDASSETATTR.ZIMPORTEDBYBUNDLEIDENTIFIER',
        ZADDASSETATTR.ZIMPORTEDBYDISPLAYNAME AS '068-ZADDASSETATTR.ZIMPORTEDBYDISPLAYNAME',
        ZCLDMAST.ZIMPORTEDBYBUNDLEIDENTIFIER AS '069-ZCLDMAST.ZIMPORTEDBYBUNDLEIDENTIFIER',
        ZCLDMAST.ZIMPORTEDBYDISPLAYNAME AS '070-ZCLDMAST.ZIMPORTEDBYDISPLAYNAME',
        -- hex(ZASSET.ZIMAGEREQUESTHINTS) AS '071-ZASSET.ZIMAGEREQUESTHINTS(HEX Path)',

        CASE ZASSET.ZSAVEDASSETTYPE
            WHEN 0 THEN '0  [Saved via other source]'
            WHEN 2 THEN '1  [Still Testing]'
            WHEN 1 THEN '2  [Still Testing]'
            WHEN 3 THEN '3  [Local Photo Library Asset]'
            WHEN 4 THEN '4  [Photo Cloud Sharing Data Asset]'
            WHEN 5 THEN '5  [PhotoBooth Photo Library Asset]'
            WHEN 6 THEN '6  [Cloud Photo Library Asset]'
            WHEN 7 THEN '7  [Still Testing]'
            WHEN 8 THEN '8  [iCloudLink Cloud Master Moment Asset]'
            WHEN 12 THEN '12  [SWY Syndication PL Asset/Auto Displayed in LPL]'
            ELSE 'Unknown Value: ' || ZASSET.ZSAVEDASSETTYPE || ''
        END AS '072-ZASSET.ZSAVEDASSETTYPE(LPL)',

        CASE ZINTRESOU.ZDATASTORECLASSID
            WHEN 0 THEN '0  [LPL Asset CPL Asset]'
            WHEN 1 THEN '1  [Still Testing]'
            WHEN 2 THEN '2  [Photo Cloud Sharing Asset]'
            WHEN 3 THEN '3  [SWY Syndication Asset]'
            ELSE 'Unknown Value: ' || ZINTRESOU.ZDATASTORECLASSID || ''
        END AS '073-ZINTRESOU.ZDATASTORECLASSID',

        CASE ZASSET.ZCLOUDPLACEHOLDERKIND
            WHEN 0 THEN '0  [Local & Cloud Master Asset]'
            WHEN 1 THEN '1  [Still Testing]'
            WHEN 2 THEN '2  [Still Testing]'
            WHEN 3 THEN '3  [.JPG Asset Only PhDa/Thumb/V2]'
            WHEN 4 THEN '4  [LPL .JPG Asset CPL Asset Other Type]'
            WHEN 5 THEN '5  [Asset synced CPL to Device]'
            WHEN 6 THEN '6  [Still Testing]'
            WHEN 7 THEN '7  [LPL poster JPG Asset CPL Asset .MP4]'
            WHEN 8 THEN '8  [LPL .JPG Asset CPL Asset Live Photo .MOV]'
            WHEN 9 THEN '9  [CPL .MP4 Asset Saved to LPL]'
            ELSE 'Unknown Value: ' || ZASSET.ZCLOUDPLACEHOLDERKIND || ''
        END AS '074-ZASSET.ZCLOUDPLACEHOLDERKIND',

        CASE ZINTRESOU.ZLOCALAVAILABILITY
            WHEN -1 THEN '(-1)  [IR Asset Not Avail Locally]'
            WHEN 1 THEN '1  [IR Asset Avail Locally]'
            WHEN -32768 THEN '(-32768)  [IR Asset SWY Linked Asset]'
            ELSE 'Unknown Value: ' || ZINTRESOU.ZLOCALAVAILABILITY || ''
        END AS '075-ZINTRESOU.ZLOCALAVAILABILITY',

        CASE ZINTRESOU.ZLOCALAVAILABILITYTARGET
            WHEN 0 THEN '0  [Still Testing]'
            ELSE 'Unknown Value: ' || ZINTRESOU.ZLOCALAVAILABILITYTARGET || ''
        END AS '076-ZINTRESOU.ZLOCALAVAILABILITYTARGET',

        CASE ZINTRESOU.ZCLOUDLOCALSTATE
            WHEN 0 THEN '0  [IR Asset Not Synced No IR CloudMastDateCreated]'
            WHEN 1 THEN '1  [IR Asset Pending Upload]'
            WHEN 2 THEN '2  [IR Asset Photo Cloud Share Asset On Local Device]'
            WHEN 3 THEN '3  [IR Asset Synced iCloud]'
            ELSE 'Unknown Value: ' || ZINTRESOU.ZCLOUDLOCALSTATE || ''
        END AS '077-ZINTRESOU.ZCLOUDLOCALSTATE',

        CASE ZINTRESOU.ZREMOTEAVAILABILITY
            WHEN 0 THEN '0  [IR Asset Not Avail Remotely]'
            WHEN 1 THEN '1  [IR Asset Avail Remotely]'
            ELSE 'Unknown Value: ' || ZINTRESOU.ZREMOTEAVAILABILITY || ''
        END AS '078-ZINTRESOU.ZREMOTEAVAILABILITY',

        CASE ZINTRESOU.ZREMOTEAVAILABILITYTARGET
            WHEN 0 THEN '0  [Still Testing]'
            WHEN 1 THEN '1  [Still Testing]'
            ELSE 'Unknown Value: ' || ZINTRESOU.ZREMOTEAVAILABILITYTARGET || ''
        END AS '079-ZINTRESOU.ZREMOTEAVAILABILITYTARGET',

        ZINTRESOU.ZTRANSIENTCLOUDMASTER AS '080-ZINTRESOU.ZTRANSIENTCLOUDMASTER',
        ZINTRESOU.ZSIDECARINDEX AS '081-ZINTRESOU.ZSIDECARINDEX',
        ZINTRESOU.ZFILEID AS '082-ZINTRESOU.ZFILEID',

        CASE ZINTRESOU.ZVERSION
            WHEN 0 THEN '0  [IR Asset Standard]'
            WHEN 1 THEN '1  [Still Testing]'
            WHEN 2 THEN '2  [IR Asset Adjustments Mutation]'
            WHEN 3 THEN '3  [IR Asset No IR Cloud Master Date Created]'
            ELSE 'Unknown Value: ' || ZINTRESOU.ZVERSION || ''
        END AS '083-ZINTRESOU.ZVERSION',

        printf("%,d", ZADDASSETATTR.ZORIGINALFILESIZE) AS '084-ZADDASSETATTR.ZORIGINALFILESIZE(bytes)',

        CASE ZINTRESOU.ZRESOURCETYPE
            WHEN 0 THEN '0  [Photo]'
            WHEN 1 THEN '1  [Video]'
            WHEN 3 THEN '3  [Live Photo]'
            WHEN 5 THEN '5  [Adjustment Data]'
            WHEN 6 THEN '6  [Screenshot]'
            WHEN 9 THEN '9  [Alternate Photo 3rd Party App - Still Testing]'
            WHEN 13 THEN '13  [Movie]'
            WHEN 14 THEN '14  [Wallpaper]'
            ELSE 'Unknown Value: ' || ZINTRESOU.ZRESOURCETYPE || ''
        END AS '085-ZINTRESOU.ZRESOURCETYPE',

        -- hex(ZINTRESOU.ZDATASTOREKEYDATA) AS '086-ZINTRESOU.ZDATASTOREKEYDATA(HEX)',

        CASE ZINTRESOU.ZDATASTORESUBTYPE
            WHEN 0 THEN '0  [No Cloud Inter Resource]'
            WHEN 1 THEN '1  [Main Asset Orig Size]'
            WHEN 2 THEN '2  [Photo with Adjustments]'
            WHEN 3 THEN '3  [.JPG Large Thumb]'
            WHEN 4 THEN '4  [.JPG Med Thumb]'
            WHEN 5 THEN '5  [.JPG Small Thumb]'
            WHEN 6 THEN '6  [Video Med Data]'
            WHEN 7 THEN '7  [Video Small Data]'
            WHEN 8 THEN '8  [.MP4 Cloud Share]'
            WHEN 9 THEN '9  [Still Testing]'
            WHEN 10 THEN '10  [3rd Party App thumb - Still Testing]'
            WHEN 11 THEN '11  [Still Testing]'
            WHEN 12 THEN '12  [Still Testing]'
            WHEN 13 THEN '13  [.PNG Optimized CPL Asset]'
            WHEN 14 THEN '14  [Wallpaper]'
            WHEN 15 THEN '15  [Has Markup and Adjustments]'
            WHEN 16 THEN '16  [Video with Adjustments]'
            WHEN 17 THEN '17  [RAW Photo]'
            WHEN 18 THEN '18  [Live Photo Video Optimized CPL Asset]'
            WHEN 19 THEN '19  [Live Photo with Adjustments]'
            WHEN 20 THEN '20  [Still Testing]'
            WHEN 21 THEN '21  [.MOV Optimized HEVC 4K video]'
            WHEN 22 THEN '22  [Adjust Mutation AAE Asset]'
            WHEN 23 THEN '23  [Still Testing]'
            WHEN 24 THEN '24  [Still Testing]'
            WHEN 25 THEN '25  [Still Testing]'
            WHEN 26 THEN '26  [.MOV Optimized CPLAsset]'
            WHEN 27 THEN '27  [Still Testing]'
            WHEN 28 THEN '28  [.MOV Med HDR Data]'
            ELSE 'Unknown Value: ' || ZINTRESOU.ZDATASTORESUBTYPE || ''
        END AS '087-ZINTRESOU.ZDATASTORESUBTYPE',

        CASE ZINTRESOU.ZCLOUDSOURCETYPE
            WHEN 0 THEN '0  [NA]'
            WHEN 1 THEN '1  [Main Asset Orig Size]'
            WHEN 2 THEN '2  [Photo with Adjustments]'
            WHEN 3 THEN '3  [.JPG Large Thumb]'
            WHEN 4 THEN '4  [.JPG Med Thumb]'
            WHEN 5 THEN '5  [.JPG Small Thumb]'
            WHEN 6 THEN '6  [Video Med Data]'
            WHEN 7 THEN '7  [Video Small Data]'
            WHEN 8 THEN '8  [.MP4 Cloud Share]'
            WHEN 9 THEN '9  [Still Testing]'
            WHEN 10 THEN '10  [3rd Party App thumb - Still Testing]'
            WHEN 11 THEN '11  [Still Testing]'
            WHEN 12 THEN '12  [Still Testing]'
            WHEN 13 THEN '13  [.PNG Optimized CPL Asset]'
            WHEN 14 THEN '14  [Wallpaper]'
            WHEN 15 THEN '15  [Has Markup and Adjustments]'
            WHEN 16 THEN '16  [Video with Adjustments]'
            WHEN 17 THEN '17  [RAW Photo]'
            WHEN 18 THEN '18  [Live Photo Video Optimized CPL Asset]'
            WHEN 19 THEN '19  [Live Photo with Adjustments]'
            WHEN 20 THEN '20  [Still Testing]'
            WHEN 21 THEN '21  [.MOV Optimized HEVC 4K video]'
            WHEN 22 THEN '22  [Adjust Mutation AAE Asset]'
            WHEN 23 THEN '23  [Still Testing]'
            WHEN 24 THEN '24  [Still Testing]'
            WHEN 25 THEN '25  [Still Testing]'
            WHEN 26 THEN '26  [.MOV Optimized CPLAsset]'
            WHEN 27 THEN '27  [Still Testing]'
            WHEN 28 THEN '28  [.MOV Med HDR Data]'
            ELSE 'Unknown Value: ' || ZINTRESOU.ZCLOUDSOURCETYPE || ''
        END AS '088-ZINTRESOU.ZCLOUDSOURCETYPE',

        ZINTRESOU.ZDATALENGTH AS '089-ZINTRESOU.ZDATALENGTH',

        CASE ZINTRESOU.ZRECIPEID
            WHEN 0 THEN '0  [Orig File Size match Data Length or Optimized]'
            WHEN 65737 THEN '65737  [Full .JPG Orig ProRAW DNG]'
            WHEN 65739 THEN '65739  [.JPG Large Thumb]'
            WHEN 65741 THEN '65741  [Various Asset Types or Thumbs]'
            WHEN 65743 THEN '65743  [ResouType Photo 5003 or 5005 .JPG Thumb]'
            WHEN 65749 THEN '65749  [LocalVideoKeyFrame .JPG Thumb]'
            WHEN 65938 THEN '65938  [FullSizeRender Photo or .plist]'
            WHEN 131072 THEN '131072  [FullSizeRender Video or .plist]'
            WHEN 131077 THEN '131077  [Medium .MOV HEVC 4K]'
            WHEN 131079 THEN '131079  [Medium .MP4 Adj Mutation Asset]'
            WHEN 131081 THEN '131081  [ResouType Video 5003 or 5005 .JPG Thumb]'
            WHEN 131272 THEN '131272  [FullSizeRender Video Live Photo Adj Mutation]'
            WHEN 131275 THEN '131275  [Medium .MOV LivePhoto]'
            WHEN 131277 THEN '131277  [No IR Asset LivePhoto iCloud Sync Asset]'
            WHEN 131475 THEN '131475  [Medium HDR .MOV]'
            WHEN 327683 THEN '327683  [.JPG Thumb for 3rd Party - Still Testing]'
            WHEN 327687 THEN '627687  [Wallpaper Compute Resource]'
            ELSE 'Unknown Value: ' || ZINTRESOU.ZRECIPEID || ''
        END AS '090-ZINTRESOU.ZRECIPEID',

        CASE ZINTRESOU.ZCLOUDLASTPREFETCHDATE
            WHEN 0 THEN '0 N/A'
            ELSE datetime(ZINTRESOU.ZCLOUDLASTPREFETCHDATE + 978307200, 'UNIXEPOCH')
        END AS '091-ZINTRESOU.ZCLOUDLASTPREFETCHDATE(UTC)',

        ZINTRESOU.ZCLOUDPREFETCHCOUNT AS '092-ZINTRESOU.ZCLOUDPREFETCHCOUNT',
        datetime(ZINTRESOU.ZCLOUDLASTONDEMANDDOWNLOADDATE + 978307200, 'UNIXEPOCH') AS '093-ZINTRESOU.ZCLOUDLASTONDEMANDDOWNLOADDATE(UTC)',

        CASE ZINTRESOU.ZUTICONFORMANCEHINT
            WHEN 0 THEN '0  [N/A, Does not Conform]'
            WHEN 1 THEN '1  [UT Type Image]'
            WHEN 2 THEN '2  [UT Type Pro Raw Photo]'
            WHEN 3 THEN '3  [UT Type Movie]'
            ELSE 'Unknown Value: ' || ZINTRESOU.ZUTICONFORMANCEHINT || ''
        END AS '094-ZINTRESOU.ZUTICONFORMANCEHINT',

        CASE ZINTRESOU.ZCOMPACTUTI
            WHEN 1 THEN '1  [.JPEG/.THM]'
            WHEN 3 THEN '3  [.HEIC]'
            WHEN 6 THEN '6  [.PNG]'
            WHEN 7 THEN '7  [Still Testing]'
            WHEN 9 THEN '9  [.DNG]'
            WHEN 23 THEN '23  [.JPEG/.HEIC/.mov]'
            WHEN 24 THEN '24  [.MPEG4]'
            WHEN 36 THEN '36  [Wallpaper]'
            WHEN 37 THEN '37  [Adj/Mutation Data]'
            ELSE 'Unknown Value: ' || ZINTRESOU.ZCOMPACTUTI || ''
        END AS '095-ZINTRESOU.ZCOMPACTUTI',

        ZASSET.ZUNIFORMTYPEIDENTIFIER AS '096-ZASSET.ZUNIFORMTYPEIDENTIFIER',
        ZASSET.ZORIGINALCOLORSPACE AS '097-ZASSET.ZORIGINALCOLORSPACE',
        ZCLDMAST.ZUNIFORMTYPEIDENTIFIER AS '098-ZCLDMAST.ZUNIFORMTYPEIDENTIFIER',

        CASE ZCLDMAST.ZFULLSIZEJPEGSOURCE
            WHEN 0 THEN '0  [Cloud Master .JPEG Source Video - Still Testing]'
            WHEN 1 THEN '1  [Cloud Master .JPEG Source Other - Still Testing]'
            ELSE 'Unknown Value: ' || ZCLDMAST.ZFULLSIZEJPEGSOURCE || ''
        END AS '099-ZCLDMAST.ZFULLSIZEJPEGSOURCE',

        CASE ZCLDMAST.ZCLOUDLOCALSTATE
            WHEN 0 THEN '0  [Not Synced with Cloud]'
            WHEN 1 THEN '1  [Pending Upload]'
            WHEN 2 THEN '2  [Still Testing]'
            WHEN 3 THEN '3  [Synced with Cloud]'
            ELSE 'Unknown Value: ' || ZCLDMAST.ZCLOUDLOCALSTATE || ''
        END AS '100-ZCLDMAST.ZCLOUDLOCALSTATE',

        datetime(ZCLDMAST.ZIMPORTDATE + 978307200, 'UNIXEPOCH') AS '101-ZCLDMAST.ZIMPORTDATE(UTC)',
        ZASSET.ZIMPORTSESSION AS '102-ZASSET.ZIMPORTSESSION',
        ZADDASSETATTR.ZIMPORTSESSIONID AS '103-ZADDASSETATTR.ZIMPORTSESSIONID',
        datetime(ZADDASSETATTR.ZALTERNATEIMPORTIMAGEDATE + 978307200, 'UNIXEPOCH') AS '104-ZADDASSETATTR.ZALTERNATEIMPORTIMAGEDATE(UTC)',
        ZCLDMAST.ZIMPORTSESSIONID AS '105-ZCLDMAST.ZIMPORTSESSIONID',
        datetime(ZASSET.ZCLOUDBATCHPUBLISHDATE + 978307200, 'UNIXEPOCH') AS '106-ZASSET.ZCLOUDBATCHPUBLISHDATE(UTC)',
        datetime(ZASSET.ZCLOUDSERVERPUBLISHDATE + 978307200, 'UNIXEPOCH') AS '107-ZASSET.ZCLOUDSERVERPUBLISHDATE(UTC)',
        ZASSET.ZCLOUDDOWNLOADREQUESTS AS '108-ZASSET.ZCLOUDDOWNLOADREQUESTS',
        ZASSET.ZCLOUDBATCHID AS '109-ZASSET.ZCLOUDBATCHID',
        datetime(ZADDASSETATTR.ZLASTUPLOADATTEMPTDATE + 978307200, 'UNIXEPOCH') AS '110-ZADDASSETATTR.ZLASTUPLOADATTEMPTDATE(SWY)(UTC)',
        ZADDASSETATTR.ZUPLOADATTEMPTS AS '111-ZADDASSETATTR.ZUPLOADATTEMPTS',

        CASE ZASSET.ZLATITUDE
            WHEN -180.0 THEN '[-180.0]'
            ELSE ZASSET.ZLATITUDE
        END AS '112-ZASSET.ZLATITUDE',

        CASE ZASSET.ZLONGITUDE
            WHEN -180.0 THEN '[-180.0]'
            ELSE ZASSET.ZLONGITUDE
        END AS '113-ZASSET.ZLONGITUDE',

        ZEXTATTR.ZLATITUDE AS '114-ZEXTATTR.ZLATITUDE',
        ZEXTATTR.ZLONGITUDE AS '115-ZEXTATTR.ZLONGITUDE',

        CASE ZADDASSETATTR.ZGPSHORIZONTALACCURACY
            WHEN -1.0 THEN '[-1.0]'
            ELSE ZADDASSETATTR.ZGPSHORIZONTALACCURACY
        END AS '116-ZADDASSETATTR.ZGPSHORIZONTALACCURACY',

        hex(ZASSET.ZLOCATIONDATA) AS '117-ZASSET.ZLOCATIONDATA(HEX)',
        -- ZADDASSETATTR.ZREVERSELOCATIONDATA AS '118-ZADDASSETATTR.ZREVERSELOCATIONDATA(Orig-Asset, HEX NSKeyed .plist)',

        CASE ZADDASSETATTR.ZSHIFTEDLOCATIONISVALID
            WHEN 0 THEN '0  [Shifted Location Not Valid]'
            WHEN 1 THEN '1  [Shifted Location Valid]'
        END AS '119-ZADDASSETATTR.ZSHIFTEDLOCATIONISVALID',

        ZADDASSETATTR.ZSHIFTEDLOCATIONDATA AS '120-ZADDASSETATTR.ZSHIFTEDLOCATIONDATA',
        ZADDASSETATTR.ZLOCATIONHASH AS '121-ZADDASSETATTR.ZLOCATIONHASH',

        CASE AAAZCLDMASTMedData.Z_OPT
            WHEN 1 THEN '1  [Cloud - Still Testing]'
            WHEN 2 THEN '2  [This Device - Still Testing]'
            WHEN 3 THEN '3  [Muted - Still Testing]'
            WHEN 4 THEN '4  [Unknown - Still Testing]'
            WHEN 5 THEN '5  [Unknown - Still Testing]'
            ELSE 'Unknown Value: ' || AAAZCLDMASTMedData.Z_OPT || ''
        END AS '122-AAAZCLDMASTMedData.Z_OPT',

        ZADDASSETATTR.ZMEDIAMETADATATYPE AS '123-ZADDASSETATTR.ZMEDIAMETADATATYPE',
        -- hex(AAAZCLDMASTMedData.ZDATA) AS '124-AAAZCLDMASTMedData.ZDATA(HEX)',

        CASE CMZCLDMASTMedData.Z_OPT
            WHEN 1 THEN '1  [Has Cloud Master Asset - Still Testing]'
            WHEN 2 THEN '2  [Local Asset - Still Testing]'
            WHEN 3 THEN '3  [Muted - Still Testing]'
            WHEN 4 THEN '4  [Unknown - Still Testing]'
            WHEN 5 THEN '5  [Unknown - Still Testing]'
            ELSE 'Unknown Value: ' || CMZCLDMASTMedData.Z_OPT || ''
        END AS '125-CldMasterZCLDMASTMedData.Z_OPT',

        ZCLDMAST.ZMEDIAMETADATATYPE AS '126-ZCLDMAST.ZMEDIAMETADATATYPE',
        -- CMZCLDMASTMedData.ZDATA AS '127-CMZCLDMASTMedData.ZDATA(HEX)',

        CASE ZASSET.ZSEARCHINDEXREBUILDSTATE
            WHEN 0 THEN '0  [Still Testing]'
            ELSE 'Unknown Value: ' || ZASSET.ZSEARCHINDEXREBUILDSTATE || ''
        END AS '128-ZASSET.ZSEARCHINDEXREBUILDSTATE',

        CASE ZASSET.ZORIENTATION
            WHEN 1 THEN '1  [Video Default/Adjustment/Horizontal Camera (left)]'
            WHEN 2 THEN '2  [Horizontal Camera (right)]'
            WHEN 3 THEN '3  [Horizontal Camera (right)]'
            WHEN 4 THEN '4  [Horizontal Camera (left)]'
            WHEN 5 THEN '5  [Vertical Camera (top)]'
            WHEN 6 THEN '6  [Vertical Camera (top)]'
            WHEN 7 THEN '7  [Vertical Camera (bottom)]'
            WHEN 8 THEN '8  [Vertical Camera (bottom)]'
            ELSE 'Unknown Value: ' || ZASSET.ZORIENTATION || ''
        END AS '129-ZASSET.ZORIENTATION',

        CASE ZADDASSETATTR.ZORIGINALORIENTATION
            WHEN 1 THEN '1  [Video Default/Adjustment/Horizontal Camera (left)]'
            WHEN 2 THEN '2  [Horizontal Camera (right)]'
            WHEN 3 THEN '3  [Horizontal Camera (right)]'
            WHEN 4 THEN '4  [Horizontal Camera (left)]'
            WHEN 5 THEN '5  [Vertical Camera (top)]'
            WHEN 6 THEN '6  [Vertical Camera (top)]'
            WHEN 7 THEN '7  [Vertical Camera (bottom)]'
            WHEN 8 THEN '8  [Vertical Camera (bottom)]'
            ELSE 'Unknown Value: ' || ZADDASSETATTR.ZORIGINALORIENTATION || ''
        END AS '130-ZADDASSETATTR.ZORIGINALORIENTATION',

        CASE ZASSET.ZKIND
            WHEN 0 THEN '0  [Photo]'
            WHEN 1 THEN '1  [Video]'
        END AS '131-ZASSET.ZKIND',

        CASE ZASSET.ZKINDSUBTYPE
            WHEN 0 THEN '0  [Still Photo]'
            WHEN 2 THEN '2  [Live Photo]'
            WHEN 10 THEN '10  [SpringBoard Screenshot]'
            WHEN 100 THEN '100  [Video]'
            WHEN 101 THEN '101  [Slow-Mo Video]'
            WHEN 102 THEN '102  [Time-lapse Video]'
            WHEN 103 THEN '103  [Replay Screen Recording]'
            ELSE 'Unknown Value: ' || ZASSET.ZKINDSUBTYPE || ''
        END AS '132-ZASSET.ZKINDSUBTYPE',

        CASE ZADDASSETATTR.ZCLOUDKINDSUBTYPE
            WHEN 0 THEN '0  [Still Photo]'
            WHEN 1 THEN '1  [Still Testing]'
            WHEN 2 THEN '2  [Live Photo]'
            WHEN 3 THEN '3  [Screenshot]'
            WHEN 10 THEN '10  [SpringBoard Screenshot]'
            WHEN 100 THEN '100  [Video]'
            WHEN 101 THEN '101  [Slow-Mo Video]'
            WHEN 102 THEN '102  [Time-lapse Video]'
            WHEN 103 THEN '103  [Replay Screen Recording]'
            ELSE 'Unknown Value: ' || ZADDASSETATTR.ZCLOUDKINDSUBTYPE || ''
        END AS '133-ZADDASSETATTR.ZCLOUDKINDSUBTYPE',

        CASE ZASSET.ZPLAYBACKSTYLE
            WHEN 1 THEN '1  [Image]'
            WHEN 2 THEN '2  [Image Animated]'
            WHEN 3 THEN '3  [Live Photo]'
            WHEN 4 THEN '4  [Video]'
            WHEN 5 THEN '5  [Video Looping]'
            ELSE 'Unknown Value: ' || ZASSET.ZPLAYBACKSTYLE || ''
        END AS '134-ZASSET.ZPLAYBACKSTYLE',

        ZASSET.ZPLAYBACKVARIATION AS '135-ZASSET.ZPLAYBACKVARIATION',
        ZASSET.ZDURATION AS '136-ZASSET.ZDURATION',
        ZEXTATTR.ZDURATION AS '137-ZEXTATTR.ZDURATION',
        ZASSET.ZVIDEOCPDURATIONVALUE AS '138-ZASSET.ZVIDEOCPDURATIONVALUE',
        ZADDASSETATTR.ZVIDEOCPDURATIONTIMESCALE AS '139-ZADDASSETATTR.ZVIDEOCPDURATIONTIMESCALE',
        ZASSET.ZVIDEOCPVISIBILITYSTATE AS '140-ZASSET.ZVIDEOCPVISIBILITYSTATE',
        ZADDASSETATTR.ZVIDEOCPDISPLAYVALUE AS '141-ZADDASSETATTR.ZVIDEOCPDISPLAYVALUE',
        ZADDASSETATTR.ZVIDEOCPDISPLAYTIMESCALE AS '142-ZADDASSETATTR.ZVIDEOCPDISPLAYTIMESCALE',

        -- [ZINTRESOU.ZASSET = ZASSET.Z_PK]
        ZINTRESOU.ZASSET AS '143-ZINTRESOU.ZASSET',
        ZINTRESOU.Z_PK AS '144-ZINTRESOU.Z_PK',
        ZINTRESOU.Z_ENT AS '145-ZINTRESOU.Z_ENT',
        ZINTRESOU.Z_OPT AS '146-ZINTRESOU.Z_OPT',
        ZASSET.ZHDRGAIN AS '147-ZASSET.ZHDRGAIN',

        CASE ZASSET.ZHDRTYPE
            WHEN 0 THEN '0  [No HDR]'
            WHEN 3 THEN '3  [HDR Photo]'
            WHEN 4 THEN '4  [Non HDR Version]'
            WHEN 5 THEN '5  [HEVC Movie]'
            WHEN 6 THEN '6  [Panorama]'
            WHEN 10 THEN '10  [HDR Gain]'
            ELSE 'Unknown Value: ' || ZASSET.ZHDRTYPE || ''
        END AS '148-ZASSET.ZHDRTYPE',

        ZEXTATTR.ZCODEC AS '149-ZEXTATTR.ZCODEC',
        ZINTRESOU.ZCODECFOURCHARCODENAME AS '150-ZINTRESOU.ZCODECFOURCHARCODENAME',
        ZCLDMAST.ZCODECNAME AS '151-ZCLDMAST.ZCODECNAME',
        ZCLDMAST.ZVIDEOFRAMERATE AS '152-ZCLDMAST.ZVIDEOFRAMERATE',
        ZCLDMAST.ZPLACEHOLDERSTATE AS '153-ZCLDMAST.ZPLACEHOLDERSTATE',

        CASE ZASSET.ZDEPTHTYPE
            WHEN 0 THEN '0  [Not Portrait]'
            ELSE 'Portrait: ' || ZASSET.ZDEPTHTYPE || ''
        END AS '154-ZASSET.ZDEPTHTYPE',

        ZASSET.ZAVALANCHEUUID AS '155-ZASSET.ZAVALANCHEUUID',

        CASE ZASSET.ZAVALANCHEPICKTYPE
            WHEN 0 THEN '0  [NA/Single Asset Burst UUID]'
            WHEN 2 THEN '2  [Burst Asset Not Selected]'
            WHEN 4 THEN '4  [Burst Asset PhotosApp Picked Key Image]'
            WHEN 8 THEN '8  [Burst Asset Selected for LPL]'
            WHEN 16 THEN '16  [Top Burst Asset inStack Key Image]'
            WHEN 32 THEN '32  [Still Testing]'
            WHEN 52 THEN '52  [Burst Asset Visible LPL]'
            ELSE 'Unknown Value: ' || ZASSET.ZAVALANCHEPICKTYPE || ''
        END AS '156-ZASSET.ZAVALANCHEPICKTYPE',

        CASE ZADDASSETATTR.ZCLOUDAVALANCHEPICKTYPE
            WHEN 0 THEN '0  [NA/Single Asset Burst UUID]'
            WHEN 2 THEN '2  [Burst Asset Not Selected]'
            WHEN 4 THEN '4  [Burst Asset PhotosApp Picked Key Image]'
            WHEN 8 THEN '8  [Burst Asset Selected for LPL]'
            WHEN 16 THEN '16  [Top Burst Asset inStack Key Image]'
            WHEN 32 THEN '32  [Still Testing]'
            WHEN 52 THEN '52  [Burst Asset Visible LPL]'
            ELSE 'Unknown Value: ' || ZADDASSETATTR.ZCLOUDAVALANCHEPICKTYPE || ''
        END AS '157-ZADDASSETATTR.ZCLOUDAVALANCHEPICKTYPE',

        CASE ZADDASSETATTR.ZCLOUDRECOVERYSTATE
            WHEN 0 THEN '0  [Still Testing]'
            WHEN 1 THEN '1  [Still Testing]'
            ELSE 'Unknown Value: ' || ZADDASSETATTR.ZCLOUDRECOVERYSTATE || ''
        END AS '158-ZADDASSETATTR.ZCLOUDRECOVERYSTATE',

        ZADDASSETATTR.ZCLOUDSTATERECOVERYATTEMPTSCOUNT AS '159-ZADDASSETATTR.ZCLOUDSTATERECOVERYATTEMPTSCOUNT',
        ZASSET.ZDEFERREDPROCESSINGNEEDED AS '160-ZASSET.ZDEFERREDPROCESSINGNEEDED',
        ZASSET.ZVIDEODEFERREDPROCESSINGNEEDED AS '161-ZASSET.ZVIDEODEFERREDPROCESSINGNEEDED',
        ZADDASSETATTR.ZDEFERREDPHOTOIDENTIFIER AS '162-ZADDASSETATTR.ZDEFERREDPHOTOIDENTIFIER',
        ZADDASSETATTR.ZDEFERREDPROCESSINGCANDIDATEOPTIONS AS '163-ZADDASSETATTR.ZDEFERREDPROCESSINGCANDIDATEOPTIONS',

        CASE ZASSET.ZHASADJUSTMENTS
            WHEN 0 THEN '0  [No Adjustments]'
            WHEN 1 THEN '1  [Yes Adjustments]'
            ELSE 'Unknown Value: ' || ZASSET.ZHASADJUSTMENTS || ''
        END AS '164-ZASSET.ZHASADJUSTMENTS',

        -- [ZUNMADJ.ZASSETATTRIBUTES = ZADDASSETATTR.Z_PK]
        ZUNMADJ.ZASSETATTRIBUTES AS '165-ZUNMADJ.ZASSETATTRIBUTES',
        -- [ZADDASSETATTR.ZUNMANAGEDADJUSTMENT = ZUNMADJ.Z_PK]
        ZADDASSETATTR.ZUNMANAGEDADJUSTMENT AS '166-ZADDASSETATTR.ZUNMANAGEDADJUSTMENT',
        -- [ZUNMADJ.Z_PK = ZADDASSETATTR.ZUNMANAGEDADJUSTMENT]
        ZUNMADJ.Z_PK AS '167-ZUNMADJ.Z_PK',
        ZUNMADJ.ZUUID AS '168-ZUNMADJ.UUID',
        datetime(ZASSET.ZADJUSTMENTTIMESTAMP + 978307200, 'UNIXEPOCH') AS '169-ZASSET.ZADJUSTMENTTIMESTAMP(UTC)',
        datetime(ZUNMADJ.ZADJUSTMENTTIMESTAMP + 978307200, 'UNIXEPOCH') AS '170-ZUNMADJ.ZADJUSTMENTTIMESTAMP(UTC)',
        ZADDASSETATTR.ZEDITORBUNDLEID AS '171-ZADDASSETATTR.ZEDITORBUNDLEID',
        ZUNMADJ.ZEDITORLOCALIZEDNAME AS '172-ZUNMADJ.ZEDITORLOCALIZEDNAME',
        ZUNMADJ.ZADJUSTMENTFORMATIDENTIFIER AS '173-ZUNMADJ.ZADJUSTMENTFORMATIDENTIFIER',
        ZADDASSETATTR.ZMONTAGE AS '174-ZADDASSETATTR.ZMONTAGE',

        CASE ZUNMADJ.ZADJUSTMENTRENDERTYPES
            WHEN 0 THEN '0  [Standard or Portrait with errors]'
            WHEN 1 THEN '1  [Still Testing]'
            WHEN 2 THEN '2  [Portrait]'
            WHEN 3 THEN '3  [Still Testing]'
            WHEN 4 THEN '4  [Still Testing]'
            ELSE 'Unknown Value: ' || ZUNMADJ.ZADJUSTMENTRENDERTYPES || ''
        END AS '175-ZUNMADJ.ZADJUSTMENTRENDERTYPES',

        CASE ZUNMADJ.ZADJUSTMENTFORMATVERSION
            WHEN 1.0 THEN '1.0  [Markup]'
            WHEN 1.1 THEN '1.1  [Slow-Mo]'
            WHEN 1.2 THEN '1.2  [Still Testing]'
            WHEN 1.3 THEN '1.3  [Still Testing]'
            WHEN 1.4 THEN '1.4  [Filter]'
            WHEN 1.5 THEN '1.5  [Adjust]'
            WHEN 1.6 THEN '1.6  [Video Trim]'
            WHEN 1.7 THEN '1.7  [Still Testing]'
            WHEN 1.8 THEN '1.8  [Still Testing]'
            WHEN 1.9 THEN '1.9  [Still Testing]'
            WHEN 2.0 THEN '2.0  [Screenshot Services]'
            ELSE 'Unknown Value: ' || ZUNMADJ.ZADJUSTMENTFORMATVERSION || ''
        END AS '176-ZUNMADJ.ZADJUSTMENTFORMATVERSION',

        ZUNMADJ.ZADJUSTMENTBASEIMAGEFORMAT AS '177-ZUNMADJ.ZADJUSTMENTBASEIMAGEFORMAT',

        CASE ZASSET.ZFAVORITE
            WHEN 0 THEN '0  [Not Favorite]'
            WHEN 1 THEN '1  [Favorite]'
        END AS '178-ZASSET.ZFAVORITE',

        CASE ZASSET.ZHIDDEN
            WHEN 0 THEN '0  [Not Hidden]'
            WHEN 1 THEN '1  [Hidden]'
            ELSE 'Unknown Value: ' || ZASSET.ZHIDDEN || ''
        END AS '179-ZASSET.ZHIDDEN',

        CASE ZASSET.ZTRASHEDSTATE
            WHEN 0 THEN '0  [Not In Trash/Recently Deleted]'
            WHEN 1 THEN '1  [In Trash/Recently Deleted]'
            ELSE 'Unknown Value: ' || ZASSET.ZTRASHEDSTATE || ''
        END AS '180-ZASSET.ZTRASHEDSTATE (Local Asset Recently Deleted)',

        datetime(ZASSET.ZTRASHEDDATE + 978307200, 'UNIXEPOCH') AS '181-ZASSET.ZTRASHEDDATE(UTC)',

        CASE ZASSET.ZDELETEREASON
            WHEN 1 THEN '1  [Delete Reason - Still Testing]'
            WHEN 2 THEN '2  [Delete Reason - Still Testing]'
            WHEN 3 THEN '3  [Delete Reason - Still Testing]'
            ELSE 'Unknown Value: ' || ZASSET.ZDELETEREASON || ''
        END AS '182-ZASSET.ZDELETEREASON',

        CASE ZASSET.ZTRASHEDBYPARTICIPANT
            WHEN 1 THEN '1  [Trashed/Recently Deleted by Participant]'
            ELSE 'Unknown Value: ' || ZASSET.ZTRASHEDBYPARTICIPANT || ''
        END AS '183-ZASSET.ZTRASHEDBYPARTICIPANT',

        CASE ZINTRESOU.ZTRASHEDSTATE
            WHEN 0 THEN '0  [INTRESOU Not In Trash/Recently Deleted]'
            WHEN 1 THEN '1  [INTRESOU In Trash/Recently Deleted]'
            ELSE 'Unknown Value: ' || ZINTRESOU.ZTRASHEDSTATE || ''
        END AS '184-ZINTRESOU.ZTRASHEDSTATE',

        datetime(ZINTRESOU.ZTRASHEDDATE + 978307200, 'UNIXEPOCH') AS '185-ZINTRESOU.ZTRASHEDDATE(UTC)',

        CASE ZASSET.ZCLOUDDELETESTATE
            WHEN 0 THEN '0  [CLOUD Asset Not Deleted]'
            WHEN 1 THEN '1  [CLOUD Asset Deleted]'
            ELSE 'Unknown Value: ' || ZASSET.ZCLOUDDELETESTATE || ''
        END AS '186-ZASSET.ZCLOUDDELETESTATE',

        CASE ZINTRESOU.ZCLOUDDELETESTATE
            WHEN 0 THEN '0  [CLOUD IntResou Not Deleted]'
            WHEN 1 THEN '1  [CLOUD IntResou Deleted]'
            ELSE 'Unknown Value: ' || ZINTRESOU.ZCLOUDDELETESTATE || ''
        END AS '187-ZINTRESOU.ZCLOUDDELETESTATE',

        CASE ZADDASSETATTR.ZPTPTRASHEDSTATE
            WHEN 0 THEN '0  [PTP Not in Trash]'
            WHEN 1 THEN '1  [PTP In Trash]'
            ELSE 'Unknown Value: ' || ZADDASSETATTR.ZPTPTRASHEDSTATE || ''
        END AS '188-ZADDASSETATTR.ZPTPTRASHEDSTATE',

        CASE ZINTRESOU.ZPTPTRASHEDSTATE
            WHEN 0 THEN '0  [PTP IntResou Not in Trash]'
            WHEN 1 THEN '1  [PTP IntResou In Trash]'
            ELSE 'Unknown Value: ' || ZINTRESOU.ZPTPTRASHEDSTATE || ''
        END AS '189-ZINTRESOU.ZPTPTRASHEDSTATE',

        ZINTRESOU.ZCLOUDDELETEASSETUUIDWITHRESOURCETYPE AS '190-ZINTRESOU.ZCLOUDDELETEASSETUUIDWITHRESOURCETYPE',

        datetime(ZMEDANLYASTATTR.ZMEDIAANALYSISTIMESTAMP + 978307200, 'UNIXEPOCH') AS '191-ZMEDANLYASTATTR.ZMEDIAANALYSISTIMESTAMP(UTC)',
        datetime(ZASSET.ZANALYSISSTATEMODIFICATIONDATE + 978307200, 'UNIXEPOCH') AS '192-ZASSET.ZANALYSISSTATEMODIFICATIONDATE(UTC)',

        ZADDASSETATTR.ZPENDINGVIEWCOUNT AS '193-ZADDASSETATTR.ZPENDINGVIEWCOUNT',
        ZADDASSETATTR.ZVIEWCOUNT AS '194-ZADDASSETATTR.ZVIEWCOUNT',
        ZADDASSETATTR.ZPENDINGPLAYCOUNT AS '195-ZADDASSETATTR.ZPENDINGPLAYCOUNT',
        ZADDASSETATTR.ZPLAYCOUNT AS '196-ZADDASSETATTR.ZPLAYCOUNT',
        ZADDASSETATTR.ZPENDINGSHARECOUNT AS '197-ZADDASSETATTR.ZPENDINGSHARECOUNT',
        ZADDASSETATTR.ZSHARECOUNT AS '198-ZADDASSETATTR.ZSHARECOUNT',

        datetime(ZASSET.ZLASTSHAREDDATE + 978307200, 'UNIXEPOCH') AS '199-ZASSET.ZLASTSHAREDDATE(UTC)',

        ZADDASSETATTR.ZSHAREORIGINATOR AS '200-ZADDASSETATTR.ZSHAREORIGINATOR',

        CASE ZASSET.ZSYNDICATIONSTATE
            WHEN 0 THEN '0  [Local PL Asset - Syndication State N/A]'
            ELSE 'Unknown Value: ' || ZASSET.ZSYNDICATIONSTATE || ''
        END AS '201-ZASSET.ZSYNDICATIONSTATE(LPL)',

        ZADDASSETATTR.ZSYNDICATIONHISTORY AS '202-ZADDASSETATTR.ZSYNDICATIONHISTORY',
        ZMEDANLYASTATTR.ZSYNDICATIONPROCESSINGVERSION AS '203-ZMEDANLYASTATTR.ZSYNDICATIONPROCESSINGVERSION',

        CASE ZMEDANLYASTATTR.ZSYNDICATIONPROCESSINGVALUE
            WHEN 0 THEN '0  [N/A]'
            WHEN 1 THEN '1  [Wide Camera JPG - Still Testing]'
            WHEN 2 THEN '2  [Telephoto Camera Lens - Still Testing]'
            WHEN 4 THEN '4  [SWY Asset Orig Asset Import System Package App - Still Testing]'
            WHEN 16 THEN '16  [Still Testing]'
            WHEN 1024 THEN '1024  [SWY Asset OrigAssetImport Native Camera - Still Testing]'
            WHEN 2048 THEN '2048  [Still Testing]'
            WHEN 4096 THEN '4096  [SWY Asset Manually Saved - Still Testing]'
            ELSE 'Unknown Value: ' || ZMEDANLYASTATTR.ZSYNDICATIONPROCESSINGVALUE || ''
        END AS '204-ZMEDANLYASTATTR.ZSYNDICATIONPROCESSINGVALUE',

        -- datetime(ZMEDANLYASTATTR.ZVAANALYSISTIMESTAMP + 978307200, 'UNIXEPOCH') AS '205-ZMEDANLYASTATTR.ZVAANALYSISTIMESTAMP(UTC)',
        -- ZMEDANLYASTATTR.ZVAANALYSISVERSION AS '206-ZMEDANLYASTATTR.ZVAANALYSISVERSION',

        CASE ZADDASSETATTR.ZALLOWEDFORANALYSIS
            WHEN 0 THEN '0  [Asset Not Allowed For Analysis]'
            WHEN 1 THEN '1  [Asset Allowed for Analysis]'
            ELSE 'Unknown Value: ' || ZADDASSETATTR.ZALLOWEDFORANALYSIS || ''
        END AS '207-ZADDASSETATTR.ZALLOWEDFORANALYSIS',

        ZADDASSETATTR.ZSCENEANALYSISVERSION AS '208-ZADDASSETATTR.ZSCENEANALYSISVERSION',

        CASE ZADDASSETATTR.ZSCENEANALYSISISFROMPREVIEW
            WHEN 0 THEN '0  [No]'
            ELSE 'Unknown Value: ' || ZADDASSETATTR.ZSCENEANALYSISISFROMPREVIEW || ''
        END AS '209-ZADDASSETATTR.ZSCENEANALYSISISFROMPREVIEW',

        datetime(ZADDASSETATTR.ZSCENEANALYSISTIMESTAMP + 978307200, 'UNIXEPOCH') AS '210-ZADDASSETATTR.ZSCENEANALYSISTIMESTAMP(UTC)',

        CASE ZASSET.ZDUPLICATEASSETVISIBILITYSTATE
            WHEN 0 THEN '0  [No Duplicates]'
            WHEN 1 THEN '1  [Has Duplicate]'
            WHEN 2 THEN '2  [Is a Duplicate]'
            ELSE 'Unknown Value: ' || ZASSET.ZDUPLICATEASSETVISIBILITYSTATE || ''
        END AS '211-ZASSET.ZDUPLICATEASSETVISIBILITYSTATE',

        CASE ZADDASSETATTR.ZDESTINATIONASSETCOPYSTATE
            WHEN 0 THEN '0  [No Copy]'
            WHEN 1 THEN '1  [Has A Copy]'
            WHEN 2 THEN '2  [Has A Copy]'
            ELSE 'Unknown Value: ' || ZADDASSETATTR.ZDESTINATIONASSETCOPYSTATE || ''
        END AS '212-ZADDASSETATTR.ZDESTINATIONASSETCOPYSTATE',

        -- ZSCENEP.ZDATA AS '213-ZSCENEP.ZDATA (HEX NSKeyed .plist)',
        -- ZSCENEP.ZDUPLICATEMATCHINGDATA AS '214-ZSCENEP.ZDUPLICATEMATCHINGDATA (HEX NSKeyed .plist)',
        -- ZSCENEP.ZDUPLICATEMATCHINGALTERNATEDATA AS '215-ZSCENEP.ZDUPLICATEMATCHINGALTERNATEDATA (HEX NSKeyed .plist)',
        ZADDASSETATTR.ZSOURCEASSETFORDUPLICATIONSCOPEIDENTIFIER AS '216-ZADDASSETATTR.ZSOURCEASSETFORDUPLICATIONSCOPEIDENTIFIER',
        ZCLDMAST.ZSOURCEMASTERFORDUPLICATIONSCOPEIDENTIFIER AS '217-ZCLDMAST.ZSOURCEMASTERFORDUPLICATIONSCOPEIDENTIFIER',
        ZADDASSETATTR.ZSOURCEASSETFORDUPLICATIONIDENTIFIER AS '218-ZADDASSETATTR.ZSOURCEASSETFORDUPLICATIONIDENTIFIER',
        ZCLDMAST.ZSOURCEMASTERFORDUPLICATIONIDENTIFIER AS '219-ZCLDMAST.ZSOURCEMASTERFORDUPLICATIONIDENTIFIER',
        ZEXTATTR.Z_ENT AS '220-ZEXTATTR.Z_ENT',
        ZEXTATTR.Z_OPT AS '221-ZEXTATTR.Z_OPT',
        ZADDASSETATTR.ZVARIATIONSUGGESTIONSTATES AS '222-ZADDASSETATTR.ZVARIATIONSUGGESTIONSTATES',
        ZASSET.ZHIGHFRAMERATESTATE AS '223-ZASSET.ZHIGHFRAMERATESTATE',
        ZASSET.ZVIDEOKEYFRAMETIMESCALE AS '224-ZASSET.ZVIDEOKEYFRAMETIMESCALE',
        ZASSET.ZVIDEOKEYFRAMEVALUE AS '225-ZASSET.ZVIDEOKEYFRAMEVALUE',
        ZEXTATTR.ZISO AS '226-ZEXTATTR.ZISO',
        ZEXTATTR.ZMETERINGMODE AS '227-ZEXTATTR.ZMETERINGMODE',
        ZEXTATTR.ZSAMPLERATE AS '228-ZEXTATTR.ZSAMPLERATE',
        ZEXTATTR.ZTRACKFORMAT AS '229-ZEXTATTR.ZTRACKFORMAT',
        ZEXTATTR.ZWHITEBALANCE AS '230-ZEXTATTR.ZWHITEBALANCE',
        ZEXTATTR.ZASSET AS '231-ZEXTATTR.ZASSET',
        ZEXTATTR.ZAPERTURE AS '232-ZEXTATTR.ZAPERTURE',
        ZEXTATTR.ZBITRATE AS '233-ZEXTATTR.ZBITRATE',
        ZEXTATTR.ZEXPOSUREBIAS AS '234-ZEXTATTR.ZEXPOSUREBIAS',
        ZEXTATTR.ZFPS AS '235-ZEXTATTR.ZFPS',
        ZEXTATTR.ZSHUTTERSPEED AS '236-ZEXTATTR.ZSHUTTERSPEED',
        ZEXTATTR.ZSLUSHSCENEBIAS AS '237-ZEXTATTR.ZSLUSHSCENEBIAS',
        ZEXTATTR.ZSLUSHVERSION AS '238-ZEXTATTR.ZSLUSHVERSION',
        ZEXTATTR.ZSLUSHPRESET AS '239-ZEXTATTR.ZSLUSHPRESET',
        ZEXTATTR.ZSLUSHWARMTHBIAS AS '240-ZEXTATTR.ZSLUSHWARMTHBIAS',
        ZASSET.ZHEIGHT AS '241-ZASSET.ZHEIGHT',
        ZADDASSETATTR.ZORIGINALHEIGHT AS '242-ZADDASSETATTR.ZORIGINALHEIGHT',
        ZINTRESOU.ZUNORIENTEDHEIGHT AS '243-ZINTRESOU.ZUNORIENTEDHEIGHT',
        ZASSET.ZWIDTH AS '244-ZASSET.ZWIDTH',
        ZADDASSETATTR.ZORIGINALWIDTH AS '245-ADDASSETATTR.ZORIGINALWIDTH',
        ZINTRESOU.ZUNORIENTEDWIDTH AS '246-ZINTRESOU.ZUNORIENTEDWIDTH',
        ZSHARE.ZTHUMBNAILIMAGEDATA AS '247-ZSHARE.ZTHUMBNAILIMAGEDATA',
        ZASSET.ZTHUMBNAILINDEX AS '248-ZASSET.ZTHUMBNAILINDEX',
        ZADDASSETATTR.ZEMBEDDEDTHUMBNAILHEIGHT AS '249-ZADDASSETATTR.ZEMBEDDEDTHUMBNAILHEIGHT',
        ZADDASSETATTR.ZEMBEDDEDTHUMBNAILLENGTH AS '250-ZADDASSETATTR.ZEMBEDDEDTHUMBNAILLENGTH',
        ZADDASSETATTR.ZEMBEDDEDTHUMBNAILOFFSET AS '251-ZADDASSETATTR.ZEMBEDDEDTHUMBNAILOFFSET',
        ZADDASSETATTR.ZEMBEDDEDTHUMBNAILWIDTH AS '252-ZADDASSETATTR.ZEMBEDDEDTHUMBNAILWIDTH',
        ZASSET.ZPACKEDACCEPTABLECROPRECT AS '253-ZASSET.ZPACKEDACCEPTABLECROPRECT',
        ZASSET.ZPACKEDBADGEATTRIBUTES AS '254-ZASSET.ZPACKEDBADGEATTRIBUTES',
        ZASSET.ZPACKEDPREFERREDCROPRECT AS '255-ZASSET.ZPACKEDPREFERREDCROPRECT',
        ZASSET.ZCURATIONSCORE AS '256-ZASSET.ZCURATIONSCORE',
        ZASSET.ZCAMERAPROCESSINGADJUSTMENTSTATE AS '257-ZASSET.ZCAMERAPROCESSINGADJUSTMENTSTATE',
        ZASSET.ZDEPTHTYPE AS '258-ZASSET.ZDEPTHTYPE',
        ZASSET.ZISMAGICCARPET AS '259-ZASSET.ZISMAGICCARPET',
        ZASSET.ZLIBRARYSCOPE AS '260-ZASSET.ZLIBRARYSCOPE',

        CASE ZASSET.ZLIBRARYSCOPESHARESTATE
            WHEN 0 THEN '0  [Not Shared - Still Testing]'
            ELSE 'Unknown Value: ' || ZASSET.ZLIBRARYSCOPESHARESTATE || ''
        END AS '261-ZASSET.ZLIBRARYSCOPESHARESTATE',

        ZADDASSETATTR.ZORIGINALRESOURCECHOICE AS '262-ZADDASSETATTR.ZORIGINALRESOURCECHOICE',
        ZADDASSETATTR.ZSPATIALOVERCAPTUREGROUPIDENTIFIER AS '263-ZADDASSETATTR.ZSPATIALOVERCAPTUREGROUPIDENTIFIER',
        -- hex(ZADDASSETATTR.ZOBJECTSALIENCYRECTSDATA) AS '264-ZADDASSETATTR.ZOBJECTSALIENCYRECTSDATA(HEX NSKeyed .plist)',
        -- hex(ZADDASSETATTR.ZORIGINALHASH) AS '265-ZADDASSETATTR.ZORIGINALHASH(HEX)',
        ZADDASSETATTR.ZPLACEANNOTATIONDATA AS '266-ZADDASSETATTR.ZPLACEANNOTATIONDATA',
        ZADDASSETATTR.ZDISTANCEIDENTITY AS '267-ZADDASSETATTR.ZDISTANCEIDENTITY',

    /* Source for each line of data */
    '/private/var/mobile/Media/PhotoData/Photos.sqlite; ZASSET(Z_PK:' || ZASSET.Z_PK || ')' AS 'DATA_SOURCE'


    FROM ZASSET

        LEFT JOIN ZADDITIONALASSETATTRIBUTES ZADDASSETATTR ON ZADDASSETATTR.Z_PK = ZASSET.ZADDITIONALATTRIBUTES
        LEFT JOIN ZEXTENDEDATTRIBUTES ZEXTATTR ON ZEXTATTR.Z_PK = ZASSET.ZEXTENDEDATTRIBUTES
        LEFT JOIN ZINTERNALRESOURCE ZINTRESOU ON ZINTRESOU.ZASSET = ZASSET.Z_PK
        LEFT JOIN ZSCENEPRINT ZSCENEP ON ZSCENEP.Z_PK = ZADDASSETATTR.ZSCENEPRINT
        LEFT JOIN Z_28ASSETS ON Z_28ASSETS.Z_3ASSETS = ZASSET.Z_PK
        LEFT JOIN ZGENERICALBUM ZGENALBUM ON ZGENALBUM.Z_PK = Z_28ASSETS.Z_28ALBUMS
        LEFT JOIN ZUNMANAGEDADJUSTMENT ZUNMADJ ON ZADDASSETATTR.ZUNMANAGEDADJUSTMENT = ZUNMADJ.Z_PK
        LEFT JOIN Z_27ALBUMLISTS ON Z_27ALBUMLISTS.Z_27ALBUMS = ZGENALBUM.Z_PK
        LEFT JOIN ZALBUMLIST ON ZALBUMLIST.Z_PK = Z_27ALBUMLISTS.Z_2ALBUMLISTS
        LEFT JOIN ZGENERICALBUM ParentZGENALBUM ON ParentZGENALBUM.Z_PK = ZGENALBUM.ZPARENTFOLDER
        LEFT JOIN ZCLOUDMASTER ZCLDMAST ON ZASSET.ZMASTER = ZCLDMAST.Z_PK
        LEFT JOIN ZCLOUDMASTERMEDIAMETADATA AAAZCLDMASTMedData ON AAAZCLDMASTMedData.Z_PK = ZADDASSETATTR.ZMEDIAMETADATA
        LEFT JOIN ZCLOUDMASTERMEDIAMETADATA CMZCLDMASTMedData ON CMZCLDMASTMedData.Z_PK = ZCLDMAST.ZMEDIAMETADATA
        LEFT JOIN ZMEDIAANALYSISASSETATTRIBUTES ZMEDANLYASTATTR ON ZASSET.ZMEDIAANALYSISATTRIBUTES = ZMEDANLYASTATTR.Z_PK
        LEFT JOIN ZSHARE ON ZSHARE.Z_PK = ZASSET.ZMOMENTSHARE


    ORDER BY ZASSET.ZADDEDDATE
)


SELECT *


FROM joined


WHERE
    FILEPATH LIKE '%.webp%'