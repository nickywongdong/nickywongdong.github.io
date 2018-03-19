-- Drop Tables if they Exist:

DROP TABLE IF EXISTS `guardian`;
DROP TABLE IF EXISTS `guardian_on_strike`;
DROP TABLE IF EXISTS `weapon`;
DROP TABLE IF EXISTS `guardians_weapons`;
DROP TABLE IF EXISTS `planet`;
DROP TABLE IF EXISTS `npc`;
DROP TABLE IF EXISTS `strike`;


-- Guardian Table:

CREATE TABLE guardian (
    id int NOT NULL AUTO_INCREMENT,
    weapon_id int,
    planet_id int,
    npc_id int,
    strike_id int,
    current_planet VARCHAR(255),
    name VARCHAR(255) NOT NULL,
    class VARCHAR(255) NOT NULL,
    race VARCHAR(255) NOT NULL,
    level int NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (strike_id) REFERENCES strike(id),
    FOREIGN KEY (weapon_id)  REFERENCES weapon(id),
    FOREIGN KEY (planet_id) REFERENCES planet(id),
    FOREIGN KEY (npc_id) REFERENCES npc(id),
    UNIQUE (name)
);

CREATE TABLE guardians_weapons (
    id int NOT NULL AUTO_INCREMENT,
    guardian_id int,
    weapon_id int,
    PRIMARY KEY(id),
    FOREIGN KEY(guardian_id) REFERENCES guardian(id),
    FOREIGN KEY(weapon_id) REFERENCES weapon(id)
);

CREATE TABLE guardian_on_strike (
    id int NOT NULL AUTO_INCREMENT,
    guardian_id int,
    strike_id int,
    PRIMARY KEY(id),
    FOREIGN KEY (guardian_id) REFERENCES guardian(id),
    FOREIGN KEY (strike_id) REFERENCES strike(id)
);


-- NPC Table:

CREATE TABLE npc (
    id int NOT NULL AUTO_INCREMENT,
    weapon_id int,
    guardian_id int,
    planet_id int,
    current_planet VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    class VARCHAR(255) NOT NULL,
    race VARCHAR(255) NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (weapon_id)  REFERENCES weapon(id),
    FOREIGN KEY (guardian_id)  REFERENCES guardian(id),
    FOREIGN KEY (planet_id)  REFERENCES planet(id),
    UNIQUE (name)
);


-- Planet Table:

CREATE TABLE planet (
    id int NOT NULL AUTO_INCREMENT,
    npc_id int,
    guardian_id int,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (npc_id) REFERENCES npc(id),
    FOREIGN KEY (guardian_id) REFERENCES guardian(id),
    UNIQUE (name)
);

-- Weapon Table:

CREATE TABLE weapon (
    id int NOT NULL AUTO_INCREMENT,
    guardian_id int,
    npc_id int,
    name VARCHAR(255) NOT NULL,
    tier VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (guardian_id) REFERENCES guardian(id),
    FOREIGN KEY (npc_id) REFERENCES npc(id)
);

-- Strikes Table:

CREATE TABLE strike (
    id int NOT NULL AUTO_INCREMENT,
    guardian_id int,
    npc_id int,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (guardian_id) REFERENCES guardian(id),
    FOREIGN KEY (npc_id) REFERENCES npc(id)
);


-- Inserting initial planets
INSERT INTO planet (name)
VALUES
('Earth'),
('Io'),
('Titan'),
('The Reef'),
('Nessus');

-- Inserting initial weapons
INSERT INTO weapon(name, tier, type)
VALUES
('MIDA Multi-Tool', 'Exotic', 'Scout Rifle'),
('Gjallarhorn', 'Exotoc', 'Rocket Launcher'),
('Prometheus Lens', 'Exotic', 'Trace Rifle'),
('Sorrow MG2', 'Common', 'Submachine Gun');


-- Inserting Initial Guardians:
INSERT INTO guardian (name, class, race, level, current_planet)
VALUES
('HorsemanSOJelly', 'Hunter', 'Human', '20', 'Earth'),
('kidvi11ain', 'Warlock', 'Awoken', '20', 'The Reef'),
('IMgrenade', 'Titan', 'Human', '12', 'Earth');

-- Inserting initial NPCs
INSERT INTO npc (name, class, race, current_planet)
VALUES
('Cayde-6', 'Hunter', 'EXO', 'Earth'),
('Ikora Rey', 'Warlock', 'Human', 'Earth'),
('Zavala', 'Titan', 'Awoken', 'Earth');


-- Inserting initial strikes
INSERT INTO strike (name, npc_id)
VALUES
('Nightfall', (select id from npc where name = 'Zavala')),
('Exodus Crash', (select id from npc where name = 'Cayde-6')),
('Savathûns Song', (select id from npc where name = 'Zavala')),
('The Inverted Spire', (select id from npc where name = 'Cayde-6')),
('The Pyramidion', (select id from npc where name = 'Ikora Rey'));
