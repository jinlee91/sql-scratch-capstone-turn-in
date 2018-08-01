select count (distinct utm_campaign) as campaign, count(distinct utm_source) as source from page_visits;
select distinct utm_campaign, utm_source from page_visits;

select distinct page_name from page_visits;

WITH first_touch as (
 	select user_id, MIN(timestamp) as first_touch_at 
  from page_visits
  group by user_id),

ft_table as (SELECT ft.user_id, ft.first_touch_at, pv.utm_source,pv.utm_campaign
from first_touch as ft
Join page_visits as pv
	on ft.user_id = pv.user_id
  and ft.first_touch_at = pv.timestamp)
  
select ft_table.utm_campaign, ft_table.utm_source, count(*)
	from ft_table
	group by 1,2
order by 3 desc;

WITH last_touch as (
 	select user_id, max(timestamp) as last_touch_at 
  from page_visits
  group by user_id),

lt_table as (SELECT lt.user_id, lt.last_touch_at, pv.utm_source,pv.utm_campaign
from last_touch as lt
Join page_visits as pv
	on lt.user_id = pv.user_id
  and lt.last_touch_at = pv.timestamp)
  
select lt_table.utm_campaign, lt_table.utm_source, count(*)
	from lt_table
	group by 1,2
  order by 3 desc;

select page_name, count(distinct user_id) from page_visits
where page_name = "4 - purchase"
group by 1;	

WITH last_touch as (
 	select user_id, max(timestamp) as last_touch_at 
  from page_visits
  where page_name = '4 - purchase'
  group by user_id),

lt_table as (SELECT lt.user_id, lt.last_touch_at, pv.utm_source,pv.utm_campaign
from last_touch as lt
Join page_visits as pv
	on lt.user_id = pv.user_id
  and lt.last_touch_at = pv.timestamp)
  
select lt_table.utm_campaign, lt_table.utm_source, count(*)
	from lt_table
 	group by 1,2
  order by 3 desc;
