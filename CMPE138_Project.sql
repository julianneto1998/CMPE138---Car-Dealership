-- SJSU CMPE138 Spring 2022 Team10

drop database dealership;
create database dealership;
use dealership;

create table dealership_worker 
	(
	d_name 		varchar(25) not null,
        d_username  	varchar(25) not null,
        d_password	varchar(25) not null,
        d_email		varchar(25) not null,
        d_ssn		char(9) not null,
	dept_name	varchar(20), -- management, sales, service
        primary key (d_ssn, d_username, d_email)
	);
    
create table worker_phones
	(
	worker_ssn	char(9) not null, 
        worker_phone	varchar(14) not null,
        primary key (worker_ssn, worker_phone), 
        foreign key (worker_ssn) references dealership(ssn)
	);

create table vehicle 
	(
	vin		char(17) not null,
	vehi_cond	varchar(10), -- 'excellent', 'very good', 'good', 'fair',
        price		numeric(10,2) check (price > 0),
        size		varchar(10), -- 'coupe', 'sedan', 'crossover, 'suv', 'truck'
        make		varchar(10) not null,
        model		varchar(10) not null,
        year		YEAR,
        primary key (vin)
	);
    
create table vehicle_color
	(
	vin		char(17) not null, 
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
        phone			varchar(14) not null,
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
	sale_id		varchar(5),
	vin		numeric(17),
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
	service_id	varchar(5),
        customer	varchar(25),
        vin			numeric(17),
        servicer	varchar(25),
	primary key (service_id),
        foreign key (customer) references customer(c_username),
        foreign key (vin) references vehicle(vin), 
        foreign key (servicer) references service_advisor(a_ssn)
	);

INSERT dealership_worker VALUES
('Mark Norman', 'mnorman', 'bone43with2055', 'mnorman@cars.com', '870076968', 'management'),																			
('Lee Young	lyoung', '1384speak29school', 'lyoung@cars.com', '989683918', 'management'),																				
('Vivan Parks',	'vparks', '9367helpsilver8', 'vparks@cars.com', '798869855', 'management'),
('Robin Smith',	'rsmith', 'whereand777831',	'rsmith@cars.com', '470218049','sales'),
('Mariele Davis', 'mdavis', '71bad9063decimal',	'mdavis@cars.com', '550122380', 'sales'),																			
('Jerome Miller', 'jmiller', 'shoutpiece223044', 'jmiller@cars.com', '305813508',	'sales'),																				
('Crystal Chau', 'cchau',	'583operateremote74', 'cchau@cars.com', '746354525', 'service'),																				
('John Brown',	'jbrown',	'36arrangepath7844', 'jbrown@cars.com',	'041796904', 'service'),																				
('Tiffany Jones', 'tjones','3956lady2open', 'tjones@cars.com', '831-461798', 'service');																											

INSERT worker_phones VALUES
('870-07-6968',	'(510) 849-2220'),
('870-07-6968',	'(510) 919-0135'),
('989-68-3918',	'(515) 419-7440'),
('989-68-3918',	'(510) 849-2221'),
('798-86-9855',	'(550) 257-7950'),
('798-86-9855',	'(510) 849-2222'),
('470-21-8049',	'(690) 219-0624'),
('550-12-2380',	'(383) 267-3179'),
('305-81-3508',	'(910) 470-1791'),
('746-35-4525',	'(604) 384-2802'),
('041-79-6904',	'(448) 989-4389'),
('831-46-1798', '(258) 581-2619');

INSERT vehicle VALUES
('JH4KA7670MC006807', 'fair',	'3230',	'Coupe', 'Acura', 'CL', 1999),																	
('WBAKA8C54BL446873', 'very good',	'12150', 'Sedan', 'BMW', '750i', 2011),																			
('1HGCM66533AO93328', 'excellent',	'26400', 'SUV',	'Honda', 'CR-V', 2021),																			
('1C4NJPBA1CD661292', 'very good',	'17000', 'Truck', 'Toyota', 'Tacoma', 2012),																			
('WBAKA8C54BL446873', 'excellent',	'11000', 'Sedan', 'Lexus', 'IS250',	2007),																			
('5UXFB33512LH31861', 'good', '26700','Crossover','BMW', 'X5',2018),																			
('JN1CA31D3YT717809', 'fair', '3450', 'Sedan', 'Nissan', 'Maxima', 2000),																			
('JH2TE181XDK201469', 'good', '15500','SUV','Honda','Pilot',2013),																			
('ZAMBC38A450014565', NULL,	NULL, 'Sedan', 'Toyota', 'Camry', 2011),																			
('JH4KA4561JC021254', NULL,	NULL, 'SUV', 'Jeep', 'Grand Cherokee',2018),																			
('1J4GZ58S9VC710649', NULL,	NULL, 'Sedan',	'Audi',	'A6', 2015),																			
('WAUHGAFC6DN030356', NULL,	NULL, 'Sedan',	'Ford',	'Mustang',	2020);																			

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
