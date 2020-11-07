
/* challenge 1*/
SELECT au.au_id AS "Authors ID", au.au_lname AS "Last Name",au.au_fname AS "First Name", 
title, pub_name AS "Publisher"
FROM authors AS au
INNER JOIN titleauthor ON titleauthor.au_id = au.au_id
LEFT JOIN  publications.titles ON titleauthor.title_id = titles.title_id
inner JOIN publishers ON publishers.pub_id = titles.pub_id

/*Challenge 2*/
SELECT au.au_id AS "Authors ID", au.au_lname AS "Last Name",au.au_fname AS "First Name", 
COUNT(title) AS "Title Count"
FROM authors AS au
INNER JOIN titleauthor ON titleauthor.au_id = au.au_id
LEFT JOIN  publications.titles ON titleauthor.title_id = titles.title_id
GROUP BY titles.title

/*Challenge 3*/

SELECT au.au_id AS "Authors ID", au.au_lname AS "Last Name", au.au_fname AS "First Name",  SUM(  qty) AS "Total"
FROM  sales
INNER JOIN titleauthor ON titleauthor.title_id = sales.title_id
INNER JOIN AUTHORS AS au ON titleauthor.au_id  = au.au_id 
GROUP BY au.au_id
ORDER BY SUM(qty) DESC
LIMIT 3

/*Challenge 4*/

SELECT  au.au_id AS "Authors ID", au.au_lname AS "Last Name", au.au_fname AS "First Name", SUM(IFNULL( qty,0)) AS "Total"
FROM  AUTHORS AS au
LEFT JOIN titleauthor ON titleauthor.au_id  = au.au_id 
LEFT JOIN sales ON titleauthor.title_id = sales.title_id
GROUP BY au.au_id
ORDER BY "Authors ID", "Last Name", "First Name", "Total" DESC


/* BONUS */
SELECT sub_qu2.au_id AS "Author ID", sub_qu2.au_lname AS "Last Name", sub_qu2.au_fname AS "First Name", ROUND(SUM(Profit),2) AS "Profit"
FROM(
SELECT sub_qu.au_id, sub_qu.au_lname, sub_qu.au_fname,
((royalty+advance) * royaltyper) AS "Profit"
FROM (
SELECT AUTHORS.au_id, AUTHORS.au_lname, AUTHORS.au_fname, IFNULL((royaltyper/100),0) AS "royaltyper",
titles.title_id, IFNULL(advance,0) AS "advance", IFNULL((royalty/100),0)*IFNULL((price*ytd_sales),0) AS "royalty"
FROM titles
INNER JOIN titleauthor ON titles.title_id = titleauthor.title_id
INNER JOIN AUTHORS ON titleauthor.au_id = AUTHORS.au_id) AS sub_qu) AS sub_qu2
GROUP BY sub_qu2.au_id
ORDER BY Profit DESC
