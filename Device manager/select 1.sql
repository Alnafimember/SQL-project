USE DeviceManager
SELECT 
    D.DeviceID, 
    D.DeviceName, 
    DT.TypeName, 
    D.Manufacturer, 
    D.ModelNumber, 
    D.SerialNumber, 
    D.PurchaseDate, 
    D.WarrantyExpiryDate, 
    DS.Status AS CurrentStatus, 
    DS.StatusDate AS CurrentStatusDate, 
    DSF.SpecificationName,
    DSF.SpecificationValue,
    (SELECT COUNT(*) FROM DeviceStatus WHERE DeviceID = D.DeviceID AND Status = 'ON') AS OnCount,
    (SELECT COUNT(*) FROM DeviceStatus WHERE DeviceID = D.DeviceID AND Status = 'OFF') AS OffCount
FROM 
    Device D
JOIN 
    DeviceType DT ON D.DeviceTypeID = DT.DeviceTypeID
JOIN 
    (
        SELECT 
            DeviceID, 
            Status, 
            StatusDate
        FROM 
            DeviceStatus DS
        WHERE 
            DS.StatusDate = (
                SELECT MAX(StatusDate) 
                FROM DeviceStatus 
                WHERE DeviceID = DS.DeviceID
            )
    ) DS ON D.DeviceID = DS.DeviceID
LEFT JOIN 
    (
        SELECT 
            DeviceID, 
            MAX(UsageID) AS LastUsageID
        FROM 
            DeviceUsageHistory
        GROUP BY 
            DeviceID
    ) DUH_Sum ON D.DeviceID = DUH_Sum.DeviceID
LEFT JOIN 
    DeviceUsageHistory DUH ON DUH.UsageID = DUH_Sum.LastUsageID
LEFT JOIN 
    DeviceSpecification DSF ON D.DeviceID = DSF.DeviceID;
