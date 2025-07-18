SELECT outgoingResources.scopeIndex AS 'outgoingResources- scopeIndex',
  outgoingResources.fingerPrint AS 'outgoingResources- fingerPrint',
  outgoingResources.itemIdentifier AS 'outgoingResources- itemIdentifier',
  resources.identifierForStorage AS 'resources- identifierForStorage',
  resources.retainCount AS 'resources- retainCount',
  outgoingResources.uploadIdentifier AS 'outgoingResources- uploadIdentifier',
  outgoingResources.fileUTI AS 'outgoingResources- fileUTI',
  outgoingResources.fileSize AS 'outgoingResources- fileSize',
  CASE outgoingResources.fileKind
    WHEN 0 THEN '0-Unknown- Still Testing-0'
    WHEN 1 THEN '1-Unknown- Still Testing-1'
    ELSE 'Unknown-New-Value!: ' || outgoingResources.fileKind || ''
  END AS 'outgoingResources- fileKind',
  CASE outgoingResources.resourceType
    WHEN 1 THEN '1-Unknown- Still Testing-1'
    WHEN 18 THEN '18-Unknown- Still Testing-18'
    ELSE 'Unknown-New-Value!: ' || outgoingResources.resourceType || ''
  END AS 'outgoingResources- resourceType'
FROM outgoingResources
  LEFT JOIN resources ON resources.identifierForStorage LIKE '%' || outgoingResources.fingerPrint || '%'
ORDER BY 'outgoingResources- itemIdentifier'