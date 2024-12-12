SET search_path = crypto_scheme, public;

--SELECT
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


--Получить все биржи и число их пользователей, где число пользователей в которых более 100000
Select NameExchange as Биржа,
    NumberOfUsers as ЧислоПользователей
from "Exchange"
Where NumberOfUsers > 100000
ORDER BY NumberOfUsers DESC;

--Посмотреть все транзации по монете Bitcoin
SELECT t.TransactionID, t.TimeTransaction, t.TransferredAmount
FROM "Transaction" t
JOIN "Coin" c
ON t.CoinName = c.CoinName
WHERE c.CoinName = 'Bitcoin'
ORDER BY t.TimeTransaction DESC;


   
-- Вставить новый кошелек
INSERT INTO "Wallet" (UserID, CoinName, CoinVersionID, WalletNumber , Quantity) VALUES
    (2, 'Bitcoin', 1, 'WALLET100', 10);


--Посмотреть всех пользователей с их кошельками
SELECT u.UserID, u.username, u.surename, w.WalletNumber
FROM "User" u
LEFT JOIN "Wallet" w ON u.UserID = w.UserID;
   

--По каждому пользователю получить дату последней транзации, чтобы узнать его активность
-- select * 
-- from "User" u
-- left join "Wallet" w ON
--     u.userid = w.userid
-- left join "Transaction" t ON
--     t.WalletFirstID = w.WalletNumber;

--По каждому пользователю узнать самую покупаемую им монету

--Отсортировать монеты по росту

--Посмотреть топ пользователей по прибыли за сутки

--INSERT
INSERT INTO "User" (Username, Surename, Passport)
VALUES ('Kirill', 'Almetow', '8919896552');
INSERT INTO "Exchange" (NameExchange, NumberOfUsers)
VALUES ('ByBit', 1000000);
INSERT INTO coin_insert_view (
    CoinName,
    Price,
    MCAP,
    Liquidity,
    NumberOfHolders,
    PercentOfTop30Holders
) VALUES (
    'Ethereum',
    45000.00,
    850000000000.00,
    5000000.00,
    1000000,
    30.00
);

--Добавить транзакцию
INSERT INTO "Transaction" (TransactionID, WalletFirstNumber, WalletSecondNumber, CoinName, CoinVersionID, ExchangeID, TimeTransaction, TransferredAmount) VALUES
    ('TXN323', 'WALLET001', 'WALLET100', 'Bitcoin', 1, 1, '2023-10-01 10:23:32', 0.1);



--Оконная функция
SELECT 
    WalletNumber,
    TotalCoins,
    CoinName,
    RANK() OVER (ORDER BY TotalCoins DESC) as Rank
FROM (
    SELECT 
        walletnumber,
        SUM(Quantity) as TotalCoins,
        CoinName
    FROM "Wallet"
    GROUP BY WalletNumber
) as WalletTotals
ORDER BY Rank;


SELECT CoinName
FROM "Coin"
where IsActive = TRUE
GROUP BY CoinName, PercentOfTop30Holders
HAVING PercentOfTop30Holders < (SELECT AVG(PercentOfTop30Holders) FROM "Coin");

SELECT CoinName, Price
FROM "Coin"
WHERE Price > 200 and IsActive = TRUE
ORDER BY Price DESC;