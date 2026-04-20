/*
[DLU]
    15-Jul-2025

Query copied from https://github.com/ScottKjr3347/iOS_SWY_PL_Photos.sqlite_Queries/blob/main/iOS16/iOS16_SWY-PL_Phsql_Basic.txt
*/

SELECT
    ROW_NUMBER() OVER() AS 'record_number',
    ZASSET.Z_PK AS 'ZASSET.z_pk ',
    -- ZASSET.ZSORTTOKEN AS 'ZASSET.ZSORTTOKEN',
    -- ZASSET.ZPROMOTIONSCORE AS 'ZASSET.ZPROMOTIONSCORE',

    CASE ZASSET.ZCOMPLETE
        WHEN 1 THEN 'Yes [1]'
        ELSE ZASSET.ZCOMPLETE
    END AS 'ZASSET.zcomplete',

    ZADDASSETATTR.Z_PK AS 'ZADDASSETATTR.z_pk',

    -- [ZCLOUDMASTER.Z_PK = ZASSET.ZMASTER]
    ZCLOUDMASTER.Z_PK AS 'ZCLOUDMASTER.z_pk',

    -- [ZASSET.ZMASTER = ZCLOUDMASTER.Z_PK]
    ZASSET.ZMASTER AS 'ZASSET.ZMASTER',

    -- [ZASSET.ZEXTENDEDATTRIBUTES = ZEXTATTR.Z_PK]
    ZASSET.ZEXTENDEDATTRIBUTES AS 'ZASSET.zextendedattributes',

    -- [ZEXTATTR.Z_PK = ZASSET.ZEXTENDEDATTRIBUTES]
    ZEXTATTR.Z_PK AS 'ZEXTATTR.z_pk',

    -- [CMzCldMastMedData-CldMast = ZCLOUDMASTER.Z_PK]
    CMzCldMastMedData.ZCLOUDMASTER AS 'CMzCldMastMedData.zcloudmaster',

    -- [ZCLOUDMASTER.ZMEDIAMETADATA = zCldMastMedData.Z_PK]
    ZCLOUDMASTER.ZMEDIAMETADATA AS 'ZCLOUDMASTER.zmediametadata',

    -- [CMzCldMastMedData.Z_PK=ZADDASSETATTR&ZCLOUDMASTER.ZMEDIAMETADATA]
    CMzCldMastMedData.Z_PK AS 'CMzCldMastMedData.z_pk',
    CMzCldMastMedData.Z_ENT AS 'CMzCldMastMedData.z_ent',

    -- [ZASSET.UUID = store.cloudphotodb]
    ZASSET.ZUUID AS 'ZASSET.zuuid',
    ZASSET.ZDIRECTORY AS 'ZASSET.zdirectory',
    ZASSET.ZFILENAME AS 'ZASSET.zfilename',
    CONCAT(ZASSET.ZDIRECTORY,'/',ZASSET.ZFILENAME) AS filepath,
    ZADDASSETATTR.ZORIGINALFILENAME AS 'ZADDASSETATTR.zoriginalfilename',
    ZCLOUDMASTER.ZORIGINALFILENAME AS 'ZCLOUDMASTER.zoriginalfilename ',

    /* The GUID value in this column matches the GUID of the message from the sms.db file */
    ZADDASSETATTR.ZSYNDICATIONIDENTIFIER AS 'ZADDASSETATTR.zsyndicationidentifier',

    -- [ZASSET.Cloud_Asset_GUID = store.cloudphotodb]
    ZASSET.ZCLOUDASSETGUID AS 'ZASSET.zcloudassetguid',
    ZASSET.ZCLOUDCOLLECTIONGUID AS 'ZASSET.zcloudcollectionguid',

    -- [ZCLOUDMASTER.ZCLOUDMASTERGUID = store.cloudphotodb]
    ZCLOUDMASTER.ZCLOUDMASTERGUID AS 'ZCLOUDMASTER.zcloudmasterguid',

    -- [zGenAlbum.ZCLOUDGUID = store.cloudphotodb]
    zGenAlbum.ZCLOUDGUID AS 'ZGENERICALBUM.zcloudguid',

    -- [ZSHARE.ZSCOPEIDENTIFIER = store.cloudphotodb]
    ZSHARE.ZSCOPEIDENTIFIER AS 'ZSHARE.zscopeidentifier',
    ZADDASSETATTR.ZORIGINALASSETSUUID AS 'ZADDASSETATTR.zoriginalassetsuuid',
    ZADDASSETATTR.ZPUBLICGLOBALUUID AS 'ZADDASSETATTR.zpublicglobaluuid',
    ZADDASSETATTR.ZMASTERFINGERPRINT AS 'ZADDASSETATTR.zmasterfingerprint',
    ZADDASSETATTR.ZORIGINATINGASSETIDENTIFIER AS 'ZADDASSETATTR.zoriginatingassetidentifier',
    ZCLOUDMASTER.ZORIGINATINGASSETIDENTIFIER AS 'ZCLOUDMASTER.zoriginatingassetidentifier',
    ZINTERNALRESOURCE.ZFINGERPRINT AS 'ZINTERNALRESOURCE.zfingerprint',
    ZADDASSETATTR.ZADJUSTEDFINGERPRINT AS 'ZADDASSETATTR.zadjustedfingerprint',
    ZUNMANAGEDADJUSTMENT.ZOTHERADJUSTMENTSFINGERPRINT AS 'ZUNMANAGEDADJUSTMENT.ZOTHERADJUSTMENTSFINGERPRINT',
    ZUNMANAGEDADJUSTMENT.ZSIMILARTOORIGINALADJUSTMENTSFINGERPRINT AS 'ZUNMANAGEDADJUSTMENT.zsimilartooriginaladjustmentsfingerprint',

    CASE
        WHEN ZASSET.ZADDEDDATE < 0 THEN 'Invalid Date/Time Value: [' || ZASSET.ZADDEDDATE || ']'
        ELSE datetime(ZASSET.ZADDEDDATE + 978307200, 'UNIXEPOCH')
    END AS 'ZASSET.zaddeddate(utc)',

    CASE
        WHEN ZASSET.ZDATECREATED < 0 THEN 'Invalid Date/Time Value: [' || ZASSET.ZDATECREATED || ']'
        ELSE datetime(ZASSET.ZDATECREATED + 978307200, 'UNIXEPOCH')
    END AS 'ZASSET.zdatecreated(utc)',

    datetime(ZASSET.ZMODIFICATIONDATE + 978307200, 'UNIXEPOCH') AS 'ZASSET.zmodificationdate(utc)',

    CASE
        WHEN NULL THEN NULL
        ELSE datetime(ZASSET.ZANALYSISSTATEMODIFICATIONDATE + 978307200, 'UNIXEPOCH')
    END AS 'ZASSET.zanalysisstatemodificationdate(utc)',

    datetime(ZCLOUDMASTER.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'ZCLOUDMASTER.zcreationdate(utc)',
    datetime(ZINTERNALRESOURCE.ZCLOUDMASTERDATECREATED + 978307200, 'UNIXEPOCH') AS 'ZINTERNALRESOURCE.zcloudmasterdatecreated(utc)',

    ZADDASSETATTR.ZIMPORTEDBYBUNDLEIDENTIFIER AS 'ZADDASSETATTR.zimportedbybundleidentifier',
    ZADDASSETATTR.ZIMPORTEDBYDISPLAYNAME AS 'ZADDASSETATTR.zimportedbydisplayname',
    ZADDASSETATTR.ZORIGINALHEIGHT AS 'ZADDASSETATTR.zoriginalheight',
    ZADDASSETATTR.ZORIGINALWIDTH AS 'ZADDASSETATTR.zoriginalwidth',
    ZADDASSETATTR.ZORIGINALORIENTATION AS 'ZADDASSETATTR.zoriginalorientation',
    printf("%,d", ZADDASSETATTR.ZORIGINALFILESIZE) AS 'ZADDASSETATTR.zoriginalfilesize(bytes)',
    ZCLOUDMASTER.ZIMPORTEDBYBUNDLEIDENTIFIER AS 'ZCLOUDMASTER.zimportedbybundleidentifier',
    ZCLOUDMASTER.ZIMPORTEDBYDISPLAYNAME AS 'ZCLOUDMASTER.zimportedbydisplayname',

    CASE ParentzGenAlbum.ZCLOUDLOCALSTATE
        WHEN 0 THEN '0 [iCloudPhotos ON=Asset In Shared/Other Album / iCloudPhotos OFF=Generic Album]'
        WHEN 1 THEN '1 [iCloudPhotos ON=Asset In Generic Album]'
        ELSE 'Unknown Value: ' || ParentzGenAlbum.ZCLOUDLOCALSTATE || ''
    END AS 'ParentzGenAlbum.zcloudlocalstate',

    ParentzGenAlbum.ZTITLE AS 'ParentzGenAlbum.ztitle',

    datetime(ParentzGenAlbum.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'ParentzGenAlbum.zcreationdate(utc)',
    datetime(zGenAlbum.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'zGenAlbum.zcreationdate(utc)',

    CASE zGenAlbum.ZCLOUDLOCALSTATE
        WHEN 0 THEN '0 [iCloudPhotos ON=Asset In Shared/Other Album / iCloudPhotos OFF=Generic Album]'
        WHEN 1 THEN '1 [iCloudPhotos ON=Asset In Generic Album]'
        ELSE 'Unknown Value: ' || zGenAlbum.ZCLOUDLOCALSTATE || ''
    END AS 'zGenAlbum.zcloudlocalstate',

    zGenAlbum.ZTITLE AS 'zGenAlbum.ztitle',

	CASE ZADDASSETATTR.ZIMPORTEDBY
        WHEN 0 THEN '0 [Cloud Other]'
        WHEN 1 THEN '1 [Native Back Camera]'
        WHEN 2 THEN '2 [Native Front Camera]'
        WHEN 3 THEN '3 [Third Party App]'
        WHEN 4 THEN '4 [Still Testing]'
        WHEN 5 THEN '5 [PhotoBooth PL Asset]'
        WHEN 6 THEN '6 [Third Party App]'
        WHEN 7 THEN '7 [iCloud Share Link CMMAsset]'
        WHEN 8 THEN '8 [System Package App]'
        WHEN 9 THEN '9 [Native App]'
        WHEN 10 THEN '10 [Still Testing]'
        WHEN 11 THEN '11 [Still Testing]'
        WHEN 12 THEN '12 [SWY Syndication PL]'
        ELSE 'Unknown Value: ' || ZADDASSETATTR.ZIMPORTEDBY || ''
    END AS 'ZADDASSETATTR.zimportedby',

    datetime(ZCLOUDMASTER.ZIMPORTDATE + 978307200, 'UNIXEPOCH') AS 'ZCLOUDMASTER.zimportdate(utc)',

	CASE ZCLOUDMASTER.ZIMPORTEDBY
        WHEN 0 THEN '0 [Cloud Other]'
        WHEN 1 THEN '1 [Native Back Camera]'
        WHEN 2 THEN '2 [Native Front Camera]'
        WHEN 3 THEN '3 [Third Party App]'
        WHEN 4 THEN '4 [Still Testing]'
        WHEN 5 THEN '5 [PhotoBooth PL Asset]'
        WHEN 6 THEN '6 [Third Party App]'
        WHEN 7 THEN '7 [iCloud Share Link CMMAsset]'
        WHEN 8 THEN '8 [System Package App]'
        WHEN 9 THEN '9 [Native App]'
        WHEN 10 THEN '10 [Still Testing]'
        WHEN 11 THEN '11 [Still Testing]'
        WHEN 12 THEN '12 [SWY Syndication PL]'
        ELSE 'Unknown Value: ' || ZCLOUDMASTER.ZIMPORTEDBY || ''
    END AS 'ZCLOUDMASTER.zimportedby',

    -- hex(ZASSET.ZIMAGEREQUESTHINTS) AS 'ZASSET.ZIMAGEREQUESTHINTS(HEX)',

    CASE ZASSET.ZBUNDLESCOPE
        WHEN 0 THEN '0 [iCloudPhotos ON=Not In Shared Album iCloudPhotos OFF=On Local Device]'
        WHEN 1 THEN '1 [SWY Syndication CMMAsset]'
        WHEN 2 THEN '2 [iCloudPhotos ON=Asset In Cloud Shared Album]'
        WHEN 3 THEN '3 [iCloudPhotos ON=SWY Syndication Asset]'
        ELSE 'Unknown Value: ' || ZASSET.ZBUNDLESCOPE || ''
    END AS 'ZASSET.zbundlescope',

    CASE ZASSET.ZCLOUDISMYASSET
        WHEN 0 THEN '0 [Not My Asset in Shared Album]'
        WHEN 1 THEN '1 [My Asset in Shared Album]'
        ELSE 'Unknown Value: ' || ZASSET.ZCLOUDISMYASSET || ''
    END AS 'ZASSET.zcloudismyasset',

    CASE ZASSET.ZCLOUDISDELETABLE
        WHEN 0 THEN '0 [No]'
        WHEN 1 THEN '1 [Yes]'
        ELSE 'Unknown Value: ' || ZASSET.ZCLOUDISDELETABLE || ''
    END AS 'ZASSET.zcloudisdeletable',

    CASE ZASSET.ZCLOUDLOCALSTATE
        WHEN 0 THEN '0 [iCloudPhotos ON=Asset In Shared Other Album/iCloudPhotos OFF=Not Synced]'
        WHEN 1 THEN '1 [iCloudPhotos ON=Asset Synced with iCloud]'
        ELSE 'Unknown Value: ' || ZASSET.ZCLOUDLOCALSTATE || ''
    END AS 'ZASSET.zcloudlocalstate',

    CASE ZASSET.ZVISIBILITYSTATE
        WHEN 0 THEN '0 [Visible Photo Library]'
        WHEN 2 THEN '2 [Not Visible Photo Library]'
        ELSE 'Unknown Value: ' || ZASSET.ZVISIBILITYSTATE || ''
    END AS 'ZASSET.zvisibilitystate',

    ZEXTATTR.ZCAMERAMAKE AS 'ZEXTATTR.zcameramake',
    ZEXTATTR.ZCAMERAMODEL AS 'ZEXTATTR.zcameramodel',
    ZEXTATTR.ZLENSMODEL AS 'ZEXTATTR.zlensmodel',

    CASE ZEXTATTR.ZFLASHFIRED
        WHEN 0 THEN '0 [No Flash]'
        WHEN 1 THEN '1 [Flash Fired]'
        ELSE 'Unknown Value: ' || ZEXTATTR.ZFLASHFIRED || ''
    END AS 'ZEXTATTR.zflashfired',

    ZEXTATTR.ZFOCALLENGTH AS 'ZEXTATTR.zfocallength',
    ZEXTATTR.ZFOCALLENGTHIN35MM AS 'ZEXTATTR.zfocallengthin35mm',
    ZEXTATTR.ZDIGITALZOOMRATIO AS 'ZEXTATTR.zdigitalzoomratio',

    CASE ZASSET.ZDERIVEDCAMERACAPTUREDEVICE
        WHEN 0 THEN '0 [Back Camera/Other]'
        WHEN 1 THEN '1 [Front Camera]'
        ELSE 'Unknown Value: ' || ZASSET.ZDERIVEDCAMERACAPTUREDEVICE || ''
    END AS 'ZASSET.zderivedcameracapturedevice',

    CASE ZADDASSETATTR.ZCAMERACAPTUREDEVICE
        WHEN 0 THEN '0 [Back Camera/Other]'
        WHEN 1 THEN '1 [Front Camera]'
        ELSE 'Unknown Value: ' || ZADDASSETATTR.ZCAMERACAPTUREDEVICE || ''
    END AS 'ZADDASSETATTR.zcameracapturedevice',

    CASE ZASSET.ZSAVEDASSETTYPE
        WHEN 0 THEN '0 [Saved Via Other Source]'
        WHEN 1 THEN '1 [Still Testing]'
        WHEN 2 THEN '2 [Still Testing]'
        WHEN 3 THEN '3 [SWY Syndicaion PL Asset Not In Local PL]'
        WHEN 4 THEN '4 [Photo Cloud Sharing Data Asset]'
        WHEN 5 THEN '5 [Still Testing]'
        WHEN 6 THEN '6 [Cloud Photo Library Asset]'
        WHEN 7 THEN '7 [Still Testing]'
        WHEN 8 THEN '8 [iCloud Link CloudMaster Moment Asset]'
        WHEN 12 THEN '12 [SWY Syndicaion PL Asset In Local PL]'
        ELSE 'Unknown Value: ' || ZASSET.ZSAVEDASSETTYPE || ''
    END AS 'ZASSET.zsavedassettype',

    CASE ZASSET.ZSAVEDASSETTYPE
        WHEN 0 THEN '0 [Saved Via Other Source]'
        WHEN 1 THEN '1 [Still Testing]'
        WHEN 2 THEN '2 [Still Testing]'
        WHEN 3 THEN '3 [Local Photo Library Asset]'
        WHEN 4 THEN '4 [Photo Cloud Sharing Data Asset]'
        WHEN 5 THEN '5 [PhotoBooth Photo Library Asset]'
        WHEN 6 THEN '6 [Cloud Photo Library Asset]'
        WHEN 7 THEN '7 [Still Testing]'
        WHEN 8 THEN '8 [iCloud Link CloudMaster Moment Asset]'
        WHEN 12 THEN '12 [SWY Syndication PL Asset/Auto Displayed in LPL]'
        ELSE 'Unknown Value: ' || ZASSET.ZSAVEDASSETTYPE || ''
    END AS 'ZASSET.zsavedassettype',

    CASE ZASSET.ZSYNDICATIONSTATE
        WHEN 0 THEN '0 [Received SWY Synd Asset]'
        WHEN 1 THEN '1 [Sent SWY Synd Asset]'
        WHEN 2 THEN '2 [Manually Saved SWY Synd Asset]'
        WHEN 8 THEN '8 [SWY Linked Asset was Visible On Device User Deleted Link]'
        WHEN 10 THEN '10 [Manually Saved SWY Synd Asset User Deleted From LPL]'
        ELSE 'Unknown Value: ' || ZASSET.ZSYNDICATIONSTATE || ''
    END AS 'ZASSET.zsyndicationstate',

    ZADDASSETATTR.ZSYNDICATIONHISTORY AS 'ZADDASSETATTR.zsyndicationhistory',
    zMedAnlyAstAttr.ZSYNDICATIONPROCESSINGVERSION AS 'zMedAnlyAstAttr.zsyndicationprocessingversion',

    CASE zMedAnlyAstAttr.ZSYNDICATIONPROCESSINGVALUE
        WHEN 0 THEN '0 [N/A]'
        WHEN 1 THEN '1 [Still Testing Wide Camera JPG]'
        WHEN 2 THEN '2 [Still Testing Telephoto Camear Lens]'
        WHEN 4 THEN '4 [Still Testing SWY Asset OrigAssetImport SystemPackageApp]'
        WHEN 16 THEN '16 [Still Testing]'
        WHEN 1024 THEN '1024 [Still Testing SWY Asset OrigAssetImport Native Camera]'
        WHEN 2048 THEN '2048 [Still Testing]'
        WHEN 4096 THEN '4096 [Still Testing SWY Asset Manually Saved]'
        ELSE 'Unknown Value: ' || zMedAnlyAstAttr.ZSYNDICATIONPROCESSINGVALUE || ''
    END AS 'zMedAnlyAstAttr.zsyndicationprocessingvalue',

    CASE ZADDASSETATTR.ZDATECREATEDSOURCE
        WHEN 0 THEN '0 [Cloud Asset]'
        WHEN 1 THEN '1 [Local Asset EXIF]'
        WHEN 3 THEN '3 [Local Asset No EXIF]'
        ELSE 'Unknown Value: ' || ZADDASSETATTR.ZDATECREATEDSOURCE || ''
    END AS 'ZADDASSETATTR.zdatecreatedsource',

    ZADDASSETATTR.ZTIMEZONENAME AS 'ZADDASSETATTR.ztimezonename',
    ZADDASSETATTR.ZTIMEZONEOFFSET AS 'ZADDASSETATTR.ztimezoneoffset',
    ZADDASSETATTR.ZINFERREDTIMEZONEOFFSET AS 'ZADDASSETATTR.zinferredtimezoneoffset',
    ZADDASSETATTR.ZEXIFTIMESTAMPSTRING AS 'ZADDASSETATTR.zexiftimestampstring',

    CASE ZCLOUDMASTER.ZCLOUDLOCALSTATE
        WHEN 0 THEN '0 [Not Synced with Cloud]'
        WHEN 1 THEN '1 [Pending Upload]'
        WHEN 2 THEN '2 [Still Testing]'
        WHEN 3 THEN '3 [Synced with Cloud]'
        ELSE 'Unknown Value: ' || ZCLOUDMASTER.ZCLOUDLOCALSTATE || ''
    END AS 'ZCLOUDMASTER.zcloudlocalstate',

    ZASSET.ZIMPORTSESSION AS 'ZASSET.zimportsession',
    ZADDASSETATTR.ZIMPORTSESSIONID AS 'ZADDASSETATTR.zimportsessionid',

    datetime(ZADDASSETATTR.ZALTERNATEIMPORTIMAGEDATE + 978307200, 'UNIXEPOCH') AS 'ZADDASSETATTR.zalternateimportimagedate(utc)',

    ZCLOUDMASTER.ZIMPORTSESSIONID AS 'ZCLOUDMASTER.zimportsessionid',

    datetime(ZASSET.ZCLOUDBATCHPUBLISHDATE + 978307200, 'UNIXEPOCH') AS 'ZASSET.zcloudbatchpublishdate(utc)',
    datetime(ZASSET.ZCLOUDSERVERPUBLISHDATE + 978307200, 'UNIXEPOCH') AS 'ZASSET.zcloudserverpublishdate(utc)',

    ZASSET.ZCLOUDDOWNLOADREQUESTS AS 'ZASSET.zclouddownloadrequests',
    ZASSET.ZCLOUDBATCHID AS 'ZASSET.zcloudbatchid',

    datetime(ZADDASSETATTR.ZLASTUPLOADATTEMPTDATE + 978307200, 'UNIXEPOCH') AS 'ZADDASSETATTR.zlastuploadattemptdate(utc)',

    ZADDASSETATTR.ZUPLOADATTEMPTS AS 'ZADDASSETATTR.zuploadattempts',

    CASE ZASSET.ZLATITUDE
        WHEN -180.0 THEN '[-180.0]'
        ELSE ZASSET.ZLATITUDE
    END AS 'ZASSET.zlatitude',

    CASE ZASSET.ZLONGITUDE
        WHEN -180.0 THEN '[-180.0]'
        ELSE ZASSET.ZLONGITUDE
    END AS 'ZASSET.zlongitude',

    ZEXTATTR.ZLATITUDE AS 'ZEXTATTR.zlatitude',
    ZEXTATTR.ZLONGITUDE AS 'ZEXTATTR.zlongitude',

    CASE ZADDASSETATTR.ZGPSHORIZONTALACCURACY
        WHEN -1.0 THEN '[-1.0]'
        ELSE ZADDASSETATTR.ZGPSHORIZONTALACCURACY
    END AS 'ZADDASSETATTR.zgpshorizontalaccuracy',

    -- hex(ZASSET.ZLOCATIONDATA) AS 'ZASSET.zlocationdata(HEX)',
    -- hex(ZADDASSETATTR.ZREVERSELOCATIONDATA) AS 'ZADDASSETATTR.zreverselocationdata(hex nskeyed .plist)',

    CASE ZADDASSETATTR.ZSHIFTEDLOCATIONISVALID
        WHEN 0 THEN '0 [Shifted Location Not Valid]'
        WHEN 1 THEN '1 [Shifted Location Valid]'
    END AS 'ZADDASSETATTR.zshiftedlocationisvalid',

    ZADDASSETATTR.ZSHIFTEDLOCATIONDATA AS 'ZADDASSETATTR.zshiftedlocationdata',
    ZADDASSETATTR.ZLOCATIONHASH AS 'ZADDASSETATTR.zlocationhash',

    CASE AAAzCldMastMedData.Z_OPT
        WHEN 1 THEN '1 [Still Testing Cloud]'
        WHEN 2 THEN '2 [Still Testing This Device]'
        WHEN 3 THEN '3 [Still Testing Muted]'
        WHEN 4 THEN '4 [Still Testing Unknown]'
        WHEN 5 THEN '5 [Still Testing Unknown]'
        ELSE 'Unknown Value: ' || AAAzCldMastMedData.Z_OPT || ''
    END AS 'AAAzCldMastMedData.z_opt',

    ZADDASSETATTR.ZMEDIAMETADATATYPE AS 'ZADDASSETATTR.zmediametadatatype',
    -- hex(AAAzCldMastMedData.ZDATA) AS 'AAAzCldMastMedData.zdata(HEX)',

    CASE CMzCldMastMedData.z_opt
        WHEN 1 THEN '1 [Still Testing Has CldMastAsset]'
        WHEN 2 THEN '2 [Still Testing Local Asset]'
        WHEN 3 THEN '3 [Still Testing Muted]'
        WHEN 4 THEN '4 [Still Testing Unknown]'
        WHEN 5 THEN '5 [Still Testing Unknown]'
        ELSE 'Unknown Value: ' || CMzCldMastMedData.Z_OPT || ''
    END AS 'CMzCldMastMedData.z_opt',

    ZCLOUDMASTER.ZMEDIAMETADATATYPE AS 'ZCLOUDMASTER.zmediametadatatype',
    -- hex(CMzCldMastMedData.ZDATA) AS 'CMzCldMastMedData.zdata(HEX)',

    CASE ZASSET.ZSEARCHINDEXREBUILDSTATE
        WHEN 0 THEN '0 [Still Testing]'
        ELSE 'Unknown Value: ' || ZASSET.ZSEARCHINDEXREBUILDSTATE || ''
    END AS 'ZASSET.zsearchindexrebuildstate',

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
    END AS 'ZASSET.zorientation',

    CASE ZADDASSETATTR.ZORIGINALORIENTATION
        WHEN 1 THEN '1 [Video Default/Adjustment/Horizontal Camera (left)]'
        WHEN 2 THEN '2 [Horizontal Camera (right)]'
        WHEN 3 THEN '3 [Horizontal Camera (right)]'
        WHEN 4 THEN '4 [Horizontal Camera (left)]'
        WHEN 5 THEN '5 [Vertical Camera (top)]'
        WHEN 6 THEN '6 [Vertical Camera (top)]'
        WHEN 7 THEN '7 [Vertical Camera (bottom)]'
        WHEN 8 THEN '8 [Vertical Camera (bottom)]'
        ELSE 'Unknown Value: ' || ZASSET.ZORIENTATION || ''
    END AS 'ZADDASSETATTR.zoriginalorientation',

    CASE ZINTERNALRESOURCE.ZORIENTATION
        WHEN 0 THEN '0 [N/A]'
        WHEN 1 THEN '1 [Video Default/Adjustment/Horizontal Camera (left)]'
        WHEN 2 THEN '2 [Horizontal Camera (right)]'
        WHEN 3 THEN '3 [Horizontal Camera (right)]'
        WHEN 4 THEN '4 [Horizontal Camera (left)]'
        WHEN 5 THEN '5 [Vertical Camera (top)]'
        WHEN 6 THEN '6 [Vertical Camera (top)]'
        WHEN 7 THEN '7 [Vertical Camera (bottom)]'
        WHEN 8 THEN '8 [Vertical Camera (bottom)]'
        ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZORIENTATION || ''
    END AS 'ZINTERNALRESOURCE.zorientation',

    CASE ZASSET.ZKIND
        WHEN 0 THEN '0 [Photo]'
        WHEN 1 THEN '1 [Video]'
    END AS 'ZASSET.zkind',

    CASE ZASSET.ZKINDSUBTYPE
        WHEN 0 THEN '0 [Still Photo]'
        WHEN 2 THEN '2 [Live Photo]'
        WHEN 10 THEN '10 [SpringBoard Screenshot]'
        WHEN 100 THEN '100 [Video]'
        WHEN 101 THEN '101 [Slow Mo Video]'
        WHEN 102 THEN '102 [Time lapse Video]'
        WHEN 103 THEN '103 [Replay Screen Recording]'
        ELSE 'Unknown Value: ' || ZASSET.ZKINDSUBTYPE || ''
    END AS 'ZASSET.zkindsubtype',

    CASE ZADDASSETATTR.ZCLOUDKINDSUBTYPE
        WHEN 0 THEN '0 [Still Photo]'
        WHEN 1 THEN '1 [Still Testing]'
        WHEN 2 THEN '2 [Live Photo]'
        WHEN 3 THEN '3 [Screenshot]'
        WHEN 10 THEN '10 [SpringBoard Screenshot]'
        WHEN 100 THEN '100 [Video]'
        WHEN 101 THEN '101 [Slow Mo Video]'
        WHEN 102 THEN '102 [Time lapse Video]'
        WHEN 103 THEN '103 [Replay Screen Recording]'
        ELSE 'Unknown Value: ' || ZADDASSETATTR.ZCLOUDKINDSUBTYPE || ''
    END AS 'ZADDASSETATTR.zcloudkindsubtype',

    CASE ZASSET.ZPLAYBACKSTYLE
        WHEN 1 THEN '1 [Image]'
        WHEN 2 THEN '2 [Image Animated]'
        WHEN 3 THEN '3 [Live Photo]'
        WHEN 4 THEN '4 [Video]'
        WHEN 5 THEN '5 [Video Looping]'
        ELSE 'Unknown Value: ' || ZASSET.ZPLAYBACKSTYLE || ''
    END AS 'ZASSET.zplaybackstyle',

    ZASSET.ZPLAYBACKVARIATION AS 'ZASSET.zplaybackvariation',
    ZASSET.ZDURATION AS 'ZASSET.zduration',
    ZEXTATTR.ZDURATION AS 'ZEXTATTR.zduration',
    ZASSET.ZVIDEOCPDURATIONVALUE AS 'ZASSET.zvideocpdurationvalue',
    ZADDASSETATTR.ZVIDEOCPDURATIONTIMESCALE AS 'ZADDASSETATTR.zvideocpdurationtimescale',
    ZASSET.ZVIDEOCPVISIBILITYSTATE AS 'ZASSET.zvideocpvisibilitystate',
    ZADDASSETATTR.ZVIDEOCPDISPLAYVALUE AS 'ZADDASSETATTR.zvideocpdisplayvalue',
    ZADDASSETATTR.ZVIDEOCPDISPLAYTIMESCALE AS 'ZADDASSETATTR.zvideocpdisplaytimescale',

    -- [ZINTERNALRESOURCE.ZASSET = ZASSET.zPK]
    ZINTERNALRESOURCE.ZASSET AS 'ZINTERNALRESOURCE.zasset',
    ZINTERNALRESOURCE.Z_PK AS 'ZINTERNALRESOURCE.z_pk',
    ZINTERNALRESOURCE.Z_ENT AS 'ZINTERNALRESOURCE.z_ent',
    ZINTERNALRESOURCE.Z_OPT AS 'ZINTERNALRESOURCE.z_opt',
    ZINTERNALRESOURCE.ZQUALITYSORTVALUE AS 'ZINTERNALRESOURCE.zqualitysortvalue',

    CASE ZINTERNALRESOURCE.ZDATASTORECLASSID
        WHEN 0 THEN '0 [LPL Asset CPL Asset]'
        WHEN 1 THEN '1 [Still Testing]'
        WHEN 2 THEN '2 [Photo Cloud Sharing Asset]'
        WHEN 3 THEN '3 [SWY Syndication Asset]'
        ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZDATASTORECLASSID || ''
    END AS 'ZINTERNALRESOURCE.zdatastoreclassid',

    CASE ZASSET.ZCLOUDPLACEHOLDERKIND
        WHEN 0 THEN '0 [Local&CloudMaster Asset]'
        WHEN 1 THEN '1 [Still Testing]'
        WHEN 2 THEN '2 [Still Testing]'
        WHEN 3 THEN '3 [JPG Asset Only PhotoData/Thumb/V2]'
        WHEN 4 THEN '4 [LPL JPG Asset CPL Asset HEIC JPG JPEG MOV PNG]'
        WHEN 5 THEN '5 [Asset synced via iCloud Photos 2 Device]'
        WHEN 6 THEN '6 [Still Testing]'
        WHEN 7 THEN '7 [LPL poster JPG Asset CPL Asset MP4]'
        WHEN 8 THEN '8 [LPL JPG Asset CPL Asset LivePhoto MOV]'
        WHEN 9 THEN '9 [CPL MP4 Asset Saved 2 LPL]'
        ELSE 'Unknown Value: ' || ZASSET.ZCLOUDPLACEHOLDERKIND || ''
    END AS 'ZASSET.zcloudplaceholderkind',

    CASE ZINTERNALRESOURCE.ZLOCALAVAILABILITY
        WHEN -1 THEN '(-1) [IR Asset Not Available Local Device]'
        WHEN 1 THEN '1 [IR Asset Available Local Device]'
        WHEN -32768 THEN '(-32768) [IR Asset SWY Linked Asset]'
        ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZLOCALAVAILABILITY || ''
    END AS 'ZINTERNALRESOURCE.zlocalavailability',

    CASE ZINTERNALRESOURCE.ZLOCALAVAILABILITYTARGET
        WHEN 0 THEN '0 [Still Testing]'
        ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZLOCALAVAILABILITYTARGET || ''
    END AS 'ZINTERNALRESOURCE.zlocalavailabilitytarget',

    CASE ZINTERNALRESOURCE.ZCLOUDLOCALSTATE
        WHEN 0 THEN '0 [IR Asset Not Synced No IR CldMast Date Created]'
        WHEN 1 THEN '1 [IR Asset Pening Upload]'
        WHEN 2 THEN '2 [IR Asset Photo Cloud Share Asset On Local Device]'
        WHEN 3 THEN '3 [IR Asset Synced iCloud]'
        ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZCLOUDLOCALSTATE || ''
    END AS 'ZINTERNALRESOURCE.zcloudlocalstate',

    CASE ZINTERNALRESOURCE.ZREMOTEAVAILABILITY
        WHEN 0 THEN '0 [IR Asset Not Available Remotely]'
        WHEN 1 THEN '1 [IR Asset Available Remotely]'
        ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZREMOTEAVAILABILITY || ''
    END AS 'ZINTERNALRESOURCE.zremoteavailability',

    CASE ZINTERNALRESOURCE.ZREMOTEAVAILABILITYTARGET
        WHEN 0 THEN '0 [Still Testing]'
        WHEN 1 THEN '1 [Still Testing]'
        ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZREMOTEAVAILABILITYTARGET || ''
    END AS 'ZINTERNALRESOURCE.zremoteavailabilitytarget',

    ZINTERNALRESOURCE.ZTRANSIENTCLOUDMASTER AS 'ZINTERNALRESOURCE.ztransientcloudmaster',
    ZINTERNALRESOURCE.ZSIDECARINDEX AS 'ZINTERNALRESOURCE.zsidecarindex',
    ZINTERNALRESOURCE.ZFILEID AS 'ZINTERNALRESOURCE.zfileid',

    CASE ZINTERNALRESOURCE.ZVERSION
        WHEN 0 THEN '0 [IR Asset Standard]'
        WHEN 1 THEN '1 [Still Testing]'
        WHEN 2 THEN '2 [IR Asset Adjustments Mutation]'
        WHEN 3 THEN '3 [IR Asset No IR CldMastDateCreated]'
        ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZVERSION || ''
    END AS 'ZINTERNALRESOURCE.zversion',

    ZADDASSETATTR.ZORIGINALFILESIZE AS 'ZADDASSETATTR.zoriginalfilesize',

    CASE ZINTERNALRESOURCE.ZRESOURCETYPE
        WHEN 0 THEN '0 [Photo]'
        WHEN 1 THEN '1 [Video]'
        WHEN 3 THEN '3 [Live Photo]'
        WHEN 5 THEN '5 [Adjustement Data]'
        WHEN 6 THEN '6 [Screenshot]'
        WHEN 9 THEN '9 [Alternate Photo 3rd PartyApp - Still Testing]'
        WHEN 13 THEN '13 [Movie]'
        WHEN 14 THEN '14 [Wallpaper]'
        ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZRESOURCETYPE || ''
    END AS 'ZINTERNALRESOURCE.zresourcetype',

    -- hex(ZINTERNALRESOURCE.ZDATASTOREKEYDATA) AS 'ZINTERNALRESOURCE.zdatastorekeydata',

    CASE ZINTERNALRESOURCE.ZDATASTORESUBTYPE
        WHEN 0 THEN '0 [No Cloud Inter Resource]'
        WHEN 1 THEN '1 [Main Asset Orig Size]'
        WHEN 2 THEN '2 [Photo with Adjustments]'
        WHEN 3 THEN '3 [JPG Large Thumb]'
        WHEN 4 THEN '4 [JPG Med Thumb]'
        WHEN 5 THEN '5 [JPG Small Thumb]'
        WHEN 6 THEN '6 [Video Med Data]'
        WHEN 7 THEN '7 [Video Small Data]'
        WHEN 8 THEN '8 [MP4 Cloud Share]'
        WHEN 9 THEN '9 [Still Testing]'
        WHEN 10 THEN '10 [3rd PartyApp thumb - Still Testing]'
        WHEN 11 THEN '11 [Still Test]'
        WHEN 12 THEN '12 [Still Test]'
        WHEN 13 THEN '13 [PNG Optimized CPLAsset]'
        WHEN 14 THEN '14 [Wallpaper]'
        WHEN 15 THEN '15 [Has Markup and Adjustments]'
        WHEN 16 THEN '16 [Video with Adjustments]'
        WHEN 17 THEN '17 [RAW Photo]'
        WHEN 18 THEN '18 [Live Photo Video Optimized CPLAsset]'
        WHEN 19 THEN '19 [Live Photo with Adjustments]'
        WHEN 20 THEN '20 [Still Test]'
        WHEN 21 THEN '21 [Still Test]'
        WHEN 22 THEN '22 [Adjust Mutation AAE Asset]'
        WHEN 23 THEN '23 [Still Test]'
        WHEN 24 THEN '24 [Still Test]'
        WHEN 25 THEN '25 [Still Test]'
        WHEN 26 THEN '26 [MOV Optimized CPLAsset]'
        WHEN 27 THEN '27 [Still Test]'
        WHEN 28 THEN '28 [MOV Med hdr Data]'
        ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZDATASTORESUBTYPE || ''
    END AS 'ZINTERNALRESOURCE.zdatastoresubtype',

    CASE ZINTERNALRESOURCE.ZCLOUDSOURCETYPE
        WHEN 0 THEN '0 [N/A]'
        WHEN 1 THEN '1 [Main Asset Orig Size]'
        WHEN 2 THEN '2 [Photo with Adjustments]'
        WHEN 3 THEN '3 [JPG Large Thumb]'
        WHEN 4 THEN '4 [JPG Med Thumb]'
        WHEN 5 THEN '5 [JPG Small Thumb]'
        WHEN 6 THEN '6 [Video Med Data]'
        WHEN 7 THEN '7 [Video Small Data]'
        WHEN 8 THEN '8 [MP4 Cloud Share]'
        WHEN 9 THEN '9 [Still Testing]'
        WHEN 10 THEN '10 [3rd PartyApp thumb - Still Testing]'
        WHEN 11 THEN '11 [Still Test]'
        WHEN 12 THEN '12 [Still Test]'
        WHEN 13 THEN '13 [PNG Optimized CPLAsset]'
        WHEN 14 THEN '14 [Wallpaper]'
        WHEN 15 THEN '15 [Has Markup and Adjustments]'
        WHEN 16 THEN '16 [Video with Adjustments]'
        WHEN 17 THEN '17 [RAW Photo]'
        WHEN 18 THEN '18 [Live Photo Video Optimized CPLAsset]'
        WHEN 19 THEN '19 [Live Photo with Adjustments]'
        WHEN 20 THEN '20 [Still Testing]'
        WHEN 21 THEN '21 [Still Testing]'
        WHEN 22 THEN '22 [Adjust Mutation AAE Asset]'
        WHEN 23 THEN '23 [Still Testing]'
        WHEN 24 THEN '24 [Still Testing]'
        WHEN 25 THEN '25 [Still Testing]'
        WHEN 26 THEN '26 [MOV Optimized CPLAsset]'
        WHEN 27 THEN '27 [Still Testing]'
        WHEN 28 THEN '28 [MOV Med hdr Data]'
        ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZCLOUDSOURCETYPE || ''
    END AS 'ZINTERNALRESOURCE.zcloudsourcetype',

    ZINTERNALRESOURCE.ZDATALENGTH AS 'ZINTERNALRESOURCE.zdatalength',

    CASE ZINTERNALRESOURCE.ZRECIPEID
        WHEN 0 THEN '0 [Orig File Size Match Data Length or Optimized]'
        WHEN 65739 THEN '65739 [JPG Large Thumb]'
        WHEN 65741 THEN '65741 [Various Asset Types or Thumbs]'
        WHEN 65743 THEN '65743 [ResouType Photo 5003 or 5005 JPG Thumb]'
        WHEN 65749 THEN '65749 [LocalVideoKeyFrame JPG Thumb]'
        WHEN 65938 THEN '65938 [FullSizeRender Photo or plist]'
        WHEN 131072 THEN '131072 [FullSizeRender Video or plist]'
        WHEN 131079 THEN '131079 [Medium MP4 Adj Mutation Asset]'
        WHEN 131081 THEN '131081 [ResouType Video 5003 or 5005 JPG Thumb]'
        WHEN 131272 THEN '131272 [FullSizeRender Video LivePhoto Adj Mutation]'
        WHEN 131275 THEN '131275 [Medium MOV LivePhoto]'
        WHEN 131277 THEN '131277 [No IR Asset LivePhoto iCloud Sync Asset]'
        WHEN 131475 THEN '131475 [Medium hdr MOV]'
        WHEN 327683 THEN '327683 [JPG Thumb for 3rdParty Still Testing]'
        WHEN 327687 THEN '627687 [Wallpaper Compute Resource]'
        ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZRECIPEID || ''
    END AS 'ZINTERNALRESOURCE.zrecipeid',

    CASE ZINTERNALRESOURCE.ZCLOUDLASTPREFETCHDATE
        WHEN 0 THEN 'N/A [0]'
        ELSE datetime(ZINTERNALRESOURCE.ZCLOUDLASTPREFETCHDATE + 978307200, 'UNIXEPOCH')
    END AS 'ZINTERNALRESOURCE.zcloudlastprefetchdate(utc)',

    ZINTERNALRESOURCE.ZCLOUDPREFETCHCOUNT AS 'ZINTERNALRESOURCE.zcloudprefetchcount',

    datetime(ZINTERNALRESOURCE.ZCLOUDLASTONDEMANDDOWNLOADDATE + 978307200, 'UNIXEPOCH') AS 'ZINTERNALRESOURCE.zcloudlastondemanddownloaddate(utc)',

    CASE ZINTERNALRESOURCE.ZUTICONFORMANCEHINT
        WHEN 0 THEN '0 [N/A / Does not Conform]'
        WHEN 1 THEN '1 [UT Type Image]'
        WHEN 2 THEN '2 [Still Testing]'
        WHEN 3 THEN '3 [UT Type Movie]'
        ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZUTICONFORMANCEHINT || ''
    END AS 'ZINTERNALRESOURCE.zuticonformancehint',

    CASE ZINTERNALRESOURCE.ZCOMPACTUTI
        WHEN 1 THEN 'jpeg/thm [1]'
        WHEN 3 THEN 'heic [3]'
        WHEN 6 THEN 'png [6]'
        WHEN 7 THEN 'Still Testing [7]'
        WHEN 23 THEN 'jpeg/heic/quicktime mov [23]'
        WHEN 24 THEN 'mpeg4 [24]'
        WHEN 36 THEN 'Wallpaper [36]'
        WHEN 37 THEN 'Adj/Mutation Data [37]'
        ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZCOMPACTUTI || ''
    END AS 'ZINTERNALRESOURCE.zcompactuti',

    ZASSET.ZUNIFORMTYPEIDENTIFIER AS 'ZASSET.zuniformtypeidentifier',
    ZASSET.ZORIGINALCOLORSPACE AS 'ZASSET.zoriginalcolorspace',
    ZCLOUDMASTER.ZUNIFORMTYPEIDENTIFIER AS 'ZCLOUDMASTER.zuniformtypeidentifier',

    CASE ZCLOUDMASTER.ZFULLSIZEJPEGSOURCE
        WHEN 0 THEN 'CldMast JPEG Source Video [0]'
        WHEN 1 THEN 'CldMast JPEG Source Other [1]'
        ELSE 'Unknown Value: ' || ZCLOUDMASTER.ZFULLSIZEJPEGSOURCE || ''
    END AS 'ZCLOUDMASTER.zfullsizejpegsource',

    ZASSET.ZHDRGAIN AS 'ZASSET.zhdrgain',

    CASE ZASSET.ZHDRTYPE
        WHEN 0 THEN 'No HDR [0]'
        WHEN 3 THEN 'HDR Photo [3]'
        WHEN 4 THEN 'Non-HDR Version [4]'
        WHEN 5 THEN 'HEVC Movie [5]'
        WHEN 6 THEN 'Panorama [6]'
        WHEN 10 THEN 'HDR Gain [10]'
        ELSE 'Unknown Value: ' || ZASSET.ZHDRTYPE || ''
    END AS 'ZASSET.zhdrtype',

    ZEXTATTR.ZCODEC AS 'ZEXTATTR.zcodec',
    ZINTERNALRESOURCE.ZCODECFOURCHARCODENAME AS 'ZINTERNALRESOURCE.zcodecfourcharcodename',
    ZCLOUDMASTER.ZCODECNAME AS 'ZCLOUDMASTER.zcodecname',
    ZCLOUDMASTER.ZVIDEOFRAMERATE AS 'ZCLOUDMASTER.zvideoframerate',
    ZCLOUDMASTER.ZPLACEHOLDERSTATE AS 'ZCLOUDMASTER.zplaceholderstate',

    CASE ZASSET.ZDEPTHTYPE
        WHEN 0 THEN 'Not Portrait [0]'
        ELSE 'Portrait: ' || ZASSET.ZDEPTHTYPE || ''
    END AS 'ZASSET.zdepthtype',

    ZASSET.ZAVALANCHEUUID AS 'ZASSET.zavalancheuuid',

    CASE ZASSET.ZMONOSKITYPE
        WHEN 0 THEN 'Still Testing No Monoski [0]'
        ELSE 'Unknown Value: ' || ZASSET.ZMONOSKITYPE || ''
    END AS 'ZASSET.zmonoskitype',

    CASE ZASSET.ZAVALANCHEPICKTYPE
        WHEN 0 THEN 'N/A / Single Asset Burst UUID [0]'
        WHEN 2 THEN 'Burst Asset Not Selected [2]'
        WHEN 4 THEN 'Burst Asset PhotosApp Picked KeyImage [4]'
        WHEN 8 THEN 'Burst Asset Selected for LPL [8]'
        WHEN 16 THEN 'Top Burst Asset in Stack KeyImage [16]'
        WHEN 32 THEN 'Still Testing [32]'
        WHEN 52 THEN 'Burst Asset Visible LPL [52]'
        ELSE 'Unknown Value: ' || ZASSET.ZAVALANCHEPICKTYPE || ''
    END AS 'ZASSET.zavalanchepicktype',

    CASE ZADDASSETATTR.ZCLOUDAVALANCHEPICKTYPE
        WHEN 0 THEN 'N/A / Single Asset Burst UUID [0]'
        WHEN 2 THEN 'Burst Asset Not Selected [2]'
        WHEN 4 THEN 'Burst Asset PhotosApp Picked KeyImage [4]'
        WHEN 8 THEN 'Burst Asset Selected for LPL [8]'
        WHEN 16 THEN 'Top Burst Asset in Stack KeyImage [16]'
        WHEN 32 THEN 'Still Testing [32]'
        WHEN 52 THEN 'Burst Asset Visible LPL [52]'
        ELSE 'Unknown Value: ' || ZADDASSETATTR.ZCLOUDAVALANCHEPICKTYPE || ''
    END AS 'ZADDASSETATTR.zcloudavalanchepicktype',

    CASE ZADDASSETATTR.ZCLOUDRECOVERYSTATE
        WHEN 0 THEN 'Still Testing [0]'
        WHEN 1 THEN 'Still Testing [1]'
        ELSE 'Unknown Value: ' || ZADDASSETATTR.ZCLOUDRECOVERYSTATE || ''
    END AS 'ZADDASSETATTR.zcloudrecoverystate',

    ZADDASSETATTR.ZCLOUDSTATERECOVERYATTEMPTSCOUNT AS 'ZADDASSETATTR.zcloudstaterecoveryattemptscount',
    ZASSET.ZDEFERREDPROCESSINGNEEDED AS 'ZASSET.zdeferredprocessingneeded',
    ZASSET.ZVIDEODEFERREDPROCESSINGNEEDED AS 'ZASSET.zvideodeferredprocessingneeded',
    ZADDASSETATTR.ZDEFERREDPHOTOIDENTIFIER AS 'ZADDASSETATTR.zdeferredphotoidentifier',
    ZADDASSETATTR.ZDEFERREDPROCESSINGCANDIDATEOPTIONS AS 'ZADDASSETATTR.zdeferredprocessingcandidateoptions',

    CASE ZASSET.ZHASADJUSTMENTS
        WHEN 0 THEN 'No [0]'
        WHEN 1 THEN 'Yes [1]'
        ELSE 'Unknown Value: ' || ZASSET.ZHASADJUSTMENTS || ''
    END AS 'ZASSET.zhasadjustments',

    --[ZUNMANAGEDADJUSTMENT.ZASSETATTRIBUTES = ZADDASSETATTR.Z_PK]
    ZUNMANAGEDADJUSTMENT.ZASSETATTRIBUTES AS 'ZUNMANAGEDADJUSTMENT.zassetattributes',

    --[ZADDASSETATTR.ZUNMANAGEDADJUSTMENT = ZUNMANAGEDADJUSTMENT.Z_PK]
    ZADDASSETATTR.ZUNMANAGEDADJUSTMENT AS 'ZADDASSETATTR.zunmanagedadjustment',

    --[ZUNMANAGEDADJUSTMENT.Z_PK = ZADDASSETATTR.ZUnmanAdj]
    ZUNMANAGEDADJUSTMENT.Z_PK AS 'ZUNMANAGEDADJUSTMENT.z_pk',

    ZUNMANAGEDADJUSTMENT.ZUUID AS 'ZUNMANAGEDADJUSTMENT.zuuid',

    datetime(ZASSET.ZADJUSTMENTTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'ZASSET.zadjustmenttimestamp(utc)',
    datetime(ZUNMANAGEDADJUSTMENT.ZADJUSTMENTTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'ZUNMANAGEDADJUSTMENT.zadjustmenttimestamp(utc)',

    ZADDASSETATTR.ZEDITORBUNDLEID AS 'ZADDASSETATTR.zeditorbundleid',
    ZUNMANAGEDADJUSTMENT.ZEDITORLOCALIZEDNAME AS 'ZUNMANAGEDADJUSTMENT.zeditorlocalizedname',
    ZUNMANAGEDADJUSTMENT.ZADJUSTMENTFORMATIDENTIFIER AS 'ZUNMANAGEDADJUSTMENT.zadjustmentformatidentifier',
    ZADDASSETATTR.ZMONTAGE AS 'ZADDASSETATTR.zmontage',

    CASE ZUNMANAGEDADJUSTMENT.ZADJUSTMENTRENDERTYPES
        WHEN 0 THEN 'Standard or Portrait with erros [0]'
        WHEN 1 THEN 'Still Testing [1]'
        WHEN 2 THEN 'Portrait [2]'
        WHEN 3 THEN 'Still Testing [3]'
        WHEN 4 THEN 'Still Testing [4]'
        ELSE 'Unknown Value: ' || ZUNMANAGEDADJUSTMENT.ZADJUSTMENTRENDERTYPES || ''
    END AS 'ZUNMANAGEDADJUSTMENT.zadjustmentrendertypes',

    CASE ZUNMANAGEDADJUSTMENT.ZADJUSTMENTFORMATVERSION
        WHEN 1.0 THEN '1.0 [Markup]'
        WHEN 1.1 THEN '1.1 [Slow-Mo]'
        WHEN 1.2 THEN '1.2 [Still Testing]'
        WHEN 1.3 THEN '1.3 [Still Testing]'
        WHEN 1.4 THEN '1.4 [Filter]'
        WHEN 1.5 THEN '1.5 [Adjust]'
        WHEN 1.6 THEN '1.6 [Video Trim]'
        WHEN 1.7 THEN '1.7 [Still Testing]'
        WHEN 1.8 THEN '1.8 [Still Testing]'
        WHEN 1.9 THEN '1.9 [Still Testing]'
        WHEN 2.0 THEN '2.0 [Screenshot Services]'
        ELSE 'Unknown Value: ' || ZUNMANAGEDADJUSTMENT.ZADJUSTMENTFORMATVERSION || ''
    END AS 'ZUNMANAGEDADJUSTMENT.zadjustmentformatversion',

    ZUNMANAGEDADJUSTMENT.ZADJUSTMENTBASEIMAGEFORMAT AS 'ZUNMANAGEDADJUSTMENT.zadjustmentbaseimageformat',

    CASE ZASSET.ZFAVORITE
        WHEN 0 THEN 'Not Favorite [0]'
        WHEN 1 THEN 'Favorite [1]'
        ELSE 'Unknown Value: ' || ZASSET.ZFAVORITE || ''
    END AS 'ZASSET.zfavorite',

    CASE ZASSET.ZHIDDEN
        WHEN 0 THEN 'Not Hidden [0]'
        WHEN 1 THEN 'Hidden [1]'
        ELSE 'Unknown Value: ' || ZASSET.ZHIDDEN || ''
    END AS 'ZASSET.zhidden',

    CASE ZASSET.ZTRASHEDSTATE
        WHEN 0 THEN 'Not In Trash [0]'
        WHEN 1 THEN 'In Trash [1]'
        ELSE 'Unknown Value: ' || ZASSET.ZTRASHEDSTATE || ''
    END AS 'ZASSET.ztrashedstate',

    datetime(ZASSET.ZTRASHEDDATE + 978307200, 'UNIXEPOCH') AS 'ZASSET.ztrasheddate(utc)',

    CASE ZASSET.ZDELETEREASON
        WHEN NULL THEN NULL
        WHEN 1 THEN 'Still Testing [1]'
        WHEN 2 THEN 'Still Testing [2]'
        WHEN 3 THEN 'Still Testing [3]'
        ELSE 'Unknown Value: ' || ZASSET.ZDELETEREASON || ''
    END AS 'ZASSET.ZDELETEREASON',

    CASE ZASSET.ZTRASHEDBYPARTICIPANT
        WHEN NULL THEN NULL
        WHEN 0 THEN 'Not Trashed by Participant [0]'
        WHEN 1 THEN 'Trashed by Participant [1]'
        ELSE 'Unknown Value: ' || ZASSET.ZTRASHEDBYPARTICIPANT || ''
    END AS 'ZASSET.ztrashedbyparticipant',

    CASE ZINTERNALRESOURCE.ZTRASHEDSTATE
        WHEN 0 THEN 'Not In Trash [0]'
        WHEN 1 THEN 'In Trash [1]'
        ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZTRASHEDSTATE || ''
    END AS 'ZINTERNALRESOURCE.ztrashedstate',

    datetime(ZINTERNALRESOURCE.ZTRASHEDDATE + 978307200, 'UNIXEPOCH') AS 'ZINTERNALRESOURCE.ztrasheddate(utc)',

    CASE ZASSET.ZCLOUDDELETESTATE
        WHEN 0 THEN 'Cloud Asset Not Deleted [0]'
        WHEN 1 THEN 'Cloud Asset Deleted [1]'
        ELSE 'Unknown Value: ' || ZASSET.ZCLOUDDELETESTATE || ''
    END AS 'ZASSET.zclouddeletestate',

    CASE ZINTERNALRESOURCE.ZCLOUDDELETESTATE
        WHEN 0 THEN 'Cloud IntResou Not Deleted [0]'
        WHEN 1 THEN 'Cloud IntResou Deleted [1]'
        ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZCLOUDDELETESTATE || ''
    END AS 'ZINTERNALRESOURCE.zclouddeletestate',

    CASE ZADDASSETATTR.ZPTPTRASHEDSTATE
        WHEN 0 THEN 'PTP Not in Trash [0]'
        WHEN 1 THEN 'PTP In Trash [1]'
        ELSE 'Unknown Value: ' || ZADDASSETATTR.ZPTPTRASHEDSTATE || ''
    END AS 'ZADDASSETATTR.zptptrashedstate',

    CASE ZINTERNALRESOURCE.ZPTPTRASHEDSTATE
        WHEN 0 THEN 'PTP IntResou Not in Trash [0]'
        WHEN 1 THEN 'PTP IntResou In Trash [1]'
        ELSE 'Unknown Value: ' || ZINTERNALRESOURCE.ZPTPTRASHEDSTATE || ''
    END AS 'ZINTERNALRESOURCE.zptptrashedstate',

    ZINTERNALRESOURCE.ZCLOUDDELETEASSETUUIDWITHRESOURCETYPE AS 'ZINTERNALRESOURCE.zclouddeleteassetuuidwithresourcetype',

    datetime(zMedAnlyAstAttr.ZMEDIAANALYSISTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'zMedAnlyAstAttr.zmediaanalysistimestamp(utc)',

    ZADDASSETATTR.ZPENDINGVIEWCOUNT AS 'ZADDASSETATTR.zpendingviewcount',
    ZADDASSETATTR.ZVIEWCOUNT AS 'ZADDASSETATTR.zviewcount',
    ZADDASSETATTR.ZPENDINGPLAYCOUNT AS 'ZADDASSETATTR.zpendingplaycount',
    ZADDASSETATTR.ZPLAYCOUNT AS 'ZADDASSETATTR.zplaycount',
    ZADDASSETATTR.ZPENDINGSHARECOUNT AS 'ZADDASSETATTR.zpendingsharecount',
    ZADDASSETATTR.ZSHARECOUNT AS 'ZADDASSETATTR.zsharecount',

    datetime(ZASSET.ZLASTSHAREDDATE + 978307200, 'UNIXEPOCH') AS 'ZASSET.zlastshareddate(utc)',

    ZADDASSETATTR.ZSHAREORIGINATOR AS 'ZADDASSETATTR.zshareoriginator',

    CASE ZADDASSETATTR.ZALLOWEDFORANALYSIS
        WHEN 0 THEN 'Asset Not Allowed For Analysis [0]'
        WHEN 1 THEN 'Asset Allowed for Analysis [1]'
        ELSE 'Unknown Value: ' || ZADDASSETATTR.ZALLOWEDFORANALYSIS || ''
    END AS 'ZADDASSETATTR.zallowedforanalysis',

    ZADDASSETATTR.ZSCENEANALYSISVERSION AS 'ZADDASSETATTR.zsceneanalysisversion',

    CASE ZADDASSETATTR.ZSCENEANALYSISISFROMPREVIEW
        WHEN 0 THEN 'No [0]'
        ELSE 'Unknown Value: ' || ZADDASSETATTR.ZSCENEANALYSISISFROMPREVIEW || ''
    END AS 'ZADDASSETATTR.zsceneanalysisisfrompreview',

    datetime(ZADDASSETATTR.ZSCENEANALYSISTIMESTAMP + 978307200, 'UNIXEPOCH') AS 'ZADDASSETATTR.zsceneanalysistimestamp(utc)',

    CASE ZASSET.ZDUPLICATEASSETVISIBILITYSTATE
        WHEN 0 THEN 'No Duplicates [0]'
        WHEN 1 THEN 'Has Duplicate [1]'
        WHEN 2 THEN 'Is a Duplicate [2]'
        ELSE 'Unknown Value: ' || ZASSET.ZDUPLICATEASSETVISIBILITYSTATE || ''
    END AS 'ZASSET.zduplicateassetvisibilitystate',

    CASE ZADDASSETATTR.ZDESTINATIONASSETCOPYSTATE
        WHEN 0 THEN 'No Copy [0]'
        WHEN 1 THEN 'Has A Copy [1]'
        WHEN 2 THEN 'Has A Copy [2]'
        ELSE 'Unknown Value: ' || ZADDASSETATTR.ZDESTINATIONASSETCOPYSTATE || ''
    END AS 'ZADDASSETATTR.zdestinationassetcopystate',

    -- hex(ZSCENEPRINT.ZDATA) AS 'ZSCENEPRINT.zdata(hex nskeyed .plist)',
    -- hex(ZSCENEPRINT.ZDUPLICATEMATCHINGDATA) AS 'ZSCENEPRINT.zduplicatematchingdata(hex nskeyed .plist)',
    -- hex(ZSCENEPRINT.ZDUPLICATEMATCHINGALTERNATEDATA) AS 'ZSCENEPRINT.zduplicatematchingalternatedata(hex nskeyed .plist)',
    ZADDASSETATTR.ZSOURCEASSETFORDUPLICATIONSCOPEIDENTIFIER AS 'ZADDASSETATTR.zsourceassetforduplicationscopeidentifier',
    ZCLOUDMASTER.ZSOURCEMASTERFORDUPLICATIONSCOPEIDENTIFIER AS 'ZCLOUDMASTER.zsourcemasterforduplicationscopeidentifier',
    ZADDASSETATTR.ZSOURCEASSETFORDUPLICATIONIDENTIFIER AS 'ZADDASSETATTR.zsourceassetforduplicationidentifier',
    ZCLOUDMASTER.ZSOURCEMASTERFORDUPLICATIONIDENTIFIER AS 'ZCLOUDMASTER.zsourcemasterforduplicationidentifier',

    /* Source for each line of data */
    'private/var/mobile/Library/Photos/Libraries/Syndication.photoslibrary/database/Photos.sqlite; ZASSET(Z_PK:' || ZASSET.Z_PK || ')' AS 'DataSource'


FROM ZASSET
    LEFT JOIN ZADDITIONALASSETATTRIBUTES ZADDASSETATTR ON ZADDASSETATTR.Z_PK = ZASSET.ZADDITIONALATTRIBUTES
    LEFT JOIN ZEXTENDEDATTRIBUTES ZEXTATTR ON ZEXTATTR.Z_PK = ZASSET.ZEXTENDEDATTRIBUTES
    LEFT JOIN ZINTERNALRESOURCE ON ZINTERNALRESOURCE.ZASSET = ZASSET.Z_PK
    LEFT JOIN ZSCENEPRINT ON ZSCENEPRINT.Z_PK = ZADDASSETATTR.ZSCENEPRINT
    LEFT JOIN Z_28ASSETS ON Z_28ASSETS.Z_3ASSETS = ZASSET.Z_PK
    LEFT JOIN ZGENERICALBUM zGenAlbum ON zGenAlbum.Z_PK = Z_28ASSETS.Z_28ALBUMS
    LEFT JOIN ZUNMANAGEDADJUSTMENT ON ZADDASSETATTR.ZUNMANAGEDADJUSTMENT = ZUNMANAGEDADJUSTMENT.Z_PK
    LEFT JOIN Z_27ALBUMLISTS ON Z_27ALBUMLISTS.Z_27ALBUMS = zGenAlbum.Z_PK
    LEFT JOIN ZALBUMLIST ON ZALBUMLIST.Z_PK = Z_27ALBUMLISTS.Z_2ALBUMLISTS
    LEFT JOIN ZGENERICALBUM ParentzGenAlbum ON ParentzGenAlbum.Z_PK = zGenAlbum.ZPARENTFOLDER
    LEFT JOIN ZCLOUDMASTER ON ZASSET.ZMASTER = ZCLOUDMASTER.Z_PK
    LEFT JOIN ZCLOUDMASTERMEDIAMETADATA AAAzCldMastMedData ON AAAzCldMastMedData.Z_PK = ZADDASSETATTR.ZMEDIAMETADATA
    LEFT JOIN ZCLOUDMASTERMEDIAMETADATA CMzCldMastMedData ON CMzCldMastMedData.Z_PK = ZCLOUDMASTER.ZMEDIAMETADATA
    LEFT JOIN ZMEDIAANALYSISASSETATTRIBUTES zMedAnlyAstAttr ON ZASSET.ZMEDIAANALYSISATTRIBUTES = zMedAnlyAstAttr.Z_PK
    LEFT JOIN ZSHARE ON ZSHARE.Z_PK = ZASSET.ZMOMENTSHARE


ORDER BY ZASSET.ZADDEDDATE
