# 🚗 Vehicle Rental System - Database Design

A comprehensive PostgreSQL database design for a vehicle rental management system that handles users, vehicles, and booking operations efficiently.

## 📋 Table of Contents

- [Overview](#overview)
- [Database Schema](#database-schema)
- [Entity Relationship Diagram](#entity-relationship-diagram)
- [Tables Description](#tables-description)
- [Relationships](#relationships)
- [Sample Queries](#sample-queries)
- [Installation](#installation)
- [Usage](#usage)
- [Technologies Used](#technologies-used)

## 🎯 Overview

The Vehicle Rental System database is designed to manage a complete vehicle rental business workflow. It supports multiple vehicle types (cars, vans, bikes, trucks, SUVs, and electric vehicles), user management with role-based access, and comprehensive booking tracking.

### Key Features

- **Multi-role user management** (Admin & Customer)
- **Diverse vehicle inventory** with real-time status tracking
- **Comprehensive booking system** with date validation
- **Data integrity** through foreign keys and constraints
- **Optimized queries** with proper indexing

## 🗄️ Database Schema

### Database: `vehicle_rental_system`

The database consists of three main tables:

1. **users** - Stores customer and admin information
2. **vehicles** - Maintains vehicle inventory and status
3. **bookings** - Records all rental transactions

## 📊 Entity Relationship Diagram
![ERD Diagram](./assets/er_diagram.png)

**Interactive ERD:** [View on DrawSQL](https://drawsql.app/teams/raz-2/diagrams/vehicle-rental-system)

### Relationship Summary

```
users (1) ──────< bookings >────── (1) vehicles
     ONE              MANY              ONE
```

- **One user** can make **many bookings** (1:N)
- **One vehicle** can have **many bookings** over time (1:N)
- **Each booking** belongs to **one user** and **one vehicle**

## 📑 Tables Description

### 1. Users Table

Stores information about system users including both administrators and customers.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| user_id | SERIAL | PRIMARY KEY | Auto-incrementing unique identifier |
| name | VARCHAR(100) | NOT NULL | Full name of the user |
| email | VARCHAR(254) | NOT NULL, UNIQUE, CHECK | Unique email (lowercase enforced) |
| password | TEXT | NOT NULL, CHECK | Password (min 6 characters) |
| phone | VARCHAR(15) | NOT NULL | Contact phone number |
| role | VARCHAR(20) | NOT NULL, CHECK | User role: 'admin' or 'customer' |

**Indexes:**
- Primary key on `user_id`
- Unique index on `email`

**Constraints:**
- Email must be lowercase
- Password minimum length: 6 characters
- Role must be either 'admin' or 'customer'

**Sample Data:**
```sql
3 Admins (admin1@example.com, admin2@example.com, admin3@example.com)
26 Customers (razu@example.com, mobarak@example.com, etc.)
```

---

### 2. Vehicles Table

Contains the complete vehicle inventory with specifications and availability status.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| vehicle_id | SERIAL | PRIMARY KEY | Auto-incrementing unique identifier |
| name | VARCHAR(100) | NOT NULL | Vehicle name/model name |
| type | TEXT | - | Vehicle category (car, van, bike, truck, suv, electric) |
| model | VARCHAR(20) | - | Manufacturing year/model |
| registration_number | TEXT | NOT NULL, UNIQUE | Unique vehicle registration |
| rental_price | INT | NOT NULL, CHECK | Daily rental price (≥ 0) |
| status | VARCHAR(50) | NOT NULL, CHECK | Current status |

**Indexes:**
- Primary key on `vehicle_id`
- Unique index on `registration_number`

**Constraints:**
- Rental price must be non-negative
- Status must be: 'available', 'rented', or 'maintenance'

**Vehicle Categories:**
- **Cars:** 5 vehicles (Toyota Corolla, Honda Civic, etc.)
- **Vans:** 5 vehicles (Toyota Hiace, Ford Transit, etc.)
- **Bikes:** 5 vehicles (Yamaha R15, Honda CBR 150, etc.)
- **Trucks:** 5 vehicles (Ford F-150, Toyota Hilux, etc.)
- **SUVs:** 5 vehicles (BMW X5, Audi Q7, etc.)
- **Electric:** 5 vehicles (Tesla Model 3, Nissan Leaf, etc.)

**Total Vehicles:** 30

---

### 3. Bookings Table

Tracks all vehicle rental transactions with complete booking lifecycle management.

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| booking_id | SERIAL | PRIMARY KEY | Auto-incrementing unique identifier |
| user_id | INT | NOT NULL, FOREIGN KEY | References users(user_id) |
| vehicle_id | INT | NOT NULL, FOREIGN KEY | References vehicles(vehicle_id) |
| start_date | DATE | NOT NULL | Rental start date |
| end_date | DATE | NOT NULL, CHECK | Rental end date (≥ start_date) |
| total_cost | INT | NOT NULL, CHECK | Total rental cost (≥ 0) |
| status | VARCHAR(20) | NOT NULL, CHECK | Booking status |

**Indexes:**
- Primary key on `booking_id`
- Foreign key index on `user_id`
- Foreign key index on `vehicle_id`

**Constraints:**
- End date must be greater than or equal to start date
- Total cost must be non-negative
- Status must be: 'pending', 'confirmed', or 'completed'

**Foreign Key Relationships:**
- `user_id` → `users(user_id)` (ON DELETE: Restrict)
- `vehicle_id` → `vehicles(vehicle_id)` (ON DELETE: Restrict)

**Sample Bookings:** 30 records spanning from January 2023 to June 2023

---

## 🔗 Relationships

### One-to-Many Relationships

#### 1. Users → Bookings (1:N)

A single user can create multiple bookings over time.

**Example:**
```
User: Admin One (user_id: 1)
├── Booking 1: Toyota Corolla (Jan 01-05, 2023)
├── Booking 2: Honda Civic (Feb 01-03, 2023)
├── Booking 3: Hyundai Elantra (Apr 01-05, 2023)
└── Booking 4: Mazda Axela (Jun 01-04, 2023)
```

#### 2. Vehicles → Bookings (1:N)

A single vehicle can be booked multiple times by different users at different periods.

**Example:**
```
Vehicle: Honda Civic (vehicle_id: 2)
├── Booking 1: Admin One (Jan 01-05, 2023) - Completed
├── Booking 2: Admin One (Feb 01-03, 2023) - Completed
├── Booking 3: Nusrat Jahan (Mar 12-14, 2023) - Confirmed
└── Booking 4: Arif Hossain (May 08-10, 2023) - Completed
```

### Referential Integrity

All foreign key relationships enforce referential integrity:

- **Cascade behavior:** Not implemented (prevents accidental data loss)
- **Deletion protection:** Cannot delete users or vehicles with existing bookings
- **Update protection:** Changes to primary keys are restricted

---

## 🔍 Sample Queries

### Query 1: Retrieve Complete Booking Information

Get booking details with customer and vehicle information using JOINs.

```sql
SELECT
  b.booking_id,
  u.name AS customer_name,
  v.name AS vehicle_name,
  b.start_date,
  b.end_date,
  b.status
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN vehicles v ON b.vehicle_id = v.vehicle_id;
```

**Purpose:** Displays a complete view of all bookings with human-readable customer and vehicle names.

---

### Query 2: Find Unbooked Vehicles

Identify vehicles that have never been rented using EXISTS subquery.

```sql
SELECT *
FROM vehicles v
WHERE NOT EXISTS (
  SELECT 1
  FROM bookings b
  WHERE b.vehicle_id = v.vehicle_id
);
```

**Purpose:** Helps identify underutilized inventory and potential issues with vehicle listings.

---

### Query 3: Filter Available Vehicles by Type

Retrieve all available vehicles of a specific category.

```sql
SELECT * 
FROM vehicles 
WHERE type = 'car' 
  AND status = 'available';
```

**Purpose:** Customer-facing query to show rentable vehicles by category.

---

### Additional Useful Queries

#### Get Active Bookings
```sql
SELECT * FROM bookings 
WHERE status IN ('pending', 'confirmed');
```

#### Calculate Revenue by Vehicle Type
```sql
SELECT v.type, SUM(b.total_cost) as total_revenue
FROM bookings b
JOIN vehicles v ON b.vehicle_id = v.vehicle_id
WHERE b.status = 'completed'
GROUP BY v.type
ORDER BY total_revenue DESC;
```

#### Find Top Customers
```sql
SELECT u.name, COUNT(b.booking_id) as total_bookings
FROM users u
JOIN bookings b ON u.user_id = b.user_id
GROUP BY u.user_id, u.name
ORDER BY total_bookings DESC
LIMIT 10;
```

---

## 🚀 Installation

### Prerequisites

- PostgreSQL 12 or higher
- psql command-line tool or any PostgreSQL client (pgAdmin, DBeaver, etc.)

### Setup Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/mdmhrz/vehicle-rental-system_database_design.git
   cd vehicle-rental-system_database_design
   ```

2. **Create the database**
   ```bash
   psql -U postgres
   ```
   ```sql
   CREATE DATABASE vehicle_rental_system;
   \c vehicle_rental_system
   ```

3. **Execute the SQL script**
   ```bash
   psql -U postgres -d vehicle_rental_system -f schema.sql
   ```

   Or copy and paste the SQL commands from the schema file directly into your PostgreSQL client.

4. **Verify installation**
   ```sql
   -- Check tables
   \dt
   
   -- Verify data
   SELECT COUNT(*) FROM users;     -- Should return 29
   SELECT COUNT(*) FROM vehicles;  -- Should return 30
   SELECT COUNT(*) FROM bookings;  -- Should return 30
   ```

---

## 💡 Usage

### For Developers

1. **Connection String Format:**
   ```
   postgresql://username:password@localhost:5432/vehicle_rental_system
   ```

2. **Sample Connection (Node.js with pg):**
   ```javascript
   const { Pool } = require('pg');
   
   const pool = new Pool({
     user: 'your_username',
     host: 'localhost',
     database: 'vehicle_rental_system',
     password: 'your_password',
     port: 5432,
   });
   ```

3. **Sample Connection (Python with psycopg2):**
   ```python
   import psycopg2
   
   conn = psycopg2.connect(
       dbname="vehicle_rental_system",
       user="your_username",
       password="your_password",
       host="localhost",
       port="5432"
   )
   ```

### Common Operations

#### Create a New Booking
```sql
INSERT INTO bookings (user_id, vehicle_id, start_date, end_date, total_cost, status)
VALUES (1, 5, '2024-01-15', '2024-01-18', 195, 'pending');
```

#### Update Vehicle Status
```sql
UPDATE vehicles 
SET status = 'rented' 
WHERE vehicle_id = 5;
```

#### Check Vehicle Availability
```sql
SELECT v.* FROM vehicles v
WHERE v.vehicle_id = 5
  AND v.status = 'available'
  AND NOT EXISTS (
    SELECT 1 FROM bookings b
    WHERE b.vehicle_id = v.vehicle_id
      AND b.status IN ('confirmed', 'pending')
      AND '2024-01-15' <= b.end_date
      AND '2024-01-18' >= b.start_date
  );
```

---

## 🛠️ Technologies Used

- **Database:** PostgreSQL 12+
- **SQL Features:**
  - Primary Keys & Foreign Keys
  - CHECK Constraints
  - UNIQUE Constraints
  - Indexes for optimization
  - JOIN operations
  - Subqueries (EXISTS)
  - Aggregate functions

---

## 📈 Database Statistics

| Metric | Count |
|--------|-------|
| Total Tables | 3 |
| Total Users | 29 (3 admins, 26 customers) |
| Total Vehicles | 30 (across 6 categories) |
| Total Bookings | 30 |
| Foreign Key Relationships | 2 |
| Indexes | 6 |
| Check Constraints | 10 |

---

## 🔐 Security Considerations

⚠️ **Important Notes:**

1. **Password Storage:** The current implementation stores passwords in plain text. In production:
   - Use bcrypt or similar hashing algorithms
   - Never store plain text passwords
   - Implement proper authentication mechanisms

2. **Input Validation:** Always validate and sanitize user inputs to prevent SQL injection

3. **Role-Based Access:** Implement proper authorization checks at the application level

4. **Data Privacy:** Ensure compliance with data protection regulations (GDPR, etc.)

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

---

## 👤 Author

**Md Mahir Hossain**

- GitHub: [@mdmhrz](https://github.com/mdmhrz)
- Repository: [vehicle-rental-system_database_design](https://github.com/mdmhrz/vehicle-rental-system_database_design)

---

## 📧 Contact

For questions or suggestions, please open an issue on GitHub or contact through the repository.

---

## 🙏 Acknowledgments

- PostgreSQL Documentation
- DrawSQL for ERD visualization
- Database design best practices from industry standards

---

**Last Updated:** December 2024

**Version:** 1.0.0