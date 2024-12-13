CREATE OR REPLACE FUNCTION delete_wallet() RETURNS TRIGGER AS
'
DECLARE
    wallet_dont_exist BOOLEAN;
BEGIN 
    SELECT IsDelete INTO wallet_dont_exist
    FROM "Wallet"
    WHERE WalletNumber = OLD.WalletNumber;
    
    IF wallet_dont_exist = False THEN
        UPDATE "Wallet" SET IsDelete = TRUE WHERE WalletNumber = OLD.WalletNumber;

    ELSIF wallet_dont_exist = True THEN
        RAISE EXCEPTION ''Такого кошелька не сушествует'';
    END IF;

    RETURN NULL;
END;
' LANGUAGE plpgsql;

CREATE TRIGGER delete_wallet_trigger
BEFORE DELETE ON "Wallet"
FOR EACH ROW
EXECUTE PROCEDURE delete_wallet();

ALTER TABLE "Wallet" ENABLE TRIGGER delete_wallet_trigger ;

