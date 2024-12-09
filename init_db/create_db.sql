CREATE SCHEMA IF NOT EXISTS crypto_scheme;

SET search_path = crypto_scheme, public;

CREATE TABLE IF NOT EXISTS "User" (
    UserID SERIAL PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    Surename VARCHAR(50) NOT NULL,
    Passport VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS "Wallet" (
    WalletID SERIAL PRIMARY KEY,
    UserID INTEGER REFERENCES "User"(UserID) ON DELETE CASCADE,
    WalletNumber VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS "Coin" (
    CoinID SERIAL,
    VersionID SERIAL,
    CoinName VARCHAR(50) NOT NULL,
    Price DECIMAL(15,2) NOT NULL CHECK (Price > 0),
    MCAP DECIMAL(20,2),
    Liquidity DECIMAL(15,2) CHECK (Liquidity >= 0),
    NumberOfHolders INTEGER,
    PercentOfTop30Holders DECIMAL(5,2) CHECK (PercentOfTop30Holders BETWEEN 0 AND 100),
    ValidFrom TIMESTAMP NOT NULL,
    ValidTo TIMESTAMP,
    IsActive BOOLEAN NOT NULL DEFAULT TRUE,
    PRIMARY KEY (CoinID, VersionID)
);

CREATE TABLE IF NOT EXISTS "Exchange"(
    ExchangeID SERIAL PRIMARY KEY NOT NULL,
    NameExchange VARCHAR(50) UNIQUE NOT NULL,
    NumberOfUsers INTEGER
);

CREATE TABLE IF NOT EXISTS "Transaction" (
    TransactionID VARCHAR(64) PRIMARY KEY UNIQUE NOT NULL,
    WalletFirstID INTEGER REFERENCES "Wallet"(WalletID) ON DELETE CASCADE,
    WalletSecondID INTEGER REFERENCES "Wallet"(WalletID) ON DELETE CASCADE,
    CoinID INTEGER,
    CoinVersionID INTEGER,
    ExchangeID INTEGER REFERENCES "Exchange"(ExchangeID) ON DELETE CASCADE,
    TimeTransaction TIMESTAMP NOT NULL,
    TransferredAmount DECIMAL(15,2) NOT NULL CHECK (TransferredAmount > 0),
    FOREIGN KEY (CoinID, CoinVersionID) REFERENCES "Coin"(CoinID, VersionID)
);

CREATE TABLE IF NOT EXISTS "WalletCoins" (
    WalletID INTEGER NOT NULL,
    CoinID INTEGER NOT NULL,
    CoinVersionID INTEGER NOT NULL,
    Quantity DECIMAL(15, 2) NOT NULL,
    PRIMARY KEY (WalletID, CoinID, CoinVersionID),
    FOREIGN KEY (WalletID) REFERENCES "Wallet"(WalletID) ON DELETE CASCADE,
    FOREIGN KEY (CoinID, CoinVersionID) REFERENCES "Coin"(CoinID, VersionID)
);

CREATE TABLE IF NOT EXISTS "CoinExchange" (
    ExchangeID INTEGER NOT NULL,
    CoinID INTEGER NOT NULL,
    CoinVersionID INTEGER NOT NULL,
    PRIMARY KEY (ExchangeID, CoinID, CoinVersionID),
    FOREIGN KEY (ExchangeID) REFERENCES "Exchange"(ExchangeID) ON DELETE CASCADE,
    FOREIGN KEY (CoinID, CoinVersionID) REFERENCES "Coin"(CoinID, VersionID)
);

CREATE TABLE IF NOT EXISTS "UserExchange" (
    ExchangeID INTEGER NOT NULL,
    UserID INTEGER NOT NULL,
    PRIMARY KEY (ExchangeID, UserID),
    FOREIGN KEY (ExchangeID) REFERENCES "Exchange"(ExchangeID) ON DELETE CASCADE,
    FOREIGN KEY (UserID) REFERENCES "User"(UserID) ON DELETE CASCADE
);