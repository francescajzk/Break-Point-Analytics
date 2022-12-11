CREATE DATABASE bp_analytics_db;

CREATE USER 'webapp'@'%' IDENTIFIED BY 'abc123';
GRANT ALL PRIVILEGES ON bp_analytics_db.* TO 'webapp'@'%';
FLUSH PRIVILEGES;

USE bp_analytics_db;

CREATE TABLE player (
    playerID int NOT NULL UNIQUE PRIMARY KEY,
    firstName TEXT NOT NULL,
    lastName TEXT NOT NULL,
    age int NOT NULL,
    height int NOT NULL,
    playHand VARCHAR(6) NOT NULL,
    country VARCHAR(30) NOT NULL,
    points int NOT NULL,
    rank int NOT NULL,
    CONSTRAINT countryFK
                     FOREIGN KEY (country) REFERENCES country (countryName)
    ON UPDATE cascade ON DELETE restrict
);

CREATE TABLE country (
    countryName VARCHAR(30) NOT NULL PRIMARY KEY,
    laverTeam VARCHAR(7),
);

CREATE TABLE countryHost (
    country VARCHAR(30) NOT NULL,
    tourID INT NOT NULL,
    city VARCHAR(40) NOT NULL,
    PRIMARY KEY (country, tourID),
    CONSTRAINT countryFK
                     FOREIGN KEY (country) REFERENCES country (countryName)
    CONSTRAINT tournamentFK
                     FOREIGN KEY (tourID) REFERENCES tournament (tourID)
);

CREATE TABLE tournament (
    tourID INT NOT NULL UNIQUE PRIMARY KEY,
    name TEXT NOT NULL,
    points INT NOT NULL,
    drawSize INT NOT NULL,
    startDate DATE,
    endDate DATE,
    level CHAR(1) NOT NULL,
    surface VARCHAR(6) NOT NULL,
);

CREATE TABLE prizeMoney (
    tourID INT NOT NULL PRIMARY KEY,
    round INT,
    money INT,
    CONSTRAINT tournamentFK
                        FOREIGN KEY (tourID) references tournament (tourID)
);

CREATE TABLE court (
    name TEXT NOT NULL,
    capacity INT NOT NULL,
    isCovered BOOLEAN NOT NULL,
    tourID INT NOT NULL,
    courtID INT UNIQUE NOT NULL PRIMARY KEY,
    CONSTRAINT tournamentFK
                        FOREIGN KEY (tourID) references tournament (tourID)
);

CREATE TABLE matchInfo (
    matchID INT UNIQUE NOT NULL PRIMARY KEY,
    round INT NOT NULL,
    duration TIME,
    tourID INT NOT NULL,
    winnerID INT NOT NULL,
    loserID INT NOT NULL,
    CONSTRAINT tournamentFK
                        FOREIGN KEY (tourID) references tournament (tourID),
    CONSTRAINT winnerFK
                        FOREIGN KEY (winnerID) references player (playerID),
    CONSTRAINT loserFK
                        FOREIGN KEY (loserID) references player (loserID)
);

CREATE TABLE matchSchedule (
    matchID INT NOT NULL PRIMARY KEY,
    time TIME NOT NULL,
    date DATE NOT NULL,
    courtID INT NOT NULL,
    CONSTRAINT matchFK
                        FOREIGN KEY (matchID) references matchInfo (matchID),
    CONSTRAINT courtFK
                        FOREIGN KEY (courtID) references court (courtID)
);

CREATE TABLE matchResult (
    bestOf INT NOT NULL,
    score VARCHAR(50) NOT NULL,
    matchID INT UNIQUE NOT NULL PRIMARY KEY,
    CONSTRAINT matchFK
                        FOREIGN KEY (matchID) references matchInfo (matchID),
);

CREATE TABLE loser (
    playerID INT NOT NULL,
    matchID INT NOT NULL,
    seed INT,
    entry VARCHAR(2),
    currentRank INT NOT NULL,
    PRIMARY KEY(playerID, matchID),
    CONSTRAINT matchFK
                        FOREIGN KEY (matchID) references matchInfo (matchID),
    CONSTRAINT playerFK
                        FOREIGN KEY (playerID) references player (playerID)
);

CREATE TABLE winner (
    playerID INT NOT NULL,
    matchID INT NOT NULL,
    seed INT,
    entry VARCHAR(2),
    currentRank INT NOT NULL,
    pointsGained INT NOT NULL,
    PRIMARY KEY(playerID, matchID),
    CONSTRAINT matchFK
                        FOREIGN KEY (matchID) references matchInfo (matchID),
    CONSTRAINT playerFK
                        FOREIGN KEY (playerID) references player (playerID)
);

CREATE TABLE playerMatchData (
    aces INT,
    doubleFaults INT,
    servicePts INT,
    firstServeIn INT,
    firstServePts INT,
    secondServePts INT,
    serviceGames INT,
    BPFaced INT,
    BPSaved INT,
    playerID INT NOT NULL,
    matchID INT NOT NULL,
    PRIMARY KEY (playerID, matchID),
    CONSTRAINT matchFK
                        FOREIGN KEY (matchID) references matchInfo (matchID),
    CONSTRAINT playerFK
                        FOREIGN KEY (playerID) references player (playerID)
);

insert into player values
                       (1, 'Lorenzo', 'Musetti', 20, 185, 'right', 'Italy', 1865, 23),
                       (2, 'Alexander', 'Zverev', 25, 198, 'right', 'Germany', 2700, 12),
                       (3, 'Rafael', 'Nadal', 36, 185, 'left', 'Spain', 6020, 2),
                       (4, 'Hubert', 'Hurkacz', 25, 196, 'right', 'Poland', 2905, 10),
                       (5, 'Andrey', 'Rublev', 25, 188, 'right', 'Russia', 3930, 8),
                       (6, 'Stefanos', 'Tsitsipas', 24, 193, 'right', 'Greece', 5550, 4),
                       (7, 'Novak', 'Djokovic', 35, 188, 'right', 'Serbia', 4820, 5),
                       (8, 'Daniil', 'Medvedev', 26, 198, 'right', 'Russia', 4065, 7),
                       (9, 'Alexander', 'Bublik', 25, 196, 'right', 'Kazakhstan', 1130, 37),
                       (10, 'Ugo', 'Humbert', 24, 188, 'left', 'France', 613, 87);

insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (11, 'Nealy', 'Stamper', 34, 170, 'right', 'China', 529, 11);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (12, 'Townie', 'Alabaster', 19, 199, 'right', 'United States', 508, 3);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (13, 'Tabb', 'Labroue', 26, 169, 'left', 'China', 1441, 13);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (14, 'Nestor', 'Edwinson', 31, 189, 'right', 'Indonesia', 366, 14);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (15, 'Abran', 'Karpenko', 22, 194, 'right', 'Cameroon', 722, 15);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (16, 'Sammie', 'Caile', 33, 181, 'left', 'Panama', 667, 16);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (17, 'Bogey', 'Duhig', 31, 172, 'left', 'Brazil', 1497, 17);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (18, 'Dagny', 'Tipens', 27, 175, 'left', 'Poland', 328, 18);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (19, 'Chariot', 'Crinion', 31, 190, 'left', 'American Samoa', 754, 19);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (20, 'Cornell', 'Pietri', 21, 181, 'left', 'China', 154, 20);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (21, 'Orren', 'Christin', 24, 173, 'right', 'China', 822, 21);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (22, 'Guss', 'Barrowcliff', 21, 173, 'right', 'Bulgaria', 1089, 22);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (23, 'Morty', 'Bawden', 25, 197, 'right', 'Dominican Republic', 1093, 6);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (24, 'Lydon', 'Hortop', 26, 182, 'left', 'Indonesia', 173, 24);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (25, 'Symon', 'Pell', 30, 194, 'left', 'Czech Republic', 669, 25);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (26, 'Rodolfo', 'Whelband', 29, 191, 'left', 'Sweden', 939, 26);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (27, 'Lewes', 'Tatlow', 33, 194, 'right', 'Japan', 1242, 27);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (28, 'Way', 'Dumberell', 25, 169, 'left', 'Morocco', 488, 28);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (29, 'Felipe', 'Duffrie', 22, 164, 'right', 'China', 609, 29);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (30, 'Marcus', 'McAvaddy', 24, 198, 'right', 'China', 1321, 30);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (31, 'Rudyard', 'Wick', 27, 193, 'right', 'Poland', 417, 31);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (32, 'Allister', 'Ormston', 28, 161, 'right', 'Japan', 908, 32);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (33, 'Cyril', 'Waudby', 22, 189, 'right', 'Poland', 151, 33);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (34, 'Nat', 'Waudby', 19, 178, 'right', 'Saudi Arabia', 1385, 34);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (35, 'Alfy', 'Blakeborough', 28, 182, 'left', 'Russia', 820, 35);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (36, 'Corny', 'Tollfree', 23, 188, 'left', 'China', 589, 36);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (37, 'Ibrahim', 'Velden', 28, 166, 'left', 'Argentina', 974, 89);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (38, 'Craggie', 'Hadny', 21, 180, 'left', 'Venezuela', 798, 38);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (39, 'Nobie', 'Ostrich', 20, 166, 'right', 'Portugal', 76, 39);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (40, 'Shalom', 'Mayell', 19, 176, 'right', 'Philippines', 1136, 40);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (41, 'Bucky', 'Dmytryk', 23, 162, 'right', 'China', 452, 41);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (42, 'Sargent', 'Goudge', 18, 180, 'left', 'Madagascar', 669, 42);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (43, 'Monroe', 'Reignard', 19, 172, 'right', 'China', 435, 43);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (44, 'Christy', 'Timcke', 29, 190, 'left', 'Portugal', 419, 44);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (45, 'Gibbie', 'Merryfield', 22, 187, 'left', 'China', 62, 45);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (46, 'Danny', 'Kerridge', 23, 170, 'left', 'Sweden', 394, 46);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (47, 'Dannel', 'McConnell', 35, 173, 'right', 'Syria', 48, 47);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (48, 'Jens', 'Cordingly', 23, 195, 'left', 'Japan', 471, 48);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (49, 'Pattin', 'McKinnon', 18, 199, 'right', 'Poland', 1121, 49);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (50, 'Yale', 'Djurisic', 30, 183, 'left', 'Indonesia', 449, 50);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (51, 'Chaddie', 'Davitti', 22, 189, 'right', 'Argentina', 995, 51);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (52, 'Neale', 'Boote', 18, 182, 'right', 'Philippines', 1414, 52);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (53, 'Chrotoem', 'Slimm', 34, 181, 'right', 'Indonesia', 403, 53);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (54, 'Colin', 'Rohloff', 29, 183, 'right', 'Japan', 842, 54);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (55, 'Gregorius', 'Wolpert', 26, 170, 'left', 'Cape Verde', 1353, 55);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (56, 'Wyndham', 'Stainton', 22, 171, 'left', 'Venezuela', 1204, 56);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (57, 'Wendall', 'Domleo', 23, 190, 'left', 'Argentina', 869, 57);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (58, 'Virgie', 'Langridge', 35, 189, 'left', 'Mexico', 946, 58);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (59, 'Kiel', 'Kenington', 33, 197, 'left', 'China', 1070, 59);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (60, 'Alvy', 'Riddles', 24, 199, 'right', 'United States', 28, 60);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (61, 'Ludwig', 'De La Haye', 34, 173, 'right', 'Sweden', 1408, 61);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (62, 'Gray', 'Bonhill', 29, 180, 'left', 'Venezuela', 25, 62);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (63, 'Jessee', 'Deakan', 18, 170, 'right', 'Russia', 1304, 63);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (64, 'Brennen', 'Greser', 28, 167, 'left', 'United States', 1357, 64);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (65, 'Chariot', 'Rodenhurst', 22, 162, 'left', 'France', 1222, 65);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (66, 'Bear', 'Pardy', 31, 169, 'right', 'Argentina', 754, 66);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (67, 'Rafferty', 'Goodlip', 31, 197, 'right', 'Canada', 547, 67);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (68, 'Trumann', 'Riddeough', 22, 178, 'left', 'Sweden', 185, 68);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (69, 'Daniel', 'Gytesham', 28, 187, 'right', 'Portugal', 1107, 69);
insert into player (playerID, firstName, lastName, age, height, playHand, country, points, rank) values (70, 'Freddy', 'Gricewood', 27, 184, 'right', 'United States', 953, 70);

insert into country values
                       ('Italy', 'Europe'),
                       ('Germany', 'Europe'),
                       ('Spain', 'Europe'),
                       ('Poland', 'Europe'),
                       ('Russia', 'Europe'),
                       ('Greece', 'Europe'),
                       ('Serbia', 'Europe'),
                       ('Kazakhstan', 'Europe'),
                       ('France', 'Europe'),
                       ('Australia', 'World'),
                       ('United Kingdom', 'Europe'),
                       ('Serbia', 'Europe');

insert into country (countryName, laverTeam) values ('Indonesia', 'World');
insert into country (countryName, laverTeam) values ('Japan', 'World');
insert into country (countryName, laverTeam) values ('Brazil', 'World');
insert into country (countryName, laverTeam) values ('Bulgaria', 'Europe');
insert into country (countryName, laverTeam) values ('Armenia', 'World');
insert into country (countryName, laverTeam) values ('China', 'World');
insert into country (countryName, laverTeam) values ('Thailand', 'World');
insert into country (countryName, laverTeam) values ('Colombia', 'World');
insert into country (countryName, laverTeam) values ('Philippines', 'World');
insert into country (countryName, laverTeam) values ('Costa Rica', 'World');

insert into tournament values
                           (1, 'Roland-Garros', 2000, 128, '2022-05-22', '2022-06-05', 'G', 'clay'),
                           (2, 'Italian Open', 1000, 56, '2022-05-02', '2022-05-15', 'M', 'clay'),
                           (3, 'Australian Open', 2000, 128, '2022-01-17', '2022-01-30', 'G', 'hard'),
                           (4, 'Wimbledon', 2000, 128, '2021-06-28', '2021-07-11', 'G', 'grass'),
                           (5, 'Serbia Open', 250, 28, '2022-04-18', '2022-04-24', 'T', 'clay'),
                           (6, 'Roland-Garros', 2000, 128, '2021-05-22', '2021-06-05', 'G', 'clay'),
                           (7, 'Italian Open', 1000, 56, '2021-05-02', '2021-05-15', 'M', 'clay'),
                           (8, 'Australian Open', 2000, 128, '2021-01-17', '2021-01-30', 'G', 'hard'),
                           (9, 'Wimbledon', 2000, 128, '2020-06-28', '2020-07-11', 'G', 'grass'),
                           (10, 'Serbia Open', 250, 28, '2021-04-18', '2021-04-24', 'T', 'clay'),
                           (11, 'Roland-Garros', 2000, 128, '2003-05-22', '2003-06-05', 'G', 'clay'),
                           (12, 'Italian Open', 1000, 56, '2002-05-02', '2002-05-15', 'M', 'clay'),
                           (13, 'Australian Open', 2000, 128, '2019-01-17', '2019-01-30', 'G', 'hard'),
                           (14, 'Wimbledon', 2000, 128, '2006-06-28', '2006-07-11', 'G', 'grass'),
                           (15, 'Serbia Open', 250, 28, '2017-04-18', '2017-04-24', 'T', 'clay'),
                           (16, 'Roland-Garros', 2000, 128, '1999-05-22', '1999-06-05', 'G', 'clay'),
                           (17, 'Italian Open', 1000, 56, '2004-05-02', '2004-05-15', 'M', 'clay'),
                           (18, 'Australian Open', 2000, 128, '1999-01-17', '1999-01-30', 'G', 'hard'),
                           (19, 'Wimbledon', 2000, 128, '2003-06-28', '2003-07-11', 'G', 'grass'),
                           (20, 'Serbia Open', 250, 28, '2005-04-18', '2005-04-24', 'T', 'clay');

insert into countryHost values
                            ('Italy', 2, 'Rome'),
                            ('France', 1, 'Paris'),
                            ('Australia', 3, 'Melbourne'),
                            ('United Kingdom', 4, 'London'),
                            ('Serbia', 5, 'Belgrade'),
                            ('Italy', 7, 'Rome'),
                            ('France', 6, 'Paris'),
                            ('Australia', 8, 'Melbourne'),
                            ('United Kingdom', 9, 'London'),
                            ('Serbia', 10, 'Belgrade'),
                            ('Italy', 12, 'Rome'),
                            ('France', 11, 'Paris'),
                            ('Australia', 13, 'Melbourne'),
                            ('United Kingdom', 14, 'London'),
                            ('Serbia', 15, 'Belgrade'),
                            ('Italy', 17, 'Rome'),
                            ('France', 16, 'Paris'),
                            ('Australia', 18, 'Melbourne'),
                            ('United Kingdom', 19, 'London'),
                            ('Serbia', 20, 'Belgrade');

insert into court values
                      ('Suzanne Lenglen', 10056, 0, 1, 1),
                      ('Nicola Pietrangeli Stadium', 4000, 0, 2, 2),
                      ('Rod Laver Arena', 14820, 1, 3, 3),
                      ('Court 1', 11429, 0, 4, 4),
                      ('Court 1', 3500, 0, 5, 5),
                      ('Central Court', 10056, 0, 17, 6),
                      ('Court 12', 4000, 0, 19, 7),
                      ('Court 4', 14820, 1, 20, 8),
                      ('Court 5', 11429, 0, 10, 9),
                      ('Court 6', 3500, 0, 18, 10),
                      ('Court 7', 10056, 0, 12, 11),
                      ('KIA Stadium', 4000, 0, 16, 12),
                      ('Phillipe-Chartier', 14820, 1, 12, 13),
                      ('Court 5', 11429, 0, 13, 14),
                      ('Court 7', 3500, 0, 11, 15);

insert into prizeMoney values
                      (1, 1, 500),
                      (2, 4, 2000),
                      (3, 1, 1000),
                      (4, 6, 250000),
                      (5, 3, 5000),
                      (6, 1, 500),
                      (7, 4, 2000),
                      (8, 1, 1000),
                      (9, 6, 250000),
                      (10, 3, 5000),
                      (11, 1, 500),
                      (12, 4, 2000),
                      (13, 1, 1000),
                      (14, 6, 250000),
                      (15, 3, 5000),
                      (16, 1, 500),
                      (17, 4, 2000),
                      (18, 1, 1000),
                      (19, 6, 250000),
                      (20, 3, 5000);

insert into matchInfo values
                          (1, 1, '01:50:23', 1, 10, 3),
                          (14, 4, '02:23:15', 2, 2, 1),
                          (52, 3, '01:24:14', 3, 6, 10),
                          (240, 5, '03:01:22', 4, 4, 8),
                          (234, 3, '01:15:43', 5, 7, 9),
                          (265, 1, '01:50:23', 6, 25, 63),
                          (268, 4, '02:23:15', 7, 11, 55),
                          (280, 3, '01:24:14', 8, 12, 4),
                          (301, 5, '03:01:22', 9, 33, 60),
                          (303, 3, '01:15:43', 10, 27, 29),
                          (340, 1, '01:50:23', 11, 10, 1),
                          (342, 4, '02:23:15', 12, 22, 8),
                          (389, 3, '01:24:14', 13, 34, 10),
                          (390, 5, '03:01:22', 14, 50, 20),
                          (398, 3, '01:15:43', 15, 21, 5),
                          (400, 1, '01:50:23', 16, 12, 3),
                          (401, 4, '02:23:15', 17, 13, 12),
                          (423, 3, '01:24:14', 18, 14, 12),
                          (446, 5, '03:01:22', 19, 32, 8),
                          (480, 3, '01:15:43', 20, 3, 9);

insert into matchResult values
                            (5, '6-2 6-4 6-4', 1),
                            (3, '6-4 4-6 6-4', 14),
                            (5, '6-2 6-2 6-2', 52),
                            (5, '6-3 3-6 7-6(4) 6-2', 240),
                            (3, '6-1 6-1', 234),
                            (5, '6-2 6-4 6-4', 265),
                            (3, '6-4 4-6 6-4', 268),
                            (5, '6-2 6-2 6-2', 280),
                            (5, '6-3 3-6 7-6(4) 6-2', 301),
                            (3, '6-1 6-1', 303),
                            (5, '6-2 6-4 6-4', 340),
                            (3, '6-4 4-6 6-4', 342),
                            (5, '6-2 6-2 6-2', 389),
                            (5, '6-3 3-6 7-6(4) 6-2', 390),
                            (3, '6-1 6-1', 398),
                            (5, '6-2 6-4 6-4', 400),
                            (3, '6-4 4-6 6-4', 401),
                            (5, '6-2 6-2 6-2', 423),
                            (5, '6-3 3-6 7-6(4) 6-2', 446),
                            (3, '6-1 6-1', 480);

insert into winner (playerID, matchID, currentRank, pointsGained) values
                       (10, 1, 3, 25),
                       (2, 14, 5, 50),
                       (6, 52, 32, 600),
                       (4, 240, 14, 80),
                       (7, 234, 1, 50),
                       (25, 265, 2, 25),
                       (11, 268, 80, 50),
                       (12, 280, 65, 600),
                       (33, 301, 33, 80),
                       (27, 303, 40, 50),
                       (10, 340, 45, 25),
                       (22, 342, 10, 50),
                       (34, 389, 19, 600),
                       (50, 390, 22, 80),
                       (21, 398, 66, 50),
                       (12, 400, 108, 25),
                       (13, 401, 99, 50),
                       (14, 423, 89, 600),
                       (32, 446, 77, 80),
                       (3, 480, 72, 50);

insert into loser (playerID, matchID, currentRank) values
                                                       (3, 1, 5),
                                                       (1, 14, 8),
                                                       (10, 52, 4),
                                                       (8, 240, 10),
                                                       (9, 234, 50),
                                                       (63, 265, 2),
                                                       (55, 268, 19),
                                                       (4, 280, 23),
                                                       (60, 301, 109),
                                                       (29, 303, 55),
                                                       (1, 340, 43),
                                                       (8, 342, 25),
                                                       (10, 389, 69),
                                                       (20, 390, 70),
                                                       (5, 398, 91),
                                                       (3, 400, 101),
                                                       (12, 401, 4),
                                                       (12, 423, 14),
                                                       (8, 446, 17),
                                                       (9, 480, 20);

insert into playerMatchData values
                                (8, 1, 126, 76, 56, 29, 16, 14, 15, 3, 1),
                                (4, 2, 67, 35, 25, 16, 10, 4 , 6, 10, 1),
                                (0, 0, 43, 37, 29, 4, 8, 3, 3, 7, 234),
                                (12, 4, 92, 59, 47, 12, 15, 2, 4, 8, 240),
                                (2, 0, 25, 13, 9, 6, 5, 3, 5, 10, 52),
                                (8, 1, 126, 76, 56, 29, 16, 14, 15, 1, 14),
                                (4, 2, 67, 35, 25, 16, 10, 4 , 6, 63, 265),
                                (0, 0, 43, 37, 29, 4, 8, 3, 3, 55, 268),
                                (12, 4, 92, 59, 47, 12, 15, 2, 4, 4, 280),
                                (2, 0, 25, 13, 9, 6, 5, 3, 5, 60, 301),
                                (8, 1, 126, 76, 56, 29, 16, 14, 15, 29, 303),
                                (4, 2, 67, 35, 25, 16, 10, 4 , 6, 1, 340),
                                (0, 0, 43, 37, 29, 4, 8, 3, 3, 8, 342),
                                (12, 4, 92, 59, 47, 12, 15, 2, 4, 10, 389),
                                (2, 0, 25, 13, 9, 6, 5, 3, 5, 20, 390),
                                (8, 1, 126, 76, 56, 29, 16, 14, 15, 5, 398),
                                (4, 2, 67, 35, 25, 16, 10, 4 , 6, 3, 400),
                                (0, 0, 43, 37, 29, 4, 8, 3, 3, 12, 401),
                                (12, 4, 92, 59, 47, 12, 15, 2, 4, 12, 423),
                                (2, 0, 25, 13, 9, 6, 5, 3, 5, 8, 446);