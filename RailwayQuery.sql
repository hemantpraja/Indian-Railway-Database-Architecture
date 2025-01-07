-- RAILWAY RESERVATION SYSTEM 

CREATE DATABASE Railway;

use Railway;

CREATE TABLE User(
	U_id varchar(50) primary key, 
	Password VARCHAR(50)
);


create table Station(
	Station_id varchar(20) primary key,
    Station_name varchar(50) not null
);

create table Passenger(
	PNR int(20) Primary Key,
    P_name varchar(50) not null,
    Age int(3) not null,
    Gender varchar(6) not null,
    Seat_no varchar(5) not null,
    Reserve_status varchar(30) not null,
    U_id varchar(50), 
    foreign key (U_id) references User(U_id)
);

create table Train_Status(
	Status_id varchar(20) primary key,
    Wait_seat int not null,
    Avail_seat int not null,
    Booked_seat int not null,
    PNR int(20),
    foreign key (PNR) references Passenger(PNR)
);

create table Train(
	Train_id int(20) primary key,
    T_name varchar(50) not null,
    Train_type varchar(20) not null,
    Avail_class varchar(50) not null,
    Status_id varchar(20),
    foreign key (Status_id) references Train_Status(Status_id)
);

alter table Passenger add column Status_id varchar(20),
add foreign key (Status_id) references Train_Status(Status_id);

alter table Passenger add column Train_id int(20),
add foreign key (Train_id) references Train(Train_id);


alter table Train_Status add column Train_id int(20),
add foreign key(Train_id) references Train(Train_id);


create table Route(
	Arr_time varchar(8) not null,
    Depart_time varchar(8) not null,
    Stop_no int not null,
    Station_id varchar(20),
    foreign key (Station_id) references Station(Station_id)
);

drop database Railway;