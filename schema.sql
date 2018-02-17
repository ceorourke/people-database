CREATE TABLE people(
people_id SERIAL PRIMARY KEY,
fname VARCHAR(20) NOT NULL,
lname VARCHAR(20) NOT NULL,
phone_number VARCHAR(20) NOT NULL);

INSERT INTO People (fname, lname, phone_number)
    VALUES('Hellboy', 'ORourke', '415-123-4567');
INSERT INTO People (fname, lname, phone_number)
    VALUES('Colleen', 'ORourke', '415-333-2222');
INSERT INTO People (fname, lname, phone_number)
    VALUES('Paula', 'ORourke', '415-222-3333');
INSERT INTO People (fname, lname, phone_number)
    VALUES('Erin', 'ORourke', '413-222-2222');
INSERT INTO People (fname, lname, phone_number)
    VALUES('Jennie', 'ORourke', '413-333-2222');

CREATE TABLE addresses (
address_id SERIAL PRIMARY KEY,
street_address VARCHAR(50) NOT NULL,
city VARCHAR(50) NOT NULL,
state VARCHAR(50) NOT NULL,
people_id INTEGER REFERENCES People);

INSERT INTO Addresses (street_address, city, state, people_id) 
    VALUES('123 Pacific Avenue', 'San Francisco', 'CA', 1);
INSERT INTO Addresses (street_address, city, state, people_id) 
    VALUES('123 Pacific Avenue', 'San Francisco', 'CA', 2);
INSERT INTO Addresses (street_address, city, state, people_id) 
    VALUES('789 Gale Avenue', 'Pittsfield', 'MA', 3);
INSERT INTO Addresses (street_address, city, state, people_id) 
    VALUES('19 Conz Street', 'Northampton', 'MA', 4);
INSERT INTO Addresses (street_address, city, state, people_id) 
    VALUES('345 Cool Street', 'Dalton', 'MA', 5);
INSERT INTO Addresses (street_address, city, state, people_id) 
    VALUES('999 Rodeo Drive', 'Los Angeles', 'CA', 1);


-- - Display people and their phone numbers
SELECT fname, lname, phone_number FROM people;

-- - Display people and their addresses
SELECT fname, lname, street_address, city, state FROM people JOIN addresses USING (people_id);

-- - Display people and their addresses only if they are in the state of California
SELECT fname, lname, street_address, city, state FROM people JOIN addresses USING (people_id) WHERE state = 'CA';

-- - Show how many people have addresses in each state
SELECT state, COUNT(people_id) AS num_people FROM people join addresses USING (people_id) GROUP BY state;

-- - Show the % of people that have multiple addresses
SELECT ROUND(100.0 * 
    (SELECT people_id FROM addresses GROUP BY people_id HAVING count(people_id) > 1) / 
    (SELECT count(people_id) FROM addresses)) as percent_total FROM addresses LIMIT 1;