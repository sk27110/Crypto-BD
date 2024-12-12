CREATE OR REPLACE VIEW coin_insert_view AS
SELECT CoinName, Price, MCAP, Liquidity, NumberOfHolders, PercentOfTop30Holders
FROM "Coin";


CREATE OR REPLACE FUNCTION insert_coin_scd2()
RETURNS TRIGGER AS '
DECLARE
    new_version_id INTEGER;
BEGIN

    SELECT COALESCE(MAX(VersionID), 0) + 1 INTO new_version_id
    FROM "Coin"
    WHERE CoinName = NEW.CoinName;

    UPDATE "Coin"
    SET ValidTo = CURRENT_TIMESTAMP, IsActive = FALSE
    WHERE CoinName = NEW.CoinName AND IsActive = TRUE;

    INSERT INTO "Coin" (
        VersionID, CoinName, Price, MCAP, Liquidity, NumberOfHolders, PercentOfTop30Holders,
        ValidFrom, ValidTo, IsActive
    ) VALUES (
        new_version_id, NEW.CoinName, NEW.Price, NEW.MCAP, NEW.Liquidity, NEW.NumberOfHolders, NEW.PercentOfTop30Holders,
        CURRENT_TIMESTAMP, NULL, TRUE
    );

    UPDATE "Wallet"
    SET CoinVersionID = new_version_id
    WHERE CoinName = NEW.CoinName;

    UPDATE "CoinExchange"
    SET CoinVersionID = new_version_id
    WHERE CoinName = NEW.CoinName;

    RETURN NEW;
END;
' LANGUAGE plpgsql;

CREATE TRIGGER coin_insert_trigger
INSTEAD OF INSERT ON coin_insert_view
FOR EACH ROW
EXECUTE FUNCTION insert_coin_scd2();

-- ALTER TABLE "Coin" ENABLE TRIGGER coin_scd2_trigger;
