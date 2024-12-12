CREATE OR REPLACE FUNCTION manage_transaction()
RETURNS TRIGGER AS '
DECLARE
    sender_balance DECIMAL(15,2);
BEGIN
    SELECT Quantity INTO sender_balance
    FROM "Wallet"
    WHERE WalletNumber = NEW.WalletFirstNumber AND CoinName = NEW.CoinName AND CoinVersionID = NEW.CoinVersionID;

    IF sender_balance IS NULL THEN
        RAISE EXCEPTION ''Отправитель не имеет указанной монеты'';
    END IF;

    IF sender_balance < NEW.TransferredAmount THEN
        RAISE EXCEPTION ''Недостаточно средств для перевода'';
    END IF;


    UPDATE "Wallet"
    SET Quantity = Quantity - NEW.TransferredAmount
    WHERE WalletNumber = NEW.WalletFirstNumber AND CoinName = NEW.CoinName AND CoinVersionID = NEW.CoinVersionID;


    INSERT INTO "Wallet" (UserID, CoinName, CoinVersionID, WalletNumber, Quantity)
    VALUES (
        (SELECT UserID FROM "Wallet" WHERE WalletNumber = NEW.WalletSecondNumber LIMIT 1),
        NEW.CoinName,
        NEW.CoinVersionID,
        NEW.WalletSecondNumber,
        NEW.TransferredAmount
    )
    ON CONFLICT (WalletNumber, CoinName, CoinVersionID) 
    DO UPDATE SET Quantity = "Wallet".Quantity + NEW.TransferredAmount;

    RETURN NEW;
END;
' LANGUAGE plpgsql;


CREATE TRIGGER transaction_trigger
BEFORE INSERT ON "Transaction"
FOR EACH ROW
EXECUTE FUNCTION manage_transaction();

ALTER TABLE "Transaction" ENABLE TRIGGER transaction_trigger;
