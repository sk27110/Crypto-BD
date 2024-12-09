CREATE OR REPLACE FUNCTION update_coin_scd2()
RETURNS TRIGGER AS $$
DECLARE
    new_version_id INTEGER;
BEGIN
    -- Закрываем текущую активную запись
    UPDATE "Coin"
    SET ValidTo = CURRENT_TIMESTAMP, IsActive = FALSE
    WHERE CoinID = NEW.CoinID AND IsActive = TRUE;

    -- Получаем новый VersionID
    SELECT COALESCE(MAX(VersionID), 0) + 1 INTO new_version_id
    FROM "Coin"
    WHERE CoinID = NEW.CoinID;

    -- Вставляем новую запись
    INSERT INTO "Coin" (
        CoinID, VersionID, CoinName, Price, MCAP, Liquidity, NumberOfHolders, PercentOfTop30Holders,
        ValidFrom, ValidTo, IsActive
    ) VALUES (
        NEW.CoinID, new_version_id, NEW.CoinName, NEW.Price, NEW.MCAP, NEW.Liquidity, NEW.NumberOfHolders, NEW.PercentOfTop30Holders,
        CURRENT_TIMESTAMP, NULL, TRUE
    );

    -- Обновляем связанные записи в WalletCoins
    UPDATE "WalletCoins"
    SET CoinVersionID = new_version_id
    WHERE CoinID = NEW.CoinID;

    -- Обновляем связанные записи в CoinExchange
    UPDATE "CoinExchange"
    SET CoinVersionID = new_version_id
    WHERE CoinID = NEW.CoinID;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER coin_scd2_trigger
BEFORE UPDATE ON "Coin"
FOR EACH ROW
WHEN (OLD.* IS DISTINCT FROM NEW.*)
EXECUTE FUNCTION update_coin_scd2();