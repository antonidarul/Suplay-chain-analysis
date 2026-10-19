-- Overall 

with order_level as (
	select
		"Order Id",
		max(is_canceled) as order_canceled,
		max(is_delayed) as order_delayed,
		max(is_not_delayed) as order_not_delayed,
		max(schedule_variance_days) as delay_days
	from shipments
	group by "Order Id"
)
select
	
	count("Order Id") as total_unique_orders,
	count(*) as total_order_items,

	-- order batal, delayed, tepat waktu
	count(*) filter(where order_canceled = 1) as canceled_orders,
	
	count(*) filter(where order_canceled = 0 and order_delayed = 1) as delayed_orders,
	count(*) filter(where order_canceled = 0 and order_not_delayed = 1) as on_time_orders,

	round(100.0 * count(*)filter(where order_canceled = 0 and order_delayed = 1)
		/ nullif (count(*)filter(where order_canceled = 0),0 ),2 ) as late_delivery_rate_pct,

	round(avg(delay_days) filter(where order_delayed = 1),2 ) as avg_delay_days ,

	max (delay_days) filter(where order_delayed = 1) as max_delay_days
from order_level;


-- Shipping Mode Performance
with order_level as (
	select
		"Order Id",
		"Shipping Mode",
		max(is_canceled) as order_canceled,
		max(is_delayed) as order_delayed,
		max(is_not_delayed) as order_not_delayed,
		max(schedule_variance_days) as delay_days
	from shipments
	group by "Order Id", "Shipping Mode"
)
select
	"Shipping Mode",
	count("Order Id") as total_unique_orders,
	count(*) as total_order_items,

	-- order batal, delayed, tepat waktu
	count(*) filter(where order_canceled = 1) as canceled_orders,

	count(*) filter(where order_canceled = 0 and order_delayed = 1) as delayed_orders,
	count(*) filter(where order_canceled = 0 and order_not_delayed = 1) as on_time_orders,

	round(100.0 * count(*)filter(where order_canceled = 0 and order_delayed = 1)
		/ nullif (count(*)filter(where order_canceled = 0),0 ),2 ) as late_delivery_rate_pct,

	round(avg(delay_days) filter(where order_delayed = 1),2 ) as avg_delay_days ,

	max (delay_days) filter(where order_delayed = 1) as max_delay_days
from order_level
group by "Shipping Mode"
order by late_delivery_rate_pct desc;

-- regional Performance 

with order_level as (
	select
		"Order Id",
		"Order Region",
		max(is_canceled) as order_canceled,
		max(is_delayed) as order_delayed,
		max(is_not_delayed) as order_not_delayed,
		max(schedule_variance_days) as delay_days
	from shipments
	group by "Order Id", "Order Region"
)
select
	"Order Region",
	count("Order Id") as total_unique_orders,
	count(*) as total_order_items,

	-- order batal, delayed, tepat waktu
	count(*) filter(where order_canceled = 1) as canceled_orders,
	count(*) filter(where order_canceled = 0 and order_delayed = 1) as delayed_orders,
	count(*) filter(where order_canceled = 0 and order_not_delayed = 1) as on_time_orders,

	round(100.0 * count(*)filter(where order_canceled = 0 and order_delayed = 1)
		/ nullif (count(*)filter(where order_canceled = 0),0 ),2 ) as late_delivery_rate_pct,

	round(avg(delay_days) filter(where order_delayed = 1),2 ) as avg_delay_days ,

	max (delay_days) filter(where order_delayed = 1) as max_delay_days
from order_level
group by "Order Region"
order by late_delivery_rate_pct desc;



