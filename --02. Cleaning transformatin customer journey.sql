--02. cleaning transformation customer journey
drop view if exists customer_journey_clean

create or replace view customer_journey_clean as
select
  cj.*,
  case
  	when "TimeOnPage_seconds" > 97 and "ItemsInCart" >= 1 and "Purchased" = 0 then 'Bargain Hunter'
  	when "TimeOnPage_seconds" <= 97 and "Purchased" >= 1 then 'Desicive Buyers'
  	else 'Customers Browsing'
  end as user_segment,
  case
  	when "TimeOnPage_seconds" >97 and "PageType" = 'home' then 'Navigation Struggle'
  	when "TimeOnPage_seconds" <= 97 and "PageType" = 'home' then 'Fast Exit' 
  	else 'Other Page'
  end as Session_Intensity,
  case
  	when "TimeOnPage_seconds" > 97 and "ItemsInCart" > 0 then 'High Abandonment Risk'
  	when "TimeOnPage_seconds" <= 97 and "ItemsInCart" > 0 then 'Ready to Checkout'
  	when "Purchased" >= 1 then 'Converted Customer'
  	else 'Browsing Only'
  	end as Cart_Intention
 from customer_journey cj;