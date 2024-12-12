--Select
--Получить все данные о монете Bitcoin
SELECT *
FROM "Coin"
WHERE coinname = 'Bitcoin';


--Получить Цену, капитализацию и ликвидность монеты Bitcoin
SELECT coinname as Монета,
    price as Цена,
    MCAP as Капитализация,
    Liquidity as Ликвидность
from "Coin"
where coinname = 'Bitcoin';


--Посмотреть всех пользователей с их кошельками
SELECT u.UserID,
    u.username,
    u.surename,
    w.WalletNumber
FROM "User" u
    LEFT JOIN "Wallet" w ON u.UserID = w.UserID;


-- Insert
-- Вставить новый кошелек
INSERT INTO "Wallet" (
        UserID,
        CoinName,
        CoinVersionID,
        WalletNumber,
        Quantity
    )
VALUES (19, 'Bitcoin', 1, 'WALLET100', 0.01);


--Вставить нового пользователя
INSERT INTO "User" (Username, Surename, Passport)
VALUES ('Kirill', 'Almetow', '8919896552');


--Вставить новую биржу
INSERT INTO "Exchange" (NameExchange, NumberOfUsers)
VALUES ('ByBit', 1000000);


--Добавить новую запись у уже существующей монете
INSERT INTO coin_insert_view (
        CoinName,
        Price,
        MCAP,
        Liquidity,
        NumberOfHolders,
        PercentOfTop30Holders
    )
VALUES (
        'Ethereum',
        32423.00,
        42344230.00,
        534535.00,
        15345,
        35.00
    );


--Вставить новую монету, которой не было в таблице
INSERT INTO coin_insert_view (
        CoinName,
        Price,
        MCAP,
        Liquidity,
        NumberOfHolders,
        PercentOfTop30Holders
    )
VALUES (
        'RUB',
        345.00,
        42545768.00,
        2557.00,
        26687743,
        20.00
    );


--Добавить транзакцию
INSERT INTO "Transaction" (
        TransactionID,
        WalletFirstNumber,
        WalletSecondNumber,
        CoinName,
        CoinVersionID,
        ExchangeID,
        TimeTransaction,
        TransferredAmount
    )
VALUES (
        'TXN312',
        'WALLET001',
        'WALLET100',
        'Bitcoin',
        1,
        1,
        '2023-10-01 10:23:32',
        0.1
    );


--Добавить новый кошелек к пользователю с UserID = 19
SELECT add_wallet(19, 'WALLET425', 'Bitcoin');

-- Update
--Найти монеты у которых
SELECT CoinName
FROM "Coin"
where IsActive = TRUE
GROUP BY CoinName,
    PercentOfTop30Holders
HAVING PercentOfTop30Holders < (
        SELECT AVG(PercentOfTop30Holders)
        FROM "Coin"
    );

