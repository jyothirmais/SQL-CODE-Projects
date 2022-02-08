TABLE:          CUSTOMER_EMAILS
BACKGROUND:     Each row in the table represents a unique customer account. The customer_ID is the PK.


SAMPLE DATE:
+---------------+-----------------------+---------------------------------------+
| Customer_ID   | Customer_Name     | Email                 |
+---------------+-----------------------+---------------------------------------+
| 3362462944    | Darth Vader       | d.vader@empire.co         |
| 9974574193    | Hermione Granger  | hermioneg@hogwarts.co.uk      |
| 8434103670    | Han Solo      | hs@millenniumflights.com      |
| 1735736329    | Jack Sparrow      | greatwhitesharkguy            |
| 7162944850    | Princess Leia     | leia@republic.star            |
| 4076426500    | Frodo Baggins     | fbags@shire.com           |
+---------------+-----------------------+---------------------------------------+


Extract the alias from a list of email addresses with different domain names,
and flag the accounts that do not have a valid domain format.

with sub as (select customer_id customer_id,customer_name customer_name, email email,
                case when email like'%@%' and email like '%.co%' or email like '%@%' and email like'%.com' then 'not flag' else 'flag' end as status
from customer_emails),
sub1 as (select  customer_id customer_id ,customer_name customer_name,email email from  sub where status = 'not flag')
select customer_id,customer_name,email,left(email,postion("@" in "email")) postion
from sub1;

