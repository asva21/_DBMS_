CREATE TABLE t14_INCIDENT
(
Incident_Id varchar(25) NOT NULL ,
Incident_Type VARCHAR(30) NULL ,
Incident_Date DATE NOT NULL ,
Description VARCHAR(100) NULL ,
CONSTRAINT XPKINCIDENT_17 PRIMARY KEY (Incident_Id)
);
CREATE UNIQUE INDEX XPKINCIDENT_17 ON t14_INCIDENT
(Incident_Id ASC);

CREATE TABLE t14_CUSTOMER
(
Cust_Id VARCHAR(20) NOT NULL ,
Cust_FName VARCHAR(10) NOT NULL ,
Cust_LName VARCHAR(10) NOT NULL ,
Cust_DOB DATE NOT NULL ,
Cust_Gender CHAR(2) NOT NULL ,
Cust_Address VARCHAR(20) NOT NULL ,
Cust_MOB_Number INTEGER NOT NULL ,
Cust_Email VARCHAR(20) NULL ,
Cust_Passport_Number VARCHAR(20) NULL ,
Cust_Marital_Status CHAR(8) NULL ,
Cust_PPS_Number INTEGER NULL ,
CONSTRAINT XPKCUSTOMER_1 PRIMARY KEY (Cust_Id)
);
CREATE UNIQUE INDEX XPKCUSTOMER_1 ON t14_CUSTOMER
(Cust_Id ASC);


CREATE TABLE t14_INCIDENT_REPORT 
(
Incident_Report_Id VARCHAR(20) NOT NULL , 
Incident_Type CHAR(10) NULL ,
Incident_Inspector VARCHAR(20) NULL , 
Incident_Cost INTEGER NULL ,
Incident_Report_Description VARCHAR(100) NULL , 
Incident_Id VARCHAR(20) NOT NULL ,
Cust_Id VARCHAR(20) NOT NULL ,
CONSTRAINT XPKINCIDENT_REPORT_18 PRIMARY KEY (Incident_Report_Id,Incident_Id,Cust_Id), 
CONSTRAINT R_83 FOREIGN KEY (Incident_Id) REFERENCES t14_INCIDENT (Incident_Id),
CONSTRAINT R_86 FOREIGN KEY (Cust_Id) REFERENCES t14_CUSTOMER (Cust_Id) 
);
CREATE UNIQUE INDEX XPKINCIDENT_REPORT_18 ON t14_INCIDENT_REPORT (Incident_Report_Id ASC,Incident_Id ASC,Cust_Id ASC);


CREATE TABLE t14_INSURANCE_COMPANY 
(
Company_Name VARCHAR(20) NOT NULL ,
Company_Address VARCHAR(20) NULL ,
Company_Contact_Number INTEGER NULL ,
Company_Fax INTEGER NULL ,
Company_Email VARCHAR(20) NULL ,
Company_Website VARCHAR(20) NULL ,
Company_Location VARCHAR(20) NULL ,
Company_Department_Name VARCHAR(20) NULL ,
Company_Office_Name VARCHAR(20) NULL ,
CONSTRAINT XPKINSURANCE_COMPANY_15 PRIMARY KEY(Company_Name)
);
CREATE UNIQUE INDEX XPKt14_INSURANCE_COMPANY_15 ON t14_INSURANCE_COMPANY(Company_Name ASC);


CREATE TABLE t14_DEPARTMENT
(
Department_Name VARCHAR(20) NOT NULL ,
Department_ID CHAR(18) NOT NULL ,
Department_Staff CHAR(18) NULL ,
Department_Offices CHAR(18) NULL ,
Company_Name VARCHAR(20) NOT NULL ,
CONSTRAINT XPKDEPARTMENT PRIMARY KEY(Department_Name,Department_ID,Company_Name),
CONSTRAINT R_56 FOREIGN KEY (Company_Name)REFERENCES t14_insurance_company( Company_Name)
);
CREATE UNIQUE INDEX XPKDEPARTMENT ON t14_DEPARTMENT
(Department_Name ASC,Department_ID ASC,Company_Name ASC);


CREATE TABLE t14_VEHICLE
(
Vehicle_Id VARCHAR(20) NOT NULL ,
Policy_Id VARCHAR(20) NULL ,
Dependent_NOK_Id VARCHAR(20) NULL ,
Vehicle_Registration_Number VARCHAR(20) NOT NULL ,
Vehicle_Value INTEGER NULL ,
Vehicle_Type VARCHAR(20) NOT NULL ,
Vehicle_Size INTEGER NULL ,
Vehicle_Number_Of_Seat INTEGER NULL ,
Vehicle_Manufacturer VARCHAR(20) NULL ,
Vehicle_Engine_Number INTEGER NULL ,
Vehicle_Chasis_Number INTEGER NULL ,
Vehicle_Number VARCHAR(20) NULL ,
Vehicle_Model_Number VARCHAR(20) NULL ,
Cust_Id VARCHAR(20) NOT NULL ,
CONSTRAINT XPKVEHICLE_6 PRIMARY KEY (Vehicle_Id,Cust_Id),
CONSTRAINT R_92 FOREIGN KEY (Cust_Id) REFERENCES t14_CUSTOMER(Cust_Id)
);
CREATE UNIQUE INDEX XPKVEHICLE_6 ON t14_VEHICLE (Vehicle_Id ASC,Cust_Id ASC);


CREATE TABLE t14_VEHICLE_SERVICE
(

Vehicle_Service_Company_Name VARCHAR(20) NOT NULL,
Vehicle_Service_Address VARCHAR(20) NULL,
Vehicle_Service_Contact VARCHAR(20) NULL,
Vehicle_Service_Incharge VARCHAR(20) NULL,
Vehicle_Service_Type VARCHAR(20) NULL,
Department_Name VARCHAR(20) NOT NULL,
Vehicle_Id VARCHAR(20) NOT NULL,
CONSTRAINT XPKVEHICLE_SERVICE PRIMARY KEY(Vehicle_Service_Company_Name),
CONSTRAINT R_50 FOREIGN KEY (Department_Name) REFERENCES t14_department (Department_Name),
FOREIGN KEY ( Vehicle_Id) REFERENCES t14_Vehicle(Vehicle_Id)

);

CREATE UNIQUE INDEX XPKVEHICLE_SERVICE ON t14_VEHICLE_SERVICE
(Vehicle_Service_Company_Name ASC,Department_Name ASC);


CREATE TABLE t14_PREMIUM_PAYMENT
(
Premium_Payment_Id VARCHAR(20) NOT NULL ,
Policy_Number VARCHAR(20) NOT NULL ,
Premium_Payment_Amount INTEGER NOT NULL ,
Premium_Payment_Schedule DATE NOT NULL ,
Receipt_Id VARCHAR(20) NOT NULL ,
Cust_Id VARCHAR(20) NOT NULL ,
CONSTRAINT XPKPREMIUM_PAYMENT_5 PRIMARY KEY(Premium_Payment_Id,Cust_Id),
CONSTRAINT R_85 FOREIGN KEY (Cust_Id) REFERENCES t14_CUSTOMER(Cust_Id)
);
CREATE UNIQUE INDEX XPKPREMIUM_PAYMENT_5 ON t14_PREMIUM_PAYMENT(Premium_Payment_Id ASC,Cust_Id ASC);



CREATE TABLE t14_RECEIPT
(
Receipt_Id VARCHAR(20) NOT NULL ,
Time DATE NOT NULL ,
Cost INTEGER NOT NULL ,
Premium_Payment_Id VARCHAR(20) NOT NULL ,
Cust_Id VARCHAR(20) NOT NULL ,
Vehicle_Id VARCHAR(20) NOT NULL,
CONSTRAINT XPKRECEIPT_21 PRIMARY KEY(Receipt_Id,Premium_Payment_Id,Cust_Id),
CONSTRAINT R_84 FOREIGN KEY (Premium_Payment_Id, Cust_Id)
REFERENCES t14_PREMIUM_PAYMENT (Premium_Payment_Id, Cust_Id),
FOREIGN KEY (Vehicle_Id)
REFERENCES t14_vehicle(Vehicle_Id)
);
CREATE UNIQUE INDEX XPKRECEIPT_21 ON t14_RECEIPT
(Receipt_Id ASC,Premium_Payment_Id ASC,Cust_Id ASC);



CREATE TABLE t14_APPLICATION
(
Application_Id VARCHAR(20) NOT NULL ,
Vehicle_Id VARCHAR(20) NOT NULL ,
Application_Status CHAR(8) NOT NULL ,
Coverage VARCHAR(50) NOT NULL ,
Cust_Id VARCHAR(20) NOT NULL ,
CONSTRAINT XPKAPPLICATION_2 PRIMARY KEY (Application_Id,Cust_Id),
CONSTRAINT R_93 FOREIGN KEY (Cust_Id) REFERENCES t14_CUSTOMER(Cust_Id)
);
CREATE UNIQUE INDEX XPKAPPLICATION_2 ON t14_APPLICATION(Application_Id ASC,Cust_Id ASC);


CREATE TABLE t14_INSURANCE_POLICY
(
Agreement_id VARCHAR(20) NOT NULL ,
Department_Name VARCHAR(20) NULL ,
Policy_Number VARCHAR(20) NULL ,
Start_Date DATE NULL ,
Expiry_Date DATE NULL ,
Term_Condition_Description VARCHAR(100) NULL ,
Application_Id VARCHAR(20) NOT NULL ,
Cust_Id VARCHAR(20) NOT NULL ,
CONSTRAINT XPKINSURANCE_POLICY_4 PRIMARY KEY(Agreement_id,Application_Id,Cust_Id),
CONSTRAINT R_95 FOREIGN KEY (Application_Id, Cust_Id) REFERENCES t14_APPLICATION (Application_Id, Cust_Id)
);
CREATE UNIQUE INDEX XPKINSURANCE_POLICY_4 ON t14_INSURANCE_POLICY
(Agreement_id ASC,Application_Id ASC,Cust_Id ASC);


CREATE TABLE t14_POLICY_RENEWABLE
(
Policy_Renewable_Id VARCHAR(20) NOT NULL ,
Date_Of_Renewal DATE NOT NULL ,
Type_Of_Renewal CHAR(15) NOT NULL ,
Agreement_id VARCHAR(20) NOT NULL ,
Application_Id VARCHAR(20) NOT NULL ,
Cust_Id VARCHAR(20) NOT NULL ,
CONSTRAINT XPKPOLICY_RENEWABLE_16 PRIMARY KEY(Policy_Renewable_Id,Agreement_id,Application_Id,Cust_Id),
CONSTRAINT R_101 FOREIGN KEY (Agreement_id, Application_Id, Cust_Id)
REFERENCES t14_INSURANCE_POLICY (Agreement_id, Application_Id, Cust_Id)
);
CREATE UNIQUE INDEX XPKPOLICY_RENEWABLE_16 ON
t14_POLICY_RENEWABLE
(Policy_Renewable_Id ASC,Agreement_id ASC,Application_Id
ASC,Cust_Id ASC);


CREATE TABLE t14_MEMBERSHIP
(
Membership_Id VARCHAR(20) NOT NULL ,
Membership_Type CHAR(15) NOT NULL ,
Organisation_Contact VARCHAR(20) NULL ,
Cust_Id VARCHAR(20) NOT NULL ,
CONSTRAINT XPKMEMBERSHIP_12 PRIMARY KEY(Membership_Id,Cust_Id),
CONSTRAINT R_91 FOREIGN KEY (Cust_Id) REFERENCES t14_CUSTOMER(Cust_Id)
);
CREATE UNIQUE INDEX XPKMEMBERSHIP_12 ON t14_MEMBERSHIP(Membership_Id ASC,Cust_Id ASC);


CREATE TABLE t14_QU0TE
(
Quote_Id VARCHAR(20) NOT NULL ,
Issue_Date DATE NOT NULL ,
Valid_From_Date DATE NOT NULL ,
Valid_Till_Date DATE NOT NULL ,
Description VARCHAR(100) NULL ,
Product_Id VARCHAR(20) NOT NULL ,
Coverage_Level VARCHAR(20) NOT NULL ,
Application_Id VARCHAR(20) NOT NULL ,
Cust_Id VARCHAR(20) NOT NULL ,
CONSTRAINT XPKQU0TE_3 PRIMARY KEY(Quote_Id,Application_Id,Cust_Id),
CONSTRAINT R_94 FOREIGN KEY (Application_Id, Cust_Id) REFERENCES
t14_APPLICATION (Application_Id, Cust_Id)
);
CREATE UNIQUE INDEX XPKQU0TE_3 ON t14_QU0TE
(Quote_Id ASC,Application_Id ASC,Cust_Id ASC);


CREATE TABLE t14_STAFF
( 
Staff_Id VARCHAR(20) NOT NULL , 
Staff_Fname VARCHAR(10) NULL , 
Staff_LName VARCHAR(10) NULL , 
Staff_Adress VARCHAR(20) NULL , 
Staff_Contact INTEGER NULL , 
Staff_Gender CHAR(2) NULL , 
Staff_Marital_Status CHAR(8) NULL , 
Staff_Nationality CHAR(15) NULL , 
Staff_Qualification VARCHAR(20) NULL , 
Staff_Allowance INTEGER NULL , 
Staff_PPS_Number INTEGER NULL , 
Company_Name VARCHAR(20) NOT NULL , 
CONSTRAINT XPKSTAFF_9 PRIMARY KEY (Staff_Id,Company_Name), 
CONSTRAINT R_105 FOREIGN KEY (Company_Name) REFERENCES t14_INSURANCE_COMPANY (Company_Name)
);
CREATE UNIQUE INDEX XPKSTAFF_9 ON t14_STAFF(Staff_Id ASC,Company_Name ASC);


CREATE TABLE t14_NOK
(
Nok_Id VARCHAR(20) NOT NULL ,
Nok_Name VARCHAR(20) NULL ,
Nok_Address VARCHAR(20) NULL ,
Nok_Phone_Number INTEGER NULL ,
Nok_Gender CHAR(2) NULL ,
Nok_Marital_Status CHAR(8) NULL ,
Agreement_id VARCHAR(20) NOT NULL ,
Application_Id VARCHAR(20) NOT NULL ,
Cust_Id VARCHAR(20) NOT NULL ,
CONSTRAINT XPKNOK_14 PRIMARY KEY(Nok_Id,Agreement_id,Application_Id,Cust_Id),
CONSTRAINT R_99 FOREIGN KEY (Agreement_id, Application_Id, Cust_Id)
REFERENCES t14_INSURANCE_POLICY (Agreement_id, Application_Id, Cust_Id)
);
CREATE UNIQUE INDEX XPKNOK_14 ON t14_NOK
(Nok_Id ASC,Agreement_id ASC,Application_Id ASC);


CREATE TABLE t14_PRODUCT 
(
Product_Price INTEGER NULL , 
Product_Type CHAR(15) NULL , 
Product_Number VARCHAR(20) NOT NULL ,
Company_Name VARCHAR(20) NOT NULL ,
CONSTRAINT XPKPRODUCT_20 PRIMARY KEY (Product_Number,Company_Name),
CONSTRAINT R_107 FOREIGN KEY (Company_Name) REFERENCES t14_INSURANCE_COMPANY (Company_Name)
);
CREATE UNIQUE INDEX XPKPRODUCT_20 ON t14_PRODUCT
(Product_Number ASC,Company_Name ASC);


CREATE TABLE t14_OFFICE 
( 
Office_Name VARCHAR(20) NOT NULL , 
Office_Leader VARCHAR(20) NOT NULL , 
Contact_Information VARCHAR(20) NOT NULL , 
Address VARCHAR(20) NOT NULL , 
Admin_Cost INTEGER NULL , 
Staff VARCHAR(50) NULL ,
Department_Name VARCHAR(20) NOT NULL , 
Company_Name VARCHAR(20) NOT NULL , 
CONSTRAINT XPKOFFICE_11 PRIMARY KEY (Office_Name,Department_Name,Company_Name), 
CONSTRAINT R_104 FOREIGN KEY (Department_Name) REFERENCES t14_DEPARTMENT (Department_Name) ,
FOREIGN KEY (Company_Name) REFERENCES t14_INSURANCE_COMPANY  (Company_Name) 
);
CREATE UNIQUE INDEX XPKOFFICE_11 ON t14_OFFICE
(Office_Name ASC,Department_Name ASC,Company_Name ASC);


CREATE TABLE t14_COVERAGE
( 
Coverage_Id VARCHAR(20) NOT NULL ,
Coverage_Amount INTEGER NOT NULL , 
Coverage_Type CHAR(10) NOT NULL , 
Coverage_Level CHAR(15) NOT NULL , 
Product_Id VARCHAR(20) NOT NULL , 
Coverage_Description VARCHAR(100) NULL , 
Covearge_Terms VARCHAR(50) NULL , 
Company_Name VARCHAR(20) NOT NULL , 
CONSTRAINT XPKCOVERAGE_19 PRIMARY KEY (Coverage_Id,Company_Name),
CONSTRAINT R_102 FOREIGN KEY (Company_Name) REFERENCES
t14_INSURANCE_COMPANY (Company_Name)
);
CREATE UNIQUE INDEX XPKCOVERAGE_19 ON t14_COVERAGE
(Coverage_Id ASC,Company_Name ASC);


CREATE TABLE t14_INSURANCE_POLICY_COVERAGE 
( 
Agreement_id VARCHAR(20) NOT NULL , 
Application_Id VARCHAR(20) NOT NULL , 
Cust_Id VARCHAR(20) NOT NULL ,
Coverage_Id VARCHAR(20) NOT NULL , 
Company_Name VARCHAR(20) NOT NULL , 
CONSTRAINT XPKINSURANCE_POLICY_4_COVERAGE PRIMARY KEY 
(Agreement_id,Application_Id,Cust_Id,Coverage_Id,Company_Name), 
CONSTRAINT R_97 FOREIGN KEY (Agreement_id, Application_Id, Cust_Id) 
REFERENCES t14_INSURANCE_POLICY (Agreement_id, Application_Id, Cust_Id),
CONSTRAINT R_98 FOREIGN KEY (Coverage_Id, Company_Name)
REFERENCES t14_COVERAGE (Coverage_Id, Company_Name)
); 
CREATE UNIQUE INDEX XPKINSURANCE_POLICY_4_COVERAGE ON 
t14_INSURANCE_POLICY_COVERAGE
(Agreement_id ASC,Application_Id ASC,Cust_Id ASC,Coverage_Id ASC,Company_Name ASC); 


CREATE TABLE t14_CLAIM
( 
Claim_Id VARCHAR(20) NOT NULL ,
Agreement_Id VARCHAR(20) NOT NULL , 
Claim_Amount INTEGER NOT NULL ,
Incident_Id VARCHAR(20) NOT NULL , 
Damage_Type VARCHAR(20) NOT NULL , 
Date_Of_Claim DATE NOT NULL ,
Claim_Status CHAR(10) NOT NULL ,
Cust_Id VARCHAR(20) NOT NULL ,
CONSTRAINT XPKCLAIM_7 PRIMARY KEY (Claim_Id,Cust_Id),
CONSTRAINT R_88 FOREIGN KEY (Cust_Id) REFERENCES t14_CUSTOMER (Cust_Id)
);
CREATE UNIQUE INDEX XPKCLAIM_7 ON t14_CLAIM
(Claim_Id ASC,Cust_Id ASC);


CREATE TABLE t14_CLAIM_SETTLEMENT
(
Claim_Settlement_Id VARCHAR(20) NOT NULL ,
Vehicle_Id VARCHAR(20) NOT NULL ,
Date_Settled DATE NOT NULL ,
Amount_Paid INTEGER NOT NULL ,
Coverage_Id VARCHAR(20) NOT NULL ,
Claim_Id VARCHAR(20) NOT NULL ,
Cust_Id VARCHAR(20) NOT NULL ,
CONSTRAINT XPKCLAIM_SETTLEMENT_8 PRIMARY KEY
(Claim_Settlement_Id,Claim_Id,Cust_Id),
CONSTRAINT R_90 FOREIGN KEY (Claim_Id, Cust_Id) REFERENCES t14_CLAIM
(Claim_Id, Cust_Id)
);
CREATE UNIQUE INDEX XPKCLAIM_SETTLEMENT_8 ON
t14_CLAIM_SETTLEMENT
(Claim_Settlement_Id ASC,Claim_Id ASC,Cust_Id ASC);