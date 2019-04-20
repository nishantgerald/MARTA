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
CREATE PROCEDURE s01_employee_check_type(IN
  EMailID VARCHAR(50)
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

/* Page 16 - Take Transit*/
DELIMITER //
CREATE PROCEDURE s15_get_route(IN
  TType VARCHAR(50),
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


/* Page 16 - Transit History*/
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

/* page 17 - Employee Manage Profile */


/* Page 18 - Manage User*/
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

/* Page 18 - Update User Status */
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

/* Page 19 - Manage Site*/
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

/* Page 20 - Edit Site*/
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
