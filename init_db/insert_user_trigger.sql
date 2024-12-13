CREATE OR REPLACE FUNCTION delete_user() RETURNS TRIGGER AS
'
DECLARE
    user_dont_exist BOOLEAN;
BEGIN 
    SELECT IsDelete INTO user_dont_exist
    FROM "User"
    WHERE UserID = OLD.UserID;
    
    IF user_dont_exist = False THEN
        UPDATE "User" SET IsDelete = TRUE WHERE USerID = OLD.UserID;

    ELSIF user_dont_exist = True THEN
        RAISE EXCEPTION ''Такого пользователя не сушествует'';
    END IF;

    RETURN NULL;
END;
' LANGUAGE plpgsql;

CREATE TRIGGER delete_user_trigger
BEFORE DELETE ON "User"
FOR EACH ROW
EXECUTE PROCEDURE delete_user();

ALTER TABLE "User" ENABLE TRIGGER delete_user_trigger ;

