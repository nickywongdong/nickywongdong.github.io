-- Drop Tables if they Exist:

DROP TABLE IF EXISTS `guardian`;
DROP TABLE IF EXISTS `weapon`;
DROP TABLE IF EXISTS `planet`;
DROP TABLE IF EXISTS `npc`;


-- Guardian Table:

CREATE TABLE guardian (
    id int NOT NULL AUTO_INCREMENT,
    weapon_id int,
    planet_id int,
    npc_id int,
    name VARCHAR(255) NOT NULL,
    class VARCHAR(255) NOT NULL,
    race VARCHAR(255) NOT NULL,
    level int NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (weapon_id)  REFERENCES weapon(id),
    FOREIGN KEY (planet_id) REFERENCES planet(id),
    FOREIGN KEY (npc_id) REFERENCES npc(id),
    UNIQUE (name)
);


-- NPC Table:

CREATE TABLE npc (
    id int NOT NULL AUTO_INCREMENT,
    weapon_id int,
    guardian_id int,
    planet_id int,
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



-- Inserting Initial Guardians:
INSERT INTO guardian (name, class, race, level)
VALUES
('HorsemanSOJelly', 'Hunter', 'Human', '20'),
('kidvi11ain', 'Warlock', 'Awoken', '20'),
('IMgrenade', 'Titan', 'Humann', '12');

-- Inserting initial NPCs
INSERT INTO npc (name, class, race)
VALUES
('Cayde-6', 'Hunter', 'EXO'),
('Ikora Rey', 'Warlock', 'Human'),
('Zavala', 'Titan', 'Awoken');

-- Inserting initial planets
INSERT INTO planet (name)
VALUES
('Earth'),
('Io'),
('Titan'),
('Nessus');

-- Inserting initial weapons
INSERT INTO weapon(name, tier, type)
VALUES
('MIDA Multi-Tool', 'Exotic', 'Scout Rifle'),
('Prometheus Lens', 'Exotic', 'Trace Rifle'),
('Sorrow MG2', 'Common', 'Submachine Gun');
