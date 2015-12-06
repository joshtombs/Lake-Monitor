DROP DATABASE LMS_v2;

CREATE DATABASE LMS_v2;

USE LMS_v2;

CREATE TABLE sensors(
	sensor_id   	INT,
	sensor_type		VARCHAR(15),
	update_rate 	INT,
	location        VARCHAR(20),
	PRIMARY KEY (sensor_id)
);

CREATE TABLE sensordata(
	time_recorded 	DATETIME,
	sensor_id       INT,
	value 			FLOAT(5,2),
	PRIMARY KEY (time_recorded, sensor_id),
	FOREIGN KEY (sensor_id) REFERENCES sensors(sensor_id)
);

INSERT INTO sensors VALUES (1, 'wind speed', 15, 'first');
INSERT INTO sensors VALUES (2, 'wind direction', 30, 'second');
INSERT INTO sensors VALUES (3, 'rainfall', 60, 'third');
INSERT INTO sensors VALUES (4, 'water level', 20, 'fourth');
INSERT INTO sensors VALUES (5, 'water temp', 60, 'fifth');
INSERT INTO sensors VALUES (6, 'ambient temp', 20, 'sixth');
INSERT INTO sensors VALUES (7, 'humidity', 60, 'seventh');
INSERT INTO sensors VALUES (8, 'flow rate', 30, 'eighth');
INSERT INTO sensors VALUES (9, 'wind speed', 20, 'ninth');

INSERT INTO sensordata VALUES ('2015-10-31 11:45:24', 1, 30.22);
INSERT INTO sensordata VALUES ('2015-11-2 12:00:24', 1, 32.22);
INSERT INTO sensordata VALUES ('2015-11-3 12:15:24', 1, 31.54);
INSERT INTO sensordata VALUES ('2015-11-4 12:00:24', 2, 32.22);
INSERT INTO sensordata VALUES ('2015-11-4 12:00:25', 1, 35);
INSERT INTO sensordata VALUES ('2015-11-4 12:00:27', 1, 37);
INSERT INTO sensordata VALUES ('2015-11-4 12:02:27', 9, 41);
INSERT INTO sensordata VALUES ('2015-11-4 14:03:09', 3, 21.21);
INSERT INTO sensordata VALUES ('2015-11-4 11:40:34', 4, 45.7);

CREATE TABLE contact (
    first_name 		VARCHAR(30),
    last_name 		VARCHAR(30),
    phone_number 	CHAR(11),
    email 			VARCHAR(40),
    PRIMARY KEY (first_name , last_name)
);
    
CREATE TABLE admin(
	username 		VARCHAR(30),
    password_digest	VARCHAR(60),
	PRIMARY KEY (username));

###Trigger for versions of MySQL later than 5.5
# DELIMITER $$
# CREATE TRIGGER limit_admin 
# BEFORE INSERT
# ON admin
# FOR EACH ROW
# BEGIN
# 	SELECT COUNT(*) INTO @cnt FROM Admin;
# 	IF @cnt > 0 THEN
# 		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "You can not have more than one admin.";
# 	END IF;
# END
# $$
# DELIMITER ;

###Trigger for versions of MySQL earlier than 5.5
DELIMITER $$
CREATE TRIGGER limit_admin 
BEFORE INSERT
ON admin
FOR EACH ROW
BEGIN
	DECLARE dummy INT;
	SELECT COUNT(*) INTO @cnt FROM Admin;
	IF @cnt > 0 THEN
		SELECT 'You can not have more than one admin.'
		INTO dummy
		FROM admin;
	END IF;
END;
$$
DELIMITER ;

INSERT INTO contact VALUES 
	('Jeffrey', 'Magina', 1234567890, 'jmagina@umassd.edu');

INSERT INTO contact VALUES 
	('Joshua', 'Tombs', 987654321, 'jtombs@umassd.edu');

INSERT INTO admin VALUES
	('admin', '$2a$10$bdqXZ8ZdyKO7NP7ERmgEC.ZSkJL16HesTat63QmRTPcPlIXYiOwcK');
