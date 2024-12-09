INSERT INTO "User"  (Username, Surename, Passport)
VALUES ('John Doe', 'Doe', 'AA123456'),
    ('Jane Doe', 'Doe', 'BB123456'),
    ('Peter Parker', 'Parker', 'CC123456'),
    ('Mary Johnson', 'Johnson', 'DD123456'),
    ('Michael Smith', 'Smith', 'EE123456'),
    ('Sarah Jones', 'Jones', 'FF123456'),
    ('David Williams', 'Williams', 'GG123456'),
    ('Jessica Brown', 'Brown', 'HH123456'),
    ('Thomas Garcia', 'Garcia', 'II123456'),
    ('Nancy Wilson', 'Wilson', 'JJ123456'),
    ('Joseph Davis', 'Davis', 'KK123456'),
    ('Linda Rodriguez', 'Rodriguez', 'LL123456'),
    ('Christopher Clark', 'Clark', 'MM123456'),
    ('Amanda Allen', 'Allen', 'NN123456'),
    ('Daniel Moore', 'Moore', 'OO123456'),
    ('Patricia Taylor', 'Taylor', 'PP123456'),
    ('Robert White', 'White', 'QQ123456'),
    ('Susan Baker', 'Baker', 'RR123456'),
    ('James Garcia', 'Garcia', 'SS123456'),
    ('Maria Rodriguez', 'Rodriguez', 'TT123456');
INSERT INTO "Wallet" (UserID, WalletNumber)
VALUES (
        1,
        '13KDS6YezQ8p5G3jW5oE1cizRXdP1RNAz645fE1rCFja'
    ),
    (1, '14Mu72Je8n1aGa2s2bjnbyjY2Z3Yi3XRfs2c465d2s1'),
    (
        2,
        '15ioGW916XRnTkaGPFw8yOcG7f72uW3XRz3e54c2d3s4'
    ),
    (2, '16ta73oiG2f5364g1r4567uy89uio1x75d4c3def5g6'),
    (3, '172u546ghj987dfx3zcz2ws3e4rfv5tgbn765v45f76'),
    (3, '18jhg876t5432qwe4rf5t678yu98iop0o9i8u7y6t5'),
    (4, '19mnbvcxz345tyghj8765r43e2wsx1dcfv765g75f4'),
    (4, '20lkjhgf567890asdfgh12345qwertzxcv789iu65'),
    (5, '21zxcvbnm9999lpoiu8765trewqa456ty7u654321g5'),
    (5, '22qazwsxedcrfvtgbnhyu765433456yuiop09876tre'),
    (
        6,
        '23wsxedcrfvtgbnhyujki98765434dfghjkol09iop7u'
    ),
    (
        6,
        '24rfvtgbnhyujkimnbvcxz1234567890asdfghjklop9'
    ),
    (
        7,
        '25tyuiopasdfghjklmnbvcxz987654yuiop0o9iuy65t4'
    ),
    (
        7,
        '26lkjhgfdsaqwertyuiop98765r43e2wsx1dcfv765g75'
    ),
    (8, '27mnbvcxz345tyghj8765r43e2wsx1dcfv765g75f43'),
    (8, '28jhg876t5432qwe4rf5t678yu98iop0o9i8u7y6t5r'),
    (9, '29u546ghj987dfx3zcz2ws3e4rfv5tgbn765v45f76g'),
    (9, '30ta73oiG2f5364g1r4567uy89uio1x75d4c3def5g6'),
    (
        10,
        '12rfvtgbnhyujki98765434dfghjkol09iop7u8i76t5'
    ),
    (
        10,
        '11qazwsxedcrfvtgbnhyu765433456yuiop09876trew'
    ),
    (
        10,
        '14wsxedcrfvtgbnhyujki98765434dfghjkol09iop7u4'
    ),
    (
        10,
        '13lkjhgfdsaqwertyuiop98765r43e2wsx1dcfv765g75'
    );
INSERT INTO "Coin" (
        CoinName,
        Price,
        MCAP,
        Liquidity,
        NumberOfHolders,
        PercentOfTop30Holders
    )
VALUES (
        'Bitcoin',
        20000.00,
        400000000000.00,
        1000000000.00,
        1000000,
        50.00
    ),
    (
        'Ethereum',
        1500.00,
        300000000000.00,
        500000000.00,
        500000,
        40.00
    ),
    (
        'Tether',
        1.00,
        200000000000.00,
        250000000.00,
        250000,
        30.00
    ),
    (
        'USD Coin',
        1.00,
        180000000000.00,
        200000000.00,
        200000,
        25.00
    ),
    (
        'Binance Coin',
        500.00,
        100000000000.00,
        150000000.00,
        150000,
        20.00
    ),
    (
        'BNB',
        400.00,
        80000000000.00,
        100000000.00,
        100000,
        15.00
    ),
    (
        'Cardano',
        100.00,
        50000000000.00,
        75000000.00,
        75000,
        10.00
    ),
    (
        'XRP',
        0.50,
        25000000000.00,
        50000000.00,
        50000,
        5.00
    ),
    (
        'Dogecoin',
        0.20,
        10000000000.00,
        25000000.00,
        25000,
        2.50
    ),
    (
        'Shiba Inu',
        0.32,
        5000000000.00,
        12500000.00,
        12500,
        1.00
    );
INSERT INTO "Exchange" (NameExchange, NumberOfUsers)
VALUES ('Binance', 1000000),
    ('Coinbase', 500000),
    ('Kraken', 250000),
    ('Gemini', 100000),
    ('Bitstamp', 50000);
INSERT INTO "Transaction" (
        TransactionID,
        WalletFirstID,
        WalletSecondID,
        CoinID,
        ExchangeID,
        TimeTransaction,
        TransferredAmount
    )
VALUES ('1', 1, 2, 1, 1, '2023-03-08 12:34:56', 1000.00),
    ('2', 2, 3, 2, 2, '2023-03-08 13:45:07', 500.00),
    ('3', 3, 4, 3, 3, '2023-03-08 14:56:18', 250.00),
    ('4', 4, 5, 4, 4, '2023-03-08 15:07:29', 100.00),
    ('5', 5, 1, 5, 5, '2023-03-08 16:18:40', 50.00),
    ('6', 1, 3, 6, 1, '2023-03-09 12:34:56', 2000.00),
    ('7', 3, 4, 7, 2, '2023-03-09 13:45:07', 1000.00),
    ('8', 4, 5, 8, 3, '2023-03-09 14:56:18', 500.00),
    ('9', 5, 1, 9, 4, '2023-03-09 15:07:29', 250.00),
    ('10', 1, 2, 10, 5, '2023-03-09 16:18:40', 100.00);
INSERT INTO "WalletCoins" (WalletID, CoinID, Quantity)
VALUES (1, 1, 1000.00),
    (1, 2, 500.00),
    (1, 3, 250.00),
    (2, 1, 500.00),
    (2, 2, 250.00),
    (2, 3, 100.00),
    (3, 1, 250.00),
    (3, 2, 100.00),
    (3, 3, 50.00),
    (4, 1, 100.00),
    (4, 2, 50.00),
    (4, 3, 25.00),
    (5, 1, 50.00),
    (5, 2, 25.00),
    (5, 3, 10.00);
INSERT INTO "CoinExchange" (ExchangeID, CoinID)
VALUES (1, 1),
    (1, 2),
    (1, 3),
    (1, 4),
    (1, 5),
    (2, 1),
    (2, 2),
    (2, 3),
    (2, 4),
    (3, 1),
    (3, 2),
    (3, 3),
    (4, 1),
    (4, 2),
    (5, 1);
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