
from flask import Flask, render_template, jsonify, request
import pypyodbc as odbc

app = Flask(__name__)

DRIVER_NAME = 'SQL SERVER'
SERVER_NAME = 'Muhammad-Rafay\\SQLEXPRESS'
DATABASE_NAME = 'DeviceManager'

connection_string = f"""
DRIVER={{{DRIVER_NAME}}};
SERVER={SERVER_NAME};
DATABASE={DATABASE_NAME};
Trust_Connection=yes;
"""

def get_db_connection():
    try:
        conn = odbc.connect(connection_string)
        return conn
    except Exception as e:
        print("Error connecting to the database:", e)
        return None

@app.route('/device_types')
def get_device_types():
    conn = get_db_connection()
    if conn:
        cursor = conn.cursor()
        cursor.execute("SELECT DeviceTypeID, TypeName FROM DeviceType")
        device_types = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify(device_types)
    else:
        return jsonify([])

@app.route('/devices')
def get_devices():
    conn = get_db_connection()
    if conn:
        cursor = conn.cursor()
        query = """
        SELECT d.DeviceID, d.DeviceName, dt.TypeName, d.Manufacturer, d.ModelNumber, d.SerialNumber,
               d.PurchaseDate, d.WarrantyExpiryDate
        FROM Device d
        LEFT JOIN DeviceType dt ON d.DeviceTypeID = dt.DeviceTypeID;
        """
        cursor.execute(query)
        devices = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify(devices)
    else:
        return jsonify([])

@app.route('/add_device', methods=['POST'])
def add_device():
    data = request.json
    conn = get_db_connection()
    if conn:
        cursor = conn.cursor()
        device_query = """
        INSERT INTO Device (DeviceTypeID, DeviceName, Manufacturer, ModelNumber, SerialNumber, PurchaseDate, WarrantyExpiryDate)
        VALUES (?, ?, ?, ?, ?, ?, ?)
        """
        cursor.execute(device_query, (
            data['device_type'], data['device_name'], data['manufacturer'], data['model_number'],
            data['serial_number'], data['purchase_date'], data['warranty_expiry_date']
        ))
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({"success": True})
    else:
        return jsonify({"success": False, "error": "Database connection error"})

@app.route('/update_device', methods=['POST'])
def update_device():
    data = request.json
    conn = get_db_connection()
    if conn:
        cursor = conn.cursor()
        device_query = """
        UPDATE Device
        SET DeviceTypeID = ?, DeviceName = ?, Manufacturer = ?, ModelNumber = ?, SerialNumber = ?,
            PurchaseDate = ?, WarrantyExpiryDate = ?
        WHERE DeviceID = ?
        """
        cursor.execute(device_query, (
            data['device_type'], data['device_name'], data['manufacturer'], data['model_number'],
            data['serial_number'], data['purchase_date'], data['warranty_expiry_date'], data['device_id']
        ))
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({"success": True})
    else:
        return jsonify({"success": False, "error": "Database connection error"})

@app.route('/specifications')
def get_specifications():
    conn = get_db_connection()
    if conn:
        cursor = conn.cursor()
        query = """
        SELECT *
        FROM DeviceSpecification;
        """
        cursor.execute(query)
        specifications = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify(specifications)
    else:
        return jsonify([])

@app.route('/add_specification', methods=['POST'])
def add_specification():
    data = request.json
    conn = get_db_connection()
    if conn:
        cursor = conn.cursor()
        spec_query = """
        INSERT INTO DeviceSpecification (DeviceID, SpecificationName, SpecificationValue)
        VALUES (?, ?, ?)
        """
        cursor.execute(spec_query, (
            data['device_id'], data['specification_name'], data['specification_value']
        ))
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({"success": True})
    else:
        return jsonify({"success": False, "error": "Database connection error"})

@app.route('/status')
def get_status():
    conn = get_db_connection()
    if conn:
        cursor = conn.cursor()
        query = """
        SELECT StatusID, DeviceID, Status, StatusDate
        FROM DeviceStatus;
        """
        cursor.execute(query)
        status = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify(status)
    else:
        return jsonify([])

@app.route('/update_status', methods=['POST'])
def update_status():
    data = request.json
    conn = get_db_connection()
    if conn:
        cursor = conn.cursor()
        status_query = """
        INSERT INTO DeviceStatus (DeviceID, Status, StatusDate)
        VALUES (?, ?, GETDATE())
        """
        cursor.execute(status_query, (
            data['device_id'], data['status']
        ))
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({"success": True})
    else:
        return jsonify({"success": False, "error": "Database connection error"})

@app.route('/usage_history')
def get_usage_history():
    conn = get_db_connection()
    if conn:
        cursor = conn.cursor()
        query = """
        SELECT UsageID, DeviceID, UsageStartTime, UsageEndTime, UsageDescription
        FROM DeviceUsageHistory;
        """
        cursor.execute(query)
        usage_history = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify(usage_history)
    else:
        return jsonify([])

@app.route('/add_usage_history', methods=['POST'])
def add_usage_history():
    data = request.json
    conn = get_db_connection()
    if conn:
        cursor = conn.cursor()
        usage_query = """
        INSERT INTO DeviceUsageHistory (DeviceID, UsageStartTime, UsageEndTime, UsageDescription)
        VALUES (?, ?, ?, ?)
        """
        cursor.execute(usage_query, (
            data['device_id'], data['usage_start_time'], data['usage_end_time'], data['usage_description']
        ))
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({"success": True})
    else:
        return jsonify({"success": False, "error": "Database connection error"})

@app.route('/latest_device_info')
def get_latest_device_info():
    conn = get_db_connection()
    if conn:
        cursor = conn.cursor()
        query = """
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
                DATEDIFF(HOUR, UsageStartTime, UsageEndTime) AS Total                
                DUH.UsageID IN (
                    SELECT MAX(UsageID) FROM DeviceUsageHistory GROUP BY DeviceID
                )
            ) DUH ON D.DeviceID = DUH.DeviceID;
        """
        cursor.execute(query)
        latest_device_info = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify(latest_device_info)
    else:
        return jsonify([])

@app.route('/')
def index():
    return render_template('index.html')

if __name__ == '__main__':
    app.run(debug=True)

