## Create Required Tables

<pre>
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE
);
CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
INSERT INTO orders (order_id, customer_id, order_date) VALUES
(1, 101, '2024-05-31'),
(2, 102, '2024-06-01'),
(3, 103, '2024-06-02');
INSERT INTO order_details (order_id, product_id, quantity) VALUES
(1, 201, 2),
(1, 202, 3),
(2, 203, 1),
(3, 204, 5);
</pre>

### Stored Procedure for Transaction with Error Handling
<pre>
DELIMITER //

CREATE PROCEDURE PlaceOrder()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- If an error occurs, roll back the transaction
        ROLLBACK;
        SELECT 'Transaction rolled back due to an error.' AS result;
    END;

    -- Start the transaction
    START TRANSACTION;

    -- Step 1: Insert order data
    INSERT INTO orders (order_id, customer_id, order_date)
    VALUES (1, 101, '2024-05-31');

    -- Step 2: Insert order details (this step may fail)
    INSERT INTO order_details (order_id, product_id, quantity)
    VALUES (1, 202, 3);

    -- If everything goes well, commit the transaction
    COMMIT;
    SELECT 'Transaction committed successfully.' AS result;
END //

DELIMITER ;
</pre>

### Explanation:
- DECLARE EXIT HANDLER FOR SQLEXCEPTION: This handler catches any SQL exception that occurs during the transaction.
- Transaction Block:
    - START TRANSACTION begins the transaction.
    - The INSERT statements add data to the orders and order_details tables.
- If any INSERT fails, the handler executes ROLLBACK and displays a message.
- If no error occurs, COMMIT finalizes the changes, and the transaction is completed successfully.

## Execute the Stored Procedure
<pre>
CALL PlaceOrder();
</pre>

<pre>
</pre>