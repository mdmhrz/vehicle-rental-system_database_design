-- create Database
CREATE DATABASE vehicle_rental_system
-- create users table
CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  name varchar(100) NOT NULL,
  email varchar(254) NOT NULL UNIQUE CHECK (email = LOWER(email)),
  password text NOT NULL CHECK (LENGTH(password) >= 6),
  phone varchar(15) NOT NULL,
  role varchar(20) NOT NULL CHECK (role IN ('admin', 'customer'))
)
-- insert users into table
INSERT INTO
  users (name, email, password, phone, role)
VALUES
  (
    'Admin One',
    'admin1@example.com',
    'admin123',
    '01710000001',
    'admin'
  ),
  (
    'Admin Two',
    'admin2@example.com',
    'secure456',
    '01710000002',
    'admin'
  ),
  (
    'Admin Three',
    'admin3@example.com',
    'password7',
    '01710000003',
    'admin'
  ),
  (
    'Razu Hossain',
    'razu@example.com',
    'razu1234',
    '01810000001',
    'customer'
  ),
  (
    'Mobarak Ali',
    'mobarak@example.com',
    'mobarak9',
    '01810000002',
    'customer'
  ),
  (
    'Hasan Rahman',
    'hasan@example.com',
    'hasan321',
    '01810000003',
    'customer'
  ),
  (
    'Ayesha Khan',
    'ayesha@example.com',
    'ayesha88',
    '01810000004',
    'customer'
  ),
  (
    'Nusrat Jahan',
    'nusrat@example.com',
    'nusrat99',
    '01810000005',
    'customer'
  ),
  (
    'Tanvir Ahmed',
    'tanvir@example.com',
    'tanvir77',
    '01810000006',
    'customer'
  ),
  (
    'Sadia Islam',
    'sadia@example.com',
    'sadia123',
    '01810000007',
    'customer'
  ),
  (
    'Arif Hossain',
    'arif@example.com',
    'arif456',
    '01810000008',
    'customer'
  ),
  (
    'Mehedi Hasan',
    'mehedi@example.com',
    'mehedi78',
    '01810000009',
    'customer'
  ),
  (
    'Rakib Chowdhury',
    'rakib@example.com',
    'rakib321',
    '01810000010',
    'customer'
  ),
  (
    'Farzana Akter',
    'farzana@example.com',
    'farzana9',
    '01810000011',
    'customer'
  ),
  (
    'Shuvo Das',
    'shuvo@example.com',
    'shuvo123',
    '01810000012',
    'customer'
  ),
  (
    'Anika Rahman',
    'anika@example.com',
    'anika456',
    '01810000013',
    'customer'
  ),
  (
    'Siam Ahmed',
    'siam@example.com',
    'siam789',
    '01810000014',
    'customer'
  ),
  (
    'Puja Sen',
    'puja@example.com',
    'puja321',
    '01810000015',
    'customer'
  ),
  (
    'Imran Hossain',
    'imran@example.com',
    'imran123',
    '01810000016',
    'customer'
  ),
  (
    'Nabila Islam',
    'nabila@example.com',
    'nabila77',
    '01810000017',
    'customer'
  ),
  (
    'Sabbir Rahman',
    'sabbir@example.com',
    'sabbir88',
    '01810000018',
    'customer'
  ),
  (
    'Jannat Ara',
    'jannat@example.com',
    'jannat99',
    '01810000019',
    'customer'
  ),
  (
    'Rifat Mahmud',
    'rifat@example.com',
    'rifat321',
    '01810000020',
    'customer'
  ),
  (
    'Tahsin Karim',
    'tahsin@example.com',
    'tahsin456',
    '01810000021',
    'customer'
  ),
  (
    'Omar Faruk',
    'omar@example.com',
    'omar7890',
    '01810000022',
    'customer'
  ),
  (
    'Lamia Chowdhury',
    'lamia@example.com',
    'lamia123',
    '01810000023',
    'customer'
  ),
  (
    'Saiful Islam',
    'saiful@example.com',
    'saiful77',
    '01810000024',
    'customer'
  ),
  (
    'Nayeem Hasan',
    'nayeem@example.com',
    'nayeem88',
    '01810000025',
    'customer'
  ),
  (
    'Sharmin Akter',
    'sharmin@example.com',
    'sharmin9',
    '01810000026',
    'customer'
  );


-- vehicles table create
CREATE TABLE vehicles (
  vehicle_id SERIAL PRIMARY KEY,
  name varchar(100) NOT NULL,
  type text,
  model varchar(20),
  registration_number text NOT NULL UNIQUE,
  rental_price int NOT NULL CHECK (rental_price >= 0),
  status varchar(50) NOT NULL CHECK (status IN ('available', 'rented', 'maintenance'))
)
--insert data into vehicles
INSERT INTO
  vehicles (
    name,
    type,
    model,
    registration_number,
    rental_price,
    status
  )
VALUES
  (
    'Toyota Corolla',
    'car',
    '2022',
    'ABC-101',
    50,
    'available'
  ),
  (
    'Honda Civic',
    'car',
    '2021',
    'ABC-102',
    60,
    'rented'
  ),
  (
    'Nissan Sunny',
    'car',
    '2020',
    'ABC-103',
    45,
    'available'
  ),
  (
    'Hyundai Elantra',
    'car',
    '2023',
    'ABC-104',
    70,
    'available'
  ),
  (
    'Mazda Axela',
    'car',
    '2022',
    'ABC-105',
    65,
    'maintenance'
  ),
  (
    'Toyota Hiace',
    'van',
    '2019',
    'VAN-201',
    90,
    'available'
  ),
  (
    'Ford Transit',
    'van',
    '2020',
    'VAN-202',
    95,
    'rented'
  ),
  (
    'Nissan Caravan',
    'van',
    '2021',
    'VAN-203',
    85,
    'available'
  ),
  (
    'Mercedes Sprinter',
    'van',
    '2022',
    'VAN-204',
    110,
    'maintenance'
  ),
  (
    'Volkswagen Transporter',
    'van',
    '2021',
    'VAN-205',
    100,
    'available'
  ),
  (
    'Yamaha R15',
    'bike',
    '2023',
    'BIKE-301',
    30,
    'available'
  ),
  (
    'Honda CBR 150',
    'bike',
    '2022',
    'BIKE-302',
    35,
    'rented'
  ),
  (
    'Suzuki Gixxer',
    'bike',
    '2021',
    'BIKE-303',
    28,
    'available'
  ),
  (
    'Bajaj Pulsar',
    'bike',
    '2020',
    'BIKE-304',
    25,
    'maintenance'
  ),
  (
    'TVS Apache',
    'bike',
    '2022',
    'BIKE-305',
    32,
    'available'
  ),
  (
    'Ford F-150',
    'truck',
    '2020',
    'TRK-401',
    120,
    'available'
  ),
  (
    'Toyota Hilux',
    'truck',
    '2021',
    'TRK-402',
    110,
    'rented'
  ),
  (
    'Isuzu D-Max',
    'truck',
    '2022',
    'TRK-403',
    105,
    'available'
  ),
  (
    'Nissan Navara',
    'truck',
    '2019',
    'TRK-404',
    100,
    'maintenance'
  ),
  (
    'Chevrolet Silverado',
    'truck',
    '2023',
    'TRK-405',
    130,
    'available'
  ),
  (
    'BMW X5',
    'suv',
    '2022',
    'SUV-501',
    150,
    'available'
  ),
  (
    'Audi Q7',
    'suv',
    '2021',
    'SUV-502',
    145,
    'rented'
  ),
  (
    'Toyota Land Cruiser',
    'suv',
    '2020',
    'SUV-503',
    160,
    'maintenance'
  ),
  (
    'Hyundai Tucson',
    'suv',
    '2023',
    'SUV-504',
    120,
    'available'
  ),
  (
    'Kia Sportage',
    'suv',
    '2022',
    'SUV-505',
    115,
    'available'
  ),
  (
    'Tesla Model 3',
    'electric',
    '2023',
    'EV-601',
    180,
    'available'
  ),
  (
    'Nissan Leaf',
    'electric',
    '2022',
    'EV-602',
    140,
    'rented'
  ),
  (
    'Hyundai Ioniq',
    'electric',
    '2021',
    'EV-603',
    135,
    'available'
  ),
  (
    'Chevy Bolt',
    'electric',
    '2020',
    'EV-604',
    130,
    'maintenance'
  ),
  (
    'BMW i4',
    'electric',
    '2023',
    'EV-605',
    190,
    'available'
  );


-- create bookings table
CREATE TABLE bookings (
  booking_id SERIAL PRIMARY KEY,
  user_id int NOT NULL REFERENCES users (user_id),
  vehicle_id int NOT NULL REFERENCES vehicles (vehicle_id),
  start_date date NOT NULL,
  end_date date NOT NULL CHECK (end_date >= start_date),
  total_cost int NOT NULL CHECK (total_cost >= 0),
  status varchar(20) NOT NULL CHECK (status IN ('completed', 'confirmed', 'pending'))
)
-- insert data into bookings
INSERT INTO
  bookings (
    user_id,
    vehicle_id,
    start_date,
    end_date,
    total_cost,
    status
  )
VALUES
  (
    1,
    2,
    '2023-01-01',
    '2023-01-05',
    240,
    'completed'
  ),
  (2, 3, '2023-01-10', '2023-01-12', 60, 'completed'),
  (
    3,
    1,
    '2023-01-15',
    '2023-01-18',
    150,
    'completed'
  ),
  (
    4,
    4,
    '2023-01-20',
    '2023-01-22',
    200,
    'completed'
  ),
  (
    5,
    5,
    '2023-01-25',
    '2023-01-27',
    180,
    'completed'
  ),
  (
    1,
    2,
    '2023-02-01',
    '2023-02-03',
    120,
    'completed'
  ),
  (
    2,
    6,
    '2023-02-05',
    '2023-02-08',
    270,
    'completed'
  ),
  (3, 7, '2023-02-10', '2023-02-12', 90, 'completed'),
  (4, 1, '2023-02-15', '2023-02-16', 50, 'completed'),
  (5, 3, '2023-02-18', '2023-02-20', 60, 'completed'),
  (
    6,
    8,
    '2023-03-01',
    '2023-03-04',
    300,
    'confirmed'
  ),
  (
    7,
    9,
    '2023-03-05',
    '2023-03-06',
    140,
    'confirmed'
  ),
  (
    8,
    10,
    '2023-03-08',
    '2023-03-10',
    260,
    'confirmed'
  ),
  (
    9,
    2,
    '2023-03-12',
    '2023-03-14',
    120,
    'confirmed'
  ),
  (
    10,
    1,
    '2023-03-15',
    '2023-03-17',
    100,
    'confirmed'
  ),
  (1, 4, '2023-04-01', '2023-04-05', 400, 'pending'),
  (2, 5, '2023-04-06', '2023-04-08', 240, 'pending'),
  (3, 6, '2023-04-10', '2023-04-12', 180, 'pending'),
  (4, 7, '2023-04-14', '2023-04-16', 160, 'pending'),
  (5, 8, '2023-04-18', '2023-04-21', 450, 'pending'),
  (
    6,
    9,
    '2023-05-01',
    '2023-05-03',
    280,
    'completed'
  ),
  (
    7,
    10,
    '2023-05-04',
    '2023-05-07',
    390,
    'completed'
  ),
  (
    8,
    2,
    '2023-05-08',
    '2023-05-10',
    120,
    'completed'
  ),
  (9, 3, '2023-05-11', '2023-05-12', 30, 'completed'),
  (
    10,
    4,
    '2023-05-14',
    '2023-05-17',
    300,
    'completed'
  ),
  (
    1,
    5,
    '2023-06-01',
    '2023-06-04',
    270,
    'confirmed'
  ),
  (
    2,
    6,
    '2023-06-05',
    '2023-06-08',
    270,
    'confirmed'
  ),
  (3, 7, '2023-06-10', '2023-06-12', 90, 'confirmed'),
  (
    4,
    8,
    '2023-06-14',
    '2023-06-16',
    200,
    'confirmed'
  ),
  (
    5,
    9,
    '2023-06-18',
    '2023-06-20',
    280,
    'confirmed'
  );


-- Query 1: JOIN
-- Requirement: Retrieve booking information along with Customer name and Vehicle name.
SELECT
  b.booking_id,
  u.name AS customer_name,
  v.name AS vehicle_name,
  b.start_date,
  b.end_date,
  b.status
FROM
  bookings b
  JOIN users u ON b.user_id = u.user_id
  JOIN vehicles v ON b.vehicle_id = v.vehicle_id;


--Query 2: EXISTS
--Requirement: Find all vehicles that have never been booked.
SELECT
  *
FROM
  vehicles v
WHERE
  NOT EXISTS (
    SELECT
      1
    FROM
      bookings b
    WHERE
      b.vehicle_id = v.vehicle_id
  );


--Query 3: WHERE
--Requirement: Retrieve all available vehicles of a specific type (e.g. cars).
SELECT
  *
FROM
  vehicles
WHERE
  type = 'car'
  AND status = 'available'



-- Query 4: GROUP BY and HAVING
-- Requirement: Find the total number of bookings for each vehicle and display only those vehicles that have more than 2 bookings.
SELECT
  v.name AS vehicle_name,
  COUNT(b.booking_id) AS total_bookings
FROM
  bookings b
  JOIN vehicles v ON b.vehicle_id = v.vehicle_id
GROUP BY
  v.vehicle_id,
  v.name
HAVING
  COUNT(b.booking_id) > 2;