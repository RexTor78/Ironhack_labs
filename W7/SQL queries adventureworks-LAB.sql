# 1) Write a SELECT statement that lists the customerid along with their account number, 
# type, the city the customer lives in and their postalcode.
select * from address; #postal code and city
select * from customer; # cust id and type and account
select * from customeraddress; #joining fields-cust id, addr id

select * from customer 
join customeraddress ca using(CustomerID)
join address a using(AddressID);

select c.CustomerID, c.CustomerType, c.AccountNumber, a.City, a.PostalCode from customer c
join customeraddress ca using(CustomerID)
join address a using(AddressID);

# 2) SELECT statement that lists the 20 most recently launched products, their name and colour.alter
select Name, ProductNumber, Color from product
order by SellStartDate desc limit 20;

# 3) SELECT statement that shows how many products are on each shelf in 2/5/98
select Shelf, count(distinct ProductID) from productinventory
where ModifiedDate = '1998-05-02'
group by Shelf;

# 4) I am trying to track down a vendor email address… his name is Stuart and he works at G&K Bicycle Corp. 
# Can you help?
select * from contact c 
join vendorcontact vc using(contactID);

select c.EmailAddress from contact c 
join vendorcontact vc using(contactID)
join vendor v using (VendorID)
where c.FirstName = 'Stuart'
and v.Name= 'G & K Bicycle Corp.';

# 5) What’s the total sales tax amount for sales to Germany? What’s the top region in Germany by sales tax?

select sum(TaxAmt),cr.Name from salesorderheader
join salesterritory st using (TerritoryID)
join countryregion cr using (CountryRegionCode)
where CountryRegionCode= 'DE';

SELECT sp.Name as RegionName, sum(s.TaxAmt) as taxtotal
 FROM salesorderheader s # amounts
 join salesterritory st using(TerritoryID) # country - filter
 join address a on s.BillToAddressID = a.AddressID # ship address - to get region
 join stateprovince sp using(StateProvinceID) # region 
 where st.Name = 'Germany'
 Group by sp.Name
 order by sum(s.TaxAmt) DESC
 LIMIT 1;

# I do by taxRate I don't know why but 
select  cr.Name Country,sp.Name CityRegion, TaxRate from salesorderheader
join salesterritory st using (TerritoryID)
join countryregion cr using (CountryRegionCode)
join stateprovince sp using (CountryRegionCode)
join salestaxrate stax using (StateProvinceID)
where CountryRegionCode= 'DE'
order by TaxRate desc limit 10;

# 6) Summarise the distinct # transactions by month
select count(distinct(TransactionID)), date_format(TransactionDate, '%Y'' ' '%M') Month_  from transactionhistory
group by Month_;

# 7) Which ( if any) of the sales people exceeded their sales quota this year and last year?
select SalesPersonID, SalesQuota, SalesYTD, SalesLastYear  from salesperson
where SalesQuota < SalesLastYear and SalesYTD;

# 8) Do all products in the inventory have photos in the database and a text product description? 
select ProductID from product 
join productproductphoto phid using( ProductID)
join productphoto ph using(ProductPhotoID)
join productmodelproductdescriptionculture pmd using(ProductModelID)
join productdescription pd using(ProductDescriptionID)
having count(distinct(ProductDescriptionID and ProductPhotoID)) > 0;

# 9) What's the average unit price of each product name on purchase orders which were not fully, but at least partially rejected?
select Name, avg(UnitPrice) from product
join purchaseorderdetail using (ProductID)
where OrderQty != StockedQty and   RejectedQty>0 !=StockedQty;

# 10) How many engineers are on the employee list? Have they taken any sickleave?   like '%ngineer%'
select count(EmployeeID ) Engineers from employee
where Title like '%ngineer%' ;

# 11) How many days difference on average between the planned and actual end date of workorders in the painting stages?


Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '!= StockedQty)' at line 3
