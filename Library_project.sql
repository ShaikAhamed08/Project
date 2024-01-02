use library_management_db;

-- 1) How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?

SELECT sum(no_of_copies) AS total
FROM book_copies INNER JOIN books
ON book_copies.book_id=books.book_id
#where book_Title='The Lost Tribe'
LEFT JOIN library_branch
ON library_branch.branch_id=book_copies.branch_id
WHERE branchname='Sharpstown' AND book_Title='The Lost Tribe';

-- 2)How many copies of the book titled "The Lost Tribe" are owned by each library branch?
SELECT branchname,sum(no_of_copies) AS count
FROM book_copies INNER JOIN books
ON books.book_id=book_copies.book_id
LEFT JOIN library_branch
ON library_branch.branch_id=book_copies.branch_id
WHERE book_title LIKE 'The Lost Tribe'
GROUP BY branchname ;

-- 3)Retrieve the names of all borrowers who do not have any books checked out?
SELECT NAME FROM customer
INNER JOIN loan
ON loan.card_no=customer.card_no
LEFT JOIN books
ON books.book_id=loan.book_id
GROUP BY customer.card_no
HAVING count(customer.name)=0;

-- 4)Retrieve the names of all borrowers who have checked out  'The Name of the Wind'?
SELECT name FROM customer
INNER JOIN loan
ON loan.card_no=customer.card_no
LEFT JOIN books
ON books.book_id=loan.book_id
WHERE book_title='The Name of the Wind'
GROUP BY customer.name;

-- 5)For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today, retrieve the book title, 
--    the borrower's name, and the borrower's address.
SELECT book_title,name,address 
FROM customer 
INNER JOIN loan 
ON loan.card_no=customer.card_no
LEFT JOIN books
on loan.book_id=books.book_id
LEFT JOIN library_branch 
ON library_branch.branch_id=loan.branch_id
WHERE branchname='SAline' and datedue='2018-02-03' ;

-- 6) For each library branch, retrieve the branch name and the total number of books loaned out from that branch?
SELECT branchname,sum(no_of_copies) 
FROM library_branch
INNER JOIN loan ON
library_branch.branch_id=loan.branch_id
LEFT JOIN book_copies
ON book_copies.book_id=loan.book_id
GROUP BY branchname;

-- 7)Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out?
SELECT name,address,count(name) AS counts
FROM customer 
INNER JOIN loan 
ON loan.card_no=customer.card_no
LEFT JOIN books
ON books.book_id=loan.book_id
GROUP BY customer.name,address
HAVING count(loan.card_no)>5;
# 8)For each book authored by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central"?
SELECT book_title,sum(no_of_copies) AS 'no.of copies'
FROM books INNER JOIN book_copies 
ON book_copies.book_id=books.book_id
LEFT JOIN tbl_book_authors
ON tbl_book_authors.book_id=books.book_id
LEFT JOIN library_branch
ON library_branch.branch_id=book_copies.branch_id
WHERE tbl_book_authors.author_name='Stephen KIng'
AND library_branch.branchname='Central'
GROUP BY book_title;

-- 9) How many copies of the book titled "The Hobbit" or "" are owned by every branch?
select book_title,branchname,sum(no_of_copies) as 'no.of copies'
FROM books 
INNER JOIN book_copies
ON book_copies.book_id=books.book_id
LEFT JOIN library_branch
ON library_branch.branch_id=book_copies.branch_id
WHERE book_title = 'The Hobbit'OR book_title='it'
GROUP BY book_title,branchname;

-- 10) find number of books loaned by customer named 'joe smith' ?
SELECT book_title,count(book_title) as counts
FROM books
INNER JOIN loan
ON loan.book_id=books.book_id
LEFT JOIN customer
ON customer.card_no=loan.card_no
WHERE customer.name='Joe Smith'
GROUP BY books.book_title;