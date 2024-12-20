CREATE DATABASE TravelPlanner;

CREATE TABLE Customers (
    customer_Id int PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,                    
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(30),
    date_of_birth DATE,
    gender ENUM('male', 'female', 'other', 'prefer_not_to_say') DEFAULT 'prefer_not_to_say',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Addresses (
    address_Id int PRIMARY KEY AUTO_INCREMENT,
    street_name VARCHAR(255) NOT NULL,
    house_number VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    country_state VARCHAR (100),
    country VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP    
);

CREATE TABLE User_Addresses (
    customer_Id INT,
    address_Id INT,
    PRIMARY KEY (customer_Id, address_Id),
    FOREIGN KEY (customer_Id) REFERENCES Customers(customer_Id) ON DELETE CASCADE,
    FOREIGN KEY (address_Id) REFERENCES Addresses(address_Id) ON DELETE CASCADE
);

CREATE TABLE Reviews (
    review_Id INT PRIMARY KEY AUTO_INCREMENT,
    customer_Id INT,
    rating INT NOT NULL,
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_Id) REFERENCES Customers(customer_Id) ON DELETE CASCADE
);

CREATE TABLE Payments (
    payment_Id INT PRIMARY KEY AUTO_INCREMENT,
    booking_Id INT,
    payment_method ENUM('credit_card', 'paypal', 'bank_transfer'),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_status ENUM('pending', 'completed', 'failed') DEFAULT 'pending',
    amount DECIMAL(10,2),
    transaction_Id VARCHAR(255),
    FOREIGN KEY (booking_Id) REFERENCES Bookings(booking_Id) ON DELETE CASCADE
);

CREATE TABLE Bookings (
    booking_Id INT PRIMARY KEY AUTO_INCREMENT,
    customer_Id INT,
    hotel_Id INT,
    flight_Id INT,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    start_date DATE NULL,
    end_date DATE NULL,
    total_price DECIMAL(10, 2),
    status ENUM ('pending', 'confirmed', 'cancelled', 'completed') DEFAULT 'pending',
    FOREIGN KEY (hotel_Id) REFERENCES Hotels(hotel_Id) ON DELETE SET NULL,
    FOREIGN KEY (flight_Id) REFERENCES Flights(flight_Id) ON DELETE SET NULL,
    FOREIGN KEY (customer_Id) REFERENCES Customers(customer_Id) ON DELETE CASCADE
);

CREATE TABLE Flights (
    flight_Id INT PRIMARY KEY AUTO_INCREMENT,
    flight_number VARCHAR(50) NOT NULL,
    departure_airport VARCHAR(255) NOT NULL,
    arrival_airport VARCHAR(255) NOT NULL,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    price DECIMAL(10, 2),
    available_seats INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Hotels (
    hotel_Id INT PRIMARY KEY AUTO_INCREMENT,
    hotel_name VARCHAR(255) NOT NULL,
    hotel_description TEXT,
    hotel_location VARCHAR(255),
    hotel_rating DECIMAL(3, 2),
    hotel_price_per_night DECIMAL(10, 2),
    hotel_available_rooms INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);