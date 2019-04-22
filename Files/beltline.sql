CREATE TABLE user
(
  Username VARCHAR(50) NOT NULL,
  Password VARCHAR(200) NOT NULL,
  Status ENUM('Approved','Declined','Pending') NOT NULL,
  UserType VARCHAR(50) NOT NULL, #Crosscheck this,
  Firstname VARCHAR(50) NOT NULL,
  Lastname VARCHAR(50) NOT NULL,
  PRIMARY KEY(Username)
);

CREATE TABLE emails
(
  Email VARCHAR(50) NOT NULL,
  Username VARCHAR(50) NOT NULL,
  PRIMARY KEY (Email),
  FOREIGN KEY (Username) REFERENCES user(Username)
	ON DELETE CASCADE
);

CREATE TABLE employee
(
  EmployeeID CHAR(9) NOT NULL,
  Phone DECIMAL(10,0) NOT NULL,
  EmployeeAddress VARCHAR(100) NOT NULL,
  EmployeeCity VARCHAR(50) NOT NULL,
  EmployeeState ENUM('AK', 'AL', 'AR', 'AZ', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA', 'HI', 'IA', 'ID', 'IL', 'IN', 'KS', 'KY', 'LA', 'MA', 'MD', 'ME', 'MI','MN', 'MO', 'MS', 'MT', 'NC', 'ND', 'NE', 'NH', 'NJ', 'NM', 'NV', 'NY', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VA', 'VT', 'WA', 'WI', 'WV', 'WY','other') NOT NULL,
  EmployeeZipcode DECIMAL(5,0) NOT NULL,
  EmployeeType ENUM('Manager','Staff','Admin') NOT NULL,
  Username VARCHAR(50) NOT NULL,
  PRIMARY KEY (EmployeeID),
  FOREIGN KEY (Username) REFERENCES user(Username)
  ON DELETE CASCADE,
  UNIQUE (Username),
  UNIQUE (Phone)
);

CREATE TABLE site
(
  SiteName VARCHAR(50) NOT NULL,
  SiteAddress VARCHAR(100),
  SiteZipcode DECIMAL(5,0) NOT NULL,
  OpenEveryday ENUM('Yes','No') NOT NULL,
  ManagerUsername VARCHAR(50) NOT NULL,
  PRIMARY KEY (SiteName),
  FOREIGN KEY (ManagerUsername) REFERENCES employee(Username)
  ON DELETE RESTRICT,
  UNIQUE (ManagerUsername)
);

CREATE TABLE event
(
  EventName VARCHAR(100) NOT NULL,
  StartDate DATE NOT NULL,
  EndDate DATE NOT NULL,
  EventPrice DECIMAL(7,2) NOT NULL,
  Capacity INT NOT NULL,
  MinStaffRequired INT NOT NULL,
  Description VARCHAR(1000) NOT NULL,
  SiteName VARCHAR(50) NOT NULL,
  PRIMARY KEY (EventName, StartDate, SiteName),
  FOREIGN KEY (SiteName) REFERENCES site(SiteName)
  ON DELETE CASCADE ON UPDATE CASCADE,
  UNIQUE (EventName, StartDate, SiteName)
);

CREATE TABLE staff_assignment
(
  StaffUsername VARCHAR(50) NOT NULL,
  EventName VARCHAR(100) NOT NULL,
  SiteName VARCHAR(50) NOT NULL,
  StartDate DATE NOT NULL,
  PRIMARY KEY (StaffUsername,EventName, StartDate, SiteName),
  FOREIGN KEY (StaffUsername) REFERENCES employee(Username)
  ON DELETE RESTRICT,
  FOREIGN KEY (EventName, StartDate, SiteName) REFERENCES event(EventName, StartDate, SiteName)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE transit
(
  TransitType ENUM('MARTA','Bus','Bike') NOT NULL,
  TransitRoute VARCHAR(20) NOT NULL,
  TransitPrice DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (TransitType, TransitRoute)
);

CREATE TABLE connect
(
  TransitType ENUM('MARTA','Bus','Bike') NOT NULL,
  TransitRoute VARCHAR(20) NOT NULL,
  SiteName VARCHAR(50) NOT NULL,
  PRIMARY KEY (TransitType, TransitRoute, SiteName),
  FOREIGN KEY (TransitType, TransitRoute) REFERENCES transit(TransitType, TransitRoute)
  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (SiteName) REFERENCES site(SiteName)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE take
(
  TransitDate DATE NOT NULL,
  TransitType ENUM('MARTA','Bus','Bike') NOT NULL,
  TransitRoute VARCHAR(20) NOT NULL,
  Username VARCHAR(50) NOT NULL,
  PRIMARY KEY (Username,TransitType,TransitRoute,TransitDate),
  FOREIGN KEY (TransitType,TransitRoute) REFERENCES transit(TransitType,TransitRoute)
  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (Username) REFERENCES user(Username)
  ON DELETE CASCADE
);

CREATE TABLE visitevent
(
  VisitEventDate DATE NOT NULL,
  VisitorUsername VARCHAR(50) NOT NULL,
  EventName VARCHAR(100) NOT NULL,
  SiteName VARCHAR(50) NOT NULL,
  StartDate DATE NOT NULL,
  PRIMARY KEY (VisitorUsername,EventName,StartDate,SiteName,VisitEventDate),
  FOREIGN KEY (VisitorUsername) REFERENCES user(Username)
  ON DELETE CASCADE,
  FOREIGN KEY (EventName,StartDate,SiteName) REFERENCES event(EventName,StartDate,SiteName)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE visitsite
(
  VisitSiteDate DATE NOT NULL,
  SiteName VARCHAR(50) NOT NULL,
  VisitorUsername VARCHAR(50) NOT NULL,
  PRIMARY KEY (VisitSiteDate, SiteName, VisitorUsername),
  FOREIGN KEY (SiteName) REFERENCES site(SiteName)
  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (VisitorUsername) REFERENCES user(Username)
  ON DELETE CASCADE
);


INSERT INTO user(Username,Password,Status,Firstname,Lastname,UserType) VALUES ('james.smith','jsmith123','Approved','James','Smith','Employee');
INSERT INTO user(Username,Password,Status,Firstname,Lastname,UserType) VALUES ('michael.smith','msmith456','Approved','Michael','Smith','Employee, Visitor');
INSERT INTO user(Username,Password,Status,Firstname,Lastname,UserType) VALUES ('robert.smith','rsmith789','Approved','Robert','Smith','Employee');
INSERT INTO user(Username,Password,Status,Firstname,Lastname,UserType) VALUES ('maria.garcia','mgarcia123','Approved','Maria','Garcia','Employee, Visitor');
INSERT INTO user(Username,Password,Status,Firstname,Lastname,UserType) VALUES ('david.smith','dsmith456','Approved','David','Smith','Employee');
INSERT INTO user(Username,Password,Status,Firstname,Lastname,UserType) VALUES ('manager1','manager1','Pending','Manager','One','Employee');
INSERT INTO user(Username,Password,Status,Firstname,Lastname,UserType) VALUES ('manager2','manager2','Approved','Manager','Two','Employee, Visitor');
INSERT INTO user(Username,Password,Status,Firstname,Lastname,UserType) VALUES ('manager3','manager3','Approved','Manager','Three','Employee');
INSERT INTO user(Username,Password,Status,Firstname,Lastname,UserType) VALUES ('manager4','manager4','Approved','Manager','Four','Employee, Visitor');
INSERT INTO user(Username,Password,Status,Firstname,Lastname,UserType) VALUES ('manager5','manager5','Approved','Manager','Five','Employee, Visitor');
INSERT INTO user(Username,Password,Status,Firstname,Lastname,UserType) VALUES ('maria.rodriguez','mrodriguez','Declined','Maria','Rodriguez','Visitor');
INSERT INTO user(Username,Password,Status,Firstname,Lastname,UserType) VALUES ('mary.smith','msmith789','Approved','Mary','Susersusersusersmith','Visitor');
INSERT INTO user(Username,Password,Status,Firstname,Lastname,UserType) VALUES ('maria.hernandez','mhernandez','Approved','Maria','Hernandez','User');
INSERT INTO user(Username,Password,Status,Firstname,Lastname,UserType) VALUES ('staff1','staff1234','Approved','Staff','One','Employee');
INSERT INTO user(Username,Password,Status,Firstname,Lastname,UserType) VALUES ('staff2','staff4567','Approved','Staff','Two','Employee, Visitor');
INSERT INTO user(Username,Password,Status,Firstname,Lastname,UserType) VALUES ('staff3','staff7890','Approved','Staff','Three','Employee, Visitor');
INSERT INTO user(Username,Password,Status,Firstname,Lastname,UserType) VALUES ('user1','user123456','Pending','User','One','User');
INSERT INTO user(Username,Password,Status,Firstname,Lastname,UserType) VALUES ('visitor1','visitor123','Approved','Visitor','One','Visitor');


INSERT INTO emails(Username,Email) VALUES ('james.smith','jsmith@gmail.com');
INSERT INTO emails(Username,Email) VALUES ('james.smith','jsmith@hotmail.com');
INSERT INTO emails(Username,Email) VALUES ('james.smith','jsmith@gatech.edu');
INSERT INTO emails(Username,Email) VALUES ('james.smith','jsmith@outlook.com');
INSERT INTO emails(Username,Email) VALUES ('michael.smith','msmith@gmail.com');
INSERT INTO emails(Username,Email) VALUES ('robert.smith','rsmith@hotmail.com');
INSERT INTO emails(Username,Email) VALUES ('maria.garcia','mgarcia@yahoo.com');
INSERT INTO emails(Username,Email) VALUES ('maria.garcia','mgarcia@gatech.edu');
INSERT INTO emails(Username,Email) VALUES ('david.smith','dsmith@outlook.com');
INSERT INTO emails(Username,Email) VALUES ('maria.rodriguez','mrodriguez@gmail.com');
INSERT INTO emails(Username,Email) VALUES ('mary.smith','mary@outlook.com');
INSERT INTO emails(Username,Email) VALUES ('maria.hernandez','mh@gatech.edu');
INSERT INTO emails(Username,Email) VALUES ('maria.hernandez','mh123@gmail.com');
INSERT INTO emails(Username,Email) VALUES ('manager1','m1@beltline.com');
INSERT INTO emails(Username,Email) VALUES ('manager2','m2@beltline.com');
INSERT INTO emails(Username,Email) VALUES ('manager3','m3@beltline.com');
INSERT INTO emails(Username,Email) VALUES ('manager4','m4@beltline.com');
INSERT INTO emails(Username,Email) VALUES ('manager5','m5@beltline.com');
INSERT INTO emails(Username,Email) VALUES ('staff1','s1@beltline.com');
INSERT INTO emails(Username,Email) VALUES ('staff2','s2@beltline.com');
INSERT INTO emails(Username,Email) VALUES ('staff3','s3@beltline.com');
INSERT INTO emails(Username,Email) VALUES ('user1','u1@beltline.com');
INSERT INTO emails(Username,Email) VALUES ('visitor1','v1@beltline.com');

INSERT INTO employee(Username,EmployeeID,Phone,EmployeeAddress,EmployeeCity,EmployeeState,EmployeeZipcode,EmployeeType) VALUES ('james.smith',000000001,4043721234,'123 East Main Street','Rochester','NY',14604,'Admin');
INSERT INTO employee(Username,EmployeeID,Phone,EmployeeAddress,EmployeeCity,EmployeeState,EmployeeZipcode,EmployeeType) VALUES ('michael.smith',000000002,4043726789,'350 Ferst Drive','Atlanta','GA',30332,'Staff');
INSERT INTO employee(Username,EmployeeID,Phone,EmployeeAddress,EmployeeCity,EmployeeState,EmployeeZipcode,EmployeeType) VALUES ('robert.smith',000000003,1234567890,'123 East Main Street','Columbus','OH',43215,'Staff');
INSERT INTO employee(Username,EmployeeID,Phone,EmployeeAddress,EmployeeCity,EmployeeState,EmployeeZipcode,EmployeeType) VALUES ('maria.garcia',000000004,7890123456,'123 East Main Street','Richland','PA',17987,'Manager');
INSERT INTO employee(Username,EmployeeID,Phone,EmployeeAddress,EmployeeCity,EmployeeState,EmployeeZipcode,EmployeeType) VALUES ('david.smith',000000005,5124776435,'350 Ferst Drive','Atlanta','GA',30332,'Manager');
INSERT INTO employee(Username,EmployeeID,Phone,EmployeeAddress,EmployeeCity,EmployeeState,EmployeeZipcode,EmployeeType) VALUES ('manager1',000000006,8045126767,'123 East Main Street','Rochester','NY',14604,'Manager');
INSERT INTO employee(Username,EmployeeID,Phone,EmployeeAddress,EmployeeCity,EmployeeState,EmployeeZipcode,EmployeeType) VALUES ('manager2',000000007,9876543210,'123 East Main Street','Rochester','NY',14604,'Manager');
INSERT INTO employee(Username,EmployeeID,Phone,EmployeeAddress,EmployeeCity,EmployeeState,EmployeeZipcode,EmployeeType) VALUES ('manager3',000000008,5432167890,'350 Ferst Drive','Atlanta','GA',30332,'Manager');
INSERT INTO employee(Username,EmployeeID,Phone,EmployeeAddress,EmployeeCity,EmployeeState,EmployeeZipcode,EmployeeType) VALUES ('manager4',000000009,8053467565,'123 East Main Street','Columbus','OH',43215,'Manager');
INSERT INTO employee(Username,EmployeeID,Phone,EmployeeAddress,EmployeeCity,EmployeeState,EmployeeZipcode,EmployeeType) VALUES ('manager5',000000010,8031446782,'801 Atlantic Drive','Atlanta','GA',30332,'Manager');
INSERT INTO employee(Username,EmployeeID,Phone,EmployeeAddress,EmployeeCity,EmployeeState,EmployeeZipcode,EmployeeType) VALUES ('staff1',000000011,8024456765,'266 Ferst Drive Northwest','Atlanta','GA',30332,'Staff');
INSERT INTO employee(Username,EmployeeID,Phone,EmployeeAddress,EmployeeCity,EmployeeState,EmployeeZipcode,EmployeeType) VALUES ('staff2',000000012,8888888888,'266 Ferst Drive Northwest','Atlanta','GA',30332,'Staff');
INSERT INTO employee(Username,EmployeeID,Phone,EmployeeAddress,EmployeeCity,EmployeeState,EmployeeZipcode,EmployeeType) VALUES ('staff3',000000013,3333333333,'801 Atlantic Drive','Atlanta','GA',30332,'Staff');


INSERT INTO site(SiteName,SiteAddress,SiteZipcode,OpenEveryday,ManagerUsername) VALUES ('Piedmont Park','400 Park Drive Northeast',30306,'Yes','manager2');
INSERT INTO site(SiteName,SiteAddress,SiteZipcode,OpenEveryday,ManagerUsername) VALUES ('Atlanta Beltline Center','112 Krog Street Northeast',30307,'No','manager3');
INSERT INTO site(SiteName,SiteAddress,SiteZipcode,OpenEveryday,ManagerUsername) VALUES ('Historic Fourth Ward Park','680 Dallas Street Northeast',30308,'Yes','manager4');
INSERT INTO site(SiteName,SiteAddress,SiteZipcode,OpenEveryday,ManagerUsername) VALUES ('Inman Park',NULL,30307,'Yes','david.smith');
INSERT INTO site(SiteName,SiteAddress,SiteZipcode,OpenEveryday,ManagerUsername) VALUES ('Westview Cemetery','1680 Westview Drive Southwest',30310,'No','manager5');

INSERT INTO event(EventName,StartDate,SiteName,EndDate,EventPrice,Capacity,MinStaffRequired,Description) VALUES ('Eastside Trail','2019-02-04','Piedmont Park','2019-02-05',0,99999,1,'A combination of multi-use trail and linear greenspace, the Eastside Trail was the first finished section of the Atlanta BeltLine trail in the old rail corridor. The Eastside Trail, which was funded by a combination of public and private philanthropic sources, runs from the tip of Piedmont Park to Reynoldstown. More details at https://beltline.org/explore-atlanta-beltline-trails/eastside-trail/');
INSERT INTO event(EventName,StartDate,SiteName,EndDate,EventPrice,Capacity,MinStaffRequired,Description) VALUES ('Eastside Trail','2019-02-04','Inman Park','2019-02-05',0,99999,1,'A combination of multi-use trail and linear greenspace, the Eastside Trail was the first finished section of the Atlanta BeltLine trail in the old rail corridor. The Eastside Trail, which was funded by a combination of public and private philanthropic sources, runs from the tip of Piedmont Park to Reynoldstown. More details at https://beltline.org/explore-atlanta-beltline-trails/eastside-trail/');
INSERT INTO event(EventName,StartDate,SiteName,EndDate,EventPrice,Capacity,MinStaffRequired,Description) VALUES ('Eastside Trail','2019-03-01','Inman Park','2019-03-02',0,99999,1,'A combination of multi-use trail and linear greenspace, the Eastside Trail was the first finished section of the Atlanta BeltLine trail in the old rail corridor. The Eastside Trail, which was funded by a combination of public and private philanthropic sources, runs from the tip of Piedmont Park to Reynoldstown. More details at https://beltline.org/explore-atlanta-beltline-trails/eastside-trail/');
INSERT INTO event(EventName,StartDate,SiteName,EndDate,EventPrice,Capacity,MinStaffRequired,Description) VALUES ('Eastside Trail','2019-02-13','Historic Fourth Ward Park','2019-02-14',0,99999,1,'A combination of multi-use trail and linear greenspace, the Eastside Trail was the first finished section of the Atlanta BeltLine trail in the old rail corridor. The Eastside Trail, which was funded by a combination of public and private philanthropic sources, runs from the tip of Piedmont Park to Reynoldstown. More details at https://beltline.org/explore-atlanta-beltline-trails/eastside-trail/');
INSERT INTO event(EventName,StartDate,SiteName,EndDate,EventPrice,Capacity,MinStaffRequired,Description) VALUES ('Bus Tour','2019-02-01','Inman Park','2019-02-02',25,6,2,'The Atlanta BeltLine Partnership\'s tour program operates with a natural gas-powered, ADA accessible tour bus funded through contributions from 10th & Monroe, LLC, SunTrust Bank Trusteed Foundations\' Florence C. and Harry L. English Memorial Fund and Thomas Guy Woolford Charitable Trust, and AGL Resources');
INSERT INTO event(EventName,StartDate,SiteName,EndDate,EventPrice,Capacity,MinStaffRequired,Description) VALUES ('Bus Tour','2019-02-08','Inman Park','2019-02-10',25,6,2,'The Atlanta BeltLine Partnership\'s tour program operates with a natural gas-powered, ADA accessible tour bus funded through contributions from 10th & Monroe, LLC, SunTrust Bank Trusteed Foundations\' Florence C. and Harry L. English Memorial Fund and Thomas Guy Woolford Charitable Trust, and AGL Resources');
INSERT INTO event(EventName,StartDate,SiteName,EndDate,EventPrice,Capacity,MinStaffRequired,Description) VALUES ('Private Bus Tour','2019-02-01','Inman Park','2019-02-02',40,4,1,'Private tours are available most days, pending bus and tour guide availability. Private tours can accommodate up to 4 guests per tour, and are subject to a tour fee (nonprofit rates are available). As a nonprofit organization with limited resources, we are unable to offer free private tours. We thank you for your support and your understanding as we try to provide as many private group tours as possible. The Atlanta BeltLine Partnership\'s tour program operates with a natural gas-powered, ADA accessible tour bus funded through contributions from 10th & Monroe, LLC, SunTrust Bank Trusteed Foundations\' Florence C. and Harry L. English Memorial Fund and Thomas Guy Woolford Charitable Trust, and AGL Resources');
INSERT INTO event(EventName,StartDate,SiteName,EndDate,EventPrice,Capacity,MinStaffRequired,Description) VALUES ('Arboretum Walking Tour','2019-02-08','Inman Park','2019-02-11',5,5,1,'Official Atlanta BeltLine Arboretum Walking Tours provide an up-close view of the Westside Trail and the Atlanta BeltLine Arboretum led by Trees Atlanta Docents. The one and a half hour tours step off at at 10am (Oct thru May), and 9am (June thru September). Departure for all tours is from Rose Circle Park near Brown Middle School. More details at: https://beltline.org/visit/atlanta-beltline-tours/#arboretum-walking');
INSERT INTO event(EventName,StartDate,SiteName,EndDate,EventPrice,Capacity,MinStaffRequired,Description) VALUES ('Official Atlanta BeltLine Bike Tour','2019-02-09','Atlanta BeltLine Center','2019-02-14',5,5,1,'These tours will include rest stops highlighting assets and points of interest along the Atlanta BeltLine. Staff will lead the rides, and each group will have a ride sweep to help with any unexpected mechanical difficulties.');
INSERT INTO event(EventName,StartDate,SiteName,EndDate,EventPrice,Capacity,MinStaffRequired,Description) VALUES ('Westside Trail','2019-02-18','Westview Cemetery','2019-02-21',0,99999,1,'The Westside Trail is a free amenity that offers a bicycle and pedestrian-safe corridor with a 14-foot-wide multi-use trail surrounded by mature trees and grasses thanks to Trees Atlantas Arboretum. With 16 points of entry, 14 of which will be ADA-accessible with ramp and stair systems, the trail provides numerous access points for people of all abilities. More details at: https://beltline.org/explore-atlanta-beltline-trails/westside-trail/');

INSERT INTO staff_assignment(StaffUsername,EventName,StartDate,SiteName) VALUES ('michael.smith','Eastside Trail','2019-02-04','Piedmont Park');
INSERT INTO staff_assignment(StaffUsername,EventName,StartDate,SiteName) VALUES ('staff1','Eastside Trail','2019-02-04','Piedmont Park');
INSERT INTO staff_assignment(StaffUsername,EventName,StartDate,SiteName) VALUES ('robert.smith','Eastside Trail','2019-02-04','Inman Park');
INSERT INTO staff_assignment(StaffUsername,EventName,StartDate,SiteName) VALUES ('staff2','Eastside Trail','2019-02-04','Inman Park');
INSERT INTO staff_assignment(StaffUsername,EventName,StartDate,SiteName) VALUES ('staff1','Eastside Trail','2019-03-01','Inman Park');
INSERT INTO staff_assignment(StaffUsername,EventName,StartDate,SiteName) VALUES ('michael.smith','Eastside Trail','2019-02-13','Historic Fourth Ward Park');
INSERT INTO staff_assignment(StaffUsername,EventName,StartDate,SiteName) VALUES ('michael.smith','Bus Tour','2019-02-01','Inman Park');
INSERT INTO staff_assignment(StaffUsername,EventName,StartDate,SiteName) VALUES ('staff2','Bus Tour','2019-02-01','Inman Park');
INSERT INTO staff_assignment(StaffUsername,EventName,StartDate,SiteName) VALUES ('robert.smith','Bus Tour','2019-02-08','Inman Park');
INSERT INTO staff_assignment(StaffUsername,EventName,StartDate,SiteName) VALUES ('michael.smith','Bus Tour','2019-02-08','Inman Park');
INSERT INTO staff_assignment(StaffUsername,EventName,StartDate,SiteName) VALUES ('robert.smith','Private Bus Tour','2019-02-01','Inman Park');
INSERT INTO staff_assignment(StaffUsername,EventName,StartDate,SiteName) VALUES ('staff3','Arboretum Walking Tour','2019-02-08','Inman Park');
INSERT INTO staff_assignment(StaffUsername,EventName,StartDate,SiteName) VALUES ('staff1','Official Atlanta BeltLine Bike Tour','2019-02-09','Atlanta BeltLine Center');
INSERT INTO staff_assignment(StaffUsername,EventName,StartDate,SiteName) VALUES ('staff1','Westside Trail','2019-02-18','Westview Cemetery');
INSERT INTO staff_assignment(StaffUsername,EventName,StartDate,SiteName) VALUES ('staff3','Westside Trail','2019-02-18','Westview Cemetery');

INSERT INTO transit(TransitType,TransitRoute,TransitPrice) VALUES ('MARTA','Blue',2.00);
INSERT INTO transit(TransitType,TransitRoute,TransitPrice) VALUES ('Bus','152',2.00);
INSERT INTO transit(TransitType,TransitRoute,TransitPrice) VALUES ('Bike','Relay',1.00);

INSERT INTO connect(SiteName,TransitType,TransitRoute) VALUES ('Inman Park','MARTA','Blue');
INSERT INTO connect(SiteName,TransitType,TransitRoute) VALUES ('Piedmont Park','MARTA','Blue');
INSERT INTO connect(SiteName,TransitType,TransitRoute) VALUES ('Historic Fourth Ward Park','MARTA','Blue');
INSERT INTO connect(SiteName,TransitType,TransitRoute) VALUES ('Inman Park','Bus','152');
INSERT INTO connect(SiteName,TransitType,TransitRoute) VALUES ('Piedmont Park','Bus','152');
INSERT INTO connect(SiteName,TransitType,TransitRoute) VALUES ('Historic Fourth Ward Park','Bus','152');
INSERT INTO connect(SiteName,TransitType,TransitRoute) VALUES ('Piedmont Park','Bike','Relay');
INSERT INTO connect(SiteName,TransitType,TransitRoute) VALUES ('Historic Fourth Ward Park','Bike','Relay');
INSERT INTO connect(SiteName,TransitType,TransitRoute) VALUES ('Westview Cemetery','MARTA','Blue');


INSERT INTO take(Username,TransitType,TransitRoute,TransitDate) VALUES ('manager2','MARTA','Blue','2019-03-20');
INSERT INTO take(Username,TransitType,TransitRoute,TransitDate) VALUES ('manager2','Bus','152','2019-03-20');
INSERT INTO take(Username,TransitType,TransitRoute,TransitDate) VALUES ('manager3','Bike','Relay','2019-03-20');
INSERT INTO take(Username,TransitType,TransitRoute,TransitDate) VALUES ('manager2','MARTA','Blue','2019-03-21');
INSERT INTO take(Username,TransitType,TransitRoute,TransitDate) VALUES ('maria.hernandez','Bus','152','2019-03-20');
INSERT INTO take(Username,TransitType,TransitRoute,TransitDate) VALUES ('maria.hernandez','Bike','Relay','2019-03-20');
INSERT INTO take(Username,TransitType,TransitRoute,TransitDate) VALUES ('manager2','MARTA','Blue','2019-03-22');
INSERT INTO take(Username,TransitType,TransitRoute,TransitDate) VALUES ('maria.hernandez','Bus','152','2019-03-22');
INSERT INTO take(Username,TransitType,TransitRoute,TransitDate) VALUES ('mary.smith','Bike','Relay','2019-03-23');
INSERT INTO take(Username,TransitType,TransitRoute,TransitDate) VALUES ('visitor1','MARTA','Blue','2019-03-21');

INSERT INTO visitevent(VisitorUsername,EventName,StartDate,SiteName,VisitEventDate) VALUES ('mary.smith','Bus Tour','2019-02-01','Inman Park','2019-02-01');
INSERT INTO visitevent(VisitorUsername,EventName,StartDate,SiteName,VisitEventDate) VALUES ('maria.garcia','Bus Tour','2019-02-01','Inman Park','2019-02-02');
INSERT INTO visitevent(VisitorUsername,EventName,StartDate,SiteName,VisitEventDate) VALUES ('manager2','Bus Tour','2019-02-01','Inman Park','2019-02-02');
INSERT INTO visitevent(VisitorUsername,EventName,StartDate,SiteName,VisitEventDate) VALUES ('manager4','Bus Tour','2019-02-01','Inman Park','2019-02-01');
INSERT INTO visitevent(VisitorUsername,EventName,StartDate,SiteName,VisitEventDate) VALUES ('manager5','Bus Tour','2019-02-01','Inman Park','2019-02-02');
INSERT INTO visitevent(VisitorUsername,EventName,StartDate,SiteName,VisitEventDate) VALUES ('staff2','Bus Tour','2019-02-01','Inman Park','2019-02-02');
INSERT INTO visitevent(VisitorUsername,EventName,StartDate,SiteName,VisitEventDate) VALUES ('mary.smith','Private Bus Tour','2019-02-01','Inman Park','2019-02-01');
INSERT INTO visitevent(VisitorUsername,EventName,StartDate,SiteName,VisitEventDate) VALUES ('mary.smith','Private Bus Tour','2019-02-01','Inman Park','2019-02-02');
INSERT INTO visitevent(VisitorUsername,EventName,StartDate,SiteName,VisitEventDate) VALUES ('mary.smith','Official Atlanta BeltLine Bike Tour','2019-02-09','Atlanta BeltLine Center','2019-02-10');
INSERT INTO visitevent(VisitorUsername,EventName,StartDate,SiteName,VisitEventDate) VALUES ('mary.smith','Arboretum Walking Tour','2019-02-08','Inman Park','2019-02-10');
INSERT INTO visitevent(VisitorUsername,EventName,StartDate,SiteName,VisitEventDate) VALUES ('mary.smith','Eastside Trail','2019-02-04','Piedmont Park','2019-02-04');
INSERT INTO visitevent(VisitorUsername,EventName,StartDate,SiteName,VisitEventDate) VALUES ('mary.smith','Eastside Trail','2019-02-13','Historic Fourth Ward Park','2019-02-13');
INSERT INTO visitevent(VisitorUsername,EventName,StartDate,SiteName,VisitEventDate) VALUES ('mary.smith','Eastside Trail','2019-02-13','Historic Fourth Ward Park','2019-02-14');
INSERT INTO visitevent(VisitorUsername,EventName,StartDate,SiteName,VisitEventDate) VALUES ('visitor1','Eastside Trail','2019-02-13','Historic Fourth Ward Park','2019-02-14');
INSERT INTO visitevent(VisitorUsername,EventName,StartDate,SiteName,VisitEventDate) VALUES ('visitor1','Official Atlanta BeltLine Bike Tour','2019-02-09','Atlanta BeltLine Center','2019-02-10');
INSERT INTO visitevent(VisitorUsername,EventName,StartDate,SiteName,VisitEventDate) VALUES ('mary.smith','Westside Trail','2019-02-18','Westview Cemetery','2019-02-19');
INSERT INTO visitevent(VisitorUsername,EventName,StartDate,SiteName,VisitEventDate) VALUES ('visitor1','Westside Trail','2019-02-18','Westview Cemetery','2019-02-19');

INSERT INTO visitsite(VisitorUsername,SiteName,VisitSiteDate) VALUES ('mary.smith','Inman Park','2019-02-01');
INSERT INTO visitsite(VisitorUsername,SiteName,VisitSiteDate) VALUES ('mary.smith','Inman Park','2019-02-02');
INSERT INTO visitsite(VisitorUsername,SiteName,VisitSiteDate) VALUES ('mary.smith','Inman Park','2019-02-03');
INSERT INTO visitsite(VisitorUsername,SiteName,VisitSiteDate) VALUES ('mary.smith','Atlanta Beltline Center','2019-02-01');
INSERT INTO visitsite(VisitorUsername,SiteName,VisitSiteDate) VALUES ('mary.smith','Atlanta Beltline Center','2019-02-10');
INSERT INTO visitsite(VisitorUsername,SiteName,VisitSiteDate) VALUES ('mary.smith','Historic Fourth Ward Park','2019-02-02');
INSERT INTO visitsite(VisitorUsername,SiteName,VisitSiteDate) VALUES ('mary.smith','Piedmont Park','2019-02-02');
INSERT INTO visitsite(VisitorUsername,SiteName,VisitSiteDate) VALUES ('visitor1','Piedmont Park','2019-02-11');
INSERT INTO visitsite(VisitorUsername,SiteName,VisitSiteDate) VALUES ('visitor1','Atlanta Beltline Center','2019-02-13');
INSERT INTO visitsite(VisitorUsername,SiteName,VisitSiteDate) VALUES ('visitor1','Historic Fourth Ward Park','2019-02-11');
INSERT INTO visitsite(VisitorUsername,SiteName,VisitSiteDate) VALUES ('visitor1','Inman Park','2019-02-01');
INSERT INTO visitsite(VisitorUsername,SiteName,VisitSiteDate) VALUES ('visitor1','Piedmont Park','2019-02-01');
INSERT INTO visitsite(VisitorUsername,SiteName,VisitSiteDate) VALUES ('visitor1','Atlanta Beltline Center','2019-02-09');
INSERT INTO visitsite(VisitorUsername,SiteName,VisitSiteDate) VALUES ('visitor1','Westview Cemetery','2019-02-06');
