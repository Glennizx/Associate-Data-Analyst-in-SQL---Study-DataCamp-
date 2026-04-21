/* #1. 
 Subtract the count of the non-null ticker values from the total 
number of rows in fortune500; alias the difference as missing.
*/
SELECT count(*) - COUNT(ticker) AS missing
  FROM fortune500;

/* #2.  Repeat for the industry column: subtract the count of the 
  non-null industry values from the total number of rows in fortune500; alias the difference as missing.
*/
  SELECT COUNT(*) - COUNT(industry) AS missing
FROM fortune500

/* #3.  Closely inspect the contents of the company and fortune500 
tables to find a column present in both tables that can also be considered 
to uniquely identify each company.
Join the company and fortune500 tables with an INNER JOIN.
*/
SELECT company.name 
  FROM company 
       INNER JOIN fortune500 
       ON company.ticker=fortune500.ticker;


/* #4.
First, using the tag_type table, count the number of tags with each type.
Order the results to find the most common tag type.
*/
SELECT type, count(*) AS count
  FROM tag_type
 GROUP BY type

 ORDER BY count DESC;

 /* $5.
Join the tag_company, company, and tag_type tables, keeping only mutually occurring records.
Select company.name, tag_type.tag, and tag_type.type for tags with the most common type
 from the previous step.
*/
-- Select the 3 columns desired
SELECT name, tag_type.tag, tag_type.type
  FROM company
       INNER JOIN tag_company 
       ON company.id = tag_company.company_id
       INNER JOIN tag_type
       ON tag_company.tag = tag_type.tag
  WHERE type='cloud';