/*
Query copied from https://github.com/ScottKjr3347/iOS_store.cloudphotodb_Queries/blob/main/iOS13_storecloudphotodb_Query/iOS13_storecloudphotodb_Query.txt
*/

SELECT
    ROW_NUMBER() OVER() AS 'Record No.',
    datetime(scopes.creationDate + 978307200, 'UNIXEPOCH') AS 'scopes.creationDate (UTC)',
    scopes.scopeIdentifier AS 'scopes.scopeIdentifier = Photos.sqlite-zShare.ScopeID',
    datetime(scopes.initialSyncDate + 978307200, 'UNIXEPOCH') AS 'scopes.initialSyncDate (UTC)',
    cloudCache.class AS 'cloudCache.class',
    statusCenter.class AS 'statusCenter.class',
    cloudCache.serializedRecord AS 'cloudCache.serializedRecord',
    CASE idMapping.addDirection
        WHEN 1 THEN 'Device2iCloudPhotos-1'
        WHEN 2 THEN 'iCloudPhotos2Devcie-2'
        ELSE 'Unknown Value: ' || idMapping.addDirection
    END AS 'idMapping.addDirection',
    CASE downloadQueue.resourceType
        WHEN 5 THEN 'iCloud Photos-5'
        ELSE 'Unknown Value: ' || downloadQueue.resourceType
    END AS 'downloadQueue.resourceType',
    CASE downloadQueue.status
        WHEN 2 THEN 'Synced with Device-2'
        ELSE 'Unknown Value: ' || downloadQueue.status
    END AS 'downloadQueue.status',
    CASE idMapping.mappingState
        WHEN 1 THEN 'Successful-1'
        WHEN 2 THEN 'StillTesting-2'
        ELSE 'Unknown Value: ' || idMapping.mappingState
    END AS 'idMapping.mappingState',
    downloadQueue.position AS 'downloadQueue.position',
    downloadQueue.taskIdentifier AS 'downloadQueue.taskIdentifier',
    downloadQueue.retryCount AS 'downloadQueue.retryCount',
    datetime(idMapping.addTimestamp + 978307200, 'UNIXEPOCH') AS 'idMapping.addTimestamp (UTC)',
    CASE cloudCache.confirmed
        WHEN 1 THEN 'Yes-1'
        WHEN 2 THEN 'StillTesting-2'
        ELSE 'Unknown Value: ' || cloudCache.confirmed
    END AS 'cloudCache.confirmed',
    CASE cloudCache.state
        WHEN 1 THEN 'Active-1'
        ELSE 'Unknown Value: ' || cloudCache.state
    END AS 'cloudCache.state',
    datetime(scopes.disabledDate + 978307200, 'UNIXEPOCH') AS 'scopes.disabledDate (UTC)',
    datetime(scopes.deleteDate + 978307200, 'UNIXEPOCH') AS 'scopes-deleteDate = zShare.ExpiryDate (UTC)',
    datetime(idMapping.deleteTimestamp + 978307200, 'UNIXEPOCH') AS 'idMapping.deleteTimestamp (UTC)',
    datetime(remappedDeletes.deleteDate + 978307200, 'UNIXEPOCH') AS 'remappedDeletes.deleteDate (UTC)',
    CASE idMapping.deleteDirection
        WHEN 1 THEN 'Deleted via Recently Deleted via Device Photos App-1'
        WHEN 2 THEN 'StillTesting-2'
        ELSE 'Unknown Value: ' || idMapping.deleteDirection
    END AS 'idMapping.deleteDirection',
    cloudCache.identifier AS 'cloudCache.identifier = Photos.sqlite-AssetUUID.CldMstGUID',
    idMapping.cloudIdentifier AS 'idMapping.cloudIdentifier = Photos.sqlite-AssetUUID.CldMstGUID',
    remappedDeletes.cloudIdentifier AS 'remappedDeletes.cloudIdentifier',
    idMapping.localIdentifier AS 'idMapping.localIdentifier = Photos.sqlite-AssetUUID.CldMstGUID',
    statusCenter.identifier AS 'statusCenter.identifier',
    downloadQueue.itemIdentifier AS 'downloadQueue.itemIdentifier = Photos.sqlite-AssetUUID.CldMastGUID',
    downloadQueue.fingerPrint AS 'downloadQueue.fingerPrint = Photos.sqlite-zAsset.zIntResou.Fingerprint',
    cloudCache.relatedIdentifier AS 'cloudCache.relatedIdentifier = Photos.sqlite-AssetUUID.CldMstGUID',
    remappedDeletes.realIdentifier AS 'remappedDeletes.RealIdentifier',
    cloudCache.secondaryIdentifier AS 'cloudCache.secondaryIdentifier = Photos.sqlite-GenAlbGUID',
    cloudCache.stagedSerializedRecord AS 'cloudCache.stagedSerializedRecord',
    cloudCache.stagedRelatedIdentifier AS 'cloudCache.stagedRelatedIdentifier',
    cloudCache.stagedSecondaryIdentifier AS 'cloudCache.stagedSecondaryIdentifier',
    downloadQueue.fileUTI AS 'downloadQueue.fileUTI',
    downloadQueue.fileSize AS 'downloadQueue.fileSize',
    scopes.estimatedSize AS 'scopes.estimatedSize',
    scopes.estimatedAssetCount AS 'scopes.estimatedAssetCount',
    datetime(scopes.lastClearedPush + 978307200, 'UNIXEPOCH') AS 'scopes.lastClearedPush (UTC)',
    datetime(scopes.lastLibraryInfoUpdate + 978307200, 'UNIXEPOCH') AS 'scopes.lastLibraryInfoUpdate (UTC)',
    datetime(scopes.pullFromTransportLastCompletionDate + 978307200, 'UNIXEPOCH') AS 'scopes.pullFromTransportLastCompletionDate (UTC)',
    scopes.droppedSomeRecords AS 'scopes.droppedSomeRecords',
    scopes.featureVersion AS 'scopes.featureVersion',
    scopes.flags AS 'scopes.flags',
    CASE scopes.hasFetchedInitialSyncAnchor
        WHEN 1 THEN 'Yes-1'
        ELSE 'Unknown Value: ' || scopes.hasFetchedInitialSyncAnchor
    END AS 'scopes.hasFetchedInitialSyncAnchor',
    scopes.initialSyncAnchor AS 'scopes.initialSyncAnchor',
    scopes.syncAnchor AS 'scopes.syncAnchor',
    scopes.stagedSyncAnchor AS 'scopes.stagedSyncAnchor',
    scopes.transientSyncAnchor AS 'scopes.transientSyncAnchor',
    scopes.libraryInfo AS 'scopes.libraryInfo',
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
    scopes.updateTransportCurrentGeneration AS 'scopes.updateTransportCurrentGeneration',
    scopes.updateTransportTargetGeneration AS 'scopes.updateTransportTargetGeneration',
    pushRepository.class AS 'pushRepository.class',
    pushRepository.scopeIndex AS 'pushRepository.scopeIndex',
    pushRepository.identifier AS 'pushRepository.identifier',
    pushRepository.changeType AS 'pushRepository.changeType',
    pushRepository.relatedIdentifier AS 'pushRepository.relatedIdentifier',
    pushRepository.secondaryIdentifier AS 'pushRepository.secondaryIdentifier',
    datetime(pushRepository.dequeueOrder + 978307200, 'UNIXEPOCH') AS 'pushRepository.dequeueOrder (UTC)',
    pushRepository.trashed AS 'pushRepository.trashed',
    pushRepository.uploadIdentifier AS 'pushRepository.uploadIdentifier',
    pushRepository.trustLevel AS 'pushRepository.trustLevel',
    statusCenter.generation AS 'statusCenter.generation'

FROM idMapping
    LEFT JOIN
        scopes ON scopes.stableIndex = idMapping.stableScopeIndex
    LEFT JOIN
        cloudCache ON cloudCache.identifier = idMapping.cloudIdentifier
    LEFT JOIN
        pushRepository ON pushRepository.identifier = cloudCache.identifier
    LEFT JOIN
        downloadQueue ON downloadQueue.itemIdentifier = cloudCache.identifier
    LEFT JOIN
        statusCenter ON statusCenter.identifier = idMapping.cloudIdentifier
    LEFT JOIN
        remappedDeletes ON remappedDeletes.cloudIdentifier = idMapping.cloudIdentifier

ORDER BY idMapping.addTimestamp
