---------------------------------------------------------------------------------------------------------------------
CREATE DATABASE Railway_Management2;
USE Railway_Management2;
-- drop database Railway_Management2;

---------------------------------------------------------------------------------------------------------------------
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
insert into Users values (102,'Mathew Meth','Khandwa Naka, Indore, M.P.','+91 8827432141','mathew@gmail.com','mathew','Mathew@123');
insert into Users values (103,'Rahul Rajat','Palasiya, Indore, M.P.','+91 8832432141','rahul@gmail.com','rahul','Rahul@123');
---------------------------------------------------------------------------------------------------------------------

CREATE TABLE Trains (
  TrainID INT PRIMARY KEY,
  TrainName VARCHAR(255) not null unique,
  -- shedule
  Fare DECIMAL(10, 2) not null
);

insert into Trains values(231245,'Rajdhani Express',400.00);
insert into Trains values(231246,'Intersity Express',600.00);
insert into Trains values(231247,'Saktipunj Express',200.00);
-- alter table Trains add column TrainSchedules int,
--   add foreign key(ScheduleID) references TrainSchedule(ScheduleID); 

-- select * from Trains;

---------------------------------------------------------------------------------------------------------------------

CREATE TABLE Stations (
  StationID INT PRIMARY KEY auto_increment,
  StationName VARCHAR(255) not null unique,
  StationCode varchar(50) not null unique
);

alter table Stations add column StationCode varchar(50) not null unique;

insert into Stations (StationName,StationCode) values('Bhopal','BPL');
-- UPDATE Stations SET StationCode = 'BPL' WHERE StationID = 1;
insert into Stations (StationName,StationCode) values('Indore','INDB');
insert into Stations (StationName,StationCode) values('Delhi','NDLS');
insert into Stations (StationName,StationCode) values('Jabalpur','JBP');
insert into Stations (StationName,StationCode) values('Pune','PUNE');

truncate table Stations;
select * from Stations;
drop table Stations;
desc Stations;
---------------------------------------------------------------------------------------------------------------------

CREATE TABLE TrainShedules(
	ScheduleID INT primary key auto_increment,
    TrainID int not null,
    Source int not null,
	Destination int not null,
    DepartureTime time not null,
    ArrivalTime time not null,
	foreign key(TrainID) references Trains(TrainID),
    foreign key(Destination) references Stations(StationID),
    foreign key(Source) references Stations(StationID)
);



insert into TrainShedules (TrainID,Source,Destination,DepartureTime,ArrivalTime) values(231245,1,3,'02:30:00','23:30:00');  
insert into TrainShedules (TrainID,Source,Destination,DepartureTime,ArrivalTime) values(231246,2,4,'05:30:00','22:30:00');  
insert into TrainShedules (TrainID,Source,Destination,DepartureTime,ArrivalTime) values(231247,2,5,'03:30:00','18:30:00');  

drop table TrainShedules;
---------------------------------------------------------------------------------------------------------------------

CREATE TABLE CoachType(
	CoachID int primary key auto_increment,
    CoachTypeName varchar(20)
);

insert into CoachType(CoachTypeName) values('Sleeper');
insert into CoachType(CoachTypeName) values('AC1');
insert into CoachType(CoachTypeName) values('AC2');
insert into CoachType(CoachTypeName) values('AC3');
insert into CoachType(CoachTypeName) values('General');
drop table CoachType;

select * from CoachType;
---------------------------------------------------------------------------------------------------------------------
CREATE TABLE Bookings (
  BookingID INT PRIMARY KEY auto_increment,
  UserID INT not null,
  TrainID INT not null,
  Date DATE not null,
  SeatNumber INT,
  Status VARCHAR(50) not null,
  CoachID int ,
  foreign key (CoachID) references CoachType(CoachID),
  FOREIGN KEY (UserID) REFERENCES Users(UserID),
  FOREIGN KEY (TrainID) REFERENCES Trains(TrainID)
) ;
-- alter table Bookings add column BookingDate date not null;
-- alter table Bookings add column NoOfPassengers int not null;
-- alter table Bookings add column BookingDate date not null;


insert into Bookings (UserID,TrainID,Date,SeatNumber,Status,CoachID) values(101,231245,'2023-06-03',36,'CNF',1);
insert into Bookings (UserID,TrainID,Date,Status) values(102,231246,'2023-06-03','Waiting');



drop table Bookings;
set foreign_key_checks =0;
---------------------------------------------------------------------------------------------------------------------

drop table Payments;
CREATE TABLE Payments (
  PaymentID INT PRIMARY KEY,
  BookingID INT not null,
  Amount DECIMAL(10, 2) not null,
  PaymentMethod VARCHAR(255) not null,
  TransactionID VARCHAR(255) unique,
  FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
);

insert into Payments (PaymentID,BookingID,Amount,PaymentMethod,TransactionID) values(1,1,500.00,'Online','PH092ONL6243112');
insert into Payments (PaymentID,BookingID,Amount,PaymentMethod,TransactionID) values(2,2,600.00,'Online','PH092ONL6276412');
delete from Payments where PaymentID=2;
---------------------------------------------------------------------------------------------------------------------

CREATE TABLE Tickets (
	PNR INT auto_increment primary key,
	TicketID INT not null,
  BookingID INT not null,
  PassengerName VARCHAR(255) not null,
  Age INT not null,
  Gender VARCHAR(10) not null,
  CoachNumber VARCHAR(10) not null,
  SeatNumber INT not null unique,
  FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
);

-- alter table Tickets add column 
insert into Tickets values(23923401,1101,1,'Andrew Anderson',20,'Male','S05',36);
insert into Tickets(TicketID,BookingID,PassengerName,Age,Gender,CoachNumber,SeatNumber) values(1102,2,'Mathew Meth',20,'Male','S06',34);

drop table Tickets;
---------------------------------------------------------------------------------------------------------------------

CREATE TABLE StationSchedule (
  TrainID INT not null,
  StationID INT not null,
  ArrivalTime TIME not null,
  DepartureTime TIME not null,
  FOREIGN KEY (TrainID) REFERENCES Trains(TrainID),
  FOREIGN KEY (StationID) REFERENCES Stations(StationID)
);

alter table StationSchedule add column PlatformNo int not null;
alter table StationSchedule add column Day varchar(10) not null;

insert into StationSchedule values(231245,2,'11:30:00','12:02:00',2,'Monday');
insert into StationSchedule values(231245,5,'13:30:00','14:02:00',3,'Wednsday');
insert into StationSchedule values(231246,2,'10:30:00','11:02:00',2,'Friday');

truncate table StationSchedule;


---------------------------------------------------------------------------------------------------------------------

CREATE TABLE SeatAvailability (
  TrainID INT not null,
  Date DATE not null,
  AvailableSeats INT not null,
  BookedSeats INT not null,
  PRIMARY KEY (TrainID, Date),
  FOREIGN KEY (TrainID) REFERENCES Trains(TrainID)
);

insert into SeatAvailability values(231245,'2023-06-05',50,450);
insert into SeatAvailability values(231246,'2023-06-05',100,400);
-- alter table SeatAvailability add column BookedSeats INT;

---------------------------------------------------------------------------------------------------------------------

CREATE TABLE CancelledTickets(
	PNR int not null primary key,
    RefundAmount Decimal(10,2) not null,
    CancleDate date not null,
    CancleTime time not  null,
    foreign key (PNR) references Tickets(PNR) 
);

drop table CancelledTickets;
---------------------------------------------------------------------------------------------------------------------

CREATE TABLE CanclledTrains(
	TrainID int not null,
    CancleDate date not null,
    CancleDay varchar(20) not null,
    foreign key (TrainID) references Trains(TrainID)
);

---------------------------------------------------------------------------------------------------------------------
create table Routes(
	RouteId int auto_increment primary key,
    Distance int not null,
    TotalStop int not null,
    
    
    
    
);
---------------------------------------------------------------------------------------------------------------------
select * from StationSchedule;
select * from StationSchedule where TrainID = 231245;

select * from StationSchedule where StationID=2;
select * from Bookings where Status='Waiting';


-- route 
-- pnr
-- train  cancle
-- station code
-- Day in station Schedule


