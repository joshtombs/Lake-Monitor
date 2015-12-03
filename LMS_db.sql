DROP DATABASE LMS;

CREATE DATABASE LMS;

USE LMS;

/*CREATE TABLE t_Sensor_Metadata(
	Sensor_ID		int,
    Name 			varchar(30),
    Manufacturer 	varchar(30),
    Accuracy 		float(5,2),
    Units			varchar(30),
    Min_value 		float(4,2),
    Max_value 		float(4,2),
    Description		blob,
    PRIMARY KEY (Sensor_ID));*/

CREATE TABLE t_Sensor_Data(
	time_recorded 	datetime,
    #Sensor_ID		int,
	wind_speed 		float(4,2),
	wind_direction 	int,
	rainfall 		float(4,2), 
	water_level 	float(4,2),
	water_temp 		float(5,2), 
	ambient_temp 	float(5,2), 
	humidity 		int, 
	flow_rate 		float(4,2), 
		PRIMARY KEY (Time_Recorded));/*,
		FOREIGN KEY (Sensor_ID)
			REFERENCES t_Sensor_Metadata(Sensor_ID));*/
		
CREATE TABLE t_Contact_Info (
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    phone_number CHAR(11),
    email VARCHAR(40),
    #admin TINYINT(1),
    PRIMARY KEY (First_Name , Last_Name)
);
    
/*CREATE TABLE t_Contact_Conditions(
	First_Name 			varchar(30), 
	Last_Name 			varchar(30),
	Max_Wind_Speed 		float(4,2), 
	Max_Rainfall 		float(4,2), 
	Max_Water_Level 	float(4,2), 
	Max_Water_Temp 		float(5,2), 
	Max_Ambient_Temp 	float(5,2), 
	Max_Humidity 		int, 
	Max_Flow_Rate 		float(4,2), 
    FOREIGN KEY (First_Name,Last_Name)
		REFERENCES t_Contact_Info(First_Name, Last_Name));*/
    
/*CREATE TABLE t_Admin_Info(
	First_Name 	varchar(30),
    Last_Name	varchar(30),
	Username 	varchar(20),
    Password 	varchar(20),
    PRIMARY KEY (username),
	FOREIGN KEY (First_Name,Last_Name)
		REFERENCES t_Contact_Info(First_Name, Last_Name, Admin));*/

INSERT INTO t_Sensor_Data Values
	('2015-10-31 11:45:24', 30.22, 1, 5.2, 22, 69, 55, 10, 5);

INSERT INTO t_Sensor_Data Values
	('2015-11-2 1:23:45', 1.333, 8, 2.444, 22.567, 80.4321, 41.1324, 40, 10.314);
INSERT INTO t_Sensor_Data Values
	('2015-11-3 11:23:45', 1.444, 7, 1.444, 12.567, 81.4321, 43.1324, 20, 5.314);
INSERT INTO t_Sensor_Data Values
	('2015-11-4 2:23:45', 1.555, 9, 3.444, 14.567, 82.4321, 47.1324, 11, 6.314);

INSERT INTO t_Contact_Info Values 
	('Jeffrey', 'Magina', 1234567890, 'jmagina@umassd.edu');

INSERT INTO t_Contact_Info Values 
	('Joshua', 'Tombs', 987654321, 'jtombs@umassd.edu');
    
/*INSERT INTO t_Sensor_Data Values
	( '2015-11-4 1:25:45', 120, 30, 5.2, 22, 69, 55, 10, 5);

