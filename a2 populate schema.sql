BEGIN;

DROP SCHEMA IF EXISTS A2 CASCADE;
CREATE SCHEMA A2;
SET search_path TO A2;

DROP TABLE IF EXISTS country CASCADE;
DROP TABLE IF EXISTS language CASCADE;
DROP TABLE IF EXISTS religion CASCADE;
DROP TABLE IF EXISTS hdi CASCADE;
DROP TABLE IF EXISTS ocean CASCADE;
DROP TABLE IF EXISTS neighbour CASCADE;
DROP TABLE IF EXISTS oceanAccess CASCADE;
DROP TABLE IF EXISTS Query1 CASCADE;
DROP TABLE IF EXISTS Query2 CASCADE;
DROP TABLE IF EXISTS Query3 CASCADE;
DROP TABLE IF EXISTS Query4 CASCADE;
DROP TABLE IF EXISTS Query5 CASCADE;
DROP TABLE IF EXISTS Query6 CASCADE;
DROP TABLE IF EXISTS Query7 CASCADE;
DROP TABLE IF EXISTS Query8 CASCADE;
DROP TABLE IF EXISTS Query9 CASCADE;
DROP TABLE IF EXISTS Query10 CASCADE;


-- The country table contains all the countries in the world and their facts.
-- 'cid' is the id of the country.
-- 'name' is the name of the country.
-- 'height' is the highest elevation point of the country.
-- 'population' is the population of the country.
CREATE TABLE country (
    cid 		INTEGER 	PRIMARY KEY,
    cname 		VARCHAR(200)	NOT NULL,
    height 		INTEGER 	NOT NULL,
    population	INTEGER 	NOT NULL);
    
-- The language table contains information about the languages and the percentage of the speakers of the language for each country.
-- 'cid' is the id of the country.
-- 'lid' is the id of the language.
-- 'lname' is the name of the language.
-- 'lpercentage' is the percentage of the population in the country who speak the language.
CREATE TABLE language (
    cid 		INTEGER 	REFERENCES country(cid) ON DELETE RESTRICT,
    lid 		INTEGER 	NOT NULL,
    lname 		VARCHAR(200) NOT NULL,
    lpercentage	REAL 		NOT NULL,
	PRIMARY KEY(cid, lid));

-- The religion table contains information about the religions and the percentage of the population in each country that follow the religion.
-- 'cid' is the id of the country.
-- 'rid' is the id of the religion.
-- 'rname' is the name of the religion.
-- 'rpercentage' is the percentage of the population in the country who follows the religion.
CREATE TABLE religion (
    cid 		INTEGER 	REFERENCES country(cid) ON DELETE RESTRICT,
    rid 		INTEGER 	NOT NULL,
    rname 		VARCHAR(200) NOT NULL,
    rpercentage	REAL 		NOT NULL,
	PRIMARY KEY(cid, rid));

-- The hdi table contains the human development index of each country per year. (http://en.wikipedia.org/wiki/Human_Development_Index)
-- 'cid' is the id of the country.
-- 'year' is the year when the hdi score has been estimated.
-- 'hdi_score' is the Human Development Index score of the country that year. It takes values [0, 1] with a larger number representing a higher HDI.
CREATE TABLE hdi (
    cid 		INTEGER 	REFERENCES country(cid) ON DELETE RESTRICT,
    year 		INTEGER 	NOT NULL,
    hdi_score 	REAL 		NOT NULL,
	PRIMARY KEY(cid, year));

-- The ocean table contains information about oceans on the earth.
-- 'oid' is the id of the ocean.
-- 'oname' is the name of the ocean.
-- 'depth' is the depth of the deepest part of the ocean
CREATE TABLE ocean (
    oid 		INTEGER 	PRIMARY KEY,
    oname 		VARCHAR(200) NOT NULL,
    depth 		INTEGER 	NOT NULL);

-- The neighbour table provides information about the countries and their neighbours.
-- 'country' refers to the cid of the first country.
-- 'neighbor' refers to the cid of a country that is neighbouring the first country.
-- 'length' is the length of the border between the two neighbouring countries.
-- Note that if A and B are neighbours, then there two tuples are stored in the table to represent that information (A, B) and (B, A). 
CREATE TABLE neighbour (
    country 	INTEGER 	REFERENCES country(cid) ON DELETE RESTRICT,
    neighbor 	INTEGER 	REFERENCES country(cid) ON DELETE RESTRICT, 
    length 		INTEGER 	NOT NULL,
	PRIMARY KEY(country, neighbor));

-- The oceanAccess table provides information about the countries which have a border with an ocean.
-- 'cid' refers to the cid of the country.
-- 'oid' refers to the oid of the ocean.
CREATE TABLE oceanAccess (
    cid 	INTEGER 	REFERENCES country(cid) ON DELETE RESTRICT,
    oid 	INTEGER 	REFERENCES ocean(oid) ON DELETE RESTRICT, 
    PRIMARY KEY(cid, oid));


-- The following tables will be used to store the results of your queries. 
-- Each of them should be populated by your last SQL statement that looks like:
-- "INSERT INTO QueryX (SELECT ...<complete your SQL query here> ... )"

CREATE TABLE Query1(
	c1id	INTEGER,
    c1name	VARCHAR(200),
	c2id	INTEGER,
    c2name	VARCHAR(200)
);

CREATE TABLE Query2(
	cid		INTEGER,
    cname	VARCHAR(200)
);

CREATE TABLE Query3(
	c1id	INTEGER,
    c1name	VARCHAR(200),
	c2id	INTEGER,
    c2name	VARCHAR(200)
);

CREATE TABLE Query4(
	cname	VARCHAR(200),
    oname	VARCHAR(200)
);

CREATE TABLE Query5(
	cid		INTEGER,
    cname	VARCHAR(200),
	avghdi	REAL
);

CREATE TABLE Query6(
	cid		INTEGER,
    cname	VARCHAR(200)
);

CREATE TABLE Query7(
	rid			INTEGER,
    rname		VARCHAR(200),
	followers	INTEGER
);

CREATE TABLE Query8(
	c1name	VARCHAR(200),
    c2name	VARCHAR(200),
	lname	VARCHAR(200)
);

CREATE TABLE Query9(
    cname		VARCHAR(200),
	totalspan	INTEGER
);

CREATE TABLE Query10(
    cname			VARCHAR(200),
	borderslength	INTEGER
);

-- SCHEMA POPULATING BEGIN

-- country table
COPY country (cid, cname, height, population) FROM stdin;
1	The North	500	2500
2	The Riverlands	400	3000
3	The Vale	3000	4000
4	The Westerlands	300	5000
5	Iron Islands	250	1000
6	The Crownlands	1000	8000
7	The Reach	500	4500
8	The Stormlands	600	2000
9	Dorne	800	1000
\.

-- language table
COPY language (cid, lid, lname, lpercentage) FROM stdin;
1	1	Common Tongue	100
2	1	Common Tongue	100
3	1	Common Tongue	100
4	1	Common Tongue	100
5	1	Common Tongue	100
6	1	Common Tongue	100
7	1	Common Tongue	100
8	1	Common Tongue	100
9	1	Common Tongue	100
\.
-- religion table
COPY religion (cid, rid, rname, rpercentage) FROM stdin;
1	1	Faith of the Seven	20
1	2	Old Gods of the Forest	80
2	1	Faith of the Seven	75
2	2	Old Gods of the Forest	25
3	1	Faith of the Seven	85
3	2	Old Gods of the Forest	15
4	1	Faith of the Seven	100
5	3	Drowned Gods	85
5	1	Faith of the Seven	15
6	1	Faith of the Seven	100
7	1	Faith of the Seven	100
8	1	Faith of the Seven	100
9	1	Faith of the Seven	100
\.

-- hdi table
COPY hdi (cid, year, hdi_score) FROM stdin;
1	15	23
2	15	11
3	15	3
4	15	45
5	15	68
6	15	62
7	15	87
8	15	56
9	15	14
1	35	96
2	35	23
3	35	76
4	35	35
5	35	13
6	35	99
7	35	60
8	35	35
9	35	63
1	100	66
2	100	15
3	100	10
4	100	31
5	100	10
6	100	82
7	100	14
8	100	64
9	100	6
\.

-- ocean table population
COPY ocean (oid, oname, depth) FROM stdin;
1	Narrow Sea	5000
2	Shivering Sea	10000
3	Sunset Sea	3000
4	Summer Sea	5000
\.

-- neighbour table population
COPY neighbour (country, neighbor, length) FROM stdin;
1	2	10
1	3	100
1	5	1000
2	1	10
2	3	5
2	4	15
2	5	500
2	6	50
2	7	30
3	1	100
3	2	5
3	6	200
4	2	15
4	5	250
4	7	150
5	1	1000
5	2	500
5	4	250
6	2	50
6	3	200
6	7	100
6	8	150
7	2	30
7	4	150
7	6	100
7	8	200
7	9	250
8	6	150
8	7	200
8	9	300
9	7	250
9	8	300
\.

-- country table population
COPY oceanAccess (cid, oid) FROM stdin;
1	2
1	3
2	3
3	1
3	2
4	3
5	3
6	1
7	3
7	4
8	1
9	1
9	4
\.
COMMIT;