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
    LEFT JOIN "Wallet" w ON u.UserID = w.UserID
where u.IsDelete = False and (w.walletnumber is null or w.IsDelete = False );
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
select *
from "User";
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
        'Bitcoin',
        42357.00,
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
        'TXN999',
        'WALLET555',
        'WALLET004',
        'Bitcoin',
        1,
        1,
        '2023-10-03 10:23:36',
        1
    );
--Добавить новый кошелек к пользователю с UserID = 19
SELECT add_wallet(17, 'WALLET555', 'Bitcoin');
-- Update
-- Обновить данные существующей монеты
Update coin_update_view
SET Price = 54000.00
WHERE CoinName = 'Bitcoin';
--Обновить данные пользоваетля с ID = 1
Update "User"
set surename = 'Putin'
where userid = 1;
-- Удалить пользователя
Delete from "User"
where userid = 1;

select * from "Wallet";

delete from "Wallet" where walletnumber = 'WALLET003';

