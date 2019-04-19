use Beltline;
DELIMITER //
CREATE PROCEDURE s01_user_login_check_email(IN
  EMailID VARCHAR(50))
BEGIN
	SELECT EXISTS (SELECT Username FROM emails WHERE Email = EMailID);
 END //
DELIMITER ;s01_user_login_check_email

DELIMITER //
CREATE PROCEDURE s01_user_login_check_password(IN
  EMailID VARCHAR(50),
  Pass VARCHAR(25))
BEGIN
	SELECT UserType
    FROM user
    WHERE Username in (SELECT Username FROM emails WHERE Email = EMailID) AND Password = Pass;
 END //
DELIMITER ;

DELIMITER //
<<<<<<< HEAD
CREATE PROs01_user_login_check_passwordCEDURE s01_employee_check_type(IN
  EMailID VARCHAR(50))
=======
CREATE PROCEDURE s01_employee_check_type(IN
  EMailID VARCHAR(50)
>>>>>>> da4a5046851a4aa8ec739ae8f1fcf686042bea77
BEGIN
	SELECT EmployeeType
    FROM employee
    WHERE Username in (SELECT Username FROM emails WHERE Email = EMailID);
 END //
DELIMITER ;

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

DELIMITER //
CREATE PROCEDURE s03_add_email(IN UName VARCHAR(50),
  EMail VARCHAR(50))
 BEGIN
 INSERT INTO emails(Username,Email) VALUES (UName,EMail);
 END //
DELIMITER ;

/*Page 31*/

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

/*Page 32*/
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

/*Page 33*/
DELIMITER //
CREATE PROCEDURE s33_explore_event(IN
  EName VARCHAR(50),
  Keyword VARCHAR(50),
  SName VARCHAR(50),
  SDate DATE,
  EDate DATE,
  VrangeU DECIMAL(3,0),
  VrangeL DECIMAL(3,0),
  PrangeU DECIMAL(6,2),
  PrangeL DECIMAL(6,2))
 BEGIN
 SELECT visitevent.EventName, visitevent.SiteName, EventPrice, Count(*) as TVisits, event.Capacity - count(*) as TixRemaining
 FROM visitevent
 JOIN event on visitevent.EventName = event.EventName AND visitevent.SiteName = event.SiteName AND visitevent.StartDate = event.StartDate
 GROUP BY visitevent.EventName, visitevent.SiteName, visitevent.StartDate HAVING count(*) BETWEEN VrangeL AND VrangeU and CONCAT(visitevent.EventName,visitevent.SiteName, visitevent.StartDate) IN (
 SELECT CONCAT(event.EventName,event.SiteName, event.StartDate)
 FROM event
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
  AND EventPrice BETWEEN PrangeL AND PrangeU);
 END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE s33_user_visits(IN
  UName VARCHAR(50),
  EName VARCHAR(50),
  SName VARCHAR(50),
  SDate DATE)
 BEGIN
 SELECT count(*) as myvisits
 FROM visitevent
 WHERE CONCAT(EventName,SiteName,StartDate,VisitorUsername) = CONCAT(EName,SName,SDate,UName);
 END //
DELIMITER ;

/*Page 34 - Log visit*/
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


/* page 15 - Explore transit if choice is NOT 'ALL' */
DELIMITER //
CREATE PROCEDURE s15_get_route(IN
  TType VARCHAR(50),
  Site VARCHAR(50),
  TPriceMin DECIMAL(7,2),
  TPriceMax DECIMAL(7,2))
BEGIN
SELECT connect.TransitType as Type,connect.TransitRoute as Route, transit.TransitPrice as Price, count(*) as No_of_Connected_Sites
FROM transit
INNER JOIN connect ON transit.TransitType=connect.TransitType AND transit.TransitRoute=connect.TransitRoute
GROUP BY transit.TransitType,transit.TransitRoute HAVING CONCAT(transit.TransitType,transit.TransitRoute) IN (
  SELECT CONCAT(transit.TransitType,transit.TransitRoute)

)
END //
DELIMITER ;

/* Page 16 - Transit History*/
CREATE PROCEDURE s16_transit_history(IN TType VARCHAR(50), Site VARCHAR(50), Route VARCHAR(20), StartDate DATE, EndDate DATE)
BEGIN
SELECT DISTINCT take.TransitDate as Date,take.TransitType as Type,take.TransitRoute as Route, transit.TransitPrice as Price
FROM transit
INNER JOIN take ON transit.TransitType=take.TransitType AND transit.TransitRoute=take.TransitRoute
INNER JOIN connect ON transit.TransitType=connect.TransitType AND transit.TransitRoute=connect.TransitRoute
WHERE transit.TransitType = TType AND take.TransitDate>=StartDate AND take.TransitDate<=EndDate AND connect.SiteName = Site;
END //
DELIMITER ;

/* Page 18 - Manage User*/
DELIMITER //
CREATE PROCEDURE s18_manage_user(IN username VARCHAR(50), type ENUM('User','Visitor','Employee','Employee, Visitor'), status ENUM('Approved','Declined','Pending'))
BEGIN
SELECT DISTINCT user.Username as username,user.UserType as type, user.Status as status, count(*) as email_count
FROM user
INNER JOIN emails ON emails.Username=user.Username
WHERE emails.Username = username AND user.UserType = type AND user.Status = status
GROUP BY emails.Username;
END //
DELIMITER ;

/* Page 19 - Manage Site*/
DELIMITER //
CREATE PROCEDURE s19_manage_site(IN sitename VARCHAR(50), fname VARCHAR(50), lname VARCHAR(50), open_everyday ENUM('Yes','No'))
BEGIN
SELECT site.SiteName as Name,CONCAT(fname,' ',lname) as Manager,site.OpenEveryday
FROM site
INNER JOIN user ON user.Username=site.ManagerUsername
WHERE user.FirstName= fname AND user.LastName = lname AND user.UserType IN ('Employee','Employee, Visitor');
END //
DELIMITER ;

/* Page 20 - Edit Site*/
DELIMITER //
CREATE PROCEDURE s20_edit_site(IN old_name VARCHAR(50),new_name VARCHAR(50), address VARCHAR(50), zipcode CHAR(5), fname VARCHAR(50),lname VARCHAR(50), open_everyday ENUM('Yes','No'))
BEGIN

UPDATE site
SET site.SiteName=new_name,site.siteZipcode=zipcode,site.SiteAddress=address,site.OpenEveryday=open_everyday ,site.ManagerUsername=(SELECT UserName FROM user WHERE user.Firstname=fname AND user.Lastname=lname)
WHERE site.SiteName = old_name;

END //
DELIMITER ;

#CREATE SITE - PAGE 21
#CreateSite adds a new site entry into site table

DELIMITER //
CREATE PROCEDURE CreateSite(IN Site VARCHAR(50), SiteAddr VARCHAR (100), Zip CHAR(5), OpenErrday ENUM('Yes','No'), Manager VARCHAR(50))
BEGIN
INSERT INTO site (Sitename, SiteAddress, SiteZipcode, OpenEveryday, ManagerUsername)
VALUES (Site, SiteAddr, Zip, OpenErrday, Manager);
END //
DELIMITER; 

#MANAGE TRANSIT - Page 22
#DeleteTransit removes a transit entry from transit table

DELIMITER //
CREATE PROCEDURE DeleteTransit(IN TType ENUM('MARTA','Bus','Bike'), Route VARCHAR(20))
BEGIN
DELETE FROM transit
WHERE TransitType = TType and TransitRoute = Route;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE ConnectedSites(Route VARCHAR(20))
BEGIN
SELECT Count(*)
FROM connect
WHERE TransitRoute = Route;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE NumTransitLogged(Route VARCHAR(20))
BEGIN
SELECT COUNT(*) 
FROM take
WHERE TransitRoute = Route;
END //
DELIMITER;

#EDIT EVENT - Page 23
#RemoveSites removes all entries matching the entered route num
#EditTransit re adds rows corresponding to the newly entered sites
#EditPrice updates price if it is changed in transit table

DELIMITER //
CREATE PROCEDURE RemoveSites(IN Route VARCHAR(20))
BEGIN
DELETE FROM connect 
WHERE connect.TransitRoute = Route;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE EditTransit(IN Route VARCHAR(20), TType ENUM('MARTA','Bus','Bike'), Site_Name VARCHAR(20))
BEGIN
INSERT INTO connect (TransitType, TransitRoute, SiteName)
VALUES (TType, Route, Site_Name);
 END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE EditPrice(IN Price DECIMAL(7,2), Route VARCHAR(20))
BEGIN
UPDATE transit
SET transit.TransitPrice = Price
WHERE transit.TransitRoute = Route;
END //
DELIMITER;

#CREATE TRANSIT - Page 24
#CreateTransit creates a new transit entry in the transit table
DELIMITER //
CREATE PROCEDURE CreateTransit(IN TType ENUM('MARTA','Bus','Bike'), Route VARCHAR(20), Price DECIMAL(7,2))
BEGIN
INSERT INTO transit(TransitType, TransitRoute, TransitPrice)
VALUES (TType, Route, Price);
END //
DELIMITER;

#~~Use EditTransit procedure above to add connected sites~~

#MANAGE EVENT - Page 25
#CreateEvent adds a new event to the event table
#DeleteEvents deletes and event
#Duration calculates the length of the event in days
#TotalVisits return number of visits to that site
#StaffCount returns number of staff assigned to site
#Total revenue calculated by multiplying visits by price


DELIMITER //
CREATE PROCEDURE DeleteEvent(IN Nombre VARCHAR(100), StartD Date, EndD Date)
BEGIN
DELETE FROM event
WHERE EventName = Nombre and StartDate = StartD and EndDate = EndD;
END //
DELIMITER;

DELIMITER  //
CREATE PROCEDURE Duration(IN StartD Date, EndD Date)
BEGIN
SELECT DATEDIFF(StartD, EndD) as DateDifference;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE TotalVisits(IN Nombre VARCHAR(100))
BEGIN
SELECT COUNT(*) FROM visitevent
WHERE EventName = Nombre;
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE StaffCount(IN Nombre VARCHAR(100), StartD Date)
BEGIN
SELECT COUNT(*)
FROM staff_assignment
WHERE EventName = Nombre and StartDate = StartD;
END //
DELIMITER; 

#VIEW/EDIT EVENT - Page 26
#RemoveStaff removes staff entry from staff_assignment table
#AddStaff adds staff entry to staff_assignment table
#UpdateDescription updates description in event table

DELIMITER //
CREATE PROCEDURE RemoveStaff(IN Nombre VARCHAR(100), StartD Date, EmployeeName VARCHAR(50))
BEGIN
DELETE FROM staff_assignment 
WHERE EventName = Nombre and StartDate = StartD and EmployeeName = StaffUsername;
END //
DELIMITER; 

DELIMITER //
CREATE PROCEDURE AddStaff(IN Nombre VARCHAR(100), StartD Date, EmployeeName VARCHAR(50), Site VARCHAR(50))
BEGIN
INSERT INTO staff_assignment(StaffUsername, EventName, SiteName, StartDate)
VALUES (EmployeeName, Nombre, Site, StartD);
END //
DELIMITER;

DELIMITER //
CREATE PROCEDURE UpdateDescription(IN Nombre VARCHAR(100), StartD Date, Site VARCHAR(50), Descr VARCHAR(1000))
BEGIN
UPDATE event
SET Description = Descr
WHERE EventName = Nombre and StartDate = StartD and SiteName = Site;
END //
DELIMITER;

#EXPLORE SITE - Page 35

#DELIMITER //
#CREATE PROCEDURE SelectSite(IN OpenErrday ENUM('Yes','No'), )

#TRANSIT DETAIL - Page 36
#TransitDetail gets the route, transit type, and price info
#ConnectedSites gets num of connected sites
#LogTransit logs a transit in transit table

DELIMITER //
CREATE PROCEDURE TransitDetail(In TType ENUM('MARTA','Bus','Bike'))
BEGIN
Select TransitType, TransitRoute, TransitPrice
FROM transit
WHERE TransitType = TType;
END //
DELIMITER;

#Use ConnectedSites from above

DELIMITER //
CREATE PROCEDURE LogTransit(In TDate DATE, TType ENUM('MARTA','Bus','Bike'), Route VARCHAR(20), UserN VARCHAR(50))
BEGIN
INSERT INTO take (TransitDate, TransitType, TransitRoute, Username)
VALUES (TDate, TType, Route, UserN);
END //
DELIMITER;

#SITE DETAIL - Page 37
#LogSiteVisit adds a log entry to visitsite table

DELIMITER //
CREATE PROCEDURE LogSiteVisit(IN VisitDate DATE, Nombre VARCHAR(50), Username VARCHAR(50))
BEGIN
INSERT INTO visitsite (VisitSiteDate, SiteName, VisitorUsername)
VALUES (VisitDate, Nombre, Username);
END //


#VISIT HISTORY - Page 38
