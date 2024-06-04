USE DeviceManager;
SELECT * 
FROM Device
WHERE (Manufacturer LIKE '%Apple%' OR Manufacturer LIKE '%Samsung%')
AND PurchaseDate BETWEEN '2020-09-15' AND '2021-03-10';

