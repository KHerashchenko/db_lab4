INSERT INTO Singer(name) VALUES('Unknown');
INSERT INTO Singer(name) VALUES('Ali Gatie');
INSERT INTO Singer(name) VALUES('Martin Garrix');

INSERT INTO Genre(name) VALUES('australian pop');
INSERT INTO Genre(name) VALUES('latin');
INSERT INTO Genre(name) VALUES('big room');

INSERT INTO Song(song_id, title, popularity, length) VALUES(1, 'Dance Monkey', 87, 180);
INSERT INTO Song(song_id, title, popularity, length) VALUES(2, 'Takeaway', 82, 189);
INSERT INTO Song(song_id, title, popularity, length) VALUES(3, 'Summer Days', 93, 172);

INSERT INTO Country(name) VALUES('Ukraine');
INSERT INTO Country(name) VALUES('Russia');
INSERT INTO Country(name) VALUES('Austria');

INSERT INTO GenreClassification(song_song_id, genre_name) VALUES(1, 'latin');
INSERT INTO GenreClassification(song_song_id, genre_name) VALUES(2, 'australian pop');
INSERT INTO GenreClassification(song_song_id, genre_name) VALUES(3, 'latin');

INSERT INTO Authorship(song_song_id, singer_name) VALUES(1, 'Ali Gatie');
INSERT INTO Authorship(song_song_id, singer_name) VALUES(2, 'Ali Gatie');
INSERT INTO Authorship(song_song_id, singer_name) VALUES(3, 'Martin Garrix');

INSERT INTO Tour(tour_id, country_name, singer_name, "date") VALUES(1, 'Ukraine', 'Martin Garrix', TO_DATE('2018/12/01', 'yyyy/mm/dd'));
INSERT INTO Tour(tour_id, country_name, singer_name, "date") VALUES(2, 'Ukraine', 'Ali Gatie', TO_DATE('2019/02/19', 'yyyy/mm/dd'));
INSERT INTO Tour(tour_id, country_name, singer_name, "date") VALUES(3, 'Austria', 'Martin Garrix', TO_DATE('2017/07/10', 'yyyy/mm/dd'));