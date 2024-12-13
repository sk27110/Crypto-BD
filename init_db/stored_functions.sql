--Функция которая добавляет новый кошелек к пользователю
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

--Получает для каждого пользователя его монеты и их число на всех кошельках
CREATE OR REPLACE FUNCTION get_all_users_coins()
RETURNS TABLE (
    UserID INTEGER,
    Username VARCHAR(50),
    Surename VARCHAR(50),
    CoinName VARCHAR(50),
    TotalQuantity DECIMAL(15,2)
) AS '
BEGIN
    RETURN QUERY
    SELECT 
        u.UserID,
        u.Username,
        u.Surename,
        w.CoinName,
        SUM(w.Quantity) AS TotalQuantity
    FROM 
        "User" u
    JOIN 
        "Wallet" w ON u.UserID = w.UserID
    WHERE 
        u.IsDelete = FALSE AND w.IsDelete = FALSE
    GROUP BY 
        u.UserID, u.Username, u.Surename, w.CoinName
    ORDER BY 
        u.UserID, w.CoinName;
END;
' LANGUAGE plpgsql;

SELECT * FROM get_all_users_coins();