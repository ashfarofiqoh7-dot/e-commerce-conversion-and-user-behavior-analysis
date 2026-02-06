--01. Data Profiling Customer Journey

--Checking for missing values or blank strings across all columns.
select 
  count(*) filter(where "SessionID" is null or TRIM("SessionID") = '') as blank_sid,
  count(*) filter(where "UserID" is null or TRIM ("UserID") = '') as blank_uid,
  count(*) filter(where "Timestamp" is null or trim ("Timestamp") = '') as blank_timestamp,
  count(*) filter(where "PageType" is null or trim("PageType") = '') as blank_pt,
  count(*) filter(where "DeviceType" is null or trim("DeviceType") = '') as blank_dt,
  count(*) filter(where "Country" is null or trim("Country") = '') as blank_country,
  count(*) filter(where "ReferralSource" is null or trim("ReferralSource") = '') as blank_rs,
  count(*) filter(where "TimeOnPage_seconds" is null) as blank_TOP,
  count(*) filter(where "ItemsInCart" is null) as blank_its,
  count(*) filter(where "Purchased" is null) as blank_purchased
  from customer_journey
  
--Categorial Data Consistency Check
--Check unique referral sources
select
  distinct "ReferralSource"
  from customer_journey 
  
--Check unique country
 select
  distinct "Country"
  from customer_journey
  
--check unique device types
 select
  distinct "DeviceType"
  from customer_journey
  
--check unique page types
 select
   distinct "PageType"
   from customer_journey
   
--Numerical anomaly check (outlier or logic errors)
--detecting negative values
   select "TimeOnPage_seconds","ItemsInCart","Purchased"
     from customer_journey
     where "TimeOnPage_seconds" <0
     or "ItemsInCart" <0
     or "Purchased" <0