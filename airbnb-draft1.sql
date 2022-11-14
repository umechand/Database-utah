drop table if exists payment;
drop table if exists card_details;
drop table if exists ammenities;
drop table if exists hosts;
drop table if exists review;
drop table if exists reserves;
drop table if exists host_info;
drop table if exists user_profile;
drop table if exists property;

CREATE TABLE user_profile (		
user_id INTEGER NOT NULL,				
username VARCHAR(255) NOT NULL,				
dob DATE,	
email VARCHAR(255),
mobile_number VARCHAR(20) NOT NULL,
PRIMARY KEY(user_id) 
);

 
create table property (
property_id integer,
property_name varchar(255),
address varchar(255),
availability VARCHAR(255), 
property_price money,
occupancy integer,
PRIMARY KEY(property_id)
);

create table reserves (
booking_id INTEGER,
property_id INTEGER,
user_id INTEGER,
start_date DATE,
end_date DATE,
booking_date DATE,
PRIMARY KEY(booking_id),
CONSTRAINT reserves_fkey_user_id FOREIGN KEY (user_id) REFERENCES user_profile (user_id),
CONSTRAINT reserves_fkey_property_id FOREIGN KEY (property_id) REFERENCES property (property_id)
);


create table payment (
payment_id INTEGER,
booking_id INTEGER,
user_id INTEGER,
payment_date date,
payment_price money,
PRIMARY KEY(payment_id),
CONSTRAINT payment_fkey_booking_id FOREIGN KEY (booking_id) REFERENCES reserves (booking_id),
CONSTRAINT payment_fkey_user_id FOREIGN KEY (user_id) REFERENCES user_profile (user_id)
);

create table card_details (
card_number VARCHAR(255),
user_id INTEGER,
expiry_date VARCHAR(20),
bank_name VARCHAR(255),
PRIMARY KEY(card_number),
CONSTRAINT card_details_fkey_user_id FOREIGN KEY (user_id) REFERENCES user_profile (user_id)
);

create table ammenities (
property_id integer,
room_type varchar(255),
ammenities_type varchar(255),
primary key (property_id),
CONSTRAINT ammenities_fkey_user_id FOREIGN KEY (property_id) REFERENCES property (property_id)
);


create table host_info (
host_id integer not null,
host_name varchar(255),
host_language varchar(255),
phone_number varchar(255) not null,
is_super_host varchar(10),
primary key(host_id)
);


create table hosts (
listing_id integer not null,
property_id integer,
host_id integer,
host_date date,
availability_period varchar(255),
primary key(listing_id),
CONSTRAINT hosting_fkey_user_id FOREIGN KEY (property_id) REFERENCES property (property_id),
CONSTRAINT hosting_fkey_host_id FOREIGN KEY (host_id) REFERENCES host_info (host_id)
);


create table review (
review_id integer,
booking_id integer,
user_id integer,
review_rating decimal,
review_title varchar(255),
review_description varchar(512),
posted_date date,
primary key(review_id),
CONSTRAINT review_fkey_booking_id FOREIGN KEY (booking_id) REFERENCES reserves (booking_id),
CONSTRAINT review_fkey_user_id FOREIGN KEY (user_id) REFERENCES user_profile (user_id)
);

INSERT INTO user_profile VALUES (1001,'David Kruger','10-17-1994', 'david.kruger@gmail.com', '206-677-8979');	
INSERT INTO user_profile VALUES (1002,'Stanford Pugsley','06-15-1980', 'stan.pugsley@gmail.com', '123-345-6787');		
INSERT INTO user_profile VALUES (1003,'Braddy Nike','10-17-1994', 'braddy.nike@gmail.com', '321-455-6321');		
INSERT INTO user_profile VALUES (1004,'Lucifer Bells','10-17-2003', 'lucifer.bells@gmail.com', '890-221-3434');		
INSERT INTO user_profile VALUES (1005,'Thomsan Smith','10-17-2001', 'smith.thomsan@gmail.com', '801-565-7345');	
INSERT INTO user_profile VALUES (1006,'Rutherford Barry','10-17-2004', 'barry.rutherford@gmail.com', '277-344-5666');		
INSERT INTO user_profile VALUES (1007,'Curtus Dani','10-17-2006', 'curtus.danithomsan@gmail.com', '608-405-5678');		
INSERT INTO user_profile VALUES (1008,'Shiny Wood','10-17-2001', 'shiny.wood@gmail.com', '104-688-9080');	
INSERT INTO user_profile VALUES (1009,'Kelin Smith','10-17-2002', 'kelin.smith@gmail.com', '201-699-9061');		
INSERT INTO user_profile VALUES (1010,'Wonder Don','10-17-2001', 'don.wonder@gmail.com', '455-282-7643');	

select * from user_profile;

INSERT INTO property values (1011,'The Domes at Canyonlands', 'Monticello, Utah', 'yes', 225, 5);	
INSERT INTO property values (1015,'Dreamy Treehouse', 'Parkcity, Utah', 'yes', 60, 3);
INSERT INTO property values (1020,'Zion EcoCabin', 'Hildale, Utah', 'yes', 200, 4);		
INSERT INTO property values (1003,'Crown Heights Garden Apt', 'Crown Heights, Brooklyn', 'no', 400, 8);	
INSERT INTO property values (1000,'ENJOY Downtown NYC!!', 'Manhattan, East Village', 'yes', 120, 3);	
INSERT INTO property values (1999,'Cliffside Tiny Homes', 'Orderville, Utah', 'no', 500, 10);	
INSERT INTO property values (1200,'Columbia Castle in Brooklyn Heights', 'Brooklyn Heights, Brooklyn', 'yes', 350, 5);	
INSERT INTO property values (1007,'Carriage House on the Stream', 'Sundance, Utah', 'yes', 100, 3);	
INSERT INTO property values (1213,'Historic House Boerum Hill', 'Boerum Hill, Brooklyn', 'no', 300, 4);	
INSERT INTO property values (1314,'The Brooklyn Waverly', 'Clinton Hill, Brooklyn', 'no', 250, 2);

select * from property;


INSERT INTO reserves values (1111, 1015, 1001, '2021-12-04', '2021-12-10', '2021-08-03');	
INSERT INTO reserves values (1234, 1020, 1002, '2021-12-01', '2021-12-05', '2021-09-01');
INSERT INTO reserves values (2222, 1314, 1008, '2022-05-03', '2022-05-08', '2022-04-01');		
INSERT INTO reserves values (2345, 1003, 1004, '2022-03-10', '2022-03-12', '2022-01-08');	
INSERT INTO reserves values (3333, 1999, 1010, '2020-04-04', '2020-04-12', '2020-03-02');	
INSERT INTO reserves values (3456, 1000, 1007, '2019-01-11', '2019-01-15', '2018-09-09');	
INSERT INTO reserves values (4444, 1213, 1009, '2020-10-01', '2020-10-08', '2020-08-01');	
INSERT INTO reserves values (4567, 1007, 1006, '2022-09-11', '2022-09-16', '2022-08-11');	
INSERT INTO reserves values (5555, 1011, 1003, '2018-01-02', '2018-01-04', '2017-09-01');	
INSERT INTO reserves values (5678, 1200, 1005, '2017-03-10', '2017-03-15', '2016-10-04');	

select * from reserves;

INSERT INTO payment VALUES (2345, 1111, 1001, '2021-08-04', 70.99);
INSERT INTO payment VALUES (4567, 1234, 1002, '2021-09-01', 200.99);
INSERT INTO payment VALUES (1234, 2222, 1008, '2022-04-03', 270.99);
INSERT INTO payment VALUES (3456, 2345, 1004, '2022-01-10', 430.99);
INSERT INTO payment VALUES (9087, 3333, 1010, '2020-03-04', 524.99);
INSERT INTO payment VALUES (5678, 3456, 1007, '2018-09-11', 134.99);
INSERT INTO payment VALUES (8765, 4444, 1009, '2020-08-01', 333.99);
INSERT INTO payment VALUES (7098, 4567, 1006, '2022-08-11', 200.99);
INSERT INTO payment VALUES (9845, 5555, 1003, '2017-09-02', 236.99);
INSERT INTO payment VALUES (1077, 5678, 1005, '2016-10-10', 422.99);

select * from payment;

INSERT INTO card_details values ('1313242445455656', 1001, '09-24', 'BOA');
INSERT INTO card_details values ('2345678909875643', 1002, '08-26', 'Zions');
INSERT INTO card_details values ('9078567845231456', 1003, '09-23', 'Wells Fargo');
INSERT INTO card_details values ('5678234590678912', 1004, '12-29', 'Key');
INSERT INTO card_details values ('7623124509005609', 1005, '05-24', 'BOA');
INSERT INTO card_details values ('1245321234443322', 1006, '09-24', 'Zions');
INSERT INTO card_details values ('2156568800235686', 1007, '01-25', 'Wells Fargo');
INSERT INTO card_details values ('7634568911094622', 1008, '09-26', 'Key');
INSERT INTO card_details values ('6589235578097612', 1009, '06-25', 'First');
INSERT INTO card_details values ('4906451133890235', 1010, '03-24', 'Chase');

select * from card_details;

INSERT INTO ammenities values (1011, 'Entire home/apt', 'Swimming pool, BBQ, Pet friendly');
INSERT INTO ammenities values (1015, 'Private room', 'WiFi, Speakers, Pet friendly');
INSERT INTO ammenities values (1020, 'Entire home/apt', 'Theater room, BBQ, Jacuzzi, Game room');
INSERT INTO ammenities values (1003, 'Entire home/apt', 'Swimming pool, Fireplace, Pet friendly');
INSERT INTO ammenities values (1000, 'Private room', 'WiFi, Pet friendly');
INSERT INTO ammenities values (1999, 'Entire home/apt', 'Basketball court, Game room, Theater room');
INSERT INTO ammenities values (1200, 'Entire home/apt', 'Table tennis, Billiards, Jacuzzi');
INSERT INTO ammenities values (1007, 'Entire home/apt', 'BBQ, Swimming pool, Jacuzzi, Theater room');
INSERT INTO ammenities values (1213, 'Entire home/apt', 'Fireplace, Pet friendly');
INSERT INTO ammenities values (1314, 'Private room', 'WiFi, Pet friendly, Fully furnished');

select * from ammenities;


INSERT INTO host_info values (1, 'Henry Bell', 'English, French', '304-444-7890', 'yes');
INSERT INTO host_info values (2, 'Clara Garret', 'English, French, German', '445-345-6789', 'no');
INSERT INTO host_info values (3, 'Henry Cavin', 'English, Spanish', '234-345-5678', 'no');
INSERT INTO host_info values (4, 'Ben Foster', 'Spanish', '211-347-9067', 'yes');
INSERT INTO host_info values (5, 'Michelle Wood', 'French, German', '345-233-8980', 'yes');
INSERT INTO host_info values (6, 'Rose Carey', 'English', '890-444-2345', 'yes');
INSERT INTO host_info values (7, 'Donald Specter', 'English Spanish', '445-345-6889', 'yes');
INSERT INTO host_info values (8, 'Harvey Ross', 'English Chinese', '445-345-5599', 'no');
INSERT INTO host_info values (9, 'Christopher Nolan', 'English, Korean', '374-499-7890', 'yes');
INSERT INTO host_info values (10, 'Emily Donald', 'English, German', '154-546-7521', 'yes');

select * from host_info;


INSERT INTO hosts values (9990, 1011, 1, '2023-01-02', '2022-01-01 - 2023-01-01');
INSERT INTO hosts values (9991, 1003, 2, '2022-03-10', '2022-01-01 - 2023-01-01');
INSERT INTO hosts values (9992, 1015, 3, '2023-12-04', '2023-01-01 - 2024-01-01');
INSERT INTO hosts values (9993, 1020, 4, '2022-12-01', '2022-01-01 - 2023-01-01');
INSERT INTO hosts values (9994, 1000, 5, '2023-01-11', '2023-01-01 - 2024-01-01');
INSERT INTO hosts values (9995, 1200, 6, '2022-03-10', '2022-01-01 - 2023-01-01');
INSERT INTO hosts values (9996, 1999, 7, '2023-04-04', '2023-01-01 - 2024-01-01');
INSERT INTO hosts values (9997, 1007, 8, '2022-09-11', '2022-01-01 - 2023-01-01');
INSERT INTO hosts values (9998, 1213, 9, '2023-10-01', '2023-01-01 - 2024-01-01');
INSERT INTO hosts values (9999, 1314, 10, '2023-05-03', '2023-01-01 - 2024-01-01');

select * from hosts;

INSERT INTO review values (90, 1111, 1001, 4.5, 'Very Good', 'Loved the place', '2022-01-02');
INSERT INTO review values (91, 1234, 1002, 4, 'Good', 'Enjoyed the stay, the tables were big enough', '2022-02-03');
INSERT INTO review values (92, 2222, 1008, 2, 'Bad', 'Disliked the place', '2022-06-05');
INSERT INTO review values (93, 2345, 1004, 4, 'Good', 'A peaceful and calm surrounding', '2022-06-07');
INSERT INTO review values (94, 3333, 1010, 3.5, 'Not Bad', 'Could have maintained better', '2020-08-09');
INSERT INTO review values (95, 3456, 1007, 1, 'Very Bad', 'Very poor maintenance', '2019-10-11');
INSERT INTO review values (96, 4444, 1009, 5, 'Excellent', 'Enjoyed the place and food', '2020-11-12');
INSERT INTO review values (97, 4567, 1006, 4.5, 'Very Good', 'Highly recommended', '2022-10-04');
INSERT INTO review values (98, 5555, 1003, 4, 'Good', 'Had a good stay', '2018-03-06');
INSERT INTO review values (99, 5678, 1005, 3, 'Not Bad', 'Poor food', '2017-08-12');

select * from review;


--- Sample queries run on Airbnb data to verify its working

select username 
from user_profile;

select up.username, r.start_date, r.end_date, p.payment_date, re.review_rating, re.review_title, re.posted_date
from user_profile up
inner join reserves r on up.user_id = r.user_id
inner join payment p on r.user_id = p.user_id
inner join review re on p.user_id = re.user_id;

select u.username, p.property_name, p.address, a.room_type, a.ammenities_type, p.property_price, p.occupancy, r.start_date, r.end_date
from user_profile u
join reserves r on u.user_id = r.user_id
join property p on r.property_id = p.property_id
join ammenities a on p.property_id = a.property_id
where u.user_id = 1002;

select u.username, p.property_name, re.posted_date, re.review_rating, re.review_title, re.review_description
from user_profile u
join review re on u.user_id = re.user_id
join reserves r on re.user_id = r.user_id
join property p on r.property_id = p.property_id
where u.user_id = 1002;

select p.property_id, p.property_name, p.address, re.review_rating
from property p
join reserves r on p.property_id = r.property_id 
join review re on re.user_id = r.user_id
where re.review_rating >= 3;

update property 
set property_name = 'Zions EcoCabin'
where property_id = 1020;

select property_id, property_name, address
from property
where address like '%Uta%h';

alter table property
drop column property_price;

select * from property;





