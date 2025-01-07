---------------------------------------------------------------------------------------------------------------------
CREATE DATABASE Railway_Management;
USE Railway_Management;
drop database Railway_Management;

CREATE TABLE Users (
  UserID INT PRIMARY KEY,
  Name VARCHAR(255) not null,
  Address VARCHAR(255) not null,
  ContactNumber VARCHAR(15) not null unique,
  Email VARCHAR(255) not null unique,
  Username VARCHAR(255) unique not null,
  Password VARCHAR(255) not null
);

insert into Users values (101,'Andrew Anderson','Khandwa Naka, Indore, M.P.','+91 8827432140','andrewanderson@gmail.com','andrew','Andrew@123');


CREATE TABLE Trains (
  TrainID INT PRIMARY KEY,
  TrainName VARCHAR(255) not null unique,
  Source VARCHAR(255) not null,
  Destination VARCHAR(255) not null,
  DepartureTime TIME not null,
  ArrivalTime TIME not null,
  DepartureDate date not null,
  ArrivalDate date not null,
  Fare DECIMAL(10, 2) not null
);

-- alter table Trains add column DepartureDate date not null;
insert into Trains values(12981,'Rajdhani Express','Bhopal','Delhi','12:02:00','05:30:00','2023-06-03','2023-06-04',500.00);

select * from Trains;


CREATE TABLE Stations (
  StationID INT PRIMARY KEY,
  StationName VARCHAR(255) not null
);

insert into Stations values(1101,'Bhopal');
insert into Stations values(1102,'Bhopal');


-- drop table Stations; 

CREATE TABLE Bookings (
  BookingID INT PRIMARY KEY,
  UserID INT not null,
  TrainID INT not null,
  Date DATE not null,
  SeatNumber INT,
  Status VARCHAR(50) not null,
  FOREIGN KEY (UserID) REFERENCES Users(UserID),
  FOREIGN KEY (TrainID) REFERENCES Trains(TrainID)
);
alter table Bookings add column CoachNumber varchar(5) not null;

insert into Bookings values(2301,101,12981,'2023-06-03',36,'CNF','S05');

drop table Payments;
CREATE TABLE Payments (
  PaymentID INT PRIMARY KEY,
  BookingID INT not null,
  Amount DECIMAL(10, 2) not null,
  PaymentMethod VARCHAR(255) not null,
  TransactionID VARCHAR(255) unique,
  FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
);

insert into Payments values(1011,2301,500.00,'Online','PH092ONL6243112');



CREATE TABLE Tickets (
  TicketID INT PRIMARY KEY,
  BookingID INT,
  PassengerName VARCHAR(255) not null,
  Age INT not null,
  Gender VARCHAR(10) not null,
  CoachNumber VARCHAR(10) not null,
  SeatNumber INT not null unique,
  FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
);

insert into Tickets values(1101,2301,'Andrew Anderson',20,'Male','S05',36);


CREATE TABLE TrainSchedule (
  TrainID INT not null,
  StationID INT not null,
  ArrivalTime TIME not null,
  DepartureTime TIME not null,
  FOREIGN KEY (TrainID) REFERENCES Trains(TrainID),
  FOREIGN KEY (StationID) REFERENCES Stations(StationID)
);

insert into TrainSchedule values(12981,1101,'11:30:00','12:02:00');

CREATE TABLE SeatAvailability (
  TrainID INT not null,
  Date DATE not null,
  AvailableSeats INT not null,
  BookedSeats INT not null,
  PRIMARY KEY (TrainID, Date),
  FOREIGN KEY (TrainID) REFERENCES Trains(TrainID)
);

insert into SeatAvailability values(12981,'2023-06-03',50,450);
-- alter table SeatAvailability add column BookedSeats INT;





