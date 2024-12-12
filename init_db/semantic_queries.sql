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
    c.IsActive = TRUE OR c.IsActive IS NULL
GROUP BY 
    u.UserID, u.Username, u.Surename
HAVING COALESCE(SUM(w.Quantity * c.Price), 0) > 25
ORDER BY 
    TotalValue DESC;

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
group by u.UserID
order by max(t.TimeTransaction) desc;


select DISTINCT*
from "User" u
join "Wallet" w
on u.UserID = w.UserID
left join "Transaction" t
on w.WalletNumber = t.WalletFirstNumber or w.WalletNumber = t.WalletSecondNumber;

-- group by u.UserID
-- order by COUNT(*) DESC;

--По каждому пользователю узнать самую покупаемую им монету
--Отсортировать монеты по росту
--Посмотреть топ пользователей по прибыли за сутки