CREATE OR REPLACE PACKAGE my_package IS

    FUNCTION get_genre_avg_pop (
        my_pop song.popularity%TYPE, 
        my_length song.length%TYPE) 
    RETURN pop_len_genre_table;

    PROCEDURE updateAuthorship 
    (old_song_id INTEGER,
    old_singer_name CHAR,
    new_song_id INTEGER,
    new_singer_name CHAR
    );

END my_package;

CREATE OR REPLACE PACKAGE
BODY
my_package
IS
    FUNCTION get_genre_avg_pop
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
    PROCEDURE updateAuthorship(
        old_song_id INTEGER,
        old_singer_name CHAR,
        new_song_id INTEGER,
        new_singer_name CHAR
        )
        IS 
        not_found EXCEPTION;
            check_row integer;
        BEGIN
            select count(*)
            INTO check_row
            from (select * from authorship where song_song_id = old_song_id and singer_name = old_singer_name);
            
            IF (check_row = 0) then
                RAISE not_found;
            else    
                UPDATE authorship
                    SET song_song_id = new_song_id,
                        singer_name = new_singer_name
                    where song_song_id = old_song_id and singer_name = old_singer_name;
            end if;
            
            EXCEPTION
                WHEN not_found THEN
                    dbms_output.put_line('Record not found');
        END;
END my_package;