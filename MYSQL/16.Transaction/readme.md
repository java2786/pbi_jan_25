# Bank Money Transfer

Imagine a banking system where a customer, **Shalini**, wants to transfer ₹500 from her account to **Ramesh's** account. This operation involves two steps:
- Deduct ₹500 from Shalini's account.
- Add ₹500 to Ramesh's account.  

Both steps must succeed together; otherwise, the system could end up in an inconsistent state. For example:
- If money is deducted from Shalini's account but not added to Ramesh's account due to a failure, the system loses ₹500.
- If the money is added to Ramesh's account but not deducted from Shalini’s account, Ramesh gets ₹500 extra.  

This is where transactions come in to ensure consistency.





## Key Points
- **START TRANSACTION**: Begins a transaction block. Any changes made after this command are not permanently saved until you use COMMIT.
- **COMMIT**: Finalizes all changes within the transaction, making them permanent.
- **ROLLBACK**: Undoes all changes made in the transaction if something goes wrong.

## Practical
<pre>
drop database IF EXISTS tutorial;
CREATE DATABASE IF NOT EXISTS tutorial;
use tutorial;

CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    name VARCHAR(50),
    balance DECIMAL(10, 2)
);
INSERT INTO accounts (account_id, name, balance) VALUES
(1, 'Shalini', 1000.00),
(2, 'Ramesh', 500.00);
</pre>

### Understand Transaction
We want to transfer ₹500 from Shalini (account_id = 1) to Ramesh (account_id = 2). To ensure both steps succeed or fail together, we use a transaction.

### Implement Transaction
<pre>
-- Start the transaction
START TRANSACTION;

-- Step 1: Deduct ₹500 from Shalini's account
UPDATE accounts
SET balance = balance - 500
WHERE account_id = 1;

-- Step 2: Add ₹500 to Ramesh's account
UPDATE accounts
SET balance = balance + 500
WHERE account_id = 2;

-- Commit the transaction if both steps succeed
COMMIT;
</pre>

### Handle Errors with Rollback
<pre>
-- Start the transaction
START TRANSACTION;

-- Step 1: Deduct ₹500 from Shalini's account
UPDATE accounts
SET balance = balance - 500
WHERE account_id = 1;

-- Check if Shalini has enough balance
SELECT balance FROM accounts WHERE account_id = 1;

-- Step 2: If balance is sufficient, add ₹500 to Ramesh's account
UPDATE accounts
SET balance = balance + 500
WHERE account_id = 2;

-- If an error occurs, rollback the transaction
ROLLBACK;
</pre>


<pre>
-- Start the transaction
START TRANSACTION;

-- Step 1: Deduct ₹500 from Shalini's account
UPDATE accounts
SET balance = balance - 500
WHERE account_id = 1;

-- Step 2: Check if Shalini's balance is non-negative
SET @shalini_balance = (SELECT balance FROM accounts WHERE account_id = 1);

-- Step 3: Conditionally commit or rollback
IF @shalini_balance >= 0 THEN
    -- If balance is sufficient, add ₹500 to Ramesh's account and commit
    UPDATE accounts
    SET balance = balance + 500
    WHERE account_id = 2;
    COMMIT;
ELSE
    -- Rollback if Shalini's balance would be negative
    ROLLBACK;
END IF;
</pre>


<pre>
</pre>


