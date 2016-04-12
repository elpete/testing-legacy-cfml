DROP DATABASE IF EXISTS eventplanning;
CREATE DATABASE eventplanning;
USE eventplanning;
CREATE TABLE events (id INTEGER AUTO_INCREMENT PRIMARY KEY, name VARCHAR(100) NOT NULL, event_date DATE NOT NULL, user_id INTEGER NOT NULL);
CREATE TABLE users (id INTEGER AUTO_INCREMENT PRIMARY KEY, email VARCHAR(100) UNIQUE, password VARCHAR(40) NOT NULL);
CREATE TABLE rsvps (id VARCHAR(40) PRIMARY KEY, email VARCHAR(100), event_id INTEGER, rsvp VARCHAR(100));