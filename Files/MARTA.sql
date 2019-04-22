use Beltline;

/* Screen 01 - User Login */
DELIMITER //
CREATE PROCEDURE s01_user_login_check_email(IN
  EMailID VARCHAR(50))
BEGIN
	SELECT EXISTS (SELECT Username FROM emails WHERE Email = EMailID);
 END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE s01_user_login_check_password(IN
  EMailID VARCHAR(50),
  Pass VARCHAR(25))
BEGIN
	SELECT UserType, Status
    FROM user
    WHERE Username in (SELECT Username FROM emails WHERE Email = EMailID) AND Password = Pass;
 END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE s01_employee_check_type(IN
  EMailID VARCHAR(50))
BEGIN
	SELECT EmployeeType
    FROM employee
    WHERE Username in (SELECT Username FROM emails WHERE Email = EMailID);
 END //
DELIMITER ;

/* Screen 02 - Register Navigation */

/* Screen 03 - Register User Only */
DELIMITER //
CREATE PROCEDURE s03_register_user(IN
  UName VARCHAR(50),
  Pass VARCHAR(25),
  UType ENUM('Visitor','User'),
  FName VARCHAR(50),
  LName VARCHAR(50))
 BEGIN
 INSERT INTO user(Username,Password,Status,Firstname,Lastname,UserType) VALUES (UName,Pass,'Pending',FName,LName,UType);
 END //
DELIMITER ;

/* Screen 04- Register Visitor Only */
DELIMITER //
CREATE PROCEDURE s04_add_email(IN UName VARCHAR(50),
  EMail VARCHAR(50))
 BEGIN
 INSERT INTO emails(Username,Email) VALUES (UName,EMail);
 END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE s04_register_visitor(IN UName VARCHAR(50),Pass VARCHAR(25),FName VARCHAR(50),LName VARCHAR(50))
BEGIN
INSERT INTO user(Username, Password, Status, UserType, Firstname, Lastname)
VALUES(UName, Pass, 'Pending', 'Visitor', FName, LName);
END //
DELIMITER;


/* Screen 05 - Register Employee Only */

DELIMITER //
CREATE PROCEDURE s05_register_employee(IN
  UName VARCHAR(50),
  Pass VARCHAR(25),
  UType VARCHAR(50),
  FName VARCHAR(50),
  LName VARCHAR(50),
  EID CHAR(9),
  Phone VARCHAR(20),
  EAddress VARCHAR(100),
  ECity VARCHAR(50),
  EState ENUM('AK', 'AL', 'AR', 'AZ', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA', 'HI', 'IA', 'ID', 'IL', 'IN', 'KS', 'KY', 'LA', 'MA', 'MD', 'ME', 'MI','MN', 'MO', 'MS', 'MT', 'NC', 'ND', 'NE', 'NH', 'NJ', 'NM', 'NV', 'NY', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VA', 'VT', 'WA', 'WI', 'WV', 'WY','other'),
  EZipcode CHAR(5),
  EType ENUM('Manager','Staff','Admin'))
 BEGIN
 INSERT INTO user(Username,Password,Status,Firstname,Lastname,UserType) VALUES (UName,Pass,'Pending',FName,LName,UType);
 INSERT INTO employee(Username,EmployeeID,Phone,EmployeeAddress,EmployeeCity,EmployeeState,EmployeeZipcode,EmployeeType) VALUES (UName,EID,Phone,EAddress,ECity,EState,EZipcode,EType);
 END //
DELIMITER ;

/* Screen 06 - Register Employee-Visitor*/
DELIMITER //
CREATE PROCEDURE s06_register_employee_visitor(IN
  UName VARCHAR(50),
  Pass VARCHAR(25),
  UType VARCHAR(50),
  FName VARCHAR(50),
  LName VARCHAR(50),
  EID CHAR(9),
  Phone VARCHAR(20),
  EAddress VARCHAR(100),
  ECity VARCHAR(50),
  EState ENUM('AK', 'AL', 'AR', 'AZ', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA', 'HI', 'IA', 'ID', 'IL', 'IN', 'KS', 'KY', 'LA', 'MA', 'MD', 'ME', 'MI','MN', 'MO', 'MS', 'MT', 'NC', 'ND', 'NE', 'NH', 'NJ', 'NM', 'NV', 'NY', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VA', 'VT', 'WA', 'WI', 'WV', 'WY','other'),
  EZipcode CHAR(5),
  EType ENUM('Manager','Staff','Admin'))
 BEGIN
 INSERT INTO user(Username,Password,Status,Firstname,Lastname,UserType) VALUES (UName,Pass,'Pending',FName,LName,UType);
 INSERT INTO employee(Username,EmployeeID,Phone,EmployeeAddress,EmployeeCity,EmployeeState,EmployeeZipcode,EmployeeType) VALUES (UName,EID,Phone,EAddress,ECity,EState,EZipcode,EType);
 END //
DELIMITER ;
/* Screens 7-4 - Functionality/Navigation Screens */

/* Screen 15 - User Take Transit */

DELIMITER //
CREATE PROCEDURE s15_get_route(IN
  TType ENUM('MARTA','Bus','Bike'),
  Site VARCHAR(50),
  PrangeL DECIMAL(7,2),
  PrangeU DECIMAL(7,2))
BEGIN
SELECT connect.TransitType as Type,connect.TransitRoute as Route, transit.TransitPrice as Price, count(*) as No_of_Connected_Sites
FROM transit
JOIN connect ON transit.TransitType=connect.TransitType AND transit.TransitRoute=connect.TransitRoute
GROUP BY transit.TransitType,transit.TransitRoute HAVING CONCAT(transit.TransitType,transit.TransitRoute) IN (
  SELECT DISTINCT CONCAT(transit.TransitType,transit.TransitRoute)
  FROM transit
  JOIN connect ON transit.TransitType=connect.TransitType AND transit.TransitRoute=connect.TransitRoute
  WHERE
  CASE WHEN TType IS NULL
   THEN transit.TransitType=transit.TransitType
   ELSE transit.TransitType = TType END
   AND CASE WHEN Site IS NULL
   THEN connect.SiteName = connect.SiteName
   ELSE connect.SiteName = Site END
   AND transit.TransitPrice BETWEEN PrangeL AND PrangeU);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE s15_get_sites()
BEGIN
SELECT DISTINCT SiteName
FROM site;
END //
DELIMITER;

/* Screen 16 - User Transit History */

DELIMITER //
CREATE PROCEDURE s16_transit_history(IN
  TType VARCHAR(50),
  Site VARCHAR(50),
  Route VARCHAR(20),
  StartDate DATE,
  EndDate DATE)
BEGIN

DROP VIEW IF EXISTS transit_connections;

CREATE VIEW transit_connections AS
SELECT transit.TransitType, transit.TransitRoute, transit.TransitPrice, connect.SiteName
FROM transit
JOIN connect ON transit.TransitType=connect.TransitType AND transit.TransitRoute=connect.TransitRoute;

SELECT DISTINCT take.TransitDate as Date,take.TransitType as Type,take.TransitRoute as Route, transit_connections.TransitPrice as Price
FROM take
INNER JOIN transit_connections ON transit_connections.TransitType=take.TransitType AND transit_connections.TransitRoute=take.TransitRoute
WHERE
CASE WHEN TType IS NULL
 THEN transit_connections.TransitType=transit_connections.TransitType
 ELSE transit_connections.TransitType = TType END
 AND CASE WHEN Site IS NULL
 THEN transit_connections.SiteName = transit_connections.SiteName
 ELSE transit_connections.SiteName = Site END
  AND CASE WHEN Route IS NULL
 THEN transit_connections.TransitRoute = transit_connections.TransitRoute
 ELSE transit_connections.TransitRoute = Route END
 AND take.TransitDate BETWEEN StartDate AND EndDate;
END //
DELIMITER ;


/* Screen 17 - Employee Manage Profile */
DELIMITER //
CREATE PROCEDURE s17_manage_profile(IN username VARCHAR(50),fname VARCHAR(50), lname VARCHAR(50), phone VARCHAR(20))
BEGIN
UPDATE user
SET user.Firstname=fname,user.Lastname=lname
WHERE user.Username=username;
UPDATE employee
SET employee.Phone=phone
WHERE employee.Username=username;
END //
DELIMITER ;

/* Screen 18 - Administrator Manage User */

DELIMITER //
CREATE PROCEDURE s18_manage_user(IN
  username VARCHAR(50),
  type ENUM('User','Visitor','Employee','Employee, Visitor'),
  status ENUM('Approved','Declined','Pending'))
BEGIN
SELECT DISTINCT user.Username as username,user.UserType as type, user.Status as status, count(*) as email_count
FROM user
INNER JOIN emails ON emails.Username=user.Username
GROUP BY emails.Username, user.UserType HAVING CONCAT(user.Username,user.UserType) IN (
  SELECT CONCAT(user.Username,user.UserType)
  FROM user
  WHERE
   CASE WHEN type IS NULL
   THEN user.UserType = user.UserType
   ELSE user.UserType = type END
   AND CASE WHEN username IS NULL
   THEN user.Username = user.Username
   ELSE user.Username = username END
	AND CASE WHEN status IS NULL
   THEN user.Status = user.Status
   ELSE user.Status = status END);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE s18_user_status_update(IN
  UName VARCHAR(50),
  UStat ENUM('Approved','Declined'))
BEGIN
	UPDATE user
  SET Status = UStat
  WHERE Username = UName;
 END //
DELIMITER ;

/* Screen 19 - Administrator Manage Site */

DELIMITER //
CREATE PROCEDURE s19_manage_site(IN
  sitename VARCHAR(50),
  fname VARCHAR(50),
  lname VARCHAR(50),
  open_everyday ENUM('Yes','No'))
BEGIN
SELECT site.SiteName as Name,CONCAT(user.Firstname,' ',user.Lastname) as Manager,site.OpenEveryday
FROM site
INNER JOIN user ON user.Username=site.ManagerUsername
WHERE
  CASE WHEN sitename IS NULL
  THEN site.SiteName = site.SiteName
  ELSE site.SiteName = sitename END
  AND CASE WHEN fname IS NULL
  THEN user.Firstname = user.Firstname
  ELSE user.Firstname = fname END
  AND CASE WHEN lname IS NULL
  THEN user.Lastname = user.Lastname
  ELSE user.Lastname = lname END
  AND CASE WHEN open_everyday IS NULL
  THEN site.OpenEveryday = site.OpenEveryday
  ELSE site.OpenEveryday = open_everyday END;
END //
DELIMITER ;

/* Screen 20 - Administrator Edit Site */

DELIMITER //
CREATE PROCEDURE s20_edit_site(IN
  old_name VARCHAR(50),
  new_name VARCHAR(50),
  address VARCHAR(50),
  zipcode CHAR(5),
  fname VARCHAR(50),
  lname VARCHAR(50),
  open_everyday ENUM('Yes','No'))
BEGIN

UPDATE site
SET site.SiteName=new_name,site.siteZipcode=zipcode,site.SiteAddress=address,site.OpenEveryday=open_everyday ,site.ManagerUsername=(SELECT UserName FROM user WHERE user.Firstname=fname AND user.Lastname=lname)
WHERE site.SiteName = old_name;

END //
DELIMITER ;

/* Screen 21 - Administrator Create Site */

DELIMITER //
CREATE PROCEDURE s21_create_site(IN
  SName VARCHAR(50),
  SAddress VARCHAR(50),
  SZipcode CHAR(5),
  Fname VARCHAR(50),
  Lname VARCHAR(50),
  open_everyday ENUM('Yes','No'))
BEGIN

SET @Mgrname=(SELECT UserName FROM user WHERE user.Firstname=Fname AND user.Lastname=Lname);
INSERT INTO site(Sitename, SiteAddress, SiteZipcode, OpenEveryday, ManagerUsername) VALUES (SName, SAddress, SZipcode, open_everyday, @Mgrname);

END //
DELIMITER;

/* Screen 22 - Administrator Manage Transit */
/*MANAGE TRANSIT - Page 22 DeleteTransit removes a transit entry from transit table*/
DELIMITER //
CREATE PROCEDURE s22_manage_transit(IN
  TType ENUM('MARTA','Bus','Bike'),
  Site VARCHAR(50),
  Route VARCHAR(20),
  PrangeL DECIMAL(7,2),
  PrangeU DECIMAL(7,2))
BEGIN

DROP VIEW IF EXISTS log_counts;

CREATE VIEW log_counts AS
SELECT take.TransitType as TransitType, take.TransitRoute as TransitRoute, count(*) AS Num_logs
FROM take
GROUP BY take.TransitType, take.TransitRoute;

SELECT transit.TransitType, transit.TransitRoute, transit.TransitPrice, log_counts.Num_logs, count(*) AS conn_sites
FROM transit
JOIN connect ON transit.TransitType=connect.TransitType AND transit.TransitRoute=connect.TransitRoute
JOIN log_counts ON transit.TransitType=log_counts.TransitType AND transit.TransitRoute=log_counts.TransitRoute
GROUP BY transit.TransitType, transit.TransitRoute, transit.TransitPrice HAVING CONCAT(transit.TransitType, transit.TransitRoute, transit.TransitPrice) IN(
SELECT CONCAT(transit.TransitType, transit.TransitRoute, transit.TransitPrice)
FROM transit
JOIN connect ON transit.TransitType=connect.TransitType AND transit.TransitRoute=connect.TransitRoute
WHERE
CASE WHEN TType IS NULL
 THEN transit.TransitType=transit.TransitType
 ELSE transit.TransitType = TType END
 AND CASE WHEN Site IS NULL
 THEN connect.SiteName = connect.SiteName
 ELSE connect.SiteName = Site END
  AND CASE WHEN Route IS NULL
 THEN connect.TransitRoute = connect.TransitRoute
 ELSE connect.TransitRoute = Route END
 AND transit.TransitPrice BETWEEN PrangeL AND PrangeU);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE s22_delete_transit(IN
  TType ENUM('MARTA','Bus','Bike'),
  Route VARCHAR(20))
BEGIN
DELETE FROM transit
WHERE TransitType = TType and TransitRoute = Route;
END //
DELIMITER;

/* Screen 23 - Administrator Edit Transit */
/*Edit transit- Page 23
#RemoveSites removes all entries matching the entered route num
#EditTransit re adds rows corresponding to the newly entered sites
#EditPrice updates price if it is changed in transit table*/

DELIMITER //
CREATE PROCEDURE s23_delete_sites(IN
  TType ENUM('MARTA','Bus','Bike'),
  Route VARCHAR(20))
BEGIN
DELETE FROM connect
WHERE connect.TransitRoute = Route AND connect.TransitType = TType;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE s23_add_sites(
  IN Route VARCHAR(20),
  TType ENUM('MARTA','Bus','Bike'),
  Site_Name VARCHAR(20))
BEGIN
INSERT INTO connect (TransitType, TransitRoute, SiteName)
VALUES (TType, Route, Site_Name);
 END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE s23_edit_price(IN
  TType ENUM('MARTA','Bus','Bike'),
  Price DECIMAL(7,2),
  Route VARCHAR(20))
BEGIN
UPDATE transit
SET transit.TransitPrice = Price
WHERE transit.TransitRoute = Route AND transit.TransitType = TType;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE s23_edit_route(IN
  TType ENUM('MARTA','Bus','Bike'),
  OldRoute VARCHAR(20),
  Route VARCHAR(20))
BEGIN
UPDATE transit
SET transit.TransitRoute = Route
WHERE transit.TransitRoute = OldRoute AND transit.TransitType = TType;
END //
DELIMITER;

/* Screen 24 - Administrator Create Transit */

/* Page 24 Create Transit */
DELIMITER //
CREATE PROCEDURE s24_create_transit(IN
  TType ENUM('MARTA','Bus','Bike'),
  Route VARCHAR(20),
  Price DECIMAL(7,2))
BEGIN
INSERT INTO transit(TransitType, TransitRoute, TransitPrice)
VALUES (TType, Route, Price);
END //
DELIMITER;

/* Screen 25 - Manager Manage Event */
/*#MANAGE EVENT - Page 25
#CreateEvent adds a new event to the event table
#DeleteEvents deletes and event
#Duration calculates the length of the event in days
#TotalVisits return number of visits to that site
#StaffCount returns number of staff assigned to site
#Total revenue calculated by multiplying visits by price*/
DELIMITER //
CREATE PROCEDURE s25_manage_event(IN
  EName VARCHAR(50),
  Keyword VARCHAR(50),
  SName VARCHAR(50),
  SDate DATE,
  EDate DATE,
  DrangeL DECIMAL (7,0),
  DrangeU DECIMAL (7,0),
  DurangeL DECIMAL (7,0),
  DurangeU DECIMAL (7,0),
  VrangeL DECIMAL (7,0),
  VrangeU DECIMAL (7,0),
  RrangeL DECIMAL(7,2),
  RrangeU DECIMAL(7,2))
BEGIN

DROP VIEW IF EXISTS event_visit_counts;

CREATE VIEW event_visit_counts AS
SELECT event.EventName, event.SiteName, event.StartDate, count(*) AS total_visits, DATEDIFF(event.EndDate,event.StartDate) as duration, count(*)*event.EventPrice as revenue
FROM event
JOIN visitevent ON event.EventName = visitevent.EventName AND event.SiteName = visitevent.SiteName AND event.StartDate = visitevent.StartDate
GROUP BY event.EventName, event.SiteName, event.StartDate, event.EndDate;

DROP VIEW IF EXISTS event_staff_counts;

CREATE VIEW event_staff_counts AS
SELECT event.EventName, event.SiteName, event.StartDate, count(*) AS num_staff
FROM event
JOIN staff_assignment ON event.EventName = staff_assignment.EventName AND event.SiteName = staff_assignment.SiteName AND event.StartDate = staff_assignment.StartDate
GROUP BY event.EventName, event.SiteName, event.StartDate;

SELECT event.EventName, event_staff_counts.num_staff, event_visit_counts.duration, event_visit_counts.total_visits, event_visit_counts.revenue
FROM event
JOIN event_staff_counts ON event.EventName = event_staff_counts.EventName AND event.SiteName = event_staff_counts.SiteName AND event.StartDate = event_staff_counts.StartDate
JOIN event_visit_counts ON event.EventName = event_visit_counts.EventName AND event.SiteName = event_visit_counts.SiteName AND event.StartDate = event_visit_counts.StartDate
GROUP BY event.EventName, event.SiteName, event.StartDate HAVING CONCAT(event.EventName, event.SiteName, event.StartDate) IN(
SELECT CONCAT(event.EventName, event.SiteName, event.StartDate)
FROM event
JOIN event_visit_counts ON event.EventName = event_visit_counts.EventName AND event.SiteName = event_visit_counts.SiteName AND event.StartDate = event_visit_counts.StartDate
WHERE
CASE WHEN EName IS NULL
 THEN event.EventName=event.EventName
 ELSE event.EventName = EName END
 AND CASE WHEN Keyword IS NULL
 THEN event.Description LIKE '%'
 ELSE event.Description LIKE CONCAT ('%',Keyword,'%') END
 AND event.SiteName = SName
 AND event_visit_counts.revenue BETWEEN RrangeL AND RrangeU
 AND event_visit_counts.total_visits BETWEEN VrangeL AND VrangeU
 AND event_visit_counts.duration BETWEEN DurangeL AND DurangeU
 AND (event.StartDate BETWEEN SDate and EDate OR event.EndDate BETWEEN SDate and EDate));

 END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE s26_delete_event(IN
  EName VARCHAR(50),
  SName VARCHAR(50),
  SDate Date)
BEGIN
DELETE FROM event
WHERE EventName = EName and StartDate = SDate and SiteName = SName;
END //
DELIMITER;

/* Screen 26 - Manager View/Edit Event */
/*#VIEW/EDIT EVENT - Page 26
#RemoveStaff removes staff entry from staff_assignment table
#AddStaff adds staff entry to staff_assignment table
#UpdateDescription updates description in event table*/
DELIMITER //
CREATE PROCEDURE s26_remove_staff(IN
  EName VARCHAR(50),
  SName VARCHAR(50),
  SDate Date,
  Fname VARCHAR(50),
  Lname VARCHAR(50))
BEGIN
SET @Staffname=(SELECT UserName FROM user WHERE user.Firstname=Fname AND user.Lastname=Lname);
DELETE FROM staff_assignment
WHERE EventName = EName AND StartDate = SDate AND SiteName = SName AND StaffUsername = @Staffname;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE s26_add_staff(IN
  EName VARCHAR(50),
  SName VARCHAR(50),
  SDate Date,
  Fname VARCHAR(50),
  Lname VARCHAR(50))
BEGIN
SET @Staffname=(SELECT UserName FROM user WHERE user.Firstname=Fname AND user.Lastname=Lname);
INSERT INTO staff_assignment(StaffUsername, EventName, SiteName, StartDate)
VALUES (@Staffname, EName, SName, SDate);
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE s26_update_description(IN
  EName VARCHAR(50),
  SName VARCHAR(50),
  SDate Date,
  Descr VARCHAR(1000))
BEGIN
UPDATE event
SET Description = Descr
WHERE EventName = EName and StartDate = SDate and SiteName = SName;
END //
DELIMITER;

/* Screen 27 - Manager Create Event */

DELIMITER //
CREATE PROCEDURE s27_staff_avail(IN
  SDate date,
  EDate date)
  BEGIN
  SELECT CONCAT(Firstname,' ',Lastname)
  FROM user
  WHERE Username NOT IN (
    SELECT DISTINCT StaffUsername
    FROM staff_assignment
    JOIN event ON event.EventName = staff_assignment.EventName AND event.SiteName = staff_assignment.SiteName AND event.StartDate = staff_assignment.StartDate
    WHERE staff_assignment.StartDate BETWEEN SDate and EDate OR event.EndDate BETWEEN SDate and EDate )
	AND Username IN (
	  SELECT Username
    FROM employee
    WHERE EmployeeType = 'Staff');
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE s27_mgr_create_event(IN Name VARCHAR(50), SDate date, EDate date,
Price DECIMAL(7,2), ECapacity INT(11), MinStaff INT(11), EDescr VARCHAR(1000),
SName VARCHAR(50))
BEGIN
INSERT INTO event(EventName, StartDate, EndDate, EventPrice, Capacity, MinStaffRequired, Description, SiteName)
VALUE(Name, SDate, EDate, Price, ECapacity, MinStaff, EDescr, SName);
END //
DELIMITER ;

/* Screen 28 - Manager Manage Staff */

DELIMITER //
CREATE PROCEDURE s28_mgr_manage_staff(IN
  SName VARCHAR(50),
  Fname VARCHAR(50),
  Lname VARCHAR(50),
  SDate date,
  EDate date)
BEGIN

  SELECT CONCAT(user.Firstname,' ',user.Lastname) AS staff_name, count(*) AS num_shifts
  FROM staff_assignment
  JOIN user ON staff_assignment.StaffUsername = user.Username
  JOIN event ON event.EventName = staff_assignment.EventName AND event.SiteName = staff_assignment.SiteName AND event.StartDate = staff_assignment.StartDate
  WHERE staff_assignment.StartDate BETWEEN SDate and EDate OR event.EndDate BETWEEN SDate and EDate
  GROUP BY user.Firstname, user.Lastname HAVING CONCAT(user.Firstname, user.Lastname) IN (
    SELECT CONCAT(user.Firstname, user.Lastname)
    FROM staff_assignment
    JOIN user ON staff_assignment.StaffUsername = user.Username
    WHERE
    CASE WHEN SName IS NULL
    THEN staff_assignment.SiteName=staff_assignment.SiteName
    ELSE staff_assignment.SiteName = SName END
    AND CASE WHEN FName IS NULL
    THEN user.Firstname=user.Firstname
    ELSE user.Firstname = Fname END
    AND CASE WHEN LName IS NULL
    THEN user.Lastname=user.Lastname
    ELSE user.Lastname = Lname END);

END //
DELIMITER ;

/* Screen 29 - Manager Site Report */

DELIMITER //
CREATE PROCEDURE s29_manager_site_report(IN
  SName VARCHAR(50),
  SDate DATE,
  EDate DATE,
  ECrangeL DECIMAL (7,0),
  ECrangeU DECIMAL (7,0),
  SCrangeL DECIMAL (7,0),
  SCrangeU DECIMAL (7,0),
  VrangeL DECIMAL (7,0),
  VrangeU DECIMAL (7,0),
  RrangeL DECIMAL(7,2),
  RrangeU DECIMAL(7,2))
BEGIN

/* Creating required views */
DROP VIEW IF EXISTS site_event_counts;

CREATE VIEW site_event_counts AS
SELECT SiteName, StartDate, EndDate, count(*) as num_events
FROM event
GROUP BY SiteName, StartDate, EndDate, SiteName;

DROP VIEW IF EXISTS site_visit_counts;

CREATE VIEW site_visit_counts AS
SELECT  SiteName, VisitSiteDate as VisitDate , count(*) as site_visits
FROM visitsite
GROUP BY SiteName,VisitSiteDate;

DROP VIEW IF EXISTS event_visit_counts;

CREATE VIEW event_visit_counts AS
SELECT  event.SiteName as SiteName, visitevent.VisitEventDate as VisitDate, count(*) as event_visits, count(*)*event.EventPrice as revenue
FROM event
JOIN visitevent ON event.EventName = visitevent.EventName AND event.SiteName = visitevent.SiteName AND event.StartDate = visitevent.StartDate
GROUP BY event.EventName, event.SiteName, event.StartDate, event.EndDate,visitevent.VisitEventDate;

DROP VIEW IF EXISTS daily_event_visits;

CREATE VIEW daily_event_visits AS
SELECT SiteName, VisitDate, SUM(event_visits)as event_visits, SUM(revenue)as revenue
FROM event_visit_counts
GROUP BY SiteName, VisitDate;

DROP VIEW IF EXISTS site_staff_counts;

CREATE VIEW site_staff_counts AS
SELECT event.SiteName as SiteName, event.StartDate as StartDate, event.EndDate as EndDate, count(*) AS num_staff
FROM event
JOIN staff_assignment ON event.EventName = staff_assignment.EventName AND event.SiteName = staff_assignment.SiteName AND event.StartDate = staff_assignment.StartDate
GROUP BY event.SiteName, event.StartDate, event.EndDate;
/* Created required views */

SELECT site_visit_counts.VisitDate,  (IFNULL(site_visit_counts.site_visits,0) + IFNULL(daily_event_visits.event_visits,0)) as total_visits, IFNULL(daily_event_visits.revenue,0) as revenue, IFNULL(site_staff_counts.num_staff,0) as staff_count, IFNULL(site_event_counts.num_events,0) as event_count
FROM site_visit_counts
LEFT JOIN site_staff_counts ON site_visit_counts.SiteName = site_staff_counts.SiteName AND site_visit_counts.VisitDate BETWEEN site_staff_counts.StartDate and site_staff_counts.EndDate
LEFT JOIN site_event_counts ON site_visit_counts.SiteName = site_event_counts.SiteName AND site_visit_counts.VisitDate BETWEEN site_event_counts.StartDate and site_event_counts.EndDate
RIGHT JOIN daily_event_visits ON daily_event_visits.SiteName = site_visit_counts.SiteName AND daily_event_visits.VisitDate = site_visit_counts.VisitDate
WHERE site_visit_counts.SiteName = SName
AND site_visit_counts.VisitDate BETWEEN SDate AND EDate
AND IFNULL(daily_event_visits.revenue,0) BETWEEN RrangeL AND RrangeU
AND (IFNULL(site_visit_counts.site_visits,0) + IFNULL(daily_event_visits.event_visits,0)) BETWEEN VrangeL AND VrangeU
UNION
SELECT site_visit_counts.VisitDate,  (IFNULL(site_visit_counts.site_visits,0) + IFNULL(daily_event_visits.event_visits,0)) as total_visits, IFNULL(daily_event_visits.revenue,0) as revenue, IFNULL(site_staff_counts.num_staff,0) as staff_count, IFNULL(site_event_counts.num_events,0) as event_count
FROM site_visit_counts
LEFT JOIN site_staff_counts ON site_visit_counts.SiteName = site_staff_counts.SiteName AND site_visit_counts.VisitDate BETWEEN site_staff_counts.StartDate and site_staff_counts.EndDate
LEFT JOIN site_event_counts ON site_visit_counts.SiteName = site_event_counts.SiteName AND site_visit_counts.VisitDate BETWEEN site_event_counts.StartDate and site_event_counts.EndDate
LEFT JOIN daily_event_visits ON daily_event_visits.SiteName = site_visit_counts.SiteName AND daily_event_visits.VisitDate = site_visit_counts.VisitDate
WHERE site_visit_counts.SiteName = SName
AND site_visit_counts.VisitDate BETWEEN SDate AND EDate
AND IFNULL(daily_event_visits.revenue,0) BETWEEN RrangeL AND RrangeU
AND (IFNULL(site_visit_counts.site_visits,0) + IFNULL(daily_event_visits.event_visits,0)) BETWEEN VrangeL AND VrangeU;

 END //
DELIMITER ;

/* Screen 30 - Manager Daily Detail */
/*TO DO*/
DELIMITER //
CREATE PROCEDURE s30_mgr_daily_detail(IN
  SName VARCHAR(50),
  SDate date)
BEGIN

CREATE VIEW

END //
DELIMITER ;

/* Screen 31 - Staff View Schedule */

DELIMITER //
CREATE PROCEDURE s31_view_schedule(IN
  EName VARCHAR(50),
  SName VARCHAR(50),
  Keyword VARCHAR(50),
  SDate DATE,
  EDate DATE)
 BEGIN
 SELECT staff_assignment.EventName, staff_assignment.SiteName, staff_assignment.StartDate, event.EndDate, Count(*) as StaffCount
 FROM staff_assignment
 INNER JOIN event ON staff_assignment.EventName = event.EventName AND staff_assignment.SiteName = event.SiteName AND staff_assignment.StartDate = event.StartDate
 WHERE
  CASE WHEN EName IS NULL
  THEN event.EventName = event.EventName
  ELSE event.EventName = EName END
  AND CASE WHEN SName IS NULL
  THEN event.SiteName = event.SiteName
  ELSE event.SiteName = SName END
  AND CASE WHEN Keyword IS NULL
  THEN event.Description LIKE '%'
  ELSE event.Description LIKE CONCAT ('%',Keyword,'%') END
  AND (event.StartDate BETWEEN SDate and EDate OR event.EndDate BETWEEN SDate and EDate)
 GROUP BY  staff_assignment.EventName, staff_assignment.SiteName, staff_assignment.StartDate, event.EndDate;
 END //
DELIMITER ;

/* Screen 32 - Staff Event Detail */
DELIMITER //
CREATE PROCEDURE s32_event_detail(IN EName VARCHAR(50))
 BEGIN
 SELECT EventName, SiteName, StartDate, EndDate, DATEDIFF(EndDate,StartDate) as Duration_days, Capacity, EventPrice
FROM event
WHERE EventName = EName;
 END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE s32_staff_assignment(IN EName VARCHAR(50))
 BEGIN
 SELECT concat(Firstname," ",Lastname)
 FROM user
 WHERE Username in (
	SELECT StaffUsername
	FROM staff_assignment
	WHERE EventName = EName)
;
 END //
DELIMITER ;

/* Screen 33 - Staff Event Detail */
DELIMITER //
CREATE PROCEDURE s33_explore_event(IN
  UName VARCHAR(50),
  EName VARCHAR(50),
  Keyword VARCHAR(50),
  SName VARCHAR(50),
  SDate DATE,
  EDate DATE,
  include_visited ENUM('Yes','No'),
  include_soldout ENUM('Yes','No'),
  VrangeL DECIMAL(3,0),
  VrangeU DECIMAL(3,0),
  PrangeL DECIMAL(6,2),
  PrangeU DECIMAL(6,2))
 BEGIN

 DROP VIEW IF EXISTS user_visits;

 CREATE VIEW user_visits AS
 SELECT EventName,SiteName,StartDate,VisitorUsername, count(*) as myvisits
 FROM visitevent
 GROUP BY EventName,SiteName,StartDate,VisitorUsername;

 SELECT visitevent.EventName, visitevent.SiteName, event.StartDate, EventPrice, event.Capacity - count(*) as TixRemaining, Count(*) as TVisits, user_visits.myvisits
 FROM event
 JOIN visitevent on visitevent.EventName = event.EventName AND visitevent.SiteName = event.SiteName AND visitevent.StartDate = event.StartDate
 JOIN user_visits on user_visits.EventName = event.EventName AND user_visits.SiteName = event.SiteName AND user_visits.StartDate = event.StartDate
 WHERE user_visits.Visitorusername =  UName
 GROUP BY event.EventName, event.SiteName, event.StartDate
 HAVING count(*) BETWEEN VrangeL AND VrangeU
 AND CASE WHEN include_soldout = 'No'
 THEN TixRemaining > 0
 ELSE TixRemaining = TixRemaining END
 AND CONCAT(event.EventName,event.SiteName, event.StartDate) IN (
 SELECT CONCAT(event.EventName,event.SiteName, event.StartDate)
 FROM event
 WHERE
 CASE WHEN EName IS NULL
  THEN event.EventName = event.EventName
  ELSE event.EventName LIKE CONCAT('%',EName,'%') END
  AND CASE WHEN SName IS NULL
  THEN event.SiteName = event.SiteName
  ELSE event.SiteName = SName END
  AND CASE WHEN Keyword IS NULL
  THEN event.Description LIKE '%'
  ELSE event.Description LIKE CONCAT ('%',Keyword,'%') END
  AND (event.StartDate BETWEEN SDate and EDate OR event.EndDate BETWEEN SDate and EDate)
  AND CASE WHEN include_visited = 'No'
  THEN CONCAT(event.EventName,event.SiteName, event.StartDate) NOT IN (
    SELECT CONCAT(visitevent.EventName,visitevent.SiteName, visitevent.StartDate)
    FROM visitevent WHERE VisitorUsername = UName)
  ELSE CONCAT(event.EventName,event.SiteName, event.StartDate) = CONCAT(event.EventName,event.SiteName, event.StartDate) END
  AND EventPrice BETWEEN PrangeL AND PrangeU);
 END //
DELIMITER ;

/* Screen 34 - Log visit */
DELIMITER //
CREATE PROCEDURE s34_log_event_visit(IN
  UName VARCHAR(50),
  EName VARCHAR(50),
  SName VARCHAR(50),
  SDate DATE,
  VDate DATE)
 BEGIN
 INSERT INTO visitevent(VisitorUsername,EventName,StartDate,SiteName,VisitEventDate) VALUES (Uname,EName,SDate,SName,VDate);
 END //
DELIMITER ;

/* Screen 35 - Visitor Explore Site */
DELIMITER //
CREATE PROCEDURE s35_explore_site(IN
  UName VARCHAR(50),
  SName VARCHAR(50),
  include_visited ENUM('Yes','No'),
  SDate date,
  EDate date,
  VrangeL DECIMAL(7,0),
  VrangeU DECIMAL(7,0),
  ECrangeL DECIMAL(7,0),
  ECrangeU DECIMAL(7,0))
 BEGIN

  DROP VIEW IF EXISTS site_event_counts;

  CREATE VIEW site_event_counts AS
  SELECT SiteName,  count(*) as event_count
  FROM event
  GROUP BY SiteName;

  DROP VIEW IF EXISTS site_visit_counts;

  CREATE VIEW site_visit_counts AS
  SELECT  SiteName, count(*) as site_visits
  FROM visitsite
  GROUP BY SiteName;

  DROP VIEW IF EXISTS event_visit_counts;

  CREATE VIEW event_visit_counts AS
  SELECT  SiteName, count(*) as event_visits
  FROM visitevent
  GROUP BY visitevent.SiteName;

  DROP VIEW IF EXISTS total_visit_counts;

  CREATE VIEW total_visit_counts AS
  SELECT site.SiteName, (IFNULL(site_visit_counts.site_visits,0) + IFNULL(event_visit_counts.event_visits,0)) AS total_visits
  FROM site
  JOIN site_visit_counts ON site.SiteName = site_visit_counts.SiteName
  JOIN event_visit_counts ON site.SiteName = event_visit_counts.SiteName;

  DROP VIEW IF EXISTS total_user_visit_counts;

  CREATE VIEW total_user_visit_counts AS
  SELECT  SiteName, VisitSiteDate as VisitDate,VisitorUsername, count(*) as num_visits
  FROM visitsite
  GROUP BY SiteName, VisitSiteDate, VisitorUsername
  UNION ALL
  SELECT  SiteName, VisitEventDate as VisitDate,VisitorUsername, count(*) as num_visits
  FROM visitevent
  GROUP BY SiteName, VisitEventDate, VisitorUsername;

  SELECT site.SiteName, IFNULL(site_event_counts.event_count,0) as num_events, IFNULL(total_visit_counts.total_visits,0) as total_visits, sum(num_visits) as user_visits
  FROM site
  JOIN total_visit_counts on site.SiteName = total_visit_counts.SiteName
  JOIN site_event_counts on site.SiteName = site_event_counts.SiteName
  JOIN total_user_visit_counts on site.SiteName = total_user_visit_counts.SiteName
  WHERE
  total_user_visit_counts.VisitorUsername = UName
  AND total_user_visit_counts.VisitDate BETWEEN SDate AND EDate
  GROUP BY site.SiteName
   HAVING site.SiteName IN
  (
    SELECT DISTINCT site.SiteName
    FROM site
    JOIN total_visit_counts on site.SiteName = total_visit_counts.SiteName
    JOIN site_event_counts on site.SiteName = site_event_counts.SiteName
    JOIN total_user_visit_counts on site.SiteName = total_user_visit_counts.SiteName
    WHERE
    CASE WHEN SName IS NULL
    THEN site.SiteName = site.SiteName
    ELSE site.SiteName = SName END
    AND CASE WHEN include_visited = 'No'
    THEN site.SiteName NOT IN (
    SELECT DISTINCT visitsite.SiteName
    FROM visitsite WHERE VisitorUsername = UName)
    ELSE site.SiteName = site.SiteName END
    AND IFNULL(total_visit_counts.total_visits,0) BETWEEN VrangeL AND VrangeU
    AND IFNULL(site_event_counts.event_count,0) BETWEEN ECrangeL AND ECrangeU);
   END //
  DELIMITER ;

/* Screen 36 - Visitor Transit Detail */
#First get the table info
DELIMITER //
CREATE PROCEDURE s36_transit_detail(IN TType ENUM('MARTA','Bus','Bike'), sName VARCHAR(50))
BEGIN
DROP VIEW IF EXISTS conn_site_counts;

CREATE VIEW conn_site_counts AS
SELECT  TransitType, TransitRoute, count(*) as conn_sites
FROM connect;

SELECT transit.TransitRoute as Route, transit.TransitType as TransportType, transit.TransitPrice as Price, conn_site_counts.conn_sites as NumConnectedSites
FROM transit
JOIN connect ON transit.TransitRoute = connect.TransitRoute AND transit.TransitType = connect.TransitType
JOIN conn_site_counts on transit.TransitRoute = conn_site_counts.TransitRoute AND transit.transitType = conn_site_counts.TransitType
WHERE transit.TransitType = TType AND connect.siteName = sName;
END //
DELIMITER ;

#Log transit
DELIMITER //
CREATE PROCEDURE s36_log_transit(In TDate DATE, TType ENUM('MARTA','Bus','Bike'), Route VARCHAR(20), UserN VARCHAR(50))
BEGIN
INSERT INTO take (TransitDate, TransitType, TransitRoute, Username)
VALUES (TDate, TType, Route, UserN);
END //
DELIMITER;

/* Screen 37 - Visitor Site Detail */
/*Display the site details*/
DELIMITER //
CREATE PROCEDURE s37_view_site_detail(IN
sName VARCHAR(50))
BEGIN
SELECT SiteName as Site, OpenEveryday, CONCAT(SiteAddress, ', Atlanta, GA ', SiteZipcode) as Address
FROM site
WHERE site.SiteName = sname;
END //
DELIMITER ;

/*LogSiteVisit adds a log entry to visitsite table*/
DELIMITER //
CREATE PROCEDURE s37_log_site_visit(IN VisitDate DATE, Name VARCHAR(50), Username VARCHAR(50))
BEGIN
INSERT INTO visitsite (VisitSiteDate, SiteName, VisitorUsername)
VALUES (VisitDate, Name, Username);
END //
DELIMITER;

/* Screen 38 - Visitor Site Detail */
#First query for site list
DELIMITER //
CREATE PROCEDURE s38_get_sites()
BEGIN
SELECT DISTINCT SiteName from site;
END //
DELIMITER ;

#Display Table
DELIMITER //
CREATE PROCEDURE s38_display_visit_history(IN
eName VARCHAR(100),
sName VARCHAR(50),
startDate DATE,
endDate DATE)
BEGIN
SELECT visitevent.VisitEventDate as Date, visitevent.EventName as Event, visitevent.SiteName as Site, event.EventPrice as Price
FROM visitEvent
JOIN event ON visitEvent.StartDate = Event.StartDate AND visitEvent.EventName = event.EventName AND visitEvent.SiteName = Event.SiteName
WHERE
CASE WHEN eName IS NULL
   THEN visitevent.EventName=visitevent.EventName
   ELSE visitevent.EventName LIKE CONCAT('%', eName, '%') END
   AND CASE WHEN sName IS NULL
   THEN visitevent.SiteName=visitevent.SiteName
   ELSE visitevent.SiteName = eName END
   AND visitEvent.VisitEventDate BETWEEN startDate AND endDate
UNION
SELECT visitsite.VisitSiteDate as Date, visitsite.SiteName as Site, 0 as Price, NULL as Event
FROM visitSite
JOIN event ON visitSite.SiteName = Event.SiteName
WHERE
CASE WHEN sName IS NULL
   THEN visitsite.SiteName=visitsite.SiteName
   ELSE visitsite.SiteName = sName END;
END //
DELIMITER ;
