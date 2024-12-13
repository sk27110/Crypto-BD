INSERT INTO "User"  (Username, Surename, Passport)
VALUES ('John', 'Doe', 'AA123456'),
    ('Jane', 'Doe', 'BB123456'),
    ('Peter', 'Parker', 'CC123456'),
    ('Mary', 'Johnson', 'DD123456'),
    ('Michael', 'Smith', 'EE123456'),
    ('Sarah', 'Jones', 'FF123456'),
    ('David', 'Williams', 'GG123456'),
    ('Jessica', 'Brown', 'HH123456'),
    ('Thomas', 'Garcia', 'II123456'),
    ('Nancy', 'Wilson', 'JJ123456'),
    ('Joseph', 'Davis', 'KK123456'),
    ('Linda', 'Rodriguez', 'LL123456'),
    ('Christopher', 'Clark', 'MM123456'),
    ('Amanda', 'Allen', 'NN123456'),
    ('Daniel', 'Moore', 'OO123456'),
    ('Patricia', 'Taylor', 'PP123456'),
    ('Robert', 'White', 'QQ123456'),
    ('Susan', 'Baker', 'RR123456'),
    ('James', 'Garcia', 'SS123456'),
    ('Maria', 'Rodriguez', 'TT123456');

INSERT INTO "Coin" (
    VersionID,
    CoinName,
    Price,
    MCAP,
    Liquidity,
    NumberOfHolders,
    PercentOfTop30Holders,
    ValidFrom,
    ValidTo,
    IsActive
)
VALUES 
    ( 1, 'Bitcoin', 20000.00, 400000000000.00, 1000000000.00, 1000000, 50.00, CURRENT_TIMESTAMP, NULL, TRUE),
    ( 1, 'Ethereum', 1500.00, 300000000000.00, 500000000.00, 500000, 40.00, CURRENT_TIMESTAMP, NULL, TRUE),
    ( 1, 'Tether', 1.00, 200000000000.00, 250000000.00, 250000, 30.00, CURRENT_TIMESTAMP, NULL, TRUE),
    ( 1, 'USD Coin', 1.00, 180000000000.00, 200000000.00, 200000, 25.00, CURRENT_TIMESTAMP, NULL, TRUE),
    ( 1, 'Binance Coin', 500.00, 100000000000.00, 150000000.00, 150000, 20.00, CURRENT_TIMESTAMP, NULL, TRUE),
    ( 1, 'BNB', 400.00, 80000000000.00, 100000000.00, 100000, 15.00, CURRENT_TIMESTAMP, NULL, TRUE),
    ( 1, 'Cardano', 100.00, 50000000000.00, 75000000.00, 75000, 10.00, CURRENT_TIMESTAMP, NULL, TRUE),
    ( 1, 'XRP', 0.50, 25000000000.00, 50000000.00, 50000, 5.00, CURRENT_TIMESTAMP, NULL, TRUE),
    ( 1, 'Dogecoin', 0.20, 10000000000.00, 25000000.00, 25000, 2.50, CURRENT_TIMESTAMP, NULL, TRUE),
    ( 1, 'Shiba Inu', 0.32, 5000000000.00, 12500000.00, 12500, 1.00, CURRENT_TIMESTAMP, NULL, TRUE);


INSERT INTO "Wallet" (UserID, CoinName, CoinVersionID, WalletNumber , Quantity) VALUES
    (1, 'Bitcoin', 1, 'WALLET001', 10),
    (1, 'Ethereum', 1, 'WALLET002',10),
    (2, 'Tether', 1, 'WALLET003', 10),
    (2, 'USD Coin', 1, 'WALLET004', 10),
    (3, 'Binance Coin', 1, 'WALLET005', 10),
    (3, 'BNB', 1, 'WALLET006', 10),
    (1, 'Cardano', 1, 'WALLET007', 10),
    (2, 'XRP', 1, 'WALLET008', 10),
    (3, 'Dogecoin', 1, 'WALLET009', 10),
    (1, 'Shiba Inu', 1, 'WALLET010', 10);



INSERT INTO "Exchange" (NameExchange, NumberOfUsers)
VALUES ('Binance', 1000000),
    ('Coinbase', 500000),
    ('Kraken', 250000),
    ('Gemini', 100000),
    ('Bitstamp', 50000);

INSERT INTO "Transaction" (TransactionID, WalletFirstNumber, WalletSecondNumber, CoinName, CoinVersionID, ExchangeID, TimeTransaction, TransferredAmount) VALUES
    ('TXN001', 'WALLET001', 'WALLET002', 'Bitcoin', 1, 1, '2023-10-01 10:00:00', 0.5),
    ('TXN002', 'WALLET003', 'WALLET004', 'Tether', 1, 2, '2023-10-02 11:30:00', 1000.00),
    ('TXN003', 'WALLET005', 'WALLET006', 'Binance Coin', 1, 1, '2023-10-03 14:45:00', 2.5),
    ('TXN004', 'WALLET007', 'WALLET008', 'Cardano', 1, 3, '2023-10-04 09:15:00', 150.75),
    ('TXN005', 'WALLET009', 'WALLET010', 'Dogecoin', 1, 1, '2023-10-05 16:20:00', 2500.00),
    ('TXN006', 'WALLET001', 'WALLET003', 'Ethereum', 1, 2, '2023-10-06 12:00:00', 1.0),
    ('TXN007', 'WALLET002', 'WALLET004', 'USD Coin', 1, 1, '2023-10-07 15:30:00', 500.00),
    ('TXN008', 'WALLET005', 'WALLET007', 'XRP', 1, 3, '2023-10-08 18:00:00', 300.25),
    ('TXN009', 'WALLET006', 'WALLET008', 'Shiba Inu', 1, 2, '2023-10-09 08:45:00', 750.50),
    ('TXN010', 'WALLET009', 'WALLET001', 'BNB', 1, 1, '2023-10-10 19:30:00', 5.0);


INSERT INTO "CoinExchange" (ExchangeID, CoinName, CoinVersionID)
VALUES 
    (1, 'Bitcoin', 1), 
    (1, 'Ethereum', 1), 
    (1, 'BNB', 1), 
    (1, 'Cardano', 1),  
    (1, 'Dogecoin', 1), 
    (2, 'Bitcoin', 1),  
    (2, 'Ethereum', 1),
    (2, 'BNB', 1),  
    (2, 'Cardano', 1), 
    (3, 'Bitcoin', 1), 
    (3, 'Ethereum', 1),  
    (3, 'BNB', 1),  
    (4, 'Bitcoin', 1),  
    (4, 'Ethereum', 1), 
    (5, 'BNB', 1);  

INSERT INTO "UserExchange" (ExchangeID, UserID)
VALUES (1, 1),
    (1, 2),
    (1, 3),
    (1, 4),
    (1, 5),
    (2, 1),
    (2, 2),
    (2, 3),
    (3, 1),
    (3, 2),
    (4, 1),
    (5, 1);