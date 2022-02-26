/*
USE master
GO

IF DB_ID('LigaPilkarska') IS NULL
CREATE DATABASE LigaPilkarska
GO

USE LigaPilkarska
*/
SET LANGUAGE Polish

IF OBJECT_ID('Mecze','U') IS NOT NULL
DROP TABLE Mecze

IF OBJECT_ID('Sedziowie','U') IS NOT NULL
DROP TABLE Sedziowie

IF OBJECT_ID('Kluby','U') IS NOT NULL
DROP TABLE Kluby

IF OBJECT_ID('Stadiony','U') IS NOT NULL
DROP TABLE Stadiony

IF OBJECT_ID('Trenerzy','U') IS NOT NULL
DROP TABLE Trenerzy

GO
--------------------------------------------------
IF OBJECT_ID('Trenerzy','U') IS NULL
CREATE TABLE Trenerzy (
	ID INT IDENTITY(1,1) PRIMARY KEY,
	Imie VARCHAR(15) NOT NULL,
	Nazwisko VARCHAR(20) NOT NULL,
	Zatrudniony DATE NOT NULL
)

IF OBJECT_ID('Stadiony','U') IS NULL
CREATE TABLE Stadiony (
	ID INT IDENTITY(1,1),
	Nazwa VARCHAR(30) PRIMARY KEY,
	Pojemnosc INT NOT NULL,
	Miasto VARCHAR(20) NOT NULL
)

IF OBJECT_ID('Kluby','U') IS NULL
CREATE TABLE Kluby (
	ID INT IDENTITY(1,1),
	Nazwa VARCHAR(20) PRIMARY KEY,
	Stadion VARCHAR(30) FOREIGN KEY REFERENCES Stadiony(Nazwa),
	ID_Trenera INT FOREIGN KEY REFERENCES Trenerzy(ID)
)

IF OBJECT_ID('Sedziowie','U') IS NULL
CREATE TABLE Sedziowie (
	ID INT IDENTITY(1,1) PRIMARY KEY,
	Imie VARCHAR(15) NOT NULL,
	Nazwisko VARCHAR(20) NOT NULL,
	DataUrodzenia DATE NOT NULL
)

IF OBJECT_ID('Mecze','U') IS NULL
CREATE TABLE Mecze (
	ID INT IDENTITY(1,1) PRIMARY KEY,
	Data DATE NOT NULL,
	Klub1 VARCHAR(20) FOREIGN KEY REFERENCES Kluby(Nazwa),
	GoleKlubu1 INT NOT NULL,
	GoleKlubu2 INT NOT NULL,
	Klub2 VARCHAR(20) FOREIGN KEY REFERENCES Kluby(Nazwa),
	ID_Sedziego INT FOREIGN KEY REFERENCES Sedziowie(ID),
	ZolteKartki INT NOT NULL,
	CzerwoneKartki INT NOT NULL,
	Stadion VARCHAR(30) FOREIGN KEY REFERENCES Stadiony(Nazwa),
	Frekwencja INT NOT NULL,
	PktKlub1 INT NOT NULL,
	PktKlub2 INT NOT NULL
)

GO
--------------------------------------------------
INSERT INTO Trenerzy (Imie, Nazwisko, Zatrudniony) VALUES
	('Pep', 'Guardiola', '20160701'),
	('Ole Gunnar', 'Solskjaer', '20181219'),
	('Jurgen', 'Klopp', '20151008'),
	('Thomas', 'Tuchel', '20210126'),
	('Brendan', 'Rodgers', '20190226'),
	('David', 'Moyes', '20191229'),
	('Ryan', 'Mason', '20210420'),
	('Mikel', 'Arteta', '20191222'),
	('Marcelo', 'Bielsa', '20180615'),
	('Carlo', 'Ancelotti', '20191221')
GO

INSERT INTO Stadiony (Nazwa, Pojemnosc, Miasto) VALUES
	('City of Manchester Stadium', 55017, 'Manchester'),
	('Old Trafford', 75643, 'Manchester'),
	('Anfield', 54074, 'Liverpool'),
	('Stamford Bridge', 40834, 'London'),
	('Filbert Street', 22000, 'Leicester'),
	('Boleyn Ground', 35345, 'London'),
	('Tottenham Hotspur Stadium', 62214, 'London'),
	('Emirates Stadium', 60704, 'London'),
	('Elland Road', 37792, 'Leeds'),
	('Goodison Park', 39414, 'Liverpool')
GO

INSERT INTO Kluby (Nazwa, Stadion, ID_Trenera) VALUES
	('Arsenal', 'Emirates Stadium', 8),
	('Chelsea', 'Stamford Bridge', 4),
	('Everton', 'Goodison Park', 10),
	('Leeds', 'Elland Road', 9),
	('Leicester', 'Filbert Street', 5),
	('Liverpool', 'Anfield', 3),
	('Manchester City', 'City of Manchester Stadium', 1),
	('Manchester United', 'Old Trafford', 2),
	('Tottenham Hotspur', 'Tottenham Hotspur Stadium', 7),
	('West Ham United', 'Boleyn Ground', 6)
GO

INSERT INTO Sedziowie (Imie, Nazwisko, DataUrodzenia) VALUES
	('Michael', 'Oliver', '19850220'),
	('Anthony', 'Taylor', '19781020'),
	('Martin', 'Atkinson', '19710331'),
	('Mike', 'Dean', '19680602'),
	('Kevin', 'Friend', '19710708')
GO

INSERT INTO Mecze (Data, Klub1, GoleKlubu1, GoleKlubu2, Klub2, ID_Sedziego, ZolteKartki, CzerwoneKartki, Stadion, Frekwencja, PktKlub1, PktKlub2) VALUES
	('20210820', 'Manchester City', 3, 0, 'Everton', 1, 4, 0, 'City of Manchester Stadium', 49527, 3, 0),
	('20210821', 'Manchester United', 2, 1, 'Leeds', 2, 5, 0, 'Old Trafford', 62541, 3, 0),
	('20210821', 'Liverpool', 3, 2, 'Arsenal', 3, 6, 1, 'Anfield', 48625, 3, 0),
	('20210822', 'Chelsea', 2, 2, 'Tottenham Hotspur', 4, 4, 0, 'Stamford Bridge', 38752, 1, 1),
	('20210822', 'Leicester', 1, 1, 'West Ham United', 5, 7, 0, 'Filbert Street', 18692, 1, 1),

	('20210827', 'Leeds', 0, 2, 'Chelsea', 4, 4, 0, 'Elland Road', 34254, 0, 3),
	('20210828', 'West Ham United', 0, 4, 'Manchester City', 2, 3, 0, 'Boleyn Ground', 35006, 0, 3),
	('20210828', 'Arsenal', 2, 2, 'Manchester United', 3, 5, 1, 'Emirates Stadium', 58652, 1, 1),
	('20210829', 'Tottenham Hotspur', 3, 1, 'Leicester', 1, 6, 0, 'Tottenham Hotspur Stadium', 49632, 3, 0),
	('20210829', 'Everton', 1, 3, 'Liverpool', 5, 5, 0, 'Goodison Park', 37982, 0, 3),

	('20210903', 'Leicester', 2, 3, 'Arsenal', 2, 4, 1, 'Filbert Street', 19885, 0, 3),
	('20210904', 'Liverpool', 4, 1, 'Leeds', 5, 7, 0, 'Anfield', 48952, 3, 0),
	('20210904', 'Chelsea', 3, 1, 'West Ham United', 1, 6, 0, 'Stamford Bridge', 35874, 3, 0),
	('20210905', 'Tottenham Hotspur', 2, 0, 'Everton', 4, 3, 0, 'Tottenham Hotspur Stadium', 53674, 3, 0),
	('20210905', 'Manchester City', 3, 0, 'Manchester United', 3, 3, 0, 'City of Manchester Stadium', 55017, 3, 0),

	('20210907', 'Manchester United', 2, 2, 'Everton', 5, 8, 2, 'Old Trafford', 60589, 1, 1),
	('20210907', 'Leeds', 0, 0, 'Leicester', 4, 5, 0, 'Elland Road', 25897, 1, 1),
	('20210908', 'Liverpool', 2, 3, 'Manchester City', 3, 6, 0, 'Anfield', 53896, 0, 3),
	('20210908', 'Arsenal', 1, 3, 'Chelsea', 1, 5, 0, 'Emirates Stadium', 57962, 0, 3),
	('20210909', 'West Ham United', 1, 2, 'Tottenham Hotspur', 2, 4, 0, 'Boleyn Ground', 32411, 0, 3),

	('20210911', 'Tottenham Hotspur', 3, 1, 'Leeds', 2, 4, 0, 'Tottenham Hotspur Stadium', 49987, 3, 0),
	('20210911', 'Manchester City', 2, 1, 'Chelsea', 5, 5, 0, 'City of Manchester Stadium', 53022, 3, 0),
	('20210912', 'Manchester United', 2, 2, 'Liverpool', 4, 6, 1, 'Old Trafford', 72888, 1, 1),
	('20210912', 'Arsenal', 3, 2, 'West Ham United', 1, 7, 0, 'Emirates Stadium', 54632, 3, 0),
	('20210913', 'Leicester', 3, 2, 'Everton', 3, 6, 1, 'Filbert Street', 16532, 3, 0),

	('20210917', 'Manchester United', 3, 3, 'Leicester', 1, 6, 0, 'Old Trafford', 58641, 1, 1),
	('20210918', 'West Ham United', 3, 2, 'Everton', 2, 5, 0, 'Boleyn Ground', 28777, 3, 0),
	('20210918', 'Leeds', 1, 2, 'Arsenal', 3, 4, 0, 'Elland Road', 34856, 0, 3),
	('20210919', 'Chelsea', 3, 3, 'Liverpool', 4, 5, 1, 'Stamford Bridge', 40834, 1, 1),
	('20210919', 'Tottenham Hotspur', 2, 2, 'Manchester City', 5, 8, 0, 'Tottenham Hotspur Stadium', 61127, 1, 1),

	('20210924', 'Liverpool', 4, 2, 'West Ham United', 3, 9, 0, 'Anfield', 46552, 3, 0),
	('20210925', 'Manchester City', 5, 1, 'Leeds', 1, 3, 0, 'City of Manchester Stadium', 47979, 3, 0),
	('20210925', 'Everton', 1, 2, 'Chelsea', 5, 4, 0, 'Goodison Park', 38875, 0, 3),
	('20210926', 'Arsenal', 1, 3, 'Tottenham Hotspur', 4, 5, 0, 'Emirates Stadium', 58524, 0, 3),
	('20210926', 'Leicester', 2, 2, 'Manchester United', 2, 7, 3, 'Filbert Street', 20654, 1, 1)
GO
--------------------------------------------------
IF OBJECT_ID('Srednia_frekwencja','P') IS NOT NULL
DROP PROCEDURE Srednia_frekwencja
GO

CREATE PROCEDURE Srednia_frekwencja (
	@nazwa VARCHAR(30)
) AS
	SELECT Stadion, [Srednia frekwencja] = AVG(Frekwencja)
	FROM Mecze
	WHERE Stadion = @nazwa
	GROUP BY Stadion
GO
--------------------------------------------------
IF OBJECT_ID('Przyznane_kartki','V') IS NOT NULL
DROP VIEW Przyznane_kartki
GO

CREATE VIEW Przyznane_kartki AS
	SELECT s.Imie, s.Nazwisko, m.[Czerwone Kartki], m.[Zolte Kartki]
	FROM Sedziowie s
	INNER JOIN (SELECT TOP 100 PERCENT ID_Sedziego, [Czerwone Kartki] = SUM(CzerwoneKartki), [Zolte Kartki] = SUM(ZolteKartki)
				FROM Mecze GROUP BY ID_Sedziego) m ON m.ID_Sedziego = s.ID
	ORDER BY m.[Czerwone Kartki] DESC, m.[Zolte Kartki] DESC OFFSET 0 ROWS
GO
--------------------------------------------------
IF OBJECT_ID('Pokonane_kluby','P') IS NOT NULL
DROP PROCEDURE Pokonane_kluby
GO

CREATE PROCEDURE Pokonane_kluby (
	@nazwa VARCHAR(20)
) AS
	SELECT [Pokonane kluby] = Klub2
	FROM Mecze
	WHERE Klub1 = @nazwa AND GoleKlubu1 > GoleKlubu2
	UNION
	SELECT Klub1
	FROM Mecze
	WHERE Klub2 = @nazwa AND GoleKlubu1 < GoleKlubu2
GO
--------------------------------------------------
IF OBJECT_ID('Liczba_straconych_goli','P') IS NOT NULL
DROP PROCEDURE Liczba_straconych_goli
GO

CREATE PROCEDURE Liczba_straconych_goli (
	@nazwa VARCHAR(20)
) AS
	SELECT [Stracone gole] = SUM(Gole)
	FROM
	(
		SELECT Gole = GoleKlubu2
		FROM Mecze
		WHERE Klub1 = @nazwa
		UNION ALL
		SELECT Gole = GoleKlubu1
		FROM Mecze
		WHERE Klub2 = @nazwa
	) g
GO
--------------------------------------------------
IF OBJECT_ID('Frekwencja_wg_dnia','V') IS NOT NULL
DROP VIEW Frekwencja_wg_dnia
GO

CREATE VIEW Frekwencja_wg_dnia AS
	SELECT [Dzien tygodnia] = DATENAME(dw, Data), [Srednia frekwencja] = AVG(Frekwencja)
	FROM Mecze
	GROUP BY DATENAME(dw, Data)
	ORDER BY [Srednia frekwencja] DESC OFFSET 0 ROWS
GO
--------------------------------------------------
IF OBJECT_ID('Tabela','V') IS NOT NULL
DROP VIEW Tabela
GO

CREATE VIEW Tabela AS
	SELECT Klub, Punkty = SUM(Pkt)
	FROM
	(
		SELECT Klub = Klub1, Pkt = SUM(PktKlub1)
		FROM Mecze
		GROUP BY Klub1
		UNION ALL
		SELECT Klub = Klub2, Pkt = SUM(PktKlub2)
		FROM Mecze
		GROUP BY Klub2
	) t
	GROUP BY Klub
	ORDER BY Punkty DESC OFFSET 0 ROWS
GO
--------------------------------------------------
SELECT * FROM Trenerzy
SELECT * FROM Stadiony
SELECT * FROM Kluby
SELECT * FROM Sedziowie
SELECT * FROM Mecze
--------------------------------------------------
EXEC Srednia_frekwencja 'Emirates Stadium'
EXEC Srednia_frekwencja 'Filbert Street'

SELECT * FROM Przyznane_kartki

EXEC Pokonane_kluby 'Tottenham Hotspur'
EXEC Pokonane_kluby 'Chelsea'

EXEC Liczba_straconych_goli 'Manchester City'
EXEC Liczba_straconych_goli 'West Ham United'

SELECT * FROM Frekwencja_wg_dnia

SELECT * FROM Tabela
--------------------------------------------------
/*
USE master
GO

IF DB_ID('LigaPilkarska') IS NOT NULL
DROP DATABASE LigaPilkarska
GO
*/