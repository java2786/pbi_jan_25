- drop database tutorial;
- create database tutorial;
- use tutorial;

## INNER JOIN
INNER JOIN is a type of SQL join that returns only the matching rows from the joined tables.  

### Dataset - author data
- id – The author’s unique ID within the database.
- name – The author’s name.
- birth_year – The year when that author was born.
- death_year – The year when that author died (the field is empty if they are still alive).

<pre>
CREATE TABLE authors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    birth_year INT NOT NULL,
    death_year INT
);
</pre>

### Dataset - book data
- id – The ID of a given book.
- author_id – The ID of the author who wrote that book.
- title – The book’s title.
- publish_year – The year when the book was published.
- publishing_house – The name of the publishing house that printed the book.
- rating – The average rating for the book.
<pre>
CREATE TABLE books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    author_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    publish_year INT NOT NULL,
    publishing_house VARCHAR(255),
    rating DECIMAL(3, 2),
    FOREIGN KEY (author_id) REFERENCES authors(id)
);
</pre>

### Dataset - adaptation data
- book_id – The ID of the adapted book.
- type – The type of adaptation (e.g. movie, game, play, musical).
- title – The name of this adaptation.
- release_year – The year when the adaptation was created.
- rating – The average rating for the adaptation.
<pre>
CREATE TABLE adaptations (
    book_id INT NOT NULL,
    type VARCHAR(50) NOT NULL,
    title VARCHAR(255) NOT NULL,
    release_year INT NOT NULL,
    rating DECIMAL(3, 2),
    FOREIGN KEY (book_id) REFERENCES books(id),
    PRIMARY KEY (book_id, type)
);
</pre>

### Dataset - book_review data
- book_id - The ID of a reviewed book.
- review - The summary of the review.
- author - The name of the review's author.
<pre>
CREATE TABLE book_reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    review TEXT NOT NULL,
    author_id INT NOT NULL,
    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (author_id) REFERENCES authors(id)
);
</pre>


#### Insert
```sql
INSERT INTO authors (name, birth_year, death_year) VALUES
('Jane Austen', 1775, 1817),
('Charles Dickens', 1812, 1870),
('Mark Twain', 1835, 1910),
('George Orwell', 1903, 1950),
('Virginia Woolf', 1882, 1941),
('F. Scott Fitzgerald', 1896, 1940),
('Ernest Hemingway', 1899, 1961),
('Gabriel Garcia Marquez', 1927, 2014),
('Harper Lee', 1926, 2016),
('Toni Morrison', 1931, 2019);

INSERT INTO books (author_id, title, publish_year, publishing_house, rating) VALUES
(1, 'Pride and Prejudice', 1813, 'T. Egerton', 4.25),
(1, 'Emma', 1815, 'John Murray', 4.10),
(2, 'Oliver Twist', 1837, 'Bentley', 4.20),
(2, 'A Tale of Two Cities', 1859, 'Chapman & Hall', 4.30),
(3, 'The Adventures of Tom Sawyer', 1876, 'Chatto & Windus', 4.00),
(4, '1984', 1949, 'Secker & Warburg', 4.50),
(5, 'Mrs. Dalloway', 1925, 'Hogarth Press', 4.00),
(6, 'The Great Gatsby', 1925, 'Charles Scribner\'s Sons', 3.91),
(7, 'The Old Man and the Sea', 1952, 'Charles Scribner\'s Sons', 4.20),
(8, 'One Hundred Years of Solitude', 1967, 'Harper & Row', 4.06);

INSERT INTO adaptations (book_id, type, title, release_year, rating) VALUES
(1, 'movie', 'Pride and Prejudice', 2005, 7.8),
(2, 'movie', 'Oliver Twist', 2005, 6.7),
(3, 'movie', 'The Adventures of Tom Sawyer', 1930, 6.9),
(4, 'movie', '1984', 1984, 7.1),
(5, 'play', 'Mrs. Dalloway', 2015, 8.0),
(6, 'movie', 'The Great Gatsby', 2013, 7.2),
(7, 'movie', 'The Old Man and the Sea', 1958, 6.7),
(8, 'movie', 'One Hundred Years of Solitude', 2024, 7.5),
(1, 'play', 'Pride and Prejudice', 2013, 8.5),
(2, 'musical', 'Oliver!', 1960, 8.2);

INSERT INTO book_reviews (book_id, review, author_id) VALUES
(1, 'A timeless classic about love and social class.', 1),
(2, 'A gripping tale of poverty and resilience.', 2),
(3, 'A fun and adventurous story that captivates readers.', 3),
(4, 'A thought-provoking dystopia that remains relevant today.', 4),
(5, 'An exquisite exploration of time and consciousness.', 5),
(6, 'A vivid portrayal of the American dream and its disillusionment.', 6),
(7, 'A beautifully written tale of endurance and struggle.', 7),
(8, 'A magical realism masterpiece that transcends generations.', 8),
(1, 'An engaging narrative with rich characters.', 9),
(2, 'A haunting reflection on society and human nature.', 10);
```

## Queries
- Show the name of each author together with the title of the book they wrote and the year in which that book was published.
- Show the name of each author together with the title of the book they wrote and the year in which that book was published. Show only books published after 2005.
- Show Books Adapted Within 4 Years and Rated Lower Than the Adaptation


## Solutions
```sql
SELECT
  name,
  title,
  publish_year
FROM author
JOIN book
  ON author.id = book.author_id;
```
```sql
SELECT
  name,
  title,
  publish_year
FROM authors
JOIN books
  ON authors.id = books.author_id
WHERE publish_year > 2005;
```
```sql
SELECT
  book.title AS book_title,
  adaptation.title AS adaptation_title,
  book.publish_year,
  adaptation.release_year
FROM books book
JOIN adaptations adaptation
  ON book.id = adaptation.book_id
WHERE adaptation.release_year - book.publish_year <= 4
  AND book.rating < adaptation.rating;
```



## LEFT JOIN
It is a type of outer join that returns all the columns from the left (the first) table and only the matching rows from the right (the second) table. If there is non-matching data, it’s shown as NULL.

### Problems
- Show the title of each book together with the title of its adaptation and the date of the release. Show all books, regardless of whether they had adaptations.
- Show all books with their movie adaptations. Select each book's title, the name of its publishing house, the title of its adaptation, and the type of the adaptation. Keep the books with no adaptations in the result.


### Solutions
```sql
SELECT
  book.title,
  adaptation.title,
  adaptation.release_year
FROM book
LEFT JOIN adaptation
  ON book.id = adaptation.book_id;
```

```sql
SELECT
  book.title,
  book.publishing_house,
  adaptation.title,
  adaptation.type
FROM book
LEFT JOIN adaptation
  ON book.id = adaptation.book_id
WHERE type = 'movie'
  OR type IS NULL;
```



## Right JOIN
It is a type of join that returns all the columns from the right (the second) table and only the matching rows from the left (the first) table. If there is non-matching data, it is shown as NULL.

### Problems
- Show the title of the book, the corresponding review, and the name of the review's author. Consider all books, even those that weren't reviewed.

### Solutions
```sql
SELECT
  book.title,
  book_review.review,
  book_review.author
FROM book_review
RIGHT JOIN book
  ON book.id = book_review.book_id;
```



## Full JOIN
This is a LEFT JOIN and RIGHT JOIN put together. It shows matching rows from both tables, rows that have no match from the left table, and rows that have no match from the right table. In short, **it shows all data from both tables.**

### Problems
- Display the title of each book along with the name of its author. Show all books, even those without an author. Show all authors, even those who haven't published a book yet. 

### Solutions
```sql
SELECT
  title,
  name
FROM book
FULL JOIN author
  ON book.author_id = author.id;
```

