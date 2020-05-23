CREATE OR REPLACE TYPE
    pop_len_genre_type
IS OBJECT
(
    genre     char(20),
    avg_popularity integer,
    avg_length integer
);

CREATE TYPE pop_len_genre_table IS TABLE OF pop_len_genre_type;

CREATE OR REPLACE FUNCTION get_genre_avg_pop
(my_pop song.popularity%TYPE, my_length song.length%TYPE) 
    RETURN pop_len_genre_table 
    PIPELINED 
    IS
    genre     char(20);
    avg_popularity integer;
    avg_length integer;
    CURSOR
        row_cursor
        IS
        select 
            genre.name as genre,
            avg(song.popularity) as avg_popularity,
            avg(song.length) as avg_length
        from 
            song
        join
            GENRECLASSIFICATION
        on GENRECLASSIFICATION.song_song_id = song.SONG_ID
        join 
            GENRE
        on genre.name = GENRECLASSIFICATION.genre_name
        where song.length < my_length and song.popularity < my_pop
        group by genre.name;
        
    BEGIN
        OPEN row_cursor;
        LOOP
        FETCH row_cursor
        INTO genre, avg_popularity,avg_length;
        EXIT WHEN row_cursor % NOTFOUND;
        PIPE ROW(
            pop_len_genre_type(
                genre,
                avg_popularity,
                avg_length));
        END LOOP; 
    END;