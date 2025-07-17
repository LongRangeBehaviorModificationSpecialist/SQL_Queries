SELECT

    DateTime(scopes.creationDate + 978307200, 'UNIXEPOCH') AS 'scopes.creationDate (UTC)',
    scopes.scopeIdentifier AS 'scopes.scopeIdentifier = Photos.sqlite_zShare.ScopeID',
    DateTime(scopes.initialSyncDate + 978307200, 'UNIXEPOCH') AS 'scopes.initialSyncDate (UTC)',
    cloudCache.class AS 'cloudCache.class',
    statusCenter.class AS 'statusCenter.class',
    cloudCache.serializedRecord AS 'cloudCache.serializedRecord',

    CASE idMapping.addDirection
        WHEN 1 THEN '1 Device to iCloud Photos'
        WHEN 2 THEN '2 iCloud Photos to Devcie'
        ELSE 'Unknown New Value: ' || idMapping.addDirection || ''
    END AS 'idMapping.addDirection',

    CASE downloadQueue.resourceType
        WHEN 5 THEN '5 iCloud Photos'
        ELSE 'Unknown New Value: ' || downloadQueue.resourceType || ''
    END AS 'downloadQueue.resourceType',

    CASE downloadQueue.status
        WHEN 2 THEN '2 Synced with Device'
        ELSE 'Unknown New Value: ' || downloadQueue.status || ''
    END AS 'downloadQueue.status',

    CASE idMapping.mappingState
        WHEN 1 THEN '1 Successful'
        WHEN 2 THEN '2 (Still Testing)'
        ELSE 'Unknown New Value: ' || idMapping.mappingState || ''
    END AS 'idMapping.mappingState',

    CASE downloadQueue.intent
        WHEN 1 THEN '1 Completed'
        ELSE 'Unknown New Value: ' || downloadQueue.intent || ''
    END AS 'downloadQueue.intent',

    downloadQueue.position AS 'downloadQueue.position',
    downloadQueue.taskIdentifier AS 'downloadQueue.taskIdentifier',
    downloadQueue.retryCount AS 'downloadQueue.retryCount',
    DateTime(idMapping.addTimestamp + 978307200, 'UNIXEPOCH') AS 'idMapping.addTimestamp (UTC)',

    CASE cloudCache.confirmed
        WHEN 1 THEN '1 Yes'
        WHEN 2 THEN '2 (Still Testing)'
        ELSE 'Unknown New Value: ' || cloudCache.confirmed || ''
    END AS 'cloudCache.confirmed',

    CASE cloudCache.state
        WHEN 1 THEN '1 Active'
        ELSE 'Unknown New Value: ' || cloudCache.state || ''
    END AS 'cloudCache.state',

    DateTime(scopes.disabledDate + 978307200, 'UNIXEPOCH') AS 'scopes.disabledDate (UTC)',
    DateTime(scopes.deleteDate + 978307200, 'UNIXEPOCH') AS 'scopes.deleteDate = zShare.ExpiryDate (UTC)',
    DateTime(idMapping.deleteTimestamp + 978307200, 'UNIXEPOCH') AS 'idMapping.deleteTimestamp (UTC)',

    CASE idMapping.deleteDirection
        WHEN 1 THEN '1 Deleted via Recently Deleted via Device Photos App'
        WHEN 2 THEN '2 (Still Testing)'
        ELSE 'Unknown New Value: ' || idMapping.deleteDirection || ''
    END AS 'idMapping.deleteDirection',

    cloudCache.identifier AS 'cloudCache.identifier = Photos.sqlite_AssetUUID.CldMstGUID',
    idMapping.cloudIdentifier AS 'idMapping.cloudIdentifier = Photos.sqlite_AssetUUID.CldMstGUID',
    remappedDeletes.cloudIdentifier AS 'remappedDeletes.cloudIdentifier',
    idMapping.localIdentifier AS 'idMapping.localIdentifier = Photos.sqlite_AssetUUID.CldMstGUID',
    statusCenter.identifier AS 'statusCenter.identifier',
    downloadQueue.itemIdentifier AS 'downloadQueue.itemIdentifier = Photos.sqlite_AssetUUID.CldMastGUID',
    downloadQueue.fingerPrint AS 'downloadQueue.fingerPrint = Photos.sqlite.zAsset_zIntResou.Fingerprint',
    cloudCache.relatedIdentifier AS 'cloudCache.relatedIdentifier = Photos.sqlite_AssetUUID.CldMstGUID',
    remappedDeletes.realIdentifier AS 'remappedDeletes.realIdentifier',
    cloudCache.secondaryIdentifier AS 'cloudCache.secondaryIdentifier = Photos.sqlite_GenAlbGUID',
    cloudCache.stagedSerializedRecord AS 'cloudCache.stagedSerializedRecord',
    cloudCache.stagedRelatedIdentifier AS 'cloudCache.stagedRelatedIdentifier',
    cloudCache.stagedSecondaryIdentifier AS 'cloudCache.stagedSecondaryIdentifier',
    downloadQueue.fileUTI AS 'downloadQueue.fileUTI',
    downloadQueue.fileSize AS 'downloadQueue.fileSize',
    scopes.estimatedSize AS 'scopes.estimatedSize',
    scopes.estimatedAssetCount AS 'scopes.estimatedAssetCount',

    DateTime(scopes.lastClearedPush + 978307200, 'UNIXEPOCH') AS 'scopes.lastClearedPush (UTC)',
    DateTime(scopes.lastLibraryInfoUpdate + 978307200, 'UNIXEPOCH') AS 'scopes.lastLibraryInfoUpdate (UTC)',
    DateTime(scopes.pullFromTransportLastCompletionDate + 978307200, 'UNIXEPOCH') AS 'scopes.pullFromTransportLastCompletionDate (UTC)',

    scopes.droppedSomeRecords AS 'scopes.droppedSomeRecords',
    scopes.featureVersion AS 'scopes.featureVersion',
    scopes.flags AS 'scopes.flags',

    CASE scopes.hasFetchedInitialSyncAnchor
        WHEN 1 THEN '1 Yes'
        ELSE 'Unknown New Value: ' || scopes.hasFetchedInitialSyncAnchor || ''
    END AS 'scopes.hasFetchedInitialSyncAnchor',

    scopes.initialSyncAnchor AS 'scopes.initialSyncAnchor',
    scopes.syncAnchor AS 'scopes.syncAnchor',
    scopes.stagedSyncAnchor AS 'scopes.stagedSyncAnchor',
    scopes.transientSyncAnchor AS 'scopes.transientSyncAnchor',
    scopes.libraryInfo AS 'scopes.libraryInfo',
    scopes.scopeChange AS 'scopes.scopeChange',
    scopes.transportScope AS 'scopes.transportScope',
    scopes.classForInitialQuery AS 'scopes.classForInitialQuery',
    scopes.uploadTransportGroup AS 'scopes.uploadTransportGroup',
    scopes.downloadTransportGroup AS 'scopes.downloadTransportGroup',
    scopes.pushToTransportCurrentGeneration AS 'scopes.pushToTransportCurrentGeneration',
    scopes.pushToTransportTargetGeneration AS 'scopes.pushToTransportTargetGeneration',
    scopes.pullFromTransportTargetGeneration AS 'scopes.pullFromTransportTargetGeneration',
    scopes.pullFromTransportExpirationInterval AS 'scopes.pullFromTransportExpirationInterval',
    scopes.clientNeedsToPullCurrentGeneration AS 'scopes.clientNeedsToPullCurrentGeneration',
    scopes.clientNeedsToPullTargetGeneration AS 'scopes.clientNeedsToPullTargetGeneration',
    scopes.updateTransportCurrentGeneration AS 'scopes.uupdateTransportCurrentGeneration',
    scopes.updateTransportTargetGeneration AS 'scopes.updateTransportTargetGeneration',
    statusCenter.generation AS 'statusCenter.generation'


FROM idMapping

    LEFT JOIN scopes ON scopes.stableIndex = idMapping.stableScopeIndex
    LEFT JOIN cloudCache ON cloudCache.identifier = idMapping.cloudIdentifier
    LEFT JOIN downloadQueue ON downloadQueue.itemIdentifier = cloudCache.identifier
    LEFT JOIN statusCenter ON statusCenter.identifier = idMapping.cloudIdentifier
    LEFT JOIN remappedDeletes ON remappedDeletes.cloudIdentifier = idMapping.cloudIdentifier


ORDER BY idMapping.addTimestamp