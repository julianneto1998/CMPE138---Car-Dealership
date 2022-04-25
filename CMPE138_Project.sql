-- SJSU CMPE138 Spring 2022 Team10

drop database dealership;
create database dealership;
use dealership;

create table dealership 
	(
		d_name 		varchar(25) not null,
        d_username  varchar(25) not null,
        d_password	varchar(25) not null,
        d_email		varchar(25) not null,
        d_ssn		char(9) not null,
		dept_name	varchar(20), -- management, sales, service
        primary key (d_ssn, d_username, d_email)
	);
    
create table worker_phones
	(
		worker_ssn		char(9) not null, 
        worker_phone	char(10) not null,
        primary key (worker_ssn, worker_phone), 
        foreign key (worker_ssn) references dealership(ssn)
	);

create table vehicle 
	(
		vehi_cond	varchar(10), -- 'excellent', 'very good', 'good', 'fair',
        price		numeric(10,2) check (price > 0),
        vin			numeric(17),
        size		varchar(10), -- 'coupe', 'sedan', 'crossover, 'suv', 'truck'
        make		varchar(10) not null,
        model		varchar(10),
        color		varchar(10),
        year		numeric(4),
        primary key (vin)
	);
    
create table vehicle_color
	(
		vin			numeric(17), 
        color		varchar(10),
        primary key (vin, color),
        foreign key (vin) references vehicle(vin)
	);

create table customer 
	(
		c_name		varchar(25) not null,
		c_username	varchar(9) not null,
        c_password	varchar(25) not null,
        c_email		varchar(20) not null,
		primary key (c_username,c_email)
	);
    
create table customer_phones
	(
		customer_name 	varchar(25) not null,
        phone			char(10) not null,
        primary key (customer_name, phone),
        foreign key (customer_name) references customer(c_username)
	);

create table manager 
	(
		m_ssn		char(9) not null,
		dept_manage	varchar (20), -- management, sales, service
        primary key (m_ssn),
        foreign key (m_ssn) references dealership(ssn)
	);

create table salesperson 
	(
		s_ssn		char(9) not null,
		s_manager	char(25) not null,
        primary key (s_ssn),
        foreign key (s_ssn) references dealership(d_ssn), 
        foreign key (s_manager) references manager(m_ssn)
	);

create table service_advisor 
	(
		a_ssn		char(9) not null,
		a_manager	char(25) not null,
        primary key (a_ssn),
		foreign key (a_ssn) references dealership(d_ssn),
        foreign key (a_manager) references manager(m_ssn)
	);

create table sales_contract 
	(
		sale_id		varchar(10),
		vin			numeric(17),
		sale_price	numeric(10,2) check (sale_price > 0),
		sale_date	DATE,
		seller		varchar(25),
        customer	varchar(25),
		primary key (sale_id, vin),
        foreign key (vin) references vehicle(vin),
        foreign key (seller) references salesperson(s_ssn),
        foreign key (customer) references customer(c_username)
	);

create table service_contract 
	(
		sdate		DATE,
		sprice		numeric(10,2) check (sprice > 0),
		service_id	varchar(10),
        customer	varchar(25),
        vin			numeric(17),
        servicer	varchar(25),
		primary key (service_id),
        foreign key (customer) references customer(c_username),
        foreign key (vin) references vehicle(vin), 
        foreign key (servicer) references service_advisor(a_ssn)
	);

INSERT dealership VALUES
('', '', '', ''),
('', '', '', ''),
('', '', '', '');

INSERT vehicle VALUES
('fair', 3230,'JH4KA7670MC006807','Coupe','Acura','CL','Red', 1999),
('very good',12150,'WBAKA8C54BL446873','Sedan', 'BMW','750i','Blue', 2011),
('excellent', 26400,'1HGCM66533AO93328','SUV','Honda','CR-V','Black', 2021),
('very good', 17000,'1C4NJPBA1CD661292','Truck','Toyota','Tacoma','White', 2012),
('excellent', 11000,'WBAKA8C54BL446873','Sedan','Lexus','IS250','White', 2007),
('good', 26700,'5UXFB33512LH31861','Crossover','BMW','X5','Gray', 2018),
('fair', 3450,'JN1CA31D3YT717809','Sedan','Nissan','Maxima','Red', 2000),
('good', 15500,'JH2TE181XDK201469','SUV','Honda','Pilot','Blue', 2013);

INSERT service_contract VALUES
('Lennie Thornton', '279-15-4236', '(415)-358-7304', 'sales_contract'),
('Melva Coleman', '326-11-9556', '(650)-720-6382', 'service_contract'),
('Winnie Davidson', '479-41-7622', '(951)-947-1456', 'sales_contract'),
('Ray Goodwin', '367-37-9066', '(820)-545-8305', 'service_contract');

INSERT manager VALUES 
('Mark Norman', '870-07-6968', '(600) 910-8471', 'worker'),
('Lee Young', '989-68-3918', '(515) 419-7440', 'service_advisor'),
('Vivan Parks', '798-86-9855', '(550) 257-7950', 'salesperson');

INSERT salesperson VALUES
('Crystal Chau', '746-35-4525', '(604) 384-2802', 'Vivian Parks'),
('John Brown', '041-79-6904', '(448) 989-4389', 'Vivian Parks'),
('Tiffany Jones', '831-46-1798 ', '(258) 581-2619', 'Vivian Parks');

INSERT service_advisor VALUES
('Robin Smith', '470-21-8049', '(690) 219-0624', 'Lee Young'),
('Mariele Davis', '550-12-2380', '(383) 267-3179', 'Lee Young'),
('Jerome Miller', '305-81-3508', '(910) 470-1791', 'Lee Young');

INSERT sales_contract VALUES
('8224768050', 'JH4KA7670MC006807', '3230', '2022-09-23', 'Crystal Chau'),
('210171610', 'WBAKA8C54BL446873', '12150', '2022-07-13', 'John Brown'),
('4607967080', '1HGCM66533AO93328', '26400', '2022-06-18', 'Tiffany Jones'),
('477153812', '1C4NJPBA1CD661292', '17000', '2020-10-22', 'John Brown'),
('5056461840', 'WBAKA8C54BL446873', '11000', '2019-06-19', 'Crystal Chau'),
('3071871773', '5UXFB33512LH31861', '26700', '2022-07-19', 'John Brown'),
('1251889570', 'JN1CA31D3YT717809', '3450', '2020-10-22', 'Crystal Chau'),
('2050218631', 'JH2TE181XDK201469', '15500', '2022-07-13', 'Tiffany Jones');

INSERT service_contract VALUES
('2019-06-01', '643', '9282127590'),
('2020-01-26', '1743', '3658127973'),
('2021-07-11', '590', '6061710903'),
('2022-04-24', '1049', '7431545525');
