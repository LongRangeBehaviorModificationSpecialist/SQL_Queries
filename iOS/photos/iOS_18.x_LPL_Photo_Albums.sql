SELECT

    /* Add a row number at the beggining of each row */
    ROW_NUMBER() OVER() AS 'ROW_NUMBER',
    ParentzGenAlbum.ZUUID AS 'ParentzGenAlbum.ZUUID',
    ParentzGenAlbum.ZCLOUDGUID AS 'ParentzGenAlbum.ZCLOUDGUID',
    ParentzGenAlbum.Z_PK AS 'ParentzGenAlbum.Z_PK',

    CASE ParentzGenAlbum.ZKIND
        WHEN 2 THEN '2 [Local Device iCloud Photos Album]'
        WHEN 1505 THEN '1505 [Shared Album]'
        WHEN 1506 THEN '1506 [Import Session AssetsImportedAtSameTime]'
        WHEN 1508 THEN '1508 [My_Projects_Album_CalendarCardEct_RT]'
        WHEN 1510 THEN '1510 [Duplicate Album Pending Merge]'
        WHEN 1552 THEN '1552 [Still Testing]'
        WHEN 1600 THEN '1600 [Still Testing]'
        WHEN 1602 THEN '1602 [Still Testing]'
        WHEN 1605 THEN '1605 [Still Testing]'
        WHEN 1606 THEN '1606 [Still Testing]'
        WHEN 1607 THEN '1607 [Still Testing]'
        WHEN 1608 THEN '1608 [Still Testing]'
        WHEN 1609 THEN '1609 [Still Testing]'
        WHEN 1610 THEN '1610 [Still Testing]'
        WHEN 1611 THEN '1611 [Still Testing]'
        WHEN 1612 THEN '1612 [Still Testing]'
        WHEN 1613 THEN '1613 [Still Testing]'
        WHEN 1614 THEN '1614 [Still Testing]'
        WHEN 1615 THEN '1615 [Still Testing]'
        WHEN 1616 THEN '1616 [Still Testing]'
        WHEN 1617 THEN '1617 [Still Testing]'
        WHEN 1618 THEN '1618 [Still Testing]'
        WHEN 1619 THEN '1619 [Still Testing]'
        WHEN 1620 THEN '1620 [Still Testing]'
        WHEN 1621 THEN '1621 [Still Testing]'
        WHEN 1622 THEN '1622 [Still Testing]'
        WHEN 1623 THEN '1623 [Still Testing]'
        WHEN 1624 THEN '1624 [Still Testing]'
        WHEN 1625 THEN '1625 [Still Testing]'
        WHEN 1626 THEN '1626 [Still Testing]'
        WHEN 1627 THEN '1627 [Still Testing]'
        WHEN 1628 THEN '1628 [Still Testing]'
        WHEN 1630 THEN '1630 [Still Testing]'
        WHEN 3571 THEN '3571 [Progress-Sync]'
        WHEN 3572 THEN '3572 [Progress-OTA-Restore]'
        WHEN 3573 THEN '3573 [Progress-FS-Import]'
        WHEN 3998 THEN '3998 [Project Root Folder]'
        WHEN 3999 THEN '3999 [Parent_Folder_for_Generic_Album]'
        WHEN 4000 THEN '4000 [Parent_is_Folder_on_Local_Device]'
        WHEN 4001 THEN '4001 [Still Testing]'
        WHEN 4002 THEN '4002 [Still Testing]'
        WHEN 4003 THEN '4003 [Still Testing]'
        ELSE 'Unknown Value: ' || ParentzGenAlbum.ZKIND || ''
    END AS 'ParentzGenAlbum.ZKIND',

    CASE ParentzGenAlbum.ZCLOUDLOCALSTATE
        WHEN 0 THEN '0 [iCloud Photos ON=Asset_In_Shared/Other_Album/iCloud Photos-OFF=Generic_Album]'
        WHEN 1 THEN '1 [iCloud Photos ON=Asset_In_Generic_Album]'
        ELSE 'Unknown Value: ' || ParentzGenAlbum.ZCLOUDLOCALSTATE || ''
    END AS 'ParentzGenAlbum.ZCLOUDLOCALSTATE',

    ParentzGenAlbum.ZTITLE AS 'ParentzGenAlbum.ZTITLE',

    datetime(ParentzGenAlbum.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'ParentzGenAlbum.ZCREATIONDATE(UTC)',

    ParentzGenAlbum.ZPENDINGITEMSCOUNT AS 'ParentzGenAlbum.ZPENDINGITEMSCOUNT',

    CASE ParentzGenAlbum.ZPENDINGITEMSTYPE
        WHEN 1 THEN '1 [No]'
        WHEN 24 THEN '24 [Still Testing]'
        ELSE 'Unknown Value: ' || ParentzGenAlbum.ZPENDINGITEMSTYPE || ''
    END AS 'ParentzGenAlbum.ZPENDINGITEMSTYPE',

    ParentzGenAlbum.ZSYNCEVENTORDERKEY AS 'ParentzGenAlbum.ZSYNCEVENTORDERKEY',

    CASE ParentzGenAlbum.ZISPINNED
        WHEN 0 THEN '0 [ParentzGenAlbum Not Pinned]'
        WHEN 1 THEN '1 [ParentzGenAlbum Pinned]'
        ELSE 'Unknown Value: ' || ParentzGenAlbum.ZISPINNED || ''
    END AS 'ParentzGenAlbum.ZISPINNED',

    CASE ParentzGenAlbum.ZCUSTOMSORTKEY
        WHEN 0 THEN '0 [zGenAlbum-Sorted_Manually]'
        WHEN 1 THEN '1 [zGenAlbum-CusSrtAsc0=Sorted_Newest_First/CusSrtAsc1=Sorted_Oldest_First]'
        WHEN 5 THEN '5 [zGenAlbum-Sorted_by_Title]'
        ELSE 'Unknown Value: ' || ParentzGenAlbum.ZCUSTOMSORTKEY || ''
    END AS 'ParentzGenAlbum.ZCUSTOMSORTKEY',

    CASE ParentzGenAlbum.ZCUSTOMSORTASCENDING
        WHEN 0 THEN '0 [zGenAlbum-Sorted_Newest_First]'
        WHEN 1 THEN '1 [zGenAlbum-Sorted_Oldest_First]'
        ELSE 'Unknown Value: ' || ParentzGenAlbum.ZCUSTOMSORTASCENDING || ''
    END AS 'ParentzGenAlbum.ZCUSTOMSORTASCENDING',

    CASE ParentzGenAlbum.ZISPROTOTYPE
        WHEN 0 THEN '0 [ParentzGenAlbum Not Prototype]'
        WHEN 1 THEN '1 [ParentzGenAlbum Prototype]'
        ELSE 'Unknown Value: ' || ParentzGenAlbum.ZISPROTOTYPE || ''
    END AS 'ParentzGenAlbum.ZISPROTOTYPE',

    CASE ParentzGenAlbum.ZTRASHEDSTATE
        WHEN 0 THEN '0 [Not In Trash]'
        WHEN 1 THEN '1 [Album In Trash]'
        ELSE 'Unknown Value: ' || ParentzGenAlbum.ZTRASHEDSTATE || ''
    END AS 'ParentzGenAlbum.ZTRASHEDSTATE',

    datetime(ParentzGenAlbum.ZTRASHEDDATE + 978307200, 'UNIXEPOCH') AS 'ParentzGenAlbum.ZTRASHEDDATE',

    CASE ParentzGenAlbum.ZCLOUDDELETESTATE
        WHEN 0 THEN '0 [ParentzGenAlbum Cloud Not Deleted]'
        WHEN 1 THEN '1 [ParentzGenAlbum Cloud Album Deleted]'
        ELSE 'Unknown Value: ' || ParentzGenAlbum.ZCLOUDDELETESTATE || ''
    END AS 'ParentzGenAlbum.ZCLOUDDELETESTATE',

    -- zGenAlbum.ZCLOUDGUID = store.cloudphotodb
    zGenAlbum.ZCLOUDGUID AS 'zGenAlbum.ZCLOUDGUID',
    -- z28AlbumLists.Z_28ALBUMS=zGenAlbum-zPK
    z28AlbumLists.Z_28ALBUMS AS 'z28AlbumLists.Z_28ALBUMS',
    -- zGenAlbum.Z_PK=26AlbumLists=26Albums
    zGenAlbum.Z_PK AS 'zGenAlbum.Z_PK',
    zGenAlbum.Z_ENT AS 'zGenAlbum.Z_ENT',
    zGenAlbum.Z_OPT AS 'zGenAlbum.Z_OPT',
    zGenAlbum.ZSYNDICATE AS 'zGenAlbum.ZSYNDICATE',
    -- zGenAlbum.ZPARENTFOLDER=zGenAlbum.Z_PK
    zGenAlbum.ZPARENTFOLDER AS 'zGenAlbum.ZPARENTFOLDER',
    zGenAlbum.Z_FOK_PARENTFOLDER AS 'zGenAlbum.Z_FOK_PARENTFOLDER',
    zGenAlbum.ZIMPORTSESSIONID AS 'zGenAlbum.ZIMPORTSESSIONID',
    zCldShareAlbumInvRec.ZUUID AS 'zCldShareAlbumInvRec.ZUUID',

    CASE zGenAlbum.ZKIND
        WHEN 2 THEN '2 [Local Device-iCloud Photos Album]'
        WHEN 1505 THEN '1505 [Shared Album]'
        WHEN 1506 THEN '1506 [Import_Session_AssetsImportedatSameTime]'
        WHEN 1508 THEN '1508 [My_Projects_Album_CalendarCardEct_RT]'
        WHEN 1510 THEN '1510 [Duplicate Album Pending Merge]'
        WHEN 1552 THEN '1552 [Still Testing]'
        WHEN 1600 THEN '1600 [Still Testing]'
        WHEN 1602 THEN '1602 [Still Testing]'
        WHEN 1605 THEN '1605 [Still Testing]'
        WHEN 1606 THEN '1606 [Still Testing]'
        WHEN 1607 THEN '1607 [Still Testing]'
        WHEN 1608 THEN '1608 [Still Testing]'
        WHEN 1609 THEN '1609 [Still Testing]'
        WHEN 1610 THEN '1610 [Still Testing]'
        WHEN 1611 THEN '1611 [Still Testing]'
        WHEN 1612 THEN '1612 [Still Testing]'
        WHEN 1613 THEN '1613 [Still Testing]'
        WHEN 1614 THEN '1614 [Still Testing]'
        WHEN 1615 THEN '1615 [Still Testing]'
        WHEN 1616 THEN '1616 [Still Testing]'
        WHEN 1617 THEN '1617 [Still Testing]'
        WHEN 1618 THEN '1618 [Still Testing]'
        WHEN 1619 THEN '1619 [Still Testing]'
        WHEN 1620 THEN '1620 [Still Testing]'
        WHEN 1621 THEN '1621 [Still Testing]'
        WHEN 1622 THEN '1622 [Still Testing]'
        WHEN 1623 THEN '1623 [Still Testing]'
        WHEN 1624 THEN '1624 [Still Testing]'
        WHEN 1625 THEN '1625 [Still Testing]'
        WHEN 1626 THEN '1626 [Still Testing]'
        WHEN 1627 THEN '1627 [Still Testing]'
        WHEN 1628 THEN '1628 [Still Testing]'
        WHEN 1630 THEN '1630 [Still Testing]'
        WHEN 3571 THEN '3571 [Progress-Sync]'
        WHEN 3572 THEN '3572 [Progress-OTA-Restore]'
        WHEN 3573 THEN '3573 [Progress-FS-Import]'
        WHEN 3998 THEN '3998 [Project Root Folder]'
        WHEN 3999 THEN '3999 [Parent_is_Root_containing_Generic_Album_on_Local_Device]'
        WHEN 4000 THEN '4000 [Parent_is_Sub-Folder_containing_Generic_Album_on_Local_Device]'
        WHEN 4001 THEN '4001 [Still Testing]'
        WHEN 4002 THEN '4002 [Still Testing]'
        WHEN 4003 THEN '4003 [Still Testing]'
        ELSE 'Unknown Value: ' || zGenAlbum.ZKIND || ''
    END AS 'zGenAlbum.ZKIND',

    CASE zGenAlbum.ZCLOUDLOCALSTATE
        WHEN 0 THEN '0 [iCloud Photos-ON=Asset_In_Shared/Other-Album/iCloud Photos-OFF=Generic_Album]'
        WHEN 1 THEN '1 [iCloud Photos-ON=Asset_In_Generic_Album]'
        ELSE 'Unknown Value: ' || zGenAlbum.ZCLOUDLOCALSTATE || ''
    END AS 'zGenAlbum.ZCLOUDLOCALSTATE',

    zGenAlbum.ZIMPORTEDBYBUNDLEIDENTIFIER AS 'zGenAlbum.ZIMPORTEDBYBUNDLEIDENTIFIER',
    zGenAlbum.ZTITLE AS 'zGenAlbum.ZTITLE',

    datetime(zGenAlbum.ZCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'zGenAlbum.ZCREATIONDATE(UTC)',
    datetime(zGenAlbum.ZCLOUDCREATIONDATE + 978307200, 'UNIXEPOCH') AS 'zGenAlbum.ZCLOUDCREATIONDATE(UTC)',
    datetime(zGenAlbum.ZSTARTDATE + 978307200, 'UNIXEPOCH') AS 'zGenAlbum.ZSTARTDATE(UTC)',
    datetime(zGenAlbum.ZENDDATE + 978307200, 'UNIXEPOCH') AS 'zGenAlbum.ZENDDATE(UTC)',
    datetime(zGenAlbum.ZCLOUDSUBSCRIPTIONDATE + 978307200, 'UNIXEPOCH') AS 'zGenAlbum.ZCLOUDSUBSCRIPTIONDATE(UTC)',

    zGenAlbum.ZCLOUDMETADATA AS 'zGenAlbum.ZCLOUDMETADATA(HEX NSKeyed Plist)',
    zGenAlbum.ZPENDINGITEMSCOUNT AS 'zGenAlbum.ZPENDINGITEMSCOUNT',

    CASE zGenAlbum.ZPENDINGITEMSTYPE
        WHEN 1 THEN '1 [No]'
        WHEN 24 THEN '24 [Still Testing]'
        ELSE 'Unknown Value: ' || zGenAlbum.ZPENDINGITEMSTYPE || ''
    END AS 'zGenAlbum.ZPENDINGITEMSTYPE',

    zGenAlbum.ZCACHEDPHOTOSCOUNT AS 'zGenAlbum.ZCACHEDPHOTOSCOUNT',
    zGenAlbum.ZCACHEDVIDEOSCOUNT AS 'zGenAlbum.ZCACHEDVIDEOSCOUNT',
    zGenAlbum.ZCACHEDCOUNT AS 'zGenAlbum.ZCACHEDCOUNT',
    zGenAlbum.ZUUID AS 'zGenAlbum.ZUUID',
    zGenAlbum.ZCLOUDGUID AS 'zGenAlbum.ZCLOUDGUID',
    zCldShareAlbumInvRec.ZALBUMGUID AS 'zCldShareAlbumInvRec.ZALBUMGUID',
    zCldShareAlbumInvRec.ZCLOUDGUID AS 'zCldShareAlbumInvRec.ZCLOUDGUID',
    zGenAlbum.ZPROJECTRENDERUUID AS 'zGenAlbum.ZPROJECTRENDERUUID',
    zGenAlbum.ZSYNCEVENTORDERKEY AS 'zGenAlbum.ZSYNCEVENTORDERKEY',

    CASE zGenAlbum.ZHASUNSEENCONTENT
        WHEN 0 THEN '0 [Has No Unseen Content]'
        WHEN 1 THEN '1 [Has Unseen Content]'
        ELSE 'Unknown Value: ' || zGenAlbum.ZHASUNSEENCONTENT || ''
    END AS 'zGenAlbum.ZHASUNSEENCONTENT',

    zGenAlbum.ZUNSEENASSETSCOUNT AS 'zGenAlbum.ZUNSEENASSETSCOUNT',

    CASE zGenAlbum.ZISOWNED
        WHEN 0 THEN '0 [zGenAlbum Not Owned by Device Apple Account]'
        WHEN 1 THEN '1 [zGenAlbum Owned by Device Apple Account]'
        ELSE 'Unknown Value: ' || zGenAlbum.ZISOWNED || ''
    END AS 'zGenAlbum.ZISOWNED',

    CASE zGenAlbum.ZCLOUDRELATIONSHIPSTATE
        WHEN 0 THEN '0 [zGenAlbum-Cloud Album Owned by Device Apple Acnt]'
        WHEN 2 THEN '2 [zGenAlbum-Cloud Album Not Owned by Device Apple Acnt]'
        ELSE 'Unknown Value: ' || zGenAlbum.ZCLOUDRELATIONSHIPSTATE || ''
    END AS 'zGenAlbum.ZCLOUDRELATIONSHIPSTATE',

    CASE zGenAlbum.ZCLOUDRELATIONSHIPSTATELOCAL
        WHEN 0 THEN '0 [zGenAlbum-Shared Album Accessible Local Device]'
        WHEN 1 THEN '1 [Still Testing]'
        ELSE 'Unknown Value: ' || zGenAlbum.ZCLOUDRELATIONSHIPSTATELOCAL || ''
    END AS 'zGenAlbum.ZCLOUDRELATIONSHIPSTATELOCAL',

    zGenAlbum.ZCLOUDOWNEREMAILKEY AS 'zGenAlbum.ZCLOUDOWNEREMAILKEY',
    zGenAlbum.ZCLOUDOWNERFIRSTNAME AS 'zGenAlbum.ZCLOUDOWNERFIRSTNAME',
    zGenAlbum.ZCLOUDOWNERLASTNAME AS 'zGenAlbum.ZCLOUDOWNERLASTNAME',
    zGenAlbum.ZCLOUDOWNERFULLNAME AS 'zGenAlbum.ZCLOUDOWNERFULLNAME',
    zGenAlbum.ZCLOUDPERSONID AS 'zGenAlbum.ZCLOUDPERSONID',
    zGenAlbum.ZCLOUDOWNERHASHEDPERSONID AS 'zGenAlbum.ZCLOUDOWNERHASHEDPERSONID',

    CASE zGenAlbum.ZCLOUDMULTIPLECONTRIBUTORSENABLEDLOCAL
        WHEN 0 THEN '0 [zGenAlbum-Local Cloud Single Contributor Enabled]'
        WHEN 1 THEN '1 [zGenAlbum-Local Cloud Multi-Contributors Enabled]'
        ELSE 'Unknown Value: ' || zGenAlbum.ZCLOUDMULTIPLECONTRIBUTORSENABLEDLOCAL || ''
    END AS 'zGenAlbum.ZCLOUDMULTIPLECONTRIBUTORSENABLEDLOCAL',

    CASE zGenAlbum.ZCLOUDMULTIPLECONTRIBUTORSENABLED
        WHEN 0 THEN '0 [zGenAlbum-Cloud Single Contributor Enabled]'
        WHEN 1 THEN '1 [zGenAlbum-Cloud Multi-Contributors Enabled]'
        ELSE 'Unknown Value: ' || zGenAlbum.ZCLOUDMULTIPLECONTRIBUTORSENABLED || ''
    END AS 'zGenAlbum.ZCLOUDMULTIPLECONTRIBUTORSENABLED',

    CASE zGenAlbum.ZCLOUDALBUMSUBTYPE
        WHEN 0 THEN '0 [zGenAlbum Multi-Contributor]'
        ELSE 'Unknown Value: ' || zGenAlbum.ZCLOUDALBUMSUBTYPE || ''
    END AS 'zGenAlbum.ZCLOUDALBUMSUBTYPE',

    datetime(zGenAlbum.ZCLOUDLASTCONTRIBUTIONDATE + 978307200, 'UNIXEPOCH') AS 'zGenAlbum.ZCLOUDLASTCONTRIBUTIONDATE(UTC)',
    datetime(zGenAlbum.ZCLOUDLASTINTERESTINGCHANGEDATE + 978307200, 'UNIXEPOCH') AS 'zGenAlbum.ZCLOUDLASTINTERESTINGCHANGEDATE(UTC)',

    CASE zGenAlbum.ZCLOUDNOTIFICATIONSENABLED
        WHEN 0 THEN '0 [zGenAlbum-Cloud Notifications Disabled]'
        WHEN 1 THEN '1 [zGenAlbum-Cloud Notifications Enabled]'
        ELSE 'Unknown Value: ' || zGenAlbum.ZCLOUDNOTIFICATIONSENABLED || ''
    END AS 'zGenAlbum.ZCLOUDNOTIFICATIONSENABLED',

    CASE zGenAlbum.ZISPINNED
        WHEN 0 THEN '0 [zGenAlbum-Local Not Pinned]'
        WHEN 1 THEN '1 [zGenAlbum-Local Pinned]'
        ELSE 'Unknown Value: ' || zGenAlbum.ZISPINNED || ''
    END AS 'zGenAlbum.ZISPINNED',

    CASE zGenAlbum.ZCUSTOMSORTKEY
        WHEN 0 THEN '0 [zGenAlbum-Sorted_Manually]'
        WHEN 1 THEN '1 [zGenAlbum-CusSrtAsc0=Sorted_Newest_First/CusSrtAsc1=Sorted_Oldest_First]'
        WHEN 5 THEN '5 [zGenAlbum-Sorted_by_Title]'
        ELSE 'Unknown Value: ' || zGenAlbum.ZCUSTOMSORTKEY || ''
    END AS 'zGenAlbum.ZCUSTOMSORTKEY',

    CASE zGenAlbum.ZCUSTOMSORTASCENDING
        WHEN 0 THEN '0 [zGenAlbum-Sorted_Newest_First]'
        WHEN 1 THEN '1 [zGenAlbum-Sorted_Oldest_First]'
        ELSE 'Unknown Value: ' || zGenAlbum.ZCUSTOMSORTASCENDING || ''
    END AS 'zGenAlbum.ZCUSTOMSORTASCENDING',

    CASE zGenAlbum.ZISPROTOTYPE
        WHEN 0 THEN '0 [zGenAlbum Not Prototype]'
        WHEN 1 THEN '1 [zGenAlbum Prototype]'
        ELSE 'Unknown Value: ' || zGenAlbum.ZISPROTOTYPE || ''
    END AS 'zGenAlbum.ZISPROTOTYPE',

    CASE zGenAlbum.ZPROJECTDOCUMENTTYPE
        WHEN 0 THEN '0 [Still Testing]'
        ELSE 'Unknown Value: ' || zGenAlbum.ZPROJECTDOCUMENTTYPE || ''
    END AS 'zGenAlbum.ZPROJECTDOCUMENTTYPE',

    CASE zGenAlbum.ZCUSTOMQUERYTYPE
        WHEN 0 THEN '0 [Still Testing]'
        ELSE 'Unknown Value: ' || zGenAlbum.ZCUSTOMQUERYTYPE || ''
    END AS 'zGenAlbum.ZCUSTOMQUERYTYPE',

    CASE zGenAlbum.ZTRASHEDSTATE
        WHEN 0 THEN '0 [zGenAlbum Not In Trash]'
        WHEN 1 THEN '1 [zGenAlbum Album In Trash]'
        ELSE 'Unknown Value: ' || zGenAlbum.ZTRASHEDSTATE || ''
    END AS 'zGenAlbum.ZTRASHEDSTATE',

    datetime(zGenAlbum.ZTRASHEDDATE + 978307200, 'UNIXEPOCH') AS 'zGenAlbum.ZTRASHEDDATE(UTC)',

    CASE zGenAlbum.ZCLOUDDELETESTATE
        WHEN 0 THEN '0 [zGenAlbum Cloud Not Deleted]'
        WHEN 1 THEN '1 [zGenAlbum Cloud Album Deleted]'
        ELSE 'Unknown Value: ' || zGenAlbum.ZCLOUDDELETESTATE || ''
    END AS 'zGenAlbum.ZCLOUDDELETESTATE',

    CASE zGenAlbum.ZCLOUDOWNERISWHITELISTED
        WHEN 0 THEN '0 [zGenAlbum Cloud Owner Not Whitelisted]'
        WHEN 1 THEN '1 [zGenAlbum Cloud Owner Whitelisted]'
        ELSE 'Unknown Value: ' || zGenAlbum.ZCLOUDOWNERISWHITELISTED || ''
    END AS 'zGenAlbum.ZCLOUDOWNERISWHITELISTED',

    CASE zGenAlbum.ZCLOUDPUBLICURLENABLEDLOCAL
        WHEN 0 THEN '0 [zGenAlbum Cloud Local Public URL Disabled]'
        WHEN 1 THEN '1 [zGenAlbum Cloud Local has Public URL Enabled]'
        ELSE 'Unknown Value: ' || zGenAlbum.ZCLOUDPUBLICURLENABLEDLOCAL || ''
    END AS 'zGenAlbum.ZCLOUDPUBLICURLENABLEDLOCAL',

    CASE zGenAlbum.ZCLOUDPUBLICURLENABLED
        WHEN 0 THEN '0 [zGenAlbum Cloud Public URL Disabled]'
        WHEN 1 THEN '1 [zGenAlbum Cloud Public URL Enabled]'
        ELSE 'Unknown Value: ' || zGenAlbum.ZCLOUDPUBLICURLENABLED || ''
    END AS 'zGenAlbum.ZCLOUDPUBLICURLENABLED',

    zGenAlbum.ZPUBLICURL AS 'zGenAlbum.ZPUBLICURL',
    zGenAlbum.ZKEYASSETFACETHUMBNAILINDEX AS 'zGenAlbum.ZKEYASSETFACETHUMBNAILINDEX',
    zGenAlbum.ZPROJECTEXTENSIONIDENTIFIER AS 'zGenAlbum.ZPROJECTEXTENSIONIDENTIFIER',
    zGenAlbum.ZUSERQUERYDATA AS 'zGenAlbum.ZUSERQUERYDATA',
    zGenAlbum.ZCUSTOMQUERYPARAMETERS AS 'zGenAlbum.ZCUSTOMQUERYPARAMETERS',
    zGenAlbum.ZPROJECTDATA AS 'zGenAlbum.ZPROJECTDATA',

    CASE zGenAlbum.ZSEARCHINDEXREBUILDSTATE
        WHEN 0 THEN '0 [Still Testing GenAlbm-Search Index State]'
        WHEN 1 THEN '1 [Still Testing GenAlbm-Search Index State]'
        WHEN 2 THEN '2 [Still Testing GenAlbm-Search Index State]'
        ELSE 'Unknown Value: ' || zGenAlbum.ZSEARCHINDEXREBUILDSTATE || ''
    END AS 'zGenAlbum.ZSEARCHINDEXREBUILDSTATE',
A
    CASE zGenAlbum.ZDUPLICATETYPE
        WHEN 0 THEN '0 [Still Testing GenAlbumDuplicateType]'
        WHEN 1 THEN '1 [Duplicate Asset Pending Merge]'
        WHEN 2 THEN '2 [Still Testing GenAlbumDuplicateType]'
        ELSE 'Unknown Value: ' || zGenAlbum.ZDUPLICATETYPE || ''
    END AS 'zGenAlbum.ZDUPLICATETYPE',

    CASE zGenAlbum.ZPRIVACYSTATE
        WHEN 0 THEN '0 [Still Testing GenAlbm Privacy State]'
        WHEN 1 THEN '1 [Still Testing GenAlbm Privacy State]'
        WHEN 2 THEN '2 [Still Testing GenAlbm Privacy State]'
        ELSE 'Unknown Value: ' || zGenAlbum.ZPRIVACYSTATE || ''
    END AS 'zGenAlbum.ZPRIVACYSTATE',

    zAlbumList.ZUUID AS 'zAlbumList.ZUUID',
    z28AlbumLists.Z_2ALBUMLISTS AS 'z28AlbumLists.Z_2ALBUMLISTS',
    z28AlbumLists.Z_FOK_28ALBUMS AS 'z28AlbumLists.Z_FOK_28ALBUMS',
    zAlbumList.Z_PK AS 'zAlbumList.Z_PK',
    zAlbumList.Z_ENT AS 'zAlbumList.Z_ENT',
    zAlbumList.Z_OPT AS 'zAlbumList.Z_OPT',
    zAlbumList.ZIDENTIFIER AS 'zAlbumList.ZIDENTIFIER',

    CASE zAlbumList.ZNEEDSREORDERINGNUMBER
        WHEN 1 THEN '1 [Yes]'
        ELSE 'Unknown Value: ' || zAlbumList.ZNEEDSREORDERINGNUMBER || ''
    END AS 'zAlbumList.ZNEEDSREORDERINGNUMBER',

    zCldShareAlbumInvRec.ZALBUM AS 'zCldShareAlbumInvRec.ZALBUM',
    zCldShareAlbumInvRec.Z_PK AS 'zCldShareAlbumInvRec.Z_PK',
    zCldShareAlbumInvRec.Z_ENT AS 'zCldShareAlbumInvRec.Z_ENT',
    zCldShareAlbumInvRec.Z_OPT AS 'zCldShareAlbumInvRec.Z_OPT',
    zCldShareAlbumInvRec.Z_FOK_ALBUM AS 'zCldShareAlbumInvRec.Z_FOK_ALBUM',

    CASE zCldShareAlbumInvRec.ZISMINE
        WHEN 0 THEN '0 [Not My Invitation]'
        WHEN 1 THEN '1 [My Invitation]'
        ELSE 'Unknown Value: ' || zCldShareAlbumInvRec.ZISMINE || ''
    END AS 'zCldShareAlbumInvRec.ZISMINE',

    CASE zCldShareAlbumInvRec.ZINVITATIONSTATELOCAL
        WHEN 0 THEN '0 [Still Testing]'
        WHEN 1 THEN '1 [Still Testing]'
        ELSE 'Unknown Value: ' || zCldShareAlbumInvRec.ZINVITATIONSTATELOCAL || ''
    END AS 'zCldShareAlbumInvRec.ZINVITATIONSTATELOCAL',

    CASE zCldShareAlbumInvRec.ZINVITATIONSTATE
        WHEN 1 THEN '1 [Shared Album Invitation Pending]'
        WHEN 2 THEN '2 [Shared Album Invitation Accepted]'
        WHEN 3 THEN '3 [Shared Album Invitation Declined]'
        WHEN 4 THEN '4 [Still Testing]'
        WHEN 5 THEN '5 [Still Testing]'
        ELSE 'Unknown Value: ' || zCldShareAlbumInvRec.ZINVITATIONSTATE || ''
    END AS 'zCldShareAlbumInvRec.ZINVITATIONSTATE',

    datetime(zCldShareAlbumInvRec.ZINVITEESUBSCRIPTIONDATE + 978307200, 'UNIXEPOCH') AS 'zCldShareAlbumInvRec.ZINVITEESUBSCRIPTIONDATE(UTC)',

    zCldShareAlbumInvRec.ZINVITEEFIRSTNAME AS 'zCldShareAlbumInvRec.ZINVITEEFIRSTNAME',
    zCldShareAlbumInvRec.ZINVITEELASTNAME AS 'zCldShareAlbumInvRec.ZINVITEELASTNAME',
    zCldShareAlbumInvRec.ZINVITEEFULLNAME AS 'zCldShareAlbumInvRec.ZINVITEEFULLNAME',
    zCldShareAlbumInvRec.ZINVITEEHASHEDPERSONID AS 'zCldShareAlbumInvRec.ZINVITEEHASHEDPERSONID',
    zCldShareAlbumInvRec.ZINVITEEEMAILKEY AS 'zCldShareAlbumInvRec.ZINVITEEEMAILKEY'


FROM ZGENERICALBUM zGenAlbum

    LEFT JOIN Z_28ALBUMLISTS z28AlbumLists ON z28AlbumLists.Z_28ALBUMS = zGenAlbum.Z_PK
    LEFT JOIN ZALBUMLIST zAlbumList ON zAlbumList.Z_PK = z28AlbumLists.Z_2ALBUMLISTS
    LEFT JOIN ZGENERICALBUM ParentzGenAlbum ON ParentzGenAlbum.Z_PK = zGenAlbum.ZPARENTFOLDER
    LEFT JOIN ZCLOUDSHAREDALBUMINVITATIONRECORD zCldShareAlbumInvRec ON zGenAlbum.Z_PK = zCldShareAlbumInvRec.ZALBUM


ORDER BY 'zGenAlbum-zPK=26AlbumLists=26Albums'