--SELECT
SELECT *
FROM "Coin"
WHERE coinname = 'Bitcoin';
SELECT coinname as Монета,
    price as Цена,
    MCAP as Капитализация,
    Liquidity as Ликвидность
from "Coin"
where coinname = 'Bitcoin';
Select *
from "Exchange";
Select NameExchange as Биржа,
    NumberOfUsers as ЧислоПользователей
from "Exchange"
Where NumberOfUsers > 100000
ORDER BY NumberOfUsers DESC;
Select *
from "User";

--INSERT
INSERT INTO "User" (Username, Surename, Passport)
VALUES ('Kirill', 'Almetow', '8919896552');
INSERT INTO "Exchange" (NameExchange, NumberOfUsers)
VALUES ('ByBit', 1000000);

--