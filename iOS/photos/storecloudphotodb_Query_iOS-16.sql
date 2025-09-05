/*
[DLU]
    05-Sep-2025
Query copied from
    https://github.com/ScottKjr3347/iOS_store.cloudphotodb_Queries/blob/main/iOS16_storecloudphotodb_Query/iOS16_storecloudphotodb_Query.txt
*/

SELECT
    ROW_NUMBER() OVER() AS 'RECORD_NUMBER',

    datetime(scopes.creationDate + 978307200, 'UNIXEPOCH') AS 'scopes.creationDate',

    -- [scopes.scopeIdentifier = Photos.sqlite_zShare.ScopeID]
    scopes.scopeIdentifier AS 'scopes.scopeIdentifier',

    datetime(scopes.initialSyncDate + 978307200, 'UNIXEPOCH') AS 'scopes.initialSyncDate',

    cloudCache.class AS 'cloudCache.class',
    statusCenter.class AS 'statusCenter.class',
    cloudCache.serializedRecord AS 'cloudCache.serializedRecord',

    CASE idMapping.addDirection
        WHEN 1 THEN '1 [Device2iCloudPhotos]'
        WHEN 2 THEN '2 [iCloudPhotos2Devcie]'
        ELSE 'Unknown Value: ' || idMapping.addDirection || ''
    END AS 'idMapping.addDirection',

    CASE downloadQueue.resourceType
        WHEN 5 THEN '5 [iCloud Photos]'
        ELSE 'Unknown Value: ' || downloadQueue.resourceType || ''
    END AS 'downloadQueue.resourceType',

    CASE downloadQueue.status
        WHEN 2 THEN '2 [Synced with Device]'
        ELSE 'Unknown Value: ' || downloadQueue.status || ''
    END AS 'downloadQueue.status',

    CASE idMapping.mappingState
        WHEN 1 THEN '1 [Successful]'
        WHEN 2 THEN '2 [Still Testing]'
        ELSE 'Unknown Value: ' || idMapping.mappingState || ''
    END AS 'idMapping.mappingState',

    CASE downloadQueue.intent
        WHEN 1 THEN '1 [Completed]'
        ELSE 'Unknown Value: ' || downloadQueue.intent || ''
    END AS 'downloadQueue.intent',

    downloadQueue.position AS 'downloadQueue.position',
    downloadQueue.taskIdentifier AS 'downloadQueue.taskIdentifier',
    downloadQueue.retryCount AS 'downloadQueue.retryCount',

    datetime(idMapping.addTimestamp + 978307200, 'UNIXEPOCH') AS 'idMapping.addTimestamp(UTC)',

    CASE cloudCache.confirmed
        WHEN 1 THEN '1 [Yes]'
        WHEN 2 THEN '2 [Still Testing]'
        ELSE 'Unknown Value: ' || cloudCache.confirmed || ''
    END AS 'cloudCache.confirmed',

    CASE cloudCache.state
        WHEN 1 THEN '1 [Active]'
        ELSE 'Unknown Value: ' || cloudCache.state || ''
    END AS 'cloudCache.state',

    datetime(scopes.disabledDate + 978307200, 'UNIXEPOCH') AS 'scopes.disabledDate(UTC)',
    -- [scopes.deleteDate = zShare.ExpiryDate]
    datetime(scopes.deleteDate + 978307200, 'UNIXEPOCH') AS 'scopes.deleteDate(UTC)',
    datetime(idMapping.deleteTimestamp + 978307200, 'UNIXEPOCH') AS 'idMapping.deleteTimestamp(UTC)',

    CASE idMapping.deleteDirection
        WHEN 1 THEN '1 [Deleted via Recently Deleted via Device Photos App]'
        WHEN 2 THEN '2 [Still Testing]'
        ELSE 'Unknown Value: ' || idMapping.deleteDirection || ''
    END AS 'idMapping.deleteDirection',

    -- [cloudCache.identifier = Photos.sqlite_AssetUUID.CldMstGUID]
    cloudCache.identifier AS 'cloudCache.identifier',
    -- [idMapping.cloudIdentifier = Photos.sqlite_AssetUUID.CldMstGUID]
    idMapping.cloudIdentifier AS 'idMapping.cloudIdentifier',
    remappedDeletes.cloudIdentifier AS 'remappedDeletes.Cloud Identifier',
    -- [idMapping.localIdentifier = Photos.sqlite_AssetUUID.CldMstGUID]
    idMapping.localIdentifier AS 'idMapping.localIdentifier',
    statusCenter.identifier AS 'statusCenter.identifier',
    -- [downloadQueue.itemIdentifier = Photos.sqlite_AssetUUID.CldMastGUID]
    downloadQueue.itemIdentifier AS 'downloadQueue.itemIdentifier',
    -- [downloadQueue.fingerPrint = Photos.sqlite_zAsset-zIntResouFingerprint]
    downloadQueue.fingerPrint AS 'downloadQueue.fingerPrint',
    -- [cloudCache.relatedIdentifier = Photos.sqlite_AssetUUID.CldMstGUID]
    cloudCache.relatedIdentifier AS 'cloudCache.relatedIdentifier',
    remappedDeletes.realIdentifier AS 'remappedDeletes.Real Identifier',
    -- [cloudCache.secondaryIdentifier = Photos.sqlite_GenAlb.GUID]
    cloudCache.secondaryIdentifier AS 'cloudCache.secondaryIdentifier',
    cloudCache.stagedSerializedRecord AS 'cloudCache.stagedSerializedRecord',
    cloudCache.stagedRelatedIdentifier AS 'cloudCache.stagedRelatedIdentifier',
    cloudCache.stagedSecondaryIdentifier AS 'cloudCache.stagedSecondaryIdentifier',
    downloadQueue.fileUTI AS 'downloadQueue.fileUTI',
    downloadQueue.fileSize AS 'downloadQueue.fileSize',
    scopes.estimatedSize AS 'scopes.estimatedSize',
    scopes.estimatedAssetCount AS 'scopes.estimatedAssetCount',

    datetime(scopes.lastClearedPush + 978307200, 'UNIXEPOCH') AS 'scopes.lastClearedPush(UTC)',
    datetime(scopes.lastLibraryInfoUpdate + 978307200, 'UNIXEPOCH') AS 'scopes.lastLibraryInfoUpdate(UTC)',
    datetime(scopes.pullFromTransportLastCompletionDate + 978307200, 'UNIXEPOCH') AS 'scopes.pullFromTransportLastCompletionDate(UTC)',

    scopes.droppedSomeRecords AS 'scopes.droppedSomeRecords',
    scopes.featureVersion AS 'scopes.featureVersion',
    scopes.flags AS 'scopes.flags',

    CASE scopes.hasFetchedInitialSyncAnchor
        WHEN 1 THEN '1 [Yes]'
        ELSE 'Unknown Value: ' || scopes.hasFetchedInitialSyncAnchor || ''
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
    scopes.updateTransportCurrentGeneration AS 'scopes.updateTransportCurrentGeneration',
    scopes.updateTransportTargetGeneration AS 'scopes.updateTransportTargetGeneration',
    pushRepository.class AS 'pushRepository.class',
    pushRepository.scopeIndex AS 'pushRepository.scopeIndex',
    pushRepository.identifier AS 'pushRepository.identifier',
    pushRepository.changeType AS 'pushRepository.changeType',
    pushRepository.relatedIdentifier AS 'pushRepository.relatedIdentifier',
    pushRepository.secondaryIdentifier AS 'pushRepository.secondaryIdentifier',

    datetime(pushRepository.dequeueOrder + 978307200, 'UNIXEPOCH') AS 'pushRepository.dequeueOrder(UTC)',

    pushRepository.trashed AS 'pushRepository.trashed',
    pushRepository.uploadIdentifier AS 'pushRepository.uploadIdentifier',
    pushRepository.trustLevel AS 'pushRepository.trustLevel',
    pushRepository.serializedRecord AS 'pushRepository.serializedRecord',
    statusCenter.generation AS 'statusCenter.generation'


FROM idMapping

    LEFT JOIN scopes ON scopes.stableIndex = idMapping.stableScopeIndex
    LEFT JOIN cloudCache ON cloudCache.identifier = idMapping.cloudIdentifier
    LEFT JOIN pushRepository ON pushRepository.identifier = cloudCache.identifier
    LEFT JOIN downloadQueue ON downloadQueue.itemIdentifier = cloudCache.identifier
    LEFT JOIN statusCenter ON statusCenter.identifier = idMapping.cloudIdentifier
    LEFT JOIN remappedDeletes ON remappedDeletes.cloudIdentifier = idMapping.cloudIdentifier


ORDER BY idMapping.addTimestamp
