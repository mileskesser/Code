SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;

DROP TABLE IF EXISTS Projects; 
DROP TABLE IF EXISTS Donations;
DROP TABLE IF EXISTS Donors;
DROP TABLE IF EXISTS Charities; 
DROP TABLE IF EXISTS Charities_has_Projects; 

CREATE TABLE Donors (
    donor_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    email varchar(255),
    total_donated DECIMAL(13,2) 
);

INSERT INTO Donors (name, email, total_donated) VALUES 
("George Costanza","georgec@email.com", 25.00),
("Art Vandelay","georgec@email.com", 1700.00), 
("Mike Wazowski", "mikeyw@email.com", 300.00), 
("Conan O'Brien", "teamcoco@email.com", 1000.00),
("American government", "biden@whitehouse.com", 1000000.00);

CREATE TABLE Charities (
    charity_id INT PRIMARY KEY AUTO_INCREMENT, 
    name varchar(255) NOT NULL,
    location varchar(255) NOT NULL,
    total_raised DECIMAL(13,2) 
);

INSERT INTO Charities (name, location, total_raised) VALUES 
("ASPCA", "New York, NY", 1000.00),
("Marine Mammal Center", "Sausalito, CA", 1225.00), 
("American Red Cross", "Washington D.C.", 300.00),
("YMCA", "Geneva, Switzerland", 500.00),
("Doctors Without Borders", "New York, NY", 500000.00);

CREATE TABLE Donations (
    donation_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    donor_id INT,
    charity_id INT,
    amount DECIMAL(13,2) NOT NULL,
    type varchar(255) NOT NULL,
    date DATE NOT NULL,
    FOREIGN KEY (donor_id) REFERENCES Donors (donor_id) ON DELETE CASCADE,
    FOREIGN KEY (charity_id) REFERENCES Charities (charity_id) ON DELETE CASCADE
);

INSERT INTO Donations (donor_id, charity_id, amount, type, date) VALUES 
(1, 2, 25.00, "Cash", "2022-01-01"), 
(2, 4, 500.00, "Check", "2022-01-20"), 
(2, 2, 1200.00, "Cash", "2022-02-13"),
(3, 3, 300.00, "Cash", "2022-04-10"), 
(4, 1, 1000.00, "Check", "2022-05-30"),
(5, 5, 500000.00, "Check", "2022-01-01"); 


CREATE TABLE Projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT, 
    name varchar(255) NOT NULL, 
    amount_needed DECIMAL(13,2), 
    amount_raised DECIMAL(13,2)
);

INSERT INTO Projects (name) VALUES 
("Protecting Wildlife"), 
("Providing Hurricane Relief"), 
("Building Exersice Facilities"),
("Humanitarian assisstance");


CREATE TABLE Charities_has_Projects (
    Charities_charity_id INT,
    Projects_project_id INT,
    FOREIGN KEY (Charities_charity_id) REFERENCES Charities (charity_id) ON DELETE CASCADE,
    FOREIGN KEY (Projects_project_id) REFERENCES Projects (project_id) ON DELETE CASCADE
);

Insert into Charities_has_Projects (Charities_charity_id, Projects_project_id)
VALUES 
    ((select charity_id from Charities where name = 'ASPCA'), 
    (select project_id from Projects where name = "Protecting Wildlife")),  

	((select charity_id from Charities where name = "American Red Cross"), 
    (select project_id from Projects where name = "Providing Hurricane Relief")),  

    ((select charity_id from Charities where name = "Doctors Without Borders"), 
    (select project_id from Projects where name = "Humanitarian assisstance"));


SET FOREIGN_KEY_CHECKS = 1;
COMMIT;

