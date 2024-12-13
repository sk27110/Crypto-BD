CREATE SCHEMA IF NOT EXISTS masked_views;

SET search_path = masked_views, crypto_scheme, public;

CREATE OR REPLACE VIEW masked_user AS
SELECT 
    CONCAT('***', SUBSTRING(Username FROM 4)) AS MaskedUsername,
    CONCAT('******', RIGHT(Surename, 2)) AS MaskedSurename,
    CONCAT('**-**') AS maskedpassport
FROM crypto_scheme."User" where IsDelete = False;

SELECT * from masked_user;

CREATE OR REPLACE VIEW masked_wallet AS
SELECT 
    CONCAT('*****', RIGHT(WalletNumber, 4)) AS MaskedWalletNumber
FROM crypto_scheme."Wallet";

SELECT * from masked_wallet;


CREATE OR REPLACE VIEW masked_transaction AS
SELECT 
    CONCAT(LEFT(TransactionID, 3), '...', RIGHT(TransactionID, 3)) AS MaskedTransactionID,
    TimeTransaction,
    TransferredAmount
FROM crypto_scheme."Transaction";

SELECT * from masked_transaction;


CREATE OR REPLACE VIEW masked_user_exchange AS
SELECT 
    e.NameExchange,
    CONCAT('******', RIGHT(u.Surename, 2)) AS MaskedUsername
FROM crypto_scheme."UserExchange" ue
JOIN crypto_scheme."Exchange" e ON ue.ExchangeID = e.ExchangeID
JOIN crypto_scheme."User" u ON ue.UserID = u.UserID
where u.IsDelete = False;

SELECT * from masked_user_exchange;

--Посмотреть для каждого пользователя статистику по его транзакциям - число монет, которые он переводил,
--число транзакций, сумму по всем транзакциям,
CREATE OR REPLACE VIEW user_activity_analysis AS
SELECT 
    u.UserID,
    CONCAT('***', SUBSTRING(u.Username FROM 4)) AS MaskedUsername,
    COUNT(DISTINCT w.WalletNumber) AS WalletCount,
    COUNT(t.TransactionID) AS TransactionCount,
    SUM(t.TransferredAmount) AS TotalTransferredAmount,
    MAX(t.TimeTransaction) AS LastTransactionTime
FROM 
    crypto_scheme."User" u
LEFT JOIN 
    crypto_scheme."Wallet" w ON u.UserID = w.UserID
LEFT JOIN 
    crypto_scheme."Transaction" t ON w.WalletNumber = t.WalletFirstNumber OR w.WalletNumber = t.WalletSecondNumber
LEFT JOIN 
    crypto_scheme."UserExchange" ue ON u.UserID = ue.UserID
WHERE 
    u.IsDelete = False
GROUP BY 
    u.UserID, u.Username
ORDER BY 
    TransactionCount DESC;

SELECT * from user_activity_analysis;

DROP VIEW IF EXISTS user_activity_analysis;