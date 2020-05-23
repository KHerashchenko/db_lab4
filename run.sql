-- procedure

BEGIN
    updateAuthorship(1, 'Alex Clare', 2, 'Alex Clare');
END;

-- function

BEGIN
    select * from TABLE(get_genre_avg_pop(100, 300));
END;

-- trigger

BEGIN
INSERT INTO Authorship(song_song_id, singer_name) VALUES(3, null);
END;