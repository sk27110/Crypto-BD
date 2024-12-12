CREATE OR REPLACE FUNCTION add_wallet(
    p_user_id INTEGER,
    p_wallet_number VARCHAR(255),
    p_coin_name VARCHAR(255)
)
RETURNS VOID AS '
DECLARE
    v_coin_version_id INTEGER;
BEGIN
    SELECT VersionID INTO v_coin_version_id
    FROM "Coin"
    WHERE CoinName = p_coin_name AND IsActive = TRUE;

    IF NOT EXISTS (SELECT 1 FROM "Wallet" WHERE WalletNumber = p_wallet_number) THEN
        INSERT INTO "Wallet" (UserID, CoinName, CoinVersionID, WalletNumber, Quantity)
        VALUES (p_user_id, p_coin_name, v_coin_version_id, p_wallet_number, 0);
    ELSE
        RAISE EXCEPTION ''Кошелек с номером % уже существует'', p_wallet_number;
    END IF;
END;
' LANGUAGE plpgsql;
