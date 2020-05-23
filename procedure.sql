CREATE OR REPLACE PROCEDURE updateAuthorship(
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