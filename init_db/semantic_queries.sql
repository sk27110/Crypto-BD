--Получить все биржи и число их пользователей, где число пользователей в которых более 100000
Select NameExchange as Биржа,
    NumberOfUsers as ЧислоПользователей
from "Exchange"
Where NumberOfUsers > 100000
ORDER BY NumberOfUsers DESC;


--Посмотреть все транзации по монете Bitcoin
SELECT t.coinname,
    t.TransactionID,
    t.TimeTransaction,
    t.TransferredAmount
FROM "Transaction" t
    JOIN "Coin" c ON t.CoinName = c.CoinName
WHERE c.CoinName = 'Bitcoin'
ORDER BY t.TimeTransaction DESC;


-- Для каждого пользователя, у которого сумма на его кошельках Ю 25$, вывести сумму денег, которая на текущий момент есть на всех его кошельках
SELECT 
    u.UserID,
    u.Username,
    u.Surename,
    COALESCE(SUM(w.Quantity * c.Price), 0) as TotalValue
FROM 
    "User" u
LEFT JOIN 
    "Wallet" w ON u.UserID = w.UserID
LEFT JOIN 
    "Coin" c ON w.CoinName = c.CoinName AND w.CoinVersionID = c.VersionID
WHERE 
    (c.IsActive = TRUE OR c.IsActive IS NULL) and u.IsDelete = False
GROUP BY 
    u.UserID, u.Username, u.Surename
HAVING COALESCE(SUM(w.Quantity * c.Price), 0) > 25
ORDER BY 
    TotalValue DESC;

select * from "User";



--Получить все монеты, цена которых на текущий момент > 200 и отсортировать их по убыванию цены
SELECT CoinName,
    Price
FROM "Coin"
WHERE Price > 200
    and IsActive = TRUE
ORDER BY Price DESC;


--По каждому пользователю получить дату последней транзации, чтобы узнать его активность
select u.UserID, u.Username, u.Surename ,max(t.TimeTransaction)
from "User" u
join "Wallet" w
on u.UserID = w.UserID
inner join "Transaction" t
on w.WalletNumber = t.WalletFirstNumber or w.WalletNumber = t.WalletSecondNumber
where u.IsDelete = False
group by u.UserID
order by max(t.TimeTransaction) desc;



--Почситать число транзакций для каждого пользоваетя
SELECT 
    u.UserID,
    u.Username,
    u.Surename,
    COUNT(t.TransactionID) as TransactionCount
FROM 
    "User" u
LEFT JOIN 
    "Wallet" w ON u.UserID = w.UserID
LEFT JOIN 
    "Transaction" t ON w.WalletNumber = t.WalletFirstNumber OR w.WalletNumber = t.WalletSecondNumber
where u.IsDelete = False
GROUP BY 
    u.UserID, u.Username, u.Surename
ORDER BY 
    TransactionCount DESC;

--По каждому пользователю узнать самую покупаемую им монету
WITH UserCoinPurchases AS (
    SELECT 
        u.UserID,
        u.Username,
        u.Surename,
        t.CoinName,
        COUNT(*) as PurchaseCount,
        ROW_NUMBER() OVER (PARTITION BY u.UserID ORDER BY COUNT(*) DESC) as rn
    FROM 
        "User" u
    JOIN "Wallet" w ON u.UserID = w.UserID
    JOIN "Transaction" t ON w.WalletNumber = t.WalletSecondNumber
    where u.IsDelete = False
    GROUP BY 
        u.UserID, t.CoinName
)
SELECT 
    UserID,
    Username,
    Surename,
    CoinName as MostPurchasedCoin,
    PurchaseCount
FROM 
    UserCoinPurchases
WHERE 
    rn = 1
ORDER BY 
    PurchaseCount DESC;


-- Отсортировать монеты по росту цены за сутки
WITH CoinPriceChange AS (
    SELECT 
        c1.CoinName,
        c1.Price as CurrentPrice,
        c2.Price as PreviousPrice,
        (c1.Price - c2.Price) / c2.Price * 100 as PriceChangePercent
    FROM 
        "Coin" c1
    JOIN "Coin" c2 ON c1.CoinName = c2.CoinName AND c1.VersionID = c2.VersionID + 1
    WHERE 
        c1.IsActive = TRUE
        AND c1.ValidFrom >= CURRENT_DATE - INTERVAL '1 day'
)
SELECT 
    CoinName,
    CurrentPrice,
    PreviousPrice,
    PriceChangePercent as PriceChangePercent
FROM 
    CoinPriceChange
ORDER BY 
    PriceChangePercent DESC;


-- Посмотреть топ пользователей по прибыли за сутки
-- WITH UserProfits AS (
--     SELECT 
--         u.UserID,
--         u.Username,
--         u.Surename,
--         SUM(
--             CASE 
--                 WHEN t.WalletFirstNumber = w.WalletNumber THEN -t.TransferredAmount * c.Price
--                 WHEN t.WalletSecondNumber = w.WalletNumber THEN t.TransferredAmount * c.Price
--                 ELSE 0
--             END
--         ) as DailyProfit
--     FROM 
--         "User" u
--     JOIN "Wallet" w ON u.UserID = w.UserID
--     JOIN "Transaction" t ON w.WalletNumber IN (t.WalletFirstNumber, t.WalletSecondNumber)
--     JOIN "Coin" c ON t.CoinName = c.CoinName AND t.CoinVersionID = c.VersionID
--     WHERE 
--         t.TimeTransaction >= CURRENT_DATE - INTERVAL '1 day'
--         AND c.IsActive = TRUE
--     GROUP BY 
--         u.UserID, u.Username, u.Surename
-- )
-- SELECT 
--     UserID,
--     Username,
--     Surename,
--     ROUND(DailyProfit::numeric, 2) as DailyProfit
-- FROM 
--     UserProfits
-- ORDER BY 
--     DailyProfit DESC
-- LIMIT 10;