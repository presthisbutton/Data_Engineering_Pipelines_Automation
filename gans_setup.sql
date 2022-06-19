CREATE DATABASE gans;
USE gans;


# Setting up cities table
# Alter table's datatypes of the columns and set primary key
ALTER TABLE `gans`.`cities` 
CHANGE COLUMN `city_id` `city_id` VARCHAR(10) NOT NULL,
CHANGE COLUMN `city` `city` VARCHAR(100) NULL DEFAULT NULL,
CHANGE COLUMN `country` `country` VARCHAR(100) NULL DEFAULT NULL,
CHANGE COLUMN `country_code` `country_code` VARCHAR(5) NULL DEFAULT NULL,
CHANGE COLUMN `region` `region` VARCHAR(100) NULL DEFAULT NULL,
CHANGE COLUMN `elevation` `elevation` INT NULL DEFAULT NULL,
ADD PRIMARY KEY (`city_id`);

DESCRIBE cities;


# Setting up weather table
# Before altering datatypes and setting key, weather has duplicate forecast_time values, therefore 
# a new ID column with unique values is necessary for the primary key
ALTER TABLE weather 
ADD weather_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;

# Alter table's datatypes of the columns and set primary key:
ALTER TABLE `gans`.`weather` 
CHANGE COLUMN `precip_prob` `precip_prob` FLOAT NULL DEFAULT NULL,
CHANGE COLUMN `forecast_time` `forecast_time` DATETIME NULL DEFAULT NULL,
CHANGE COLUMN `temperature` `temperature` FLOAT NULL DEFAULT NULL,
CHANGE COLUMN `feels_like` `feels_like` FLOAT NULL DEFAULT NULL,
CHANGE COLUMN `humidity` `humidity` INT NULL DEFAULT NULL,
CHANGE COLUMN `cloudiness` `cloudiness` INT NULL DEFAULT NULL,
CHANGE COLUMN `wind_speed` `wind_speed` FLOAT NULL DEFAULT NULL,
CHANGE COLUMN `wind_gust` `wind_gust` FLOAT NULL DEFAULT NULL,
CHANGE COLUMN `city` `city` VARCHAR(100) NULL DEFAULT NULL,
CHANGE COLUMN `city_id` `city_id` VARCHAR(10) NULL DEFAULT NULL;

# Setting foreign key:
ALTER TABLE `gans`.`weather` 
ADD INDEX `weather_city_id_idx` (`city_id` ASC) VISIBLE;
ALTER TABLE `gans`.`weather` 
ADD CONSTRAINT `weather_city_id`
FOREIGN KEY (`city_id`)
REFERENCES `gans`.`cities` (`city_id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

DESCRIBE weather;


# Setting up airports table
# Alter table's datatypes of the columns and set primary key
ALTER TABLE `gans`.`airports` 
CHANGE COLUMN `icao` `icao` CHAR(4) NOT NULL,
CHANGE COLUMN `iata` `iata` CHAR(3) NULL DEFAULT NULL,
CHANGE COLUMN `airport_name` `airport_name` VARCHAR(100) NULL DEFAULT NULL,
CHANGE COLUMN `municipality_name` `municipality_name` VARCHAR(100) NULL DEFAULT NULL,
CHANGE COLUMN `country_code` `country_code` VARCHAR(5) NULL DEFAULT NULL,
CHANGE COLUMN `city_id` `city_id` VARCHAR(10) NULL DEFAULT NULL,
ADD PRIMARY KEY (`icao`);

# Setting foreign key:
ALTER TABLE `gans`.`airports` 
ADD INDEX `airports_city_id_idx` (`city_id` ASC) VISIBLE;
ALTER TABLE `gans`.`airports` 
ADD CONSTRAINT `airports_city_id`
FOREIGN KEY (`city_id`)
REFERENCES `gans`.`cities` (`city_id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
  
DESCRIBE airports;
  
  
# Setting up flights table
# Before altering datatypes and setting key, flights has duplicate flight_number values, therefore 
# a new ID column with unique values is necessary for the primary key
ALTER TABLE flights 
ADD flight_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;

# Alter table's datatypes of the columns and set primary key:
ALTER TABLE `gans`.`flights` 
CHANGE COLUMN `arrival_icao` `arrival_icao` CHAR(4) NULL DEFAULT NULL,
CHANGE COLUMN `flight_number` `flight_number` VARCHAR(10) NULL DEFAULT NULL,
CHANGE COLUMN `status` `status` VARCHAR(100) NULL DEFAULT NULL,
CHANGE COLUMN `departure_airport` `departure_airport` VARCHAR(100) NULL DEFAULT NULL,
CHANGE COLUMN `scheduled_time` `scheduled_time` DATETIME NULL DEFAULT NULL,
CHANGE COLUMN `terminal` `terminal` VARCHAR(10) NULL DEFAULT NULL,
CHANGE COLUMN `aircraft_model` `aircraft_model` VARCHAR(100) NULL DEFAULT NULL,
CHANGE COLUMN `airline` `airline` VARCHAR(100) NULL DEFAULT NULL,
CHANGE COLUMN `departure_icao` `departure_icao` CHAR(4) NULL DEFAULT NULL,
CHANGE COLUMN `departure_iata` `departure_iata` CHAR(3) NULL DEFAULT NULL;

# Setting foreign key:
ALTER TABLE `gans`.`flights` 
ADD INDEX `flights_icao_idx` (`arrival_icao` ASC) VISIBLE;
ALTER TABLE `gans`.`flights` 
ADD CONSTRAINT `arrivals_icao`
FOREIGN KEY (`arrival_icao`)
REFERENCES `gans`.`airports` (`icao`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
  
DESCRIBE flights;
