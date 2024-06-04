USE DeviceManager

-- Drop tables
DROP TABLE DeviceSpecification;
DROP TABLE DeviceStatus;
DROP TABLE DeviceUsageHistory;
DROP TABLE Device;
DROP TABLE DeviceType;

-- Recreate tables
CREATE TABLE DeviceType (
    DeviceTypeID INT PRIMARY KEY IDENTITY(1,1),
    TypeName VARCHAR(100) NOT NULL,
    Description VARCHAR(255)
);

CREATE TABLE Device (
    DeviceID INT PRIMARY KEY IDENTITY(1,1),
    DeviceTypeID INT,
    DeviceName VARCHAR(100) NOT NULL,
    Manufacturer VARCHAR(100),
    ModelNumber VARCHAR(100),
    SerialNumber VARCHAR(100) UNIQUE,
    PurchaseDate DATE,
    WarrantyExpiryDate DATE,
    FOREIGN KEY (DeviceTypeID) REFERENCES DeviceType(DeviceTypeID)
);

CREATE TABLE DeviceSpecification (
    SpecID INT PRIMARY KEY IDENTITY(1,1),
    DeviceID INT,
    SpecificationName VARCHAR(100),
    SpecificationValue VARCHAR(255),
    FOREIGN KEY (DeviceID) REFERENCES Device(DeviceID)
);

CREATE TABLE DeviceStatus (
    StatusID INT PRIMARY KEY IDENTITY(1,1),
    DeviceID INT,
    Status VARCHAR(10) CHECK (Status IN ('ON', 'OFF')),
    StatusDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (DeviceID) REFERENCES Device(DeviceID)
);

CREATE TABLE DeviceUsageHistory (
    UsageID INT PRIMARY KEY IDENTITY(1,1),
    DeviceID INT,
    UsageStartTime DATETIME,
    UsageEndTime DATETIME,
    UsageDescription TEXT,
    FOREIGN KEY (DeviceID) REFERENCES Device(DeviceID)
);

-- Inserting data
INSERT INTO DeviceType (TypeName, Description) VALUES
('Laptop', 'Portable computer'),
('Smartphone', 'Handheld mobile device'),
('Printer', 'Device for printing documents'),
('Tablet', 'Portable touchscreen device'),
('Smartwatch', 'Wearable device'),
('Desktop', 'Stationary computer'),
('Router', 'Networking device'),
('Scanner', 'Document scanning device'),
('Camera', 'Digital camera'),
('Monitor', 'Display screen'),
('Keyboard', 'Input device'),
('Mouse', 'Pointing device'),
('Server', 'High-performance computer'),
('Projector', 'Display device'),
('Speaker', 'Audio output device'),
('Microphone', 'Audio input device'),
('NAS', 'Network-attached storage'),
('VR Headset', 'Virtual reality device'),
('Drone', 'Unmanned aerial vehicle'),
('Gaming Console', 'Video game device');


INSERT INTO Device (DeviceTypeID, DeviceName, Manufacturer, ModelNumber, SerialNumber, PurchaseDate, WarrantyExpiryDate) VALUES
(1, 'Dell XPS 13', 'Dell', 'XPS9370', 'SN123456', '2021-01-15', '2023-01-15'),
(2, 'iPhone 12', 'Apple', 'A2403', 'SN7891011', '2020-11-23', '2022-11-23'),
(3, 'HP LaserJet', 'HP', 'M404dn', 'SN1121314', '2019-08-01', '2021-08-01'),
(4, 'iPad Pro', 'Apple', 'A2230', 'SN12131415', '2021-03-10', '2023-03-10'),
(5, 'Apple Watch Series 6', 'Apple', 'A2293', 'SN16171819', '2020-09-18', '2022-09-18'),
(6, 'Dell OptiPlex', 'Dell', '5070', 'SN20212223', '2019-05-05', '2021-05-05'),
(7, 'Netgear Nighthawk', 'Netgear', 'R7000', 'SN24252627', '2018-07-12', '2020-07-12'),
(8, 'Canon CanoScan', 'Canon', 'LiDE 400', 'SN28293031', '2020-02-20', '2022-02-20'),
(9, 'Nikon D3500', 'Nikon', 'D3500', 'SN32333435', '2019-11-11', '2021-11-11'),
(10, 'Samsung Monitor', 'Samsung', 'LC27F398FWNXZA', 'SN36373839', '2021-04-15', '2023-04-15'),
(11, 'Logitech K120', 'Logitech', 'K120', 'SN40414243', '2020-10-20', '2022-10-20'),
(12, 'Logitech M720', 'Logitech', 'M720', 'SN44454647', '2021-06-25', '2023-06-25'),
(13, 'HP ProLiant', 'HP', 'DL380', 'SN48495051', '2018-01-30', '2020-01-30'),
(14, 'Epson PowerLite', 'Epson', '1781W', 'SN52535455', '2019-08-22', '2021-08-22'),
(15, 'Bose SoundLink', 'Bose', 'Mini II', 'SN56575859', '2020-12-01', '2022-12-01'),
(16, 'Blue Yeti', 'Blue', 'Yeti', 'SN60616263', '2021-02-15', '2023-02-15'),
(17, 'Synology DS220+', 'Synology', 'DS220+', 'SN64656667', '2020-09-01', '2022-09-01'),
(18, 'Oculus Quest 2', 'Oculus', 'Quest 2', 'SN68697071', '2021-12-12', '2023-12-12'),
(19, 'DJI Mavic Air 2', 'DJI', 'Mavic Air 2', 'SN72737475', '2020-05-25', '2022-05-25'),
(20, 'Sony PlayStation 5', 'Sony', 'CFI-1015A', 'SN76777880', '2021-11-20', '2023-11-20');


INSERT INTO DeviceSpecification (DeviceID, SpecificationName, SpecificationValue) VALUES
(1, 'Processor', 'Intel Core i7'),
(1, 'RAM', '16GB'),
(2, 'Screen Size', '6.1 inches'),
(2, 'Battery Life', '17 hours'),
(3, 'Print Speed', '38 ppm'),
(3, 'Connectivity', 'Wi-Fi, Ethernet'),
(4, 'Screen Size', '11 inches'),
(4, 'Storage', '256GB'),
(5, 'Screen Size', '44mm'),
(5, 'Battery Life', '18 hours'),
(6, 'Processor', 'Intel Core i5'),
(6, 'RAM', '8GB'),
(7, 'Speed', '1900 Mbps'),
(7, 'Bands', 'Dual-band'),
(8, 'Resolution', '4800 x 4800 dpi'),
(8, 'Type', 'Flatbed'),
(9, 'Megapixels', '24.2 MP'),
(9, 'Lens', 'AF-P DX NIKKOR 18-55mm'),
(10, 'Screen Size', '27 inches'),
(10, 'Resolution', '1920 x 1080'),
(11, 'Type', 'Wired'),
(11, 'Layout', 'Full-size'),
(12, 'Type', 'Wireless'),
(12, 'Buttons', '8');


INSERT INTO DeviceStatus (DeviceID, Status) VALUES
(1, 'ON'),
(2, 'OFF'),
(3, 'ON'),
(4, 'OFF'),
(5, 'ON'),
(6, 'ON'),
(7, 'OFF'),
(8, 'ON'),
(9, 'OFF'),
(10, 'ON'),
(11, 'OFF'),
(12, 'ON'),
(13, 'OFF'),
(14, 'ON'),
(15, 'OFF'),
(16, 'ON'),
(17, 'OFF'),
(18, 'ON'),
(19, 'OFF'),
(20, 'ON');


INSERT INTO DeviceUsageHistory (DeviceID, UsageStartTime, UsageEndTime, UsageDescription) VALUES
(1, '2023-05-20 08:00:00', '2023-05-20 10:00:00', 'Used for coding'),
(2, '2023-05-20 09:00:00', '2023-05-20 11:00:00', 'Used for calling and internet browsing'),
(3, '2023-05-20 07:30:00', '2023-05-20 08:30:00', 'Used for printing documents'),
(4, '2023-05-21 08:00:00', '2023-05-21 10:00:00', 'Used for drawing'),
(5, '2023-05-21 09:00:00', '2023-05-21 11:00:00', 'Used for fitness tracking'),
(6, '2023-05-21 07:30:00', '2023-05-21 08:30:00', 'Used for office work'),
(7, '2023-05-22 08:00:00', '2023-05-22 10:00:00', 'Used for internet browsing'),
(8, '2023-05-22 09:00:00', '2023-05-22 11:00:00', 'Used for scanning documents'),
(9, '2023-05-22 07:30:00', '2023-05-22 08:30:00', 'Used for photography'),
(10, '2023-05-23 08:00:00', '2023-05-23 10:00:00', 'Used for video editing'),
(11, '2023-05-23 09:00:00', '2023-05-23 11:00:00', 'Used for typing documents'),
(12, '2023-05-23 07:30:00', '2023-05-23 08:30:00', 'Used for navigating'),
(13, '2023-05-24 08:00:00', '2023-05-24 10:00:00', 'Used for server management'),
(14, '2023-05-24 09:00:00', '2023-05-24 11:00:00', 'Used for presentation'),
(15, '2023-05-24 07:30:00', '2023-05-24 08:30:00', 'Used for listening to music'),
(16, '2023-05-25 08:00:00', '2023-05-25 10:00:00', 'Used for podcast recording'),
(17, '2023-05-25 09:00:00', '2023-05-25 11:00:00', 'Used for data storage'),
(18, '2023-05-25 07:30:00', '2023-05-25 08:30:00', 'Used for VR gaming'),
(19, '2023-05-26 08:00:00', '2023-05-26 10:00:00', 'Used for aerial photography'),
(20, '2023-05-26 09:00:00', '2023-05-26 11:00:00', 'Used for playing video games');


-- Here We Retrieved various information about devices

-- Here We Retrieved all device types with a count of devices for each type
SELECT DT.DeviceTypeID, DT.TypeName, DT.Description, COUNT(D.DeviceID) AS DeviceCount
FROM DeviceType DT
LEFT JOIN Device D ON DT.DeviceTypeID = D.DeviceTypeID
GROUP BY DT.DeviceTypeID, DT.TypeName, DT.Description
ORDER BY DeviceCount DESC;

-- Here We Retrieved all devices with their type names, including only devices purchased within the last 2 years
SELECT D.DeviceID, D.DeviceName, DT.TypeName, D.Manufacturer, D.ModelNumber, D.SerialNumber, D.PurchaseDate, D.WarrantyExpiryDate
FROM Device D
JOIN DeviceType DT ON D.DeviceTypeID = DT.DeviceTypeID
WHERE D.PurchaseDate > DATEADD(YEAR, -2, GETDATE())
ORDER BY D.PurchaseDate DESC;

-- Here We Retrieved detailed specifications for devices of a specific type (e.g., 'Laptop')
SELECT D.DeviceID, D.DeviceName, DT.TypeName, DS.SpecificationName, DS.SpecificationValue
FROM Device D
JOIN DeviceType DT ON D.DeviceTypeID = DT.DeviceTypeID
JOIN DeviceSpecification DS ON D.DeviceID = DS.DeviceID
WHERE DT.TypeName = 'Laptop'
ORDER BY D.DeviceID, DS.SpecificationName;

-- Here We Retrieved the latest status of all devices along with the duration they have been in that status
SELECT D.DeviceID, D.DeviceName, DS.Status, DS.StatusDate, DATEDIFF(HOUR, DS.StatusDate, GETDATE()) AS StatusDurationHours
FROM Device D
JOIN (
    SELECT DeviceID, Status, StatusDate
    FROM DeviceStatus DS
    WHERE DS.StatusDate = (SELECT MAX(StatusDate) FROM DeviceStatus WHERE DeviceID = DS.DeviceID)
) DS ON D.DeviceID = DS.DeviceID
ORDER BY DS.StatusDate DESC;

-- Here We Retrieved the usage history for devices with total usage duration in hours
SELECT DUH.DeviceID, D.DeviceName, SUM(DATEDIFF(HOUR, DUH.UsageStartTime, DUH.UsageEndTime)) AS TotalUsageHours
FROM DeviceUsageHistory DUH
JOIN Device D ON DUH.DeviceID = D.DeviceID
GROUP BY DUH.DeviceID, D.DeviceName
ORDER BY TotalUsageHours DESC;

-- Here We Retrieved devices that are currently 'ON' with their total 'ON' duration in hours
SELECT D.DeviceID, D.DeviceName, DS.Status, DS.StatusDate, 
       DATEDIFF(HOUR, DS.StatusDate, GETDATE()) AS CurrentOnDurationHours
FROM Device D
JOIN (
    SELECT DeviceID, Status, StatusDate
    FROM DeviceStatus DS
    WHERE DS.StatusDate = (SELECT MAX(StatusDate) FROM DeviceStatus WHERE DeviceID = DS.DeviceID)
    AND DS.Status = 'ON'
) DS ON D.DeviceID = DS.DeviceID
ORDER BY CurrentOnDurationHours DESC;

-- Here We Retrieved devices with their latest status, including an aggregate of how many times each device has been 'ON' or 'OFF'
SELECT D.DeviceID, D.DeviceName, DS.Status, DS.StatusDate, 
       SUM(CASE WHEN DS2.Status = 'ON' THEN 1 ELSE 0 END) AS OnCount,
       SUM(CASE WHEN DS2.Status = 'OFF' THEN 1 ELSE 0 END) AS OffCount
FROM Device D
JOIN (
    SELECT DeviceID, Status, StatusDate
    FROM DeviceStatus DS
    WHERE DS.StatusDate = (SELECT MAX(StatusDate) FROM DeviceStatus WHERE DeviceID = DS.DeviceID)
) DS ON D.DeviceID = DS.DeviceID
LEFT JOIN DeviceStatus DS2 ON D.DeviceID = DS2.DeviceID
GROUP BY D.DeviceID, D.DeviceName, DS.Status, DS.StatusDate
ORDER BY OnCount DESC, OffCount DESC;

-- Here We Retrieved all device details along with their type, specifications, current status, last usage description, and total usage 
--duration
SELECT 
    D.DeviceID, 
    D.DeviceName, 
    DT.TypeName, 
    D.Manufacturer, 
    D.ModelNumber, 
    D.SerialNumber, 
    D.PurchaseDate, 
    D.WarrantyExpiryDate, 
    DS.Status, 
    DS.StatusDate, 
    DSF.SpecificationName, 
    DSF.SpecificationValue, 
    DUH.LastUsageDescription, 
    DUH.TotalUsageHours
FROM 
    Device D
JOIN 
    DeviceType DT ON D.DeviceTypeID = DT.DeviceTypeID
JOIN (
    SELECT 
        DeviceID, 
        Status, 
        StatusDate
    FROM 
        DeviceStatus DS
    WHERE 
        DS.StatusDate = (SELECT MAX(StatusDate) FROM DeviceStatus WHERE DeviceID = DS.DeviceID)
) DS ON D.DeviceID = DS.DeviceID
LEFT JOIN 
    DeviceSpecification DSF ON D.DeviceID = DSF.DeviceID
LEFT JOIN (
    SELECT 
        DeviceID, 
        UsageID AS LastUsageID, 
        UsageDescription AS LastUsageDescription, 
        DATEDIFF(HOUR, UsageStartTime, UsageEndTime) AS TotalUsageHours
    FROM 
        DeviceUsageHistory DUH
    WHERE 
        DUH.UsageID IN (
            SELECT MAX(UsageID) FROM DeviceUsageHistory GROUP BY DeviceID
        )
) DUH ON D.DeviceID = DUH.DeviceID;
