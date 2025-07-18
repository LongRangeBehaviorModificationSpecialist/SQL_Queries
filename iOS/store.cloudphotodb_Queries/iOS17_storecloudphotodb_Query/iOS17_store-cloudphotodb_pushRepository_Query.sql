SELECT  pushRepository.scopeIndex AS 'pushRepository- scopeIndex',
  DateTime(pushRepository.dequeueOrder + 978307200, 'UNIXEPOCH') AS 'pushRepository- dequeueOrder',
  CASE pushRepository.changeType
    WHEN 0 THEN '0-Unknown- Still Testing-0'
    WHEN 2 THEN '2-Unknown- Still Testing-2'
    ELSE 'Unknown-New-Value!: ' || pushRepository.changeType || ''
  END AS 'pushRepository- changeType',
  pushRepository.class AS 'pushRepository- class',
  pushRepository.serializedRecord AS 'pushRepository- serialized Record',
  pushRepository.identifier AS 'pushRepository- identifier',
  pushRepository.relatedIdentifier AS 'pushRepository- relatedIdentifier',
  pushRepository.secondaryIdentifier AS 'pushRepository- secondaryIdentifier',
  pushRepository.uploadIdentifier AS 'pushRepository- uploadIdentifier',  
  CASE pushRepository.trashed
    WHEN 0 THEN '0-Not Trashed-0'
    ELSE 'Unknown-New-Value!: ' || pushRepository.trashed || ''
  END AS 'pushRepository- trashed',
  CASE pushRepository.flags
    WHEN 0 THEN '0-No Flags-0'
    ELSE 'Unknown-New-Value!: ' || pushRepository.flags || ''
  END AS 'pushRepository- flags',
  CASE pushRepository.priority
    WHEN 0 THEN '0-No Priority-0'
    ELSE 'Unknown-New-Value!: ' || pushRepository.priority || ''
  END AS 'pushRepository- priority',
  CASE pushRepository.trustLevel
    WHEN 0 THEN '0-Unknown Trust Level-0'
    WHEN 1 THEN '1-Unknown Trust Level-1'
    ELSE 'Unknown-New-Value!: ' || pushRepository.trustLevel || ''
  END AS 'pushRepository- trustLevel'
FROM pushRepository
ORDER BY pushRepository.dequeueOrder