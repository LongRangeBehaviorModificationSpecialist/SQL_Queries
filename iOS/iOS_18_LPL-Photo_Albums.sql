SELECT

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

    zGenAlbum.ZCLOUDGUID AS 'zGenAlbum-Cloud_GUID = store.cloudphotodb',
    z28AlbumLists.Z_28ALBUMS AS 'z27AlbumList-27Albums=zGenAlbum-zPK',
    zGenAlbum.Z_PK AS 'zGenAlbum-zPK=26AlbumLists=26Albums',
    zGenAlbum.Z_ENT AS 'zGenAlbum-zEnt',
    zGenAlbum.Z_OPT AS 'zGenAlbum-zOpt',
    zGenAlbum.ZSYNDICATE AS 'zGenAlbum-zSyndicate',
    zGenAlbum.ZPARENTFOLDER AS 'zGenAlbum-Parent Folder Key=zGenAlbum-zPK',
    zGenAlbum.Z_FOK_PARENTFOLDER AS 'zGenAlbum-FOK Parent Folder',
    zGenAlbum.ZIMPORTSESSIONID AS 'zGenAlbum-Import Session ID',
    zCldShareAlbumInvRec.ZUUID AS 'zCldShareAlbumInvRec-zUUID',

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

    zGenAlbum.ZIMPORTEDBYBUNDLEIDENTIFIER AS 'zGenAlbum-Imported by Bundle Identifier',
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
    z28AlbumLists.Z_2ALBUMLISTS AS 'z27AlbumList-Album List Key',
    z28AlbumLists.Z_FOK_28ALBUMS AS 'z27AlbumList-FOK27Albums Key',
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
    zCldShareAlbumInvRec.ZINVITEEEMAILKEY AS 'zCldShareAlbumInvRec-Invitee Email Key/UnknownData'


FROM ZGENERICALBUM zGenAlbum

  LEFT JOIN Z_28ALBUMLISTS z28AlbumLists ON z28AlbumLists.Z_28ALBUMS = zGenAlbum.Z_PK
  LEFT JOIN ZALBUMLIST zAlbumList ON zAlbumList.Z_PK = z28AlbumLists.Z_2ALBUMLISTS
  LEFT JOIN ZGENERICALBUM ParentzGenAlbum ON ParentzGenAlbum.Z_PK = zGenAlbum.ZPARENTFOLDER
  LEFT JOIN ZCLOUDSHAREDALBUMINVITATIONRECORD zCldShareAlbumInvRec ON zGenAlbum.Z_PK = zCldShareAlbumInvRec.ZALBUM


ORDER BY 'zGenAlbum-zPK=26AlbumLists=26Albums'