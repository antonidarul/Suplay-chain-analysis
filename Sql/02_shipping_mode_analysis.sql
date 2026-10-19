-- Question : Which shipping modes have the highest late delivery risk 
with order_level as(
	select
		"Order Id",
		min("Shipping Mode") as shipping_mode,
		max(is_canceled) as is_canceled,
		max(is_delayed) as is_delayed,
		max(schedule_variance_days) as delay_days
	from shipments
	group by "Order Id"
)
select
	shipping_mode,
	count(*) filter( where is_canceled = 0 ) as eligible_orders,
	
	count(*) filter( where is_canceled = 0 and is_delayed = 1)  as delayed_orders,
	
	round(100.0 * count(*) filter( where is_canceled = 0 and is_delayed = 1)
	/ nullif(count(*) filter(where is_canceled = 0),0),2) as late_delivery_rate_pct,
	
	round(avg(delay_days) filter(where is_canceled = 0 and is_delayed = 1),2) as avg_delay_days
from order_level
group by shipping_mode 
order by late_delivery_rate_pct desc;



-- Volume vs Keterlambatan & Konsistensi Layanan Cepat

with order_level as(
	select
		"Order Id",
		min("Shipping Mode") as shipping_mode,
		max(is_canceled) as order_canceled,
		max(is_delayed) as order_delayed,
		max(is_not_delayed) as order_not_delayed,
		max(schedule_variance_days) as delay_days
	from shipments
	group by "Order Id"
)

select
	shipping_mode,
	count(*) as total_orders,
	count(*) filter(where order_canceled = 0) as eligible_orders,
	count(*) filter(where order_canceled = 0 and order_delayed = 1) as delayed_orders,
	count(*) filter(where order_canceled = 0 and order_not_delayed = 1) as on_time_delivery,

	round(100.0 * count(*) filter( where order_canceled = 0 and order_delayed = 1) /
	nullif(count(*) filter(where order_canceled = 0),0),2) as late_delivery_rate_pct,

	max(delay_days) filter(where order_canceled = 0 and order_delayed = 1) as max_delays
from order_level
group by shipping_mode
order by total_orders desc
	