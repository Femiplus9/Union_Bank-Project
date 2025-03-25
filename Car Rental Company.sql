Create database CarRental

Create schema Car



CREATE TABLE Car.Branch
(
	Branch_ID            INTEGER NOT NULL,
	Name                 VARCHAR(20) NOT NULL,
	Email                VARCHAR(20) NOT NULL,
	PhoneNumber          INTEGER NOT NULL,
	ManagerName          VARCHAR(30) NOT NULL,
	Manager_ID           INTEGER NOT NULL,
	Address              CHAR(18) NOT NULL
);



ALTER TABLE Car.Branch
ADD PRIMARY KEY (Branch_ID,Manager_ID);



CREATE TABLE Car.Customer
(
	Name                 VARCHAR(20) NOT NULL,
	Email                VARCHAR(20) NOT NULL,
	Password             CHAR(20) NOT NULL,
	Address              VARCHAR(50) NOT NULL,
	PhoneNumber          CHAR(10) NOT NULL,
	DriverLicenseNumber  CHAR(15) NOT NULL,
	Customer_ID          CHAR(10) NOT NULL
);



ALTER TABLE Car.Customer
ADD PRIMARY KEY (Customer_ID);



CREATE TABLE Car.Empolyee
(
	EmployeeID           INTEGER NOT NULL,
	Name                 VARCHAR(30) NOT NULL,
	Email                VARCHAR(20) NOT NULL,
	Phonenumber          CHAR(10) NOT NULL,
	Position             VARCHAR (20) NOT NULL,
	Branch_ID            INTEGER NOT NULL,
	Manager_ID           INTEGER NOT NULL
);



ALTER TABLE Car.Empolyee
ADD PRIMARY KEY (EmployeeID,Branch_ID,Manager_ID);



CREATE TABLE Car.Rental_Transaction
(
	Customer_ID          CHAR(10) NOT NULL,
	Vehicle_ID           CHAR(10) NOT NULL,
	Reservation_ID       CHAR(18) NOT NULL,
	Transaction_ID       CHAR(18) NOT NULL,
	RentalDate           INTEGER NOT NULL,
	TotalAmount          INTEGER NOT NULL,
	PaymentMethod        VARCHAR(30) NOT NULL,
	TransactionStatus    INTEGER NOT NULL,
	ReturnDate           CHAR(18) NOT NULL,
	Branch_ID            INTEGER NOT NULL,
	Manager_ID           INTEGER NOT NULL
);



ALTER TABLE Car.Rental_Transaction
ADD PRIMARY KEY (Customer_ID,Vehicle_ID,Reservation_ID,Transaction_ID,Branch_ID,Manager_ID);



CREATE TABLE Car.Reservation
(
	Reservation_ID       CHAR(18) NOT NULL,
	Customer_ID          CHAR(10) NOT NULL,
	Vehicle_ID           CHAR(10) NOT NULL,
	ReservationDate      CHAR(18) NOT NULL,
	StartDate            CHAR(18) NOT NULL,
	EndDate              CHAR(18) NOT NULL,
	TotalCost            CHAR(18) NOT NULL,
	Status               CHAR(18) NOT NULL,
	Branch_ID            INTEGER NOT NULL,
	Manager_ID           INTEGER NOT NULL
);



ALTER TABLE Car.Reservation
ADD PRIMARY KEY (Reservation_ID,Customer_ID,Vehicle_ID,Branch_ID,Manager_ID);



CREATE TABLE Car.Vehicle
(
	Vehicle_ID           CHAR(10) NOT NULL,
	Make                 CHAR(18) NOT NULL,
	Model                CHAR(18) NOT NULL,
	[Year]                 DATE NOT NULL,
	LicensePlate         INTEGER NOT NULL,
	VIN_Vehicle_Identification_Number INTEGER NOT NULL,
	DailyRentalRate      CHAR(18) NOT NULL,
	[Status]               CHAR(18) NOT NULL,
	Color                CHAR(18) NOT NULL,
	Branch_ID            INTEGER NOT NULL,
	Manager_ID           INTEGER NOT NULL
);



ALTER TABLE Car.Vehicle
ADD PRIMARY KEY (Vehicle_ID,Branch_ID,Manager_ID);



ALTER TABLE Car.Empolyee
ADD CONSTRAINT R_5 FOREIGN KEY (Branch_ID, Manager_ID) REFERENCES Car.Branch (Branch_ID, Manager_ID);



ALTER TABLE Car.Rental_Transaction
ADD CONSTRAINT R_3 FOREIGN KEY (Reservation_ID, Customer_ID, Vehicle_ID, Branch_ID, Manager_ID) REFERENCES Car.Reservation (Reservation_ID, Customer_ID, Vehicle_ID, Branch_ID, Manager_ID);



ALTER TABLE Car.Reservation
ADD CONSTRAINT R_1 FOREIGN KEY (Customer_ID) REFERENCES Car.Customer (Customer_ID);



ALTER TABLE Car.Reservation
ADD CONSTRAINT R_2 FOREIGN KEY (Vehicle_ID, Branch_ID, Manager_ID) REFERENCES Car.Vehicle (Vehicle_ID, Branch_ID, Manager_ID);



ALTER TABLE Car.Vehicle
ADD CONSTRAINT R_4 FOREIGN KEY (Branch_ID, Manager_ID) REFERENCES Car.Branch (Branch_ID, Manager_ID);


