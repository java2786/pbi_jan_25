## Create the Database:
```sql
DROP DATABASE IF EXISTS tutorial;
CREATE DATABASE IF NOT EXISTS tutorial;
USE tutorial;

CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    name VARCHAR(50),
    balance DECIMAL(10, 2)
);
```

## Create the accounts Table and Insert Data
```sql
INSERT INTO accounts (account_id, name, balance) VALUES
(1, 'Shalini', 1000.00),
(2, 'Ramesh', 500.00);

SELECT * FROM accounts;
```

## Create a Stored Procedure:
```sql
DELIMITER //

CREATE PROCEDURE TransferFunds()
BEGIN
    DECLARE shalini_balance DECIMAL(10, 2);

    -- Start transaction
    START TRANSACTION;

    -- Deduct 500 from Shalini's account
    UPDATE accounts
    SET balance = balance - 500
    WHERE account_id = 1;

    -- Check Shalini's balance
    SELECT balance INTO shalini_balance FROM accounts WHERE account_id = 1;

    -- Conditional logic
    IF shalini_balance >= 0 THEN
        -- Add 500 to Ramesh's account
        UPDATE accounts SET balance = balance + 500 WHERE account_id = 2;
        COMMIT;
    ELSE
        ROLLBACK;
    END IF;
END //

DELIMITER ;
```

## Call the Stored Procedure:
```sql
select * from accounts;
CALL TransferFunds();
select * from accounts;
```