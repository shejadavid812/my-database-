-- =====================================================
-- DATABASE: GoWildWildlifePark
-- GO WILD WILDLIFE PARK MANAGEMENT SYSTEM
-- SQLite Version
-- Unit 2: Creating Systems to Manage Information
-- =====================================================

-- =====================================================
-- PART 1: CREATE DATABASE AND TABLES
-- =====================================================

-- Drop tables if they exist (for clean setup)
DROP TABLE IF EXISTS Animals;
DROP TABLE IF EXISTS Species;
DROP TABLE IF EXISTS Diet;
DROP TABLE IF EXISTS Keepers;
DROP TABLE IF EXISTS Enclosures;

-- =====================================================
-- TABLE 1: Enclosures
-- =====================================================
CREATE TABLE Enclosures (
    EnclosureID VARCHAR(5) PRIMARY KEY,
    EnclosureType VARCHAR(20) NOT NULL,
    EnclosureLocation VARCHAR(10) NOT NULL,
    CHECK (EnclosureType IN ('Glass', 'Moat', 'Fence', 'Walled', 'Pen')),
    CHECK (EnclosureLocation IN ('North', 'South', 'East', 'West'))
);

-- =====================================================
-- TABLE 2: Keepers
-- =====================================================
CREATE TABLE Keepers (
    KeeperID VARCHAR(5) PRIMARY KEY,
    KeeperName VARCHAR(20) NOT NULL,
    KeeperDoB DATE NOT NULL,
    KeeperRank VARCHAR(10) NOT NULL,
    CHECK (KeeperRank IN ('Senior', 'Standard', 'Junior'))
);

-- =====================================================
-- TABLE 3: Diet
-- =====================================================
CREATE TABLE Diet (
    DietID VARCHAR(5) PRIMARY KEY,
    DietType VARCHAR(15) NOT NULL,
    NoOfFeedsPerDay INT NOT NULL,
    CHECK (DietType IN ('Omnivore', 'Herbivore', 'Carnivore')),
    CHECK (NoOfFeedsPerDay BETWEEN 1 AND 10)
);

-- =====================================================
-- TABLE 4: Species
-- =====================================================
CREATE TABLE Species (
    SpeciesID VARCHAR(5) PRIMARY KEY,
    SpeciesType VARCHAR(25) NOT NULL,
    SpeciesGroup VARCHAR(20) NOT NULL,
    Lifestyle VARCHAR(20) NOT NULL,
    ConservationStatus VARCHAR(25) NOT NULL,
    CHECK (ConservationStatus IN ('Threatened', 'Critically Endangered', 'Vulnerable', 'Endangered', 'Least Concern'))
);

-- =====================================================
-- TABLE 5: Animals (Main table with foreign keys)
-- =====================================================
CREATE TABLE Animals (
    AnimalID VARCHAR(5) PRIMARY KEY,
    AnimalName VARCHAR(20) NOT NULL,
    Gender VARCHAR(1) NOT NULL,
    YearOfArrival INT NOT NULL,
    SpeciesID VARCHAR(5),
    DietID VARCHAR(5),
    KeeperID VARCHAR(5),
    EnclosureID VARCHAR(5),
    CHECK (Gender IN ('M', 'F')),
    CHECK (YearOfArrival BETWEEN 1990 AND strftime('%Y', 'now')),
    FOREIGN KEY (SpeciesID) REFERENCES Species(SpeciesID) ON DELETE SET NULL,
    FOREIGN KEY (DietID) REFERENCES Diet(DietID) ON DELETE SET NULL,
    FOREIGN KEY (KeeperID) REFERENCES Keepers(KeeperID) ON DELETE SET NULL,
    FOREIGN KEY (EnclosureID) REFERENCES Enclosures(EnclosureID) ON DELETE SET NULL
);

-- =====================================================
-- PART 2: POPULATE TABLES WITH DATA FROM CSV
-- =====================================================

-- Insert Enclosures data
INSERT OR REPLACE INTO Enclosures (EnclosureID, EnclosureType, EnclosureLocation) VALUES
('E1', 'Moat', 'North'),
('E2', 'Glass', 'North'),
('E3', 'Fence', 'South'),
('E4', 'Walled', 'South'),
('E5', 'Pen', 'South');

-- Insert Keepers data
INSERT OR REPLACE INTO Keepers (KeeperID, KeeperName, KeeperDoB, KeeperRank) VALUES
('K1', 'Dave', '1964-06-18', 'Senior'),
('K2', 'Kayden', '1985-01-21', 'Junior'),
('K3', 'Suki', '1998-08-09', 'Standard'),
('K4', 'Temi', '2000-04-16', 'Senior');

-- Insert Diet data
INSERT OR REPLACE INTO Diet (DietID, DietType, NoOfFeedsPerDay) VALUES
('D1', 'Omnivore', 6),
('D2', 'Herbivore', 6),
('D3', 'Carnivore', 4);

-- Insert Species data
INSERT OR REPLACE INTO Species (SpeciesID, SpeciesType, SpeciesGroup, Lifestyle, ConservationStatus) VALUES
('S3', 'Gorilla', 'Mammal', 'Troop', 'Threatened'),
('S4', 'Orang-utan', 'Mammal', 'Solitary', 'Critically Endangered'),
('S6', 'Rhinoceros', 'Mammal', 'Solitary', 'Critically Endangered'),
('S7', 'Crocodile', 'Reptile', 'Social', 'Vulnerable'),
('S8', 'Elephant', 'Mammal', 'Herd', 'Threatened'),
('S9', 'Armadillo', 'Mammal', 'Solitary', 'Endangered'),
('S10', 'Giant Tortoise', 'Reptile', 'Herd', 'Vulnerable'),
('S11', 'Lion', 'Mammal', 'Pride', 'Vulnerable'),
('S12', 'Raccoon', 'Mammal', 'Solitary', 'Least Concern'),
('S13', 'Leopard', 'Mammal', 'Solitary', 'Threatened'),
('S14', 'Chinchilla', 'Mammal', 'Solitary', 'Endangered'),
('S15', 'Tamarin', 'Mammal', 'Troop', 'Critically Endangered'),
('S16', 'Penguin', 'Bird', 'Group', 'Threatened'),
('S17', 'Sea Turtle', 'Reptile', 'Solitary', 'Endangered'),
('S18', 'Sloth', 'Mammal', 'Solitary', 'Endangered'),
('S19', 'Kakapo', 'Bird', 'Solitary', 'Endangered'),
('S20', 'Hippopotamus', 'Mammal', 'Herd', 'Vulnerable');

-- Insert Animals data (all 48 animals from your CSV)
INSERT OR REPLACE INTO Animals (AnimalID, AnimalName, Gender, YearOfArrival, SpeciesID, DietID, KeeperID, EnclosureID) VALUES
('A3', 'Geoffrey', 'M', 2018, 'S3', 'D1', 'K1', 'E2'),
('A4', 'Oliver', 'M', 2011, 'S4', 'D1', 'K1', 'E1'),
('A6', 'Roger', 'M', 2000, 'S6', 'D2', 'K2', 'E3'),
('A7', 'Clive', 'M', 2013, 'S7', 'D3', 'K2', 'E3'),
('A8', 'Eddie', 'M', 2016, 'S8', 'D2', 'K2', 'E4'),
('A9', 'Arnie', 'M', 2012, 'S9', 'D1', 'K2', 'E5'),
('A10', 'Gavin', 'M', 2015, 'S10', 'D2', 'K2', 'E5'),
('A11', 'Lucy', 'F', 2011, 'S11', 'D3', 'K3', 'E4'),
('A12', 'Robbie', 'M', 2017, 'S12', 'D1', 'K3', 'E5'),
('A13', 'Laura', 'F', 2018, 'S13', 'D3', 'K3', 'E3'),
('A14', 'Casey', 'F', 2013, 'S14', 'D2', 'K3', 'E5'),
('A15', 'Trevor', 'M', 2000, 'S15', 'D1', 'K3', 'E3'),
('A16', 'Polly', 'F', 2017, 'S16', 'D1', 'K4', 'E2'),
('A17', 'Sarah', 'F', 2015, 'S17', 'D1', 'K4', 'E2'),
('A18', 'Stan', 'M', 2018, 'S18', 'D1', 'K4', 'E3'),
('A19', 'Kara', 'F', 2001, 'S19', 'D2', 'K4', 'E4'),
('A20', 'Henry', 'M', 2003, 'S20', 'D2', 'K4', 'E3'),
('A22', 'Eliza', 'F', 2003, 'S8', 'D2', 'K2', 'E4'),
('A23', 'George', 'M', 2000, 'S3', 'D1', 'K1', 'E2'),
('A24', 'Carlos', 'M', 2017, 'S7', 'D3', 'K2', 'E3'),
('A25', 'Lenie', 'F', 2015, 'S11', 'D3', 'K3', 'E4'),
('A26', 'Roberta', 'F', 2018, 'S12', 'D1', 'K3', 'E5'),
('A27', 'Peter', 'M', 2001, 'S16', 'D1', 'K4', 'E2'),
('A28', 'Percy', 'M', 2003, 'S16', 'D1', 'K4', 'E2'),
('A29', 'Petal', 'F', 2003, 'S16', 'D1', 'K4', 'E2'),
('A30', 'Sammie', 'F', 2013, 'S18', 'D1', 'K4', 'E3'),
('A31', 'Lionel', 'M', 2016, 'S11', 'D3', 'K3', 'E4'),
('A32', 'Gertrude', 'F', 2012, 'S3', 'D1', 'K1', 'E2'),
('A33', 'Olive', 'F', 2015, 'S4', 'D1', 'K1', 'E1'),
('A34', 'Ossie', 'M', 2011, 'S4', 'D1', 'K1', 'E1'),
('A35', 'Lena', 'F', 2017, 'S13', 'D3', 'K3', 'E3'),
('A36', 'Rommy', 'F', 2018, 'S6', 'D2', 'K2', 'E3'),
('A37', 'Tulisa', 'F', 2013, 'S15', 'D1', 'K3', 'E3'),
('A38', 'Chrissie', 'F', 2000, 'S7', 'D3', 'K2', 'E3'),
('A39', 'Elsie', 'F', 2017, 'S8', 'D2', 'K2', 'E4'),
('A40', 'Colin', 'M', 2015, 'S7', 'D3', 'K2', 'E3'),
('A41', 'Hattie', 'F', 2018, 'S20', 'D2', 'K4', 'E3'),
('A42', 'Robbie', 'M', 2017, 'S6', 'D2', 'K2', 'E3'),
('A43', 'Luna', 'F', 2018, 'S11', 'D3', 'K3', 'E4'),
('A44', 'Rebbi', 'M', 2013, 'S12', 'D1', 'K3', 'E5'),
('A45', 'Penni', 'F', 2000, 'S16', 'D1', 'K4', 'E2'),
('A46', 'Emmie', 'F', 2000, 'S8', 'D2', 'K2', 'E4'),
('A47', 'Lope', 'M', 2017, 'S13', 'D3', 'K3', 'E3'),
('A48', 'Cressida', 'F', 2015, 'S14', 'D2', 'K3', 'E5'),
('A49', 'Tommy', 'M', 2018, 'S15', 'D1', 'K3', 'E3'),
('A50', 'Gareth', 'M', 2017, 'S3', 'D1', 'K1', 'E2');

-- =====================================================
-- PART 3: DATA ENTRY VIEWS (FORMS)
-- =====================================================

-- Form 1: Animals Data Entry View
DROP VIEW IF EXISTS vw_AnimalsDataEntry;
CREATE VIEW vw_AnimalsDataEntry AS
SELECT 
    AnimalID,
    AnimalName,
    Gender,
    YearOfArrival,
    SpeciesID,
    DietID,
    KeeperID,
    EnclosureID
FROM Animals;

-- Form 2: Species Data Entry View
DROP VIEW IF EXISTS vw_SpeciesDataEntry;
CREATE VIEW vw_SpeciesDataEntry AS
SELECT * FROM Species;

-- Form 3: Diet Data Entry View
DROP VIEW IF EXISTS vw_DietDataEntry;
CREATE VIEW vw_DietDataEntry AS
SELECT * FROM Diet;

-- Form 4: Keepers Data Entry View
DROP VIEW IF EXISTS vw_KeepersDataEntry;
CREATE VIEW vw_KeepersDataEntry AS
SELECT * FROM Keepers;

-- Form 5: Enclosures Data Entry View
DROP VIEW IF EXISTS vw_EnclosuresDataEntry;
CREATE VIEW vw_EnclosuresDataEntry AS
SELECT * FROM Enclosures;

-- =====================================================
-- PART 4: TASK 3 - REQUIRED QUERIES
-- =====================================================

-- Query 1: Alphabetical sorted list of keepers (ID, name, rank)
.print '=== QUERY 1: Alphabetical List of Keepers ==='
SELECT KeeperID, KeeperName, KeeperRank
FROM Keepers
ORDER BY KeeperName ASC;

-- Query 2: Number of animals in each type of enclosure
.print '=== QUERY 2: Animals per Enclosure Type ==='
SELECT 
    e.EnclosureType,
    COUNT(a.AnimalID) AS NumberOfAnimals
FROM Enclosures e
LEFT JOIN Animals a ON e.EnclosureID = a.EnclosureID
GROUP BY e.EnclosureID, e.EnclosureType
ORDER BY NumberOfAnimals DESC;

-- Query 3: Parameter query for keeper's rank
.print '=== QUERY 3: Keepers by Rank (Senior) ==='
SELECT KeeperName, KeeperDoB
FROM Keepers
WHERE KeeperRank = 'Senior';

.print '=== QUERY 3b: Keepers by Rank (Standard) ==='
SELECT KeeperName, KeeperDoB
FROM Keepers
WHERE KeeperRank = 'Standard';

.print '=== QUERY 3c: Keepers by Rank (Junior) ==='
SELECT KeeperName, KeeperDoB
FROM Keepers
WHERE KeeperRank = 'Junior';

-- Query 4: Species with more than three feeds per day
.print '=== QUERY 4: Species with >3 Feeds per Day ==='
SELECT 
    s.SpeciesType,
    d.NoOfFeedsPerDay,
    COUNT(a.AnimalID) AS TotalAnimals
FROM Species s
JOIN Animals a ON s.SpeciesID = a.SpeciesID
JOIN Diet d ON a.DietID = d.DietID
WHERE d.NoOfFeedsPerDay > 3
GROUP BY s.SpeciesType, d.NoOfFeedsPerDay
ORDER BY d.NoOfFeedsPerDay DESC;

-- Query 5: Omnivores who are critically endangered
.print '=== QUERY 5: Critically Endangered Omnivores ==='
SELECT 
    a.AnimalID,
    a.YearOfArrival AS DateArrived,
    a.SpeciesID,
    a.KeeperID,
    s.SpeciesType,
    d.DietType,
    s.ConservationStatus
FROM Animals a
JOIN Species s ON a.SpeciesID = s.SpeciesID
JOIN Diet d ON a.DietID = d.DietID
WHERE d.DietType = 'Omnivore' 
  AND s.ConservationStatus = 'Critically Endangered'
ORDER BY a.AnimalID;

-- =====================================================
-- PART 5: TASK 4 - REPORTS (Dave & Temi's Animals)
-- =====================================================

-- Report: Animals supervised by Dave and Temi
.print '=== REPORT: Animals supervised by Dave and Temi ==='
SELECT 
    k.KeeperName,
    a.AnimalID,
    a.AnimalName,
    s.SpeciesType,
    a.YearOfArrival,
    e.EnclosureType
FROM Animals a
JOIN Keepers k ON a.KeeperID = k.KeeperID
JOIN Species s ON a.SpeciesID = s.SpeciesID
JOIN Enclosures e ON a.EnclosureID = e.EnclosureID
WHERE k.KeeperName IN ('Dave', 'Temi')
ORDER BY k.KeeperName, a.AnimalName;

-- Report with counts per keeper and overall total
.print '=== REPORT: Animals per Keeper with Overall Total ==='
SELECT 
    k.KeeperID,
    k.KeeperName,
    k.KeeperRank,
    COUNT(a.AnimalID) AS AnimalsPerKeeper,
    (SELECT COUNT(*) FROM Animals) AS TotalAnimalsOverall
FROM Keepers k
LEFT JOIN Animals a ON k.KeeperID = a.KeeperID
GROUP BY k.KeeperID, k.KeeperName, k.KeeperRank
ORDER BY AnimalsPerKeeper DESC;

-- =====================================================
-- PART 6: AUTOMATED FUNCTION (SQLite uses a different approach)
-- =====================================================

-- Create a simple query that acts as an automated function
.print '=== AUTOMATED FUNCTION: Animal Count per Keeper ==='
SELECT 
    KeeperID,
    KeeperName,
    (SELECT COUNT(*) FROM Animals WHERE Animals.KeeperID = Keepers.KeeperID) AS NumberOfAnimals
FROM Keepers;

-- =====================================================
-- PART 7: PARAMETER QUERY USING SQLite variables
-- =====================================================

-- To simulate parameter queries in SQLite, we can use a CTE or just modify the WHERE clause
-- Example: Change 'Senior' to 'Standard' or 'Junior' as needed
.print '=== PARAMETER QUERY: Keepers by Rank (Change the value as needed) ==='
WITH RankParam AS (SELECT 'Senior' AS RankValue)
SELECT k.KeeperName, k.KeeperDoB
FROM Keepers k, RankParam rp
WHERE k.KeeperRank = rp.RankValue;

-- =====================================================
-- PART 8: TEST PLAN QUERIES
-- =====================================================

.print '=== TEST PLAN: Validation Checks ==='

-- Test 1: Presence Check
.print 'Test 1 - Presence Check (Missing Keepers):'
SELECT COUNT(*) AS RecordsWithMissingKeeper
FROM Animals
WHERE KeeperID IS NULL;

-- Test 2: Range Check
.print 'Test 2 - Range Check (Invalid Year):'
SELECT AnimalID, AnimalName, YearOfArrival
FROM Animals
WHERE YearOfArrival < 1990 OR YearOfArrival > strftime('%Y', 'now');

-- Test 3: Foreign Key Integrity Check
.print 'Test 3 - Foreign Key Integrity:'
SELECT a.AnimalID, a.AnimalName, a.SpeciesID
FROM Animals a
LEFT JOIN Species s ON a.SpeciesID = s.SpeciesID
WHERE s.SpeciesID IS NULL AND a.SpeciesID IS NOT NULL;

-- =====================================================
-- PART 9: INDEXES FOR PERFORMANCE
-- =====================================================

CREATE INDEX IF NOT EXISTS idx_animals_keeper ON Animals(KeeperID);
CREATE INDEX IF NOT EXISTS idx_animals_species ON Animals(SpeciesID);
CREATE INDEX IF NOT EXISTS idx_animals_enclosure ON Animals(EnclosureID);
CREATE INDEX IF NOT EXISTS idx_animals_diet ON Animals(DietID);
CREATE INDEX IF NOT EXISTS idx_keepers_rank ON Keepers(KeeperRank);

-- =====================================================
-- PART 10: COMPLETE DATA VIEW (All Relationships)
-- =====================================================

.print '=== COMPLETE ANIMAL DETAILS (All Tables Joined) ==='
SELECT 
    a.AnimalID,
    a.AnimalName,
    a.Gender,
    a.YearOfArrival,
    s.SpeciesType,
    s.SpeciesGroup,
    s.Lifestyle,
    s.ConservationStatus,
    d.DietType,
    d.NoOfFeedsPerDay,
    k.KeeperName,
    k.KeeperRank,
    e.EnclosureType,
    e.EnclosureLocation
FROM Animals a
JOIN Species s ON a.SpeciesID = s.SpeciesID
JOIN Diet d ON a.DietID = d.DietID
JOIN Keepers k ON a.KeeperID = k.KeeperID
JOIN Enclosures e ON a.EnclosureID = e.EnclosureID
ORDER BY a.AnimalID;

-- =====================================================
-- DATA DICTIONARY VIEW
-- =====================================================

.print '=== DATA DICTIONARY ==='
SELECT 'Enclosures Table' AS TableName, 
       'EnclosureID, EnclosureType, EnclosureLocation' AS Columns,
       'PRIMARY KEY: EnclosureID, CHECK constraints on Type and Location' AS Constraints
UNION ALL
SELECT 'Keepers Table',
       'KeeperID, KeeperName, KeeperDoB, KeeperRank',
       'PRIMARY KEY: KeeperID, CHECK: Rank (Senior/Standard/Junior)'
UNION ALL
SELECT 'Diet Table',
       'DietID, DietType, NoOfFeedsPerDay',
       'PRIMARY KEY: DietID, CHECK: Type (Omnivore/Herbivore/Carnivore), Feeds 1-10'
UNION ALL
SELECT 'Species Table',
       'SpeciesID, SpeciesType, SpeciesGroup, Lifestyle, ConservationStatus',
       'PRIMARY KEY: SpeciesID, CHECK: Conservation Status values'
UNION ALL
SELECT 'Animals Table',
       'AnimalID, AnimalName, Gender, YearOfArrival, SpeciesID, DietID, KeeperID, EnclosureID',
       'PRIMARY KEY: AnimalID, FOREIGN KEYS to all other tables, CHECK: Gender M/F, Year range';

-- =====================================================
-- ADDITIONAL QUERIES FOR REPORTING
-- =====================================================

-- Summary Statistics
.print '=== SUMMARY STATISTICS ==='
SELECT 
    (SELECT COUNT(*) FROM Animals) AS TotalAnimals,
    (SELECT COUNT(*) FROM Keepers) AS TotalKeepers,
    (SELECT COUNT(*) FROM Species) AS TotalSpecies,
    (SELECT COUNT(*) FROM Enclosures) AS TotalEnclosures;

-- Animals by Conservation Status   
.print '=== ANIMALS BY CONSERVATION STATUS ==='
SELECT 
    s.ConservationStatus,
    COUNT(a.AnimalID) AS NumberOfAnimals
FROM Species s
LEFT JOIN Animals a ON s.SpeciesID = a.SpeciesID
GROUP BY s.ConservationStatus
ORDER BY NumberOfAnimals DESC;

-- Animals by Diet Type
.print '=== ANIMALS BY DIET TYPE ==='
SELECT 
    d.DietType,
    COUNT(a.AnimalID) AS NumberOfAnimals
FROM Diet d
LEFT JOIN Animals a ON d.DietID = a.DietID
GROUP BY d.DietType;
