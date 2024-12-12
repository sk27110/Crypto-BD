CREATE SCHEMA IF NOT EXISTS crypto_scheme;

SET search_path = crypto_scheme, public;

CREATE TABLE IF NOT EXISTS "User" (
    UserID SERIAL PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    Surename VARCHAR(50) NOT NULL,
    Passport VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS "Coin" (
    VersionID INTEGER,
    CoinName VARCHAR(50) NOT NULL,
    Price DECIMAL(15,2) NOT NULL CHECK (Price > 0),
    MCAP DECIMAL(20,2),
    Liquidity DECIMAL(15,2) CHECK (Liquidity >= 0),
    NumberOfHolders INTEGER,
    PercentOfTop30Holders DECIMAL(5,2) CHECK (PercentOfTop30Holders BETWEEN 0 AND 100),
    ValidFrom TIMESTAMP NOT NULL,
    ValidTo TIMESTAMP,
    IsActive BOOLEAN NOT NULL DEFAULT TRUE,
    PRIMARY KEY (CoinName, VersionID)
);

CREATE TABLE IF NOT EXISTS "Wallet" (
    UserID INTEGER REFERENCES "User"(UserID) ON DELETE CASCADE,
    CoinName VARCHAR (50) NOT NULL,
    CoinVersionID INTEGER NOT NULL,
    WalletNumber VARCHAR(50) PRIMARY KEY,
    Quantity DECIMAL(15,2) NOT NULL,
    UNIQUE (WalletNumber, CoinName, CoinVersionID),
    FOREIGN KEY (CoinName, CoinVersionID) REFERENCES "Coin"(CoinName, VersionID) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS "Exchange"(
    ExchangeID SERIAL PRIMARY KEY NOT NULL,
    NameExchange VARCHAR(50) UNIQUE NOT NULL,
    NumberOfUsers INTEGER
);

CREATE TABLE IF NOT EXISTS "Transaction" (
    TransactionID VARCHAR(64) PRIMARY KEY UNIQUE NOT NULL,
    WalletFirstNumber VARCHAR(50) NOT NULL,
    WalletSecondNumber VARCHAR(50) NOT NULL,
    CoinName VARCHAR(50) NOT NULL,
    CoinVersionID INTEGER,
    ExchangeID INTEGER REFERENCES "Exchange"(ExchangeID) ON DELETE CASCADE,
    TimeTransaction TIMESTAMP NOT NULL,
    TransferredAmount DECIMAL(15,2) NOT NULL CHECK (TransferredAmount > 0),
    FOREIGN KEY (CoinName, CoinVersionID) REFERENCES "Coin"(CoinName, VersionID),
    FOREIGN KEY (WalletFirstNumber) REFERENCES "Wallet"(WalletNumber) on DELETE CASCADE,
    FOREIGN KEY (WalletSecondNumber) REFERENCES "Wallet"(WalletNumber) on DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS "CoinExchange" (
    ExchangeID INTEGER NOT NULL,
    CoinName VARCHAR(50) NOT NULL,
    CoinVersionID INTEGER NOT NULL,
    PRIMARY KEY (ExchangeID, CoinName, CoinVersionID),
    FOREIGN KEY (ExchangeID) REFERENCES "Exchange"(ExchangeID) ON DELETE CASCADE,
    FOREIGN KEY (CoinName, CoinVersionID) REFERENCES "Coin"(CoinName, VersionID)
);

CREATE TABLE IF NOT EXISTS "UserExchange" (
    ExchangeID INTEGER NOT NULL,
    UserID INTEGER NOT NULL,
    PRIMARY KEY (ExchangeID, UserID),
    FOREIGN KEY (ExchangeID) REFERENCES "Exchange"(ExchangeID) ON DELETE CASCADE,
    FOREIGN KEY (UserID) REFERENCES "User"(UserID) ON DELETE CASCADE
);