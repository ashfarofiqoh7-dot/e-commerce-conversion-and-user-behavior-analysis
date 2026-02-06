--03. exploratory data analysis customer journey
--Conversion funnel & retention rate analysis
   select
       "PageType",
       count(distinct "SessionID") as Total_Session,
      cast(round(count(distinct "UserID")*100.0/first_value(count(distinct "UserID")) over (order by
        case
        	when "PageType" = 'home' then 1
        	when "PageType" = 'product_page' then 2
        	when "PageType" = 'cart' then 3
        	when "PageType" = 'checkout' then 4
        	when "PageType" = 'confirmation' then 5
        	else 6
        	end), 2) as text) || '%' as retention_rate_percentage 
       from customer_journey
       where "PageType" in ('home','product_page','cart','checkout','confirmation')
       group by "PageType"
       order by 
         case
       	when "PageType" = 'home' then 1
       	when "PageType" = 'product_page' then 2
       	when "PageType" = 'cart' then 3
       	when "PageType" = 'checkout' then 4
       	when "PageType" = 'confirmation' then 5
       	else 6
       end
       
-- User Engagement Baseline
   select 
     avg ("TimeOnPage_seconds") as avg_time_on_pages
     from customer_journey;
     
--User persona mapping by purchase interest
  select 
       case
       	when "TimeOnPage_seconds" <= 97 and "Purchased" >=1 then 'Decisive Buyers'
       	when "TimeOnPage_seconds" > 97 and "ItemsInCart" >= 1 and "Purchased" = 0 then 'Bargain_Hunter'
       else 'Casual_Browser'   
       end as user_segment,
       count(distinct "UserID") as total_users
       from customer_journey
       group by 1;

--Referral source performance: Bargain hunter profile
  select 
     "ReferralSource",
      count(distinct("UserID")) as Bargain_Hunters
      from customer_journey
       	where "TimeOnPage_seconds" > 97 and "ItemsInCart" >= 1 and "Purchased" = 0 
       	group by 1
       	order by Bargain_Hunters desc
     
 --Device based conversion comparison
   select
   "DeviceType",
        avg("Purchased") as avg_purchased
        from customer_journey
        group by 1
        order by 2 desc;
       
--Homepage navigation friction & UX health check
   select
      "PageType",
      case
	      when "TimeOnPage_seconds" > 97 then 'Navigation Struggle'
	      when "TimeOnPage_seconds" <= 97 then 'Fast Exit'
	      else 'other'
	      end as Session_Intensity,
	   count(distinct "UserID") as Total_Users,
	   cast(round(count(distinct "UserID")*100.0/sum(count(distinct "UserID"))
       over (),2) as text) || '%' as Percentage_of_User
       from customer_journey
	   where "PageType" = 'home'
	   group by 1,2
	   order by total_users  desc;
	      
--Cart Abandonment Analysis & payment friction
  select 
    "PageType",
    case
    	when "TimeOnPage_seconds" >= 97 and "ItemsInCart">0 then 'High_Abandonment_Risk'
        when "TimeOnPage_seconds" <= 97 and "ItemsInCart">0 then 'Ready_to_Checkout'
        when "Purchased" >= 1 then 'Converted Customer'
        else 'Browsing_Only'
    	end as cart_intent,
    count(distinct "UserID") as total_user
    from customer_journey
    group by 1,2
    order by 3 desc;

--Share of Bounce Rate
with UserFirstSource as(
  select distinct on ("UserID")
   "UserID",
   "ReferralSource"
   from customer_journey
   order by "UserID"),
   UserActivity as (
   select "UserID", count("PageType") 
   as total_pages
   from customer_journey
   group by "UserID")
   select
   f."ReferralSource",
   count (f."UserID") as Total_Users,
   round(count(case when a.total_pages = 1 then 1 end)*100.0/count (f."UserID"),2) || '%' as Bounce_Rate
 from UserFirstSource f
 join UserActivity a on f."UserID" = a."UserID"
 group by 1
 order by Total_Users desc;
