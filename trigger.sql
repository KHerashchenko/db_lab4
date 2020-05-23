CREATE OR REPLACE TRIGGER default_singer 
    BEFORE INSERT
    ON authorship FOR EACH ROW  
    WHEN ( new.singer_name IS NULL )
    
BEGIN 
    :new.singer_name := 'Unknown';
END;