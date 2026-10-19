 -- 1. validate the loaded dataset
select 
	count(*) as total_rows,
	count(distinct "Order Item Id") as unique_order_items,
	count(distinct "Order Id") as unique_orders,
	count(*) filter(where is_canceled = 1) as items_canceled,
	count(*) filter(where is_delayed = 1) as items_delayed,
	count(*) filter(where is_not_delayed = 1) as items_not_delayed
from shipments;


-- 2. check order level status consistency
select "Order Id",
	count(*) as item_count,
	count(distinct "Delivery Status") as delivery_status_count,
	count(distinct is_canceled) as cancellation_flag_count,
	count(distinct is_delayed) as delay_flag_count
from shipments
group by "Order Id"
having
	count(distinct "Delivery Status") > 1
	or count(distinct is_canceled) > 1
	or count(distinct is_delayed) > 1
order by item_count desc;

