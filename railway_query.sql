create database Railway_Management6;
use Railway_Management6;

drop database Railway_Management6;
--------------------------------------------------------------------------------------------------------------
create table user(
	user_id varchar(20) primary key,
    password varchar(20) not null,
    name varchar(50) not null,
    age int not null,
    gender varchar(10) not null,
    adthar_no bigint not null,
    mobile_no bigint not null,
    address varchar(100)not null
);


insert into user values('vaishnavi','vaishnavi@123','Vaishnavi Mishra',21,'female',626364656667,7748991496,'sohas satna mp');
insert into user values('varsha','varsha@1234','Varsha Mishra',25,'female',626364656668,9926916063,'sohas satna mp');
insert into user values('arpita','arpita@12345','Arpita Pandey',18,'female',626364656669,9691010721,'sohas satna mp');    
insert into user values('hemant','hemantpr88@gmail.com','Hemant Prajapati',18,'Male',875461391110,8827432140,'Singrauli MP');
-----------------------------------------------------------------------------------------------------------------------

create table train(
	train_id bigint primary key,
	train_name varchar(100) not null,
	number_of_coaches int
);

insert into train values(11703,'Dr. Ambedkar Nager Express',25);
insert into train values(12185,'Rewanchal Express',23);

--------------------------------------------------------------------------------------------------------------------------

create table cancelled_train(
    train_id bigint not null ,
    cancel_date date not null,
    cancel_day varchar(15) not null,
    foreign key (train_id) references train(train_id)
    
);

INSERT INTO cancelled_train values(12185,'2023-06-11','Sunday');

-------------------------------------------------------------------------------------------------------------------------

create table station(
   station_id int primary key auto_increment,
   station_name varchar(100) not null,
   station_code varchar(20) not null
);
   
   
   insert into station (station_name,station_code) values('Rewa','REWA');
   insert into station (station_name,station_code) values('Indore Juction','INDB');
   insert into station (station_name,station_code) values('Bhopal Juction','BPL');
   insert into station (station_name,station_code) values('Jabalpur Juction','JBP');
   insert into station (station_name,station_code) values('Katni Juction','KTE');
   
------------------------------------------------------------------------------------------------------------------------------

create table station_schedule(
	train_id bigint not null,
    station_id int not null,
    platfrom_no int not null,
	days varchar(100) not null,
    arrival_time time not null,
    departure_time time not null,
    FOREIGN KEY (train_id) REFERENCES train(train_id),
	FOREIGN KEY (station_id) REFERENCES station(station_id)
);

insert into station_schedule values(12185,1,2,' Sunday Monday Tuesday Wednsday Thursday Friday Saturday ','08:00:00','08:30:00');
insert into station_schedule values(12185,3,4,' Sunday Monday Tuesday Wednsday Thursday Friday Saturday ','19:15:00','21:15:00');
insert into station_schedule values(12185,5,3,' Sunday Monday Tuesday Wednsday Thursday Friday Saturday ','11:00:00','11:15:00');
insert into station_schedule values(12185,5,3,' Sunday Monday Tuesday Wednsday Thursday Friday Saturday ','04:00:00','04:15:00');

-------------------------------------------------------------------------------------------------------------------------------

create table route(
	route_id int primary key not null,
    distance_km decimal not null,
    total_stop int not null,
    first_end int not null,
    second_end int not null,
    foreign key (first_end) references station(station_id),
    foreign key (second_end) references station(station_id)    
);
 
insert into route  values(1,550,10,3,1);
insert into route  values(2,800,12,2,1);

-------------------------------------------------------------------------------------------------------------------------------------
-- constant data
create table coach_type(
	coach_id int primary key auto_increment ,
    coach_name varchar(50) not null,
    coach_code varchar(10) not null unique
); 
   
insert into coach_type(coach_name,coach_code) values("Sleeper",'SL');
insert into coach_type(coach_name,coach_code) values("General",'GEN');
insert into coach_type(coach_name,coach_code) values("2 Seater",'2S');
insert into coach_type(coach_name,coach_code) values("1st Ac",'1A');
insert into coach_type(coach_name,coach_code) values("2nd Ac",'2A');
insert into coach_type(coach_name,coach_code) values("3rd Ac",'3A');
insert into coach_type(coach_name,coach_code) values("Economy",'3E');
insert into coach_type(coach_name,coach_code) values("Anubhuti",'EA');
insert into coach_type(coach_name,coach_code) values("Executive Chair",'EC');
insert into coach_type(coach_name,coach_code) values("Chair Car",'CC');
insert into coach_type(coach_name,coach_code) values('Saloon','Saloon');
insert into coach_type(coach_name,coach_code) values('Vistadome','Vistadome');

-----------------------------------------------------------------------------------------------------------------------------------------
-- constant data
create table quota(
	quota_id int primary key auto_increment,
    quota_name varchar(50) not null
 );
 
insert into quota(quota_name) values('General');
insert into quota(quota_name) values('Ladies');
insert into quota(quota_name) values('Tatkal');
insert into quota(quota_name) values('Sr. Citizen');
insert into quota(quota_name) values('Premium Tatkal');
insert into quota(quota_name) values('Person With Disability');
  
 --------------------------------------------------------------------------------------------------------------------------
 
 create table fare(
	 fare_amount decimal not null,
     route_id int not null,
     source_station_id int not null,
	 destination_station_id int not null,
     train_id bigint not null,
     quota_id int not null,
     coach_id int not null,
     same_reverse boolean not null,
     foreign key (route_id) references route(route_id),
     foreign key (source_station_id) references station(station_id),
     foreign key (destination_station_id ) references station(station_id),
     foreign key (train_id) references train(train_id),
     foreign key (quota_id) references quota(quota_id),
     foreign key (coach_id) references coach_type(coach_id)
);

insert into fare values(500,1,1,3,12185,1,1,1);
insert into fare values(200,1,1,5,12185,1,1,1);
insert into fare values(300,1,5,3,12185,1,1,1);

---------------------------------------------------------------------------------------------------------------

create table seat_availability(
	train_id bigint not null,
    date date not null,
    quota_id int not null,
    sl_avi_seats int not null,
    sl_booked_seats int not null,
    gen_avi_seats int not null,
    gen_booked_seats int not null,
    2s_avi_seats int not null,
    2s_booked_seats int not null,
    1al_avi_seats int not null,
    1al_booked_seats int not null,
    2a_avi_seats int not null,
    2a_booked_seats int not null,
    3a_avi_seats int not null,
    3a_booked_seats int not null,
    3e_avi_seats int not null,
    3e_booked_seats int not null,
    ea_avi_seats INT not null,
	ea_booked_seats INT not null,
	ec_avi_seats INT not null,
	ec_booked_seats INT not null,
	cc_avi_seats int not null,
    cc_booked_seats int not null,
    saloon_avi_seats INT not null,
	saloon_booked_seats INT not null,
	vistadome_avi_seats INT not null,
	Vistadome_booked_seats INT not null,
	foreign key( train_id) references train(train_id),
    foreign key( quota_id) references quota(quota_id)
);

insert into seat_availability values(12185,'2023-06-11',1,30,300,20,200,50,150,5,50,15,60,30,100,2,20,5,25,2,10,1,20,1,30,2,20);

------------------------------------------------------------------------------------------------------------------------------------

create table birth_type(
	birth_id int primary key auto_increment,
    birth_type_name varchar(40) not null,
    birth_code varchar(3) not null unique
);

insert into birth_type (birth_type_name,birth_code) values('Lower Birth','LB');
insert into birth_type (birth_type_name,birth_code) values('Middle Birth','MB');
insert into birth_type (birth_type_name,birth_code) values('Upper Birth','UB');
insert into birth_type (birth_type_name,birth_code) values('Side Lower','SL');
insert into birth_type (birth_type_name,birth_code) values('Side Middle','SM');
insert into birth_type (birth_type_name,birth_code) values('Side Upper','SU');

------------------------------------------------------------------------------------------------------------------------------------
create table passenger(
	passenger_id int primary key ,
    user_id varchar(20) not null  ,
    passenger_name varchar(100) not null,
    adthar_number bigint not null unique,
    mobile_number bigint not null,
    email_id varchar(50),
    passenger_age int not null,
    gender varchar(15) not null,
    nationality varchar(20),
    preference_coach_id int not null,
    preference_birth_id int not null,
    preference_coach_number varchar(10),
    foreign key(user_id) references user(user_id),
    foreign key(preference_coach_id) references coach_type(coach_id),
    foreign key(preference_birth_id) references birth_type(birth_id)
);


insert into passenger values(1,'vaishnavi','Vaishnavi Mishra',626364656667,7748999912,'mishra123@gmail.com',21,'female','india',1,2,'S7');
insert into passenger values(2,'varsha','Varsha Mishra',626364656668,7748999913,'mishra1234@gmail.com',25,'female','india',1,2,'S7');
insert into passenger values(3,'vaishnavi','Ramlakhan Pandey',626364656669,7748969812,'pandey123@gmail.com',61,'male','india',1,1,'S6');
insert into passenger values(4,'vaishnavi','Hemant Prajapati',626364656632,7748929911,'prajapati@gmail.com',18,'male','india',1,2,'S5');
-----------------------------------------------------------------------------------------------------
   
   
create table train_schedule(
	schedule_id int primary key,
    train_id bigint not null,
    source_id int not null,
    destination_id int  not null,
    departure_day varchar(100) not null,
    arrival_day varchar(100) not null,
    departure_time time not null,
    arrival_time time not null,
    route_id int not null,
    foreign key( destination_id) references station(station_id),
    foreign key( train_id) references train(train_id),
	foreign key( source_id) references station(station_id),
	foreign key (route_id) references route(route_id)
);

insert into train_schedule values(1,12185,1,3,' Sunday Monday Tuesday Wednsday Thursday Friday Saturday ',' Sunday Monday Tuesday Wednsday Thursday Friday Saturday ','08:30:00','19:15:00',1);

-------------------------------------------------------------------------------------------------------------------------
create table booking(
	booking_id int primary key ,
    user_id varchar(50) not null,
    train_id bigint not null,
    booking_date date not null,
    booking_time time not null,
    journey_date date not null,
    no_of_passenger int not null,
    quota_id int not null,
    source_id int not null,
    destination_id int not null,
    travel_ansurance boolean not null,
    auto_upgrade boolean not null,
    passenger_id1 int not null,
    passenger_id2 int ,
    passenger_id3 int ,
    passenger_id4 int ,
    passenger_id5 int ,
    passenger_id6 int ,
    foreign key( user_id) references user(user_id),
    foreign key( train_id) references train(train_id),
    foreign key( quota_id) references quota(quota_id),
    foreign key( source_id) references station(station_id),
    foreign key( destination_id) references station(station_id),
    foreign key( passenger_id1) references passenger(passenger_id),
	foreign key( passenger_id2) references passenger(passenger_id),
    foreign key( passenger_id3) references passenger(passenger_id),
    foreign key( passenger_id4) references passenger(passenger_id),
    foreign key( passenger_id5) references passenger(passenger_id),			
    foreign key( passenger_id6) references passenger(passenger_id)
);

insert into booking (booking_id,user_id,train_id,booking_date,booking_time,journey_date,no_of_passenger,quota_id,source_id,destination_id,travel_ansurance,auto_upgrade,passenger_id1)
values(1,'vaishnavi',12185,'2023-06-11','22:50:00','2023-06-12',1,1,1,3,1,0,1);

insert into booking (booking_id,user_id,train_id,booking_date,booking_time,journey_date,no_of_passenger,quota_id,source_id,destination_id,travel_ansurance,auto_upgrade,passenger_id1)
values(2,'vaishnavi',12185,'2023-06-11','22:50:00','2023-06-12',1,1,1,3,1,0,3);

------------------------------------------------------------------------------------------------------

create table payment(
   payment_id int primary key,
   booking_id int not null,
   tiket_fare decimal not null,
   gst decimal not null,
   insurance_charge decimal not null,
   irctc_cov_fees decimal not null,
   payment_method varchar(255) not null,
   transaction_id varchar(255) ,
   total_amount decimal not null,
   foreign key( booking_id) references booking(booking_id)
);
   
insert into payment values(111213,1,500,20,.50,15,'online','23PAY01BOB001',535.50); 
insert into payment values(111214,2,500,20,.50,15,'online','23PAY01BOB002',535.50); 
   
--------------------------------------------------------------------------------------------------------------------------
-- constant data
create table ticket_status_type(
	status_id int primary key auto_increment,
    status_type varchar(10) not null
);

insert into ticket_status_type(status_type) values('GNWL');
insert into ticket_status_type(status_type) values('PQWL');
insert into ticket_status_type(status_type) values('RAC');
insert into ticket_status_type(status_type) values('CNF');
insert into ticket_status_type(status_type) values('RLWL');

---------------------------------------------------------------------------------------------    

create table ticket(
    pnr bigint not null,
    booking_id int not null,
    passenger_id int not null,
    coach_id int not null,
    coach_number varchar(10),
    birth_number int not null,
    birth_id int not null,
    status_id int not null,
    payment_id int not null,
    primary key(pnr,passenger_id),
     foreign key( coach_id) references coach_type(coach_id),
     foreign key( booking_id) references booking(booking_id),
      foreign key( passenger_id) references passenger(passenger_id),
	 foreign key( status_id) references ticket_status_type(status_id),
     foreign key( birth_id) references birth_type(birth_id),
     foreign key( payment_id) references payment(payment_id)
);

insert into ticket values(231101,1,1,1,'S7',23,2,4,111213);
insert into ticket values(231101,1,3,1,'S7',24,2,4,111214);
    
----------------------------------------------------------------------------------------------------

create table cancelled_ticket(
	pnr bigint not null,
    passenger_id int not null,
    cancel_date date not null,
    cancel_time time not null,
    refund_status  varchar(20) not null,
    refund_amount decimal ,
    primary key(pnr,passenger_id),
    foreign key (pnr) references ticket(pnr),
    foreign key(passenger_id) references passenger(passenger_id)
);
insert into  cancelled_ticket values(231101,3,'2023-06-11','23:44:00','done',400);

------------------------------------------------------------------------------------------------

create table insurance_detail(
	policy_number bigint primary key,
    pnr bigint not null,
    passenger_id int not null,
    cover_amount bigint not null,
    policy_amount bigint not null,
    nominee_name varchar(50) not null,
    nominee_aadhar bigint not null,
    unique(pnr,passenger_id),
	foreign key (pnr) references ticket(pnr),
	foreign key (passenger_id) references passenger(passenger_id) 
);

insert into insurance_detail values(2301,231101,1,500000,0.50,'Rajkishore Mishra',884356129834);
insert into insurance_detail values(2302,231101,3,500000,0.50,'Rajkishore Mishra',127890342378);

-----------------------------------------------------------------------------------------------------
-- constant data
create table tdr_reason(
	reason_id int primary key auto_increment,
    reason varchar(500) not null
);

insert into tdr_reason(reason) values('Train Late More Than Three Hours and Passenger Not Traveled.');
insert into tdr_reason(reason) values('AC Failure.');
insert into tdr_reason(reason) values('After Charting No Room Provided.');
insert into tdr_reason(reason) values('Change In Reservation Status From Confirmed To Wait listed/Part Wait listed/RAC After Chart Preparation.');
insert into tdr_reason(reason) values('Difference Of Fare As Passenger Traveled In Lower Class.');
insert into tdr_reason(reason) values('Difference Of Fare In Case proper Coach Not Attached.');
insert into tdr_reason(reason) values('Party Could Not Cancel Because Chart Prepared At Originating Or Previous Remote Location.');
insert into tdr_reason(reason) values('Party Partially Confirmed/Wait listed And All Passengers Did Not Travel.');
insert into tdr_reason(reason) values('Party Partially Confirmed/Wait listed And Wait listed Passengers Did Not Travel.');
insert into tdr_reason(reason) values('Party Partially Traveled (Journey terminated short of destination).');
insert into tdr_reason(reason) values('Passenger Not Traveled As Reservation Provided In Lower Class.');
insert into tdr_reason(reason) values('Passenger Not Traveled Due To Ticket In RAC After Chart Preparation.');
insert into tdr_reason(reason) values('Passenger Not Traveled.');
insert into tdr_reason(reason) values('Train Canceled.');
insert into tdr_reason(reason) values('Train Diverted And Train Not Touching Boarding Station.');
insert into tdr_reason(reason) values('Train Diverted And Train Not Touching Destination Station.');
insert into tdr_reason(reason) values('Train Missed As Connecting Train Was Late.');
insert into tdr_reason(reason) values('Train Terminated Short Of Destination.');
insert into tdr_reason(reason) values('Traveled Without Proper ID Proof.');
insert into tdr_reason(reason) values('Wrongly Charged BY TTE.');

-----------------------------------------------------------------------------------------------------

create table tdr_file(
	tdr_request_id int primary key auto_increment,
    pnr bigint not null,
    passenger_id int not null,
    reason_id int not null,
    unique(pnr,passenger_id),
    foreign key(passenger_id) references passenger(passenger_id),
    foreign key (pnr) references ticket(pnr),
    foreign key (reason_id) references tdr_reason(reason_id)
);

insert into tdr_file (pnr,passenger_id,reason_id) values(231101,3,1);

---------------------------------------------------------------------------------------------------

create table tdr(
	 tdr_number varchar(50) primary key,
	 tdr_request_id int not null,
     refund_status varchar(50) not null,
     refund_amount decimal,
	 foreign key (tdr_request_id) references tdr_file(tdr_request_id)	
);


insert into tdr values('23tdr0601',1,'Pending',null);

---------------------------------------------------------------------------------------------------------------------------

create table station_on_route(
	route_id int not null,
    station_id int not null,
    primary key(route_id,station_id),
    foreign key (route_id) references route(route_id),
    foreign key(station_id) references station(station_id)
);

insert into station_on_route values(1,1);
insert into station_on_route values(1,5);
insert into station_on_route values(1,3);
insert into station_on_route values(2,1);
insert into station_on_route values(2,2);
insert into station_on_route values(2,3);

-----------------------------------------------------------------------------------------------------

-- showing all stations on a root
 select * from station join station_on_route on station.station_id=station_on_route.station_id where route_id=1;   
 select * from station join station_on_route on station.station_id=station_on_route.station_id where route_id=2;
 
-- showing passenger names that are ends with a
 select passenger_name from passenger where passenger_name like '%a';
 
 
-- showing all tickets
select * from ticket;
 
-- showing train details from pnr number
select * from train where train_id = (select train_id from booking where booking_id = (select booking_id from ticket where pnr = 231101));

-- showing train schedule by using pnr
select * from train_schedule where train_id = (select train_id from booking where booking_id = (select booking_id from ticket where pnr = 231101));

-- showing all trains schedule
select * from train_schedule;
select * from train_schedule where train_id = 12185;


-- showing all stations
select * from station;

-- showing traind availibility
select departure_time from train_schedule where train_id = 12185 and source_id = (select station_id from station where station_code ='REWA') and destination_id = (select station_id from station where station_code ='BPL') and departure_day like '%Monday%'

