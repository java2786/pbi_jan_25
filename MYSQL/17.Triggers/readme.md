# Triggers
## Definition and Benefits: 
- Automatic actions executed when certain events occur on a table. 
- Enforce business rules. 
- Maintain audit trails and ensure data integrity. 
 
<p>Triggers are automatic actions performed when specific events occur on a table. They help enforce business rules and maintain audit trails. Let's create a trigger and see it in action.</p>
 
## Creating Triggers: 
 
```sql
-- Creating a trigger to maintain an audit trail 
CREATE TRIGGER BeforeStudentInsert 
BEFORE INSERT ON students 
FOR EACH ROW 
BEGIN 
	INSERT INTO audit_log(action, student_id, timestamp) 
	VALUES ('INSERT', NEW.student_id, NOW()); 
END; 
``` 

 
The items table will store the available inventory, and the purchases table will store the user purchases. The trigger will ensure that the quantity in the items table is updated before the purchase and will prevent the purchase if the total available quantity is less than 0.

## Database and Tables
```sql
DROP DATABASE IF EXISTS store;
CREATE DATABASE store;
USE store;

CREATE TABLE items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(255) NOT NULL,
    quantity INT NOT NULL
);

CREATE TABLE purchases (
    purchase_id INT AUTO_INCREMENT PRIMARY KEY,
    item_id INT NOT NULL,
    quantity INT NOT NULL,
    purchase_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);
```

### Create the Trigger
Create a BEFORE INSERT trigger on the purchases table that will:
- Check if the available quantity in the items table is enough to complete the purchase.
- Decrease the quantity in the items table if the purchase is valid.
- Prevent the insertion of a record into the purchases table if the purchase would result in negative available quantities.

```sql
DELIMITER $$

CREATE TRIGGER before_purchase
BEFORE INSERT ON purchases
FOR EACH ROW
BEGIN
    -- Check if the quantity in the items table is sufficient
    DECLARE available_quantity INT;
    
    -- Get the available quantity of the item being purchased
    SELECT quantity INTO available_quantity
    FROM items
    WHERE item_id = NEW.item_id;
    
    -- If the available quantity is less than the quantity being purchased, cancel the purchase
    IF available_quantity < NEW.quantity THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Not enough quantity available for this item';
    ELSE
        -- Decrease the quantity of the item in the items table
        UPDATE items
        SET quantity = quantity - NEW.quantity
        WHERE item_id = NEW.item_id;
    END IF;
END$$

DELIMITER ;

```

### Error Handling
The SIGNAL SQLSTATE '45000' in the trigger ensures that if a purchase can't be completed (because of insufficient stock), an error is raised, and the insert operation on the purchases table is canceled.

### Testing
```sql
INSERT INTO items (item_name, quantity) VALUES ('Laptop', 10), ('Smartphone', 5), ('Headphones', 20);

-- Try to purchase 15 laptops (only 10 are available)
INSERT INTO purchases (item_id, quantity) VALUES (1, 15);

-- Purchase 5 laptops (10 are available)
INSERT INTO purchases (item_id, quantity) VALUES (1, 8);

SELECT * FROM items;
```
