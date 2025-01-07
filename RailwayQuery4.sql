---------------------------------------------------------------------------------------------------------------------
CREATE DATABASE Railway_Management3;
USE Railway_Management3;
drop database Railway_Management3;

---------------------------------------------------------------------------------------------------------------------
CREATE TABLE Users (
	UserID varchar(20) PRIMARY KEY,
  Name VARCHAR(50) not null,
  Address VARCHAR(200) not null,
  ContactNumber bigint(10) not null unique,
  Email VARCHAR(50) not null unique,
  AadharNumber bigint(12) not null unique,
  Password VARCHAR(50) not null
);

insert into Users values('hemantpr','Hemant Prajapati','Khandwa Naka, Indore',8827432140,'hemantpraja88@gmail.com',875461391110,'Hemant@123');


---------------------------------------------------------------------------------------------------------------------

CREATE TABLE Trains (
  TrainID INT PRIMARY KEY,
  TrainName VARCHAR(255) not null unique,
  NumberOfCoaches int 
);

insert into Trains values(230601,'Rajdhani Express',50);
---------------------------------------------------------------------------------------------------------------------

CREATE TABLE CancelledTrains(
	TrainID int not null,
    CancelDate date not null,
    CancelDay varchar(20) not null,
    foreign key (TrainID) references Trains(TrainID)
);

insert into CancelledTrains values(230601,'2023-06-06','Tuesday');

---------------------------------------------------------------------------------------------------------------------

CREATE TABLE Stations (
  StationID INT PRIMARY KEY auto_increment,
  StationName VARCHAR(50) not null unique,
  StationCode varchar(50) not null unique
);

insert into Stations(StationName,StationCode) values('Bhopal Junction','BPL');
insert into Stations(StationName,StationCode) values('New Delhi Junction','NDLS');
insert into Stations(StationName,StationCode) values('Gwalior Junction','GWL');
insert into Stations(StationName,StationCode) values('Indore Junction','INDB');
insert into Stations(StationName,StationCode) values('Makshi Junction','MKC');
insert into Stations(StationName,StationCode) values('Dewas Junction','DWS');
insert into Stations(StationName,StationCode) values('Shujalpur','SJP');


---------------------------------------------------------------------------------------------------------------------

CREATE TABLE StationSchedule (
  TrainID INT not null,
  StationID INT not null,
  PlatformNo int not null,
  Days varchar(100) not null,
  ArrivalTime TIME not null,
  DepartureTime TIME not null,
  FOREIGN KEY (TrainID) REFERENCES Trains(TrainID),
  FOREIGN KEY (StationID) REFERENCES Stations(StationID)
);

insert into StationSchedule values(230601,3,2,'Monday, Wednday, Saturday','10:30:00','10:45:00');
---------------------------------------------------------------------------------------------------------------------
create table Routes(
	RouteId int auto_increment primary key,
    DistanceKM Decimal not null,
    TotalStop int not null,
    FirstEnd int not null,
    SecondEnd int not null,
    foreign key (FirstEnd) references Stations(StationID),
    foreign key (SecondEnd) references Stations(StationID)    
);

insert into Routes(DistanceKM,TotalStop,FirstEnd,SecondEnd) values(800,10,1,2);
insert into Routes(DistanceKM,TotalStop,FirstEnd,SecondEnd) values(250,5,1,4);

---------------------------------------------------------------------------------------------------------------------

CREATE TABLE CoachTypes(
	CoachID int primary key auto_increment,
    CoachTypeName varchar(20)
);

insert into CoachTypes(CoachTypeName) values('SL');
insert into CoachTypes(CoachTypeName) values('GEN');
insert into CoachTypes(CoachTypeName) values('2S');
insert into CoachTypes(CoachTypeName) values('1A');
insert into CoachTypes(CoachTypeName) values('2A');
insert into CoachTypes(CoachTypeName) values('3A');
insert into CoachTypes(CoachTypeName) values('3E');
insert into CoachTypes(CoachTypeName) values('EA');
insert into CoachTypes(CoachTypeName) values('EC');
insert into CoachTypes(CoachTypeName) values('CC');
insert into CoachTypes(CoachTypeName) values('Saloon');
insert into CoachTypes(CoachTypeName) values('Vistadome');

---------------------------------------------------------------------------------------------------------------------

create table Quota(
	QuotaID int primary key auto_increment,
    QuotaName varchar(30) not null
);

insert into Quota(QuotaName) values('General');
insert into Quota(QuotaName) values('Ladies');
insert into Quota(QuotaName) values('Tatkal');
insert into Quota(QuotaName) values('Sr. Citizen');
insert into Quota(QuotaName) values('Premium Tatkal');
insert into Quota(QuotaName) values('Person With Disability');

---------------------------------------------------------------------------------------------------------------------

create table Fare(
	FareAmount decimal not null,
    RouteID int not null,
    SourceID int not null,
    DestinationID int not null,
    TrainID int not null,
    QuotaID int not null,
    CoachID int not null,
    
    foreign key(RouteID) references Routes(RouteID),
    foreign key(SourceID) references Stations(StationID),
    foreign key(DestinationID) references Stations(StationID),
    foreign key(TrainID) references Trains(TrainID),
    foreign key(QuotaID) references Quota(QuotaID),
    foreign key (CoachID) references CoachTypes(CoachID)
    
);

insert into Fare values(700,1,1,2,230601,1,1);
---------------------------------------------------------------------------------------------------------------------

CREATE TABLE SeatAvailability (
  TrainID INT not null,
  Date DATE not null,
  QuotaID int not null,
  SLAvlSeats INT not null,
  SLBookedSeats INT not null,
  GENAvlSeats INT not null,
  GENBookedSeats INT not null,
  2SAvlSeats INT not null,
  2SBookedSeats INT not null,
  1ALAvlSeats INT not null,
  1ALBookedSeats INT not null,
  2AAvlSeats INT not null,
  2ABookedSeats INT not null,
  3AAvlSeats INT not null,
  3ABookedSeats INT not null,
  3EAvlSeats INT not null,
  3EBookedSeats INT not null,
  EAAvlSeats INT not null,
  EABookedSeats INT not null,
  ECAvlSeats INT not null,
  ECBookedSeats INT not null,
  CCAvlSeats INT not null,
  CCBookedSeats INT not null,
  SaloonAvlSeats INT not null,
  SaloonBookedSeats INT not null,
  VistadomeAvlSeats INT not null,
  VistadomeBookedSeats INT not null,
  FOREIGN KEY (TrainID) REFERENCES Trains(TrainID),
  FOREIGN KEY (QuotaID) REFERENCES Quota(QuotaID)
  
);

insert into SeatAvailability values(230601,'2023-06-07',1,10,490,50,300,23,250,12,2,2,1,0,10,0,5,5,2,2,10,1,20,1,30,2,20);
---------------------------------------------------------------------------------------------------------------------
create table BirthTypes(
	BirthID int primary key auto_increment,
    BirthTypeName varchar(5) not null unique
);

insert into BirthTypes (BirthTypeName) values('LB');
insert into BirthTypes (BirthTypeName) values('MB');
insert into BirthTypes (BirthTypeName) values('UB');
insert into BirthTypes (BirthTypeName) values('SL');
insert into BirthTypes (BirthTypeName) values('SM');
insert into BirthTypes (BirthTypeName) values('SU');

---------------------------------------------------------------------------------------------------------------------

create table Passengers(
	PassengerID int primary key auto_increment,
    UserID varchar(20) not null,
    PassengerName varchar(50) not null,
    AadharNumber bigint,
    MobileNumber bigint,
    EmailID varchar(50),
    PassengerAge int not null,
    PassengerGender varchar(10) not null,
    Nationality varchar(20) not null,
    PreferenceCoachID int,
    PreferenceBirthID int,
    PreferenceCoachNumber varchar(10),
    NomineeName varchar(50),
    NomineeAadharNumber bigint,
    foreign key(UserID) references Users(UserID),
    foreign key(PreferenceCoachID) references CoachTypes(CoachID),
    foreign key(PreferenceBirthID) references BirthTypes(BirthID)
);

insert into Passengers(UserID,PassengerName,AadharNumber,MobileNumber,EmailID,PassengerAge,PassengerGender,Nationality,PreferenceCoachID,PreferenceBirthID,PreferenceCoachNumber,NomineeName,NomineeAadharNumber) values('hemantpr','Hemant Prajapati',87546139110,8827432140,'hemantparaja88@gmail.com',18,'Male','Indian',1,1,'S01','Rajesh Khanna',875461391110);

---------------------------------------------------------------------------------------------------------------------

CREATE TABLE TrainSchedules(
	ScheduleID INT primary key auto_increment,
    TrainID int not null,
    SourceID int not null,
	DestinationID int not null,
    DepartureDay varchar(1000) not null, 
    ArrivalDay varchar(1000) not null, 
    DepartureTime time not null,
    ArrivalTime time not null,
    RouteID int not null,
    foreign key (RouteID) references Routes(RouteID),
	foreign key(TrainID) references Trains(TrainID),
    foreign key(DestinationID) references Stations(StationID),
    foreign key(SourceID) references Stations(StationID)
);

insert into TrainSchedules (TrainID,SourceID,DestinationID,DepartureDay,ArrivalDay,DepartureTime,ArrivalTime,RouteID) values(230601,1,2,'Sunday, Thursday','Monday, Friday','23:30:00','22:00:00',1);

---------------------------------------------------------------------------------------------------------------------
CREATE TABLE Bookings (
  BookingID INT PRIMARY KEY auto_increment,
  UserID varchar(20) not null,
  TrainID INT not null,
  BookingDate DATE not null,
  BookingTime time not null,
  JourneyDate date not null,
  NoOfPassengers int not null,
  QuotaID int not null,
  SourceID int not null,
  DestinationID int not null,
  TravelAnsurance boolean not null,
  AutoUpgrade boolean not null,
  PassengerID1 int not null,
  PassengerID2 int ,
  PassengerID3 int ,
  PassengerID4 int ,
  PassengerID5 int ,
  PassengerID6 int ,

  foreign key (PassengerID1) references Passengers(PassengerID),
  foreign key (PassengerID2) references Passengers(PassengerID),
  foreign key (PassengerID3) references Passengers(PassengerID),
  foreign key (PassengerID4) references Passengers(PassengerID),
  foreign key (PassengerID5) references Passengers(PassengerID),
  foreign key (PassengerID6) references Passengers(PassengerID),
  foreign key (QuotaID) references Quota(QuotaID),
  FOREIGN KEY (UserID) REFERENCES Users(UserID),
  FOREIGN KEY (TrainID) REFERENCES Trains(TrainID),
  foreign Key(SourceID) references Stations(StationID),
  foreign key(DestinationID) references Stations(StationID)
) ;

insert into Bookings(UserID,TrainID,BookingDate,BookingTime,JourneyDate,NoOfPassengers,QuotaID,SourceID,DestinationID,TravelAnsurance,AutoUpgrade,PassengerID1) values('hemantpr',230601,'2023-06-06','23:30:32','2023-06-08',1,1,1,2,1,0,1);
---------------------------------------------------------------------------------------------------------------------


CREATE TABLE Payments (
  PaymentID INT PRIMARY KEY auto_increment,
  BookingID INT not null,
  TicketFare DECIMAL(10, 2) not null,
  GST decimal not null,
  AnsuranceCharge decimal,
  IRCTCCovFees decimal not null,
  PaymentMethod VARCHAR(255) not null,
  TransactionID VARCHAR(255),
  TotalAmount decimal not null,
  FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
);

insert into Payments(BookingID,TicketFare,GST,AnsuranceCharge,IRCTCCovFees,PaymentMethod,TransactionID,TotalAmount) values(1,700,20,5,10,'Online','GPAY23ONLINE230611',735.00);
---------------------------------------------------------------------------------------------------------------------

create table TicketStatusTypes(
	StatusID int primary key auto_increment,
    StatusType varchar(10)
);

insert into TicketStatusTypes(StatusType) values('GNWL');
insert into TicketStatusTypes(StatusType) values('PQWL');
insert into TicketStatusTypes(StatusType) values('RAC');
insert into TicketStatusTypes(StatusType) values('CNF');
insert into TicketStatusTypes(StatusType) values('RLWL');


---------------------------------------------------------------------------------------------------------------------

CREATE TABLE Tickets (
  PNR INT auto_increment primary key,
  TicketID INT not null,
  BookingID INT not null,
  PassengerID int not null,
  CoachNumber VARCHAR(10),
  BirthNumber INT ,
  BirthID int,
  StatusID int not null,
  PaymentID int not null,
  foreign key(PassengerID) references Passengers(PassengerID),
  foreign key(BirthID) references BirthTypes(BirthID),
  foreign key(StatusID) references TicketStatusTypes(StatusID),
  FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID),
  foreign key (PaymentID) references Payments(PaymentID)
);

insert into Tickets values(230611,1,1,1,'S01',23,1,4,1);
---------------------------------------------------------------------------------------------------------------------

CREATE TABLE CancelledTickets(
	PNR int not null primary key,
    CancelDate date not null,
    CancelTime time not  null,
   
    RefundStatus varchar(10) not null,
	RefundAmount Decimal,
    foreign key (PNR) references Tickets(PNR) 
);


insert into CancelledTickets values(230611,'2023-06-07','00:23:00','Pending','550');

---------------------------------------------------------------------------------------------------------------------

create table AnsuranceDetails(
	PolicyNumber bigint primary key auto_increment,
    PassengerID int not null unique,
    CoverAmount bigint not null,
    PolicyAmount bigint not null,
    PNR int not null unique,
    foreign key (PNR) references Tickets(PNR),
    foreign key (PassengerID) references Passengers(PassengerID)
);

insert into AnsuranceDetails Values(2312301,1,500000,0.50,230611);

---------------------------------------------------------------------------------------------------------------------
create table TDRReasons(
	ReasonID int primary key auto_increment,
    Reason varchar(500) not null unique
);

insert into TDRReasons(Reason) values('Train Late More Than Three Hours and Passenger Not Traveled.');
insert into TDRReasons(Reason) values('AC Failure.');
insert into TDRReasons(Reason) values('After Charting No Room Provided.');
insert into TDRReasons(Reason) values('Change In Reservation Status From Confirmed To Wait listed/Part Wait listed/RAC After Chart Preparation.');
insert into TDRReasons(Reason) values('Difference Of Fare As Passenger Traveled In Lower Class.');
insert into TDRReasons(Reason) values('Difference Of Fare In Case proper Coach Not Attached.');
insert into TDRReasons(Reason) values('Party Could Not Cancel Because Chart Prepared At Originating Or Previous Remote Location.');
insert into TDRReasons(Reason) values('Party Partially Confirmed/Wait listed And All Passengers Did Not Travel.');
insert into TDRReasons(Reason) values('Party Partially Confirmed/Wait listed And Wait listed Passengers Did Not Travel.');
insert into TDRReasons(Reason) values('Party Partially Traveled (Journey terminated short of destination).');
insert into TDRReasons(Reason) values('Passenger Not Traveled As Reservation Provided In Lower Class.');
insert into TDRReasons(Reason) values('Passenger Not Traveled Due To Ticket In RAC After Chart Preparation.');
insert into TDRReasons(Reason) values('Passenger Not Traveled.');
insert into TDRReasons(Reason) values('Train Canceled.');
insert into TDRReasons(Reason) values('Train Diverted And Train Not Touching Boarding Station.');
insert into TDRReasons(Reason) values('Train Diverted And Train Not Touching Destination Station.');
insert into TDRReasons(Reason) values('Train Missed As Connecting Train Was Late.');
insert into TDRReasons(Reason) values('Train Terminated Short Of Destination.');
insert into TDRReasons(Reason) values('Traveled Without Proper ID Proof.');
insert into TDRReasons(Reason) values('Wrongly Charged BY TTE.');
---------------------------------------------------------------------------------------------------------------------
create table TDRFiles(
	TDRRequestID int primary key auto_increment,
	PNR int not null,
    ReasonID int not null,
    foreign key(ReasonID) references TDRReasons(ReasonID),
    foreign key (PNR) references Tickets(PNR)
);
insert into TDRFiles(PNR,ReasonID) values(230611,1);

----------------------------------------------------------------------------------------------------------------------

Create table TDR(
	TDRNumber bigint primary key auto_increment,
    TDRRequestID int not null,
    foreign key(TDRRequestID) references TDRFiles(TDRRequestID)
);

insert into TDR values(2393201,1);


------------------------------------------------------------------------------------------------------------------------

create table StationsOnRoots(
		RouteID int not null,
        StationID int not null,
        primary key(RouteID, StationID),
        foreign key (RouteID) references Routes(RouteID),
        foreign key (StationID) references Stations(StationID)
);

insert into StationsOnRoots values(1,1);
insert into StationsOnRoots values(1,2);
insert into StationsOnRoots values(1,3);
insert into StationsOnRoots values(2,1);
insert into StationsOnRoots values(2,4);
insert into StationsOnRoots values(2,7);
insert into StationsOnRoots values(2,8);
insert into StationsOnRoots values(2,9);



-------------------------------------------------------------------------------------------------------------------
-- --> Data Fetching Queries <-- 

select * from Stations join StationsOnRoots on Stations.StationID=StationsOnRoots.StationID where RouteID=1;
select * from Stations join StationsOnRoots on Stations.StationID=StationsOnRoots.StationID where RouteID=2;


select * from Stations;