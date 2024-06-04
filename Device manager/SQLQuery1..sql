USE DeviceManager;
SELECT * 
FROM Device
WHERE Manufacturer LIKE '%Dell%' OR Manufacturer LIKE '%HP%';
