-- Question : Which regions have the worst delivery performance

with order_level as (
	select 
		"Order Id",
		min("Market") as market,
		min("Order Region") as order_region,
		max(is_canceled) as order_canceled,
		max(is_delayed) as order_delayed,
		max(schedule_variance_days) as delay_days
	from shipments
	group by "Order Id"
),
regional as (
	select 
		market,
		order_region,
		count(*) as total_order,
		count(*) filter(where order_canceled = 0) as eligible_order,
		count(*) filter(where order_canceled = 0 and order_delayed = 1) as delayed_orders,
		round(avg(delay_days) filter(where order_canceled = 0 and order_delayed = 1), 2) as avg_delay_days
	from order_level 
	group by market, order_region
)
select 
	*,
	round(100.0 * delayed_orders / nullif (eligible_order, 0 ),2) as late_delivery_rate_pct,
	round(100.0 * delayed_orders / nullif (sum(delayed_orders) over (),0),2) as share_of_total_delayed_pct,
	avg_delay_days
from regional 
order by late_delivery_rate_pct desc;


-- Performa Wilayah dengan Memperhitungkan Shipping Mode

with order_level as (
	select
		"Order Id",
		min("Order Region") as order_region,
		min("Shipping Mode") as shipping_mode,
		max(is_canceled) as order_canceled,
		max(is_delayed) as order_delayed,
		max(schedule_variance_days) as delay_days
	from shipments
	group by "Order Id"
)
select 
	order_region,
	shipping_mode,
	count(*) filter( where order_canceled = 0 ) as eligible_orders,
	count(*) filter( where order_canceled = 0 and order_delayed = 1) as delayed_orders,
	round(100.0 * count(*) filter( where order_canceled = 0 and order_delayed = 1) /
	nullif(count(*) filter(where order_canceled = 0 ),0), 2) as late_delivery_rate_pct,
	round(avg(delay_days) filter(where order_canceled = 0 and order_delayed = 1),2 ) as avg_delay_days
from order_level 
group by order_region, shipping_mode
order by order_region asc, late_delivery_rate_pct desc;
