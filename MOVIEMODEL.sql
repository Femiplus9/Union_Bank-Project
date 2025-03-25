USE MASTER

CREATE DATABASE [MOVIEMODEL]

USE [MOVIEMODEL]

CREATE SCHEMA MOVIE;


CREATE TABLE Actor
(
	Actor_ID             CHAR(18) NOT NULL,
	Actor_Name           VARCHAR(20) NULL,
	Actor_Birthday       VARCHAR(20) NULL,
	Actor_Nationality    VARCHAR(20) NULL,
	Actor_Gender         CHAR(10) NULL,
	Characrter_ID        CHAR(10) NOT NULL,
	Movie_ID             CHAR(10) NOT NULL,
	ProductionCompany_ID CHAR(10) NOT NULL
);



ALTER TABLE Actor
ADD PRIMARY KEY (Actor_ID,Characrter_ID,Movie_ID,ProductionCompany_ID);



CREATE TABLE Awards
(
	Awards_ID            CHAR(10) NOT NULL,
	Awards_Name          VARCHAR(20) NULL,
	Awards_Year          VARCHAR(20) NULL,
	Category             DATE NULL,
	Movie_ID             CHAR(10) NOT NULL,
	ProductionCompany_ID CHAR(10) NOT NULL
);



ALTER TABLE Awards
ADD PRIMARY KEY (Awards_ID,Movie_ID,ProductionCompany_ID);



CREATE TABLE AwardsReceived
(
	AwardsReceived_ID    CHAR(10) NOT NULL,
	Movie_ID             CHAR(10) NOT NULL,
	Award_ID             CHAR(18) NULL,
	ProductionCompany_ID CHAR(10) NOT NULL
);



ALTER TABLE AwardsReceived
ADD PRIMARY KEY (AwardsReceived_ID,Movie_ID,ProductionCompany_ID);



CREATE TABLE Characrter
(
	Characrter_ID        CHAR(10) NOT NULL,
	Characrter_Name      VARCHAR(20) NULL,
	Characrter_Role      VARCHAR(20) NULL,
	Movie_ID             CHAR(10) NOT NULL,
	Actor_ID             CHAR(18) NOT NULL,
	ProductionCompany_ID CHAR(10) NOT NULL
);



ALTER TABLE Characrter
ADD PRIMARY KEY (Characrter_ID,Actor_ID,Movie_ID,ProductionCompany_ID);



CREATE TABLE Director
(
	Director_ID          CHAR(10) NOT NULL,
	Director_Name        VARCHAR(20) NULL,
	Director_Birthday    VARCHAR(20) NULL,
	Director_Nationality VARCHAR(20) NULL,
	Director_Gender      CHAR(10) NULL,
	Movie_ID             CHAR(10) NOT NULL,
	ProductionCompany_ID CHAR(10) NOT NULL
);



ALTER TABLE Director
ADD PRIMARY KEY (Director_ID,Movie_ID,ProductionCompany_ID);



CREATE TABLE Distributor
(
	Distributor_ID       CHAR(10) NOT NULL,
	Distributor_Name     VARCHAR(20) NULL,
	Distributor_Location CHAR(10) NULL,
	Movie_ID             CHAR(10) NOT NULL,
	ProductionCompany_ID CHAR(10) NOT NULL
);



ALTER TABLE Distributor
ADD PRIMARY KEY (Distributor_ID,Movie_ID,ProductionCompany_ID);



CREATE TABLE Movie
(
	Movie_ID             CHAR(10) NOT NULL,
	Movie_Title          VARCHAR(20) NULL,
	Movie_ReleaseDate    VARCHAR(20) NULL,
	Movie_Duration       VARCHAR(20) NULL,
	Movie_Genre          VARCHAR(20) NULL,
	Movie_Rating         VARCHAR(20) NULL,
	ProductionCompanyID  CHAR(18) NULL,
	ProductionCompany_ID CHAR(10) NOT NULL
);



ALTER TABLE Movie
ADD PRIMARY KEY (Movie_ID,ProductionCompany_ID);



CREATE TABLE ProductionCompany
(
	ProductionCompany_ID CHAR(10) NOT NULL,
	ProductionCompany_Name VARCHAR(20) NULL,
	ProductionCompany_Location CHAR(10) NULL,
	ProductionCompany_FoundationDate VARCHAR(20) NULL
);



ALTER TABLE ProductionCompany
ADD PRIMARY KEY (ProductionCompany_ID);



CREATE TABLE Screenwriter
(
	Screenwriter_ID      CHAR(10) NOT NULL,
	Screenwriter_Email   CHAR(10) NULL,
	Screenwriter_Location CHAR(10) NULL,
	Screenwriter_Birthday VARCHAR(20) NULL,
	Screenwriter_Gender  CHAR(10) NULL,
	Screenwriter_Nationality VARCHAR(20) NULL,
	Movie_ID             CHAR(10) NOT NULL,
	ProductionCompany_ID CHAR(10) NOT NULL
);



ALTER TABLE Screenwriter
ADD PRIMARY KEY (Screenwriter_ID,Movie_ID,ProductionCompany_ID);



CREATE TABLE Studio
(
	Studio_ID            CHAR(10) NOT NULL,
	Studio_Name          VARCHAR(20) NULL,
	Studio_Location      CHAR(10) NULL,
	Studio_Capacity      VARCHAR(20) NULL,
	Movie_ID             CHAR(10) NOT NULL,
	ProductionCompany_ID CHAR(10) NOT NULL
);



ALTER TABLE Studio
ADD PRIMARY KEY (Studio_ID,Movie_ID,ProductionCompany_ID);



ALTER TABLE Actor
ADD CONSTRAINT R_9 FOREIGN KEY (Characrter_ID, Actor_ID, Movie_ID, ProductionCompany_ID) REFERENCES Characrter (Characrter_ID, Actor_ID, Movie_ID, ProductionCompany_ID);



ALTER TABLE Awards
ADD CONSTRAINT R_17 FOREIGN KEY (Movie_ID, ProductionCompany_ID) REFERENCES Movie (Movie_ID, ProductionCompany_ID);



ALTER TABLE AwardsReceived
ADD CONSTRAINT R_16 FOREIGN KEY (Movie_ID, ProductionCompany_ID) REFERENCES Movie (Movie_ID, ProductionCompany_ID);



ALTER TABLE Characrter
ADD CONSTRAINT R_8 FOREIGN KEY (Movie_ID, ProductionCompany_ID) REFERENCES Movie (Movie_ID, ProductionCompany_ID);



ALTER TABLE Director
ADD CONSTRAINT R_12 FOREIGN KEY (Movie_ID, ProductionCompany_ID) REFERENCES Movie (Movie_ID, ProductionCompany_ID);



ALTER TABLE Distributor
ADD CONSTRAINT R_14 FOREIGN KEY (Movie_ID, ProductionCompany_ID) REFERENCES Movie (Movie_ID, ProductionCompany_ID);



ALTER TABLE Movie
ADD CONSTRAINT R_1 FOREIGN KEY (ProductionCompany_ID) REFERENCES ProductionCompany (ProductionCompany_ID);



ALTER TABLE Screenwriter
ADD CONSTRAINT R_15 FOREIGN KEY (Movie_ID, ProductionCompany_ID) REFERENCES Movie (Movie_ID, ProductionCompany_ID);



ALTER TABLE Studio
ADD CONSTRAINT R_13 FOREIGN KEY (Movie_ID, ProductionCompany_ID) REFERENCES Movie (Movie_ID, ProductionCompany_ID);


SELECT * FROM [dbo].[Actor];

SELECT * FROM [dbo].[Movie];

SELECT * FROM [dbo].[Distributor];

SELECT * FROM [dbo].[Director];

SELECT * FROM [dbo].[ProductionCompany];

SELECT * FROM [dbo].[Screenwriter];

SELECT * FROM [dbo].[Awards]

SELECT * FROM [dbo].[AwardsReceived]

SELECT * FROM [dbo].[Distributor]

SELECT * FROM [dbo].[Studio]



