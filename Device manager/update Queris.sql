
-- Updateing DeviceType

UPDATE DeviceType
SET TypeName = 'Tablet', Description = 'Portable touchscreen device'
WHERE DeviceTypeID = 1;

UPDATE DeviceType
SET TypeName = 'Smartwatch', Description = 'Wearable computing device'
WHERE DeviceTypeID = 2;


-- Updateing Devices
UPDATE Device
SET DeviceName = 'Dell Inspiron 15', Manufacturer = 'Dell', ModelNumber = 'Inspiron7591', SerialNumber = 'SN987654',
PurchaseDate = '2022-02-01', WarrantyExpiryDate = '2024-02-01'
WHERE DeviceID = 1;

UPDATE Device
SET DeviceTypeID = 2, DeviceName = 'Samsung Galaxy S21', Manufacturer = 'Samsung', ModelNumber = 'SM-G991B', 
SerialNumber = 'SN11223344', PurchaseDate = '2021-03-11', WarrantyExpiryDate = '2023-03-11'
WHERE DeviceID = 2;

-- Updating DeviceSpecification
UPDATE DeviceSpecification
SET SpecificationName = 'Operating System', SpecificationValue = 'Windows 10'
WHERE SpecID = 1;

UPDATE DeviceSpecification
SET SpecificationName = 'Storage', SpecificationValue = '512GB SSD'
WHERE SpecID = 2;

-- Updating  DeviceStatus
UPDATE DeviceStatus
SET Status = 'OFF', StatusDate = '2023-06-01 08:00:00'
WHERE StatusID = 1;

UPDATE DeviceStatus
SET Status = 'ON', StatusDate = '2023-06-02 09:00:00'
WHERE StatusID = 2;

-- Updating DeviceUsageHistory
UPDATE DeviceUsageHistory
SET UsageStartTime = '2023-06-03 10:00:00', UsageEndTime = '2023-06-03 12:00:00', UsageDescription = 'Used for video conferencing'
WHERE UsageID = 1;

UPDATE DeviceUsageHistory
SET UsageStartTime = '2023-06-03 11:00:00', UsageEndTime = '2023-06-03 13:00:00', UsageDescription = 'Used for gaming'
WHERE UsageID = 2;

-- Selection of updated data 
SELECT * FROM DeviceType
WHERE DeviceTypeID = 1 OR DeviceTypeID = 2;

SELECT * FROM Device
WHERE DeviceID = 1 OR DeviceID = 2;

SELECT * FROM DeviceSpecification
WHERE SpecID = 1 OR SpecID = 2;

SELECT * FROM DeviceStatus
WHERE StatusID = 1 OR StatusID = 2;

SELECT * FROM DeviceUsageHistory
WHERE UsageID = 1 OR UsageID = 2;
