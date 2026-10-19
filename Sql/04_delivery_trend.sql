-- Question : How has delivery performance changed over time 
with order_level as (
	select
		"Order Id",
		min("order_year_month") as order_year_month,
		max(is_canceled) as order_canceled,
		max(is_delayed) as order_delayed,
		max(schedule_variance_days) as delay_days
	from shipments
	group by "Order Id"
)
select 
	order_year_month,
	count(*) as total_orders,
	count(*) filter(where order_canceled = 1 ) as canceled_orders,
	round(100.0 * count(*) filter (where order_canceled = 1 ) / nullif(count(*),0),2) as cancellation_rate_pct,
	count(*) filter ( where order_canceled = 0) as eligible_orders,
	count(*) filter (where order_canceled = 0 and order_delayed = 1) as delayed_orders,
	round(100.0 * count(*) filter(where order_canceled = 0 and order_delayed = 1) /
	nullif(count(*) filter(where order_canceled = 0), 0), 2) as late_delivery_rate_pct,
	round(avg(delay_days) filter(where order_canceled = 0 and order_delayed = 1),2 ) as avg_delay_days
from order_level
group by order_year_month
order by late_delivery_rate_pct desc;


--Tren Bulanan Berdasarkan Shipping Mode
with order_level as (
    select
        "Order Id",
        min("order_year_month") as order_year_month,
        min("Shipping Mode") as shipping_mode,
        max(is_canceled) as order_canceled,
        max(is_delayed) as order_delayed,
        max(schedule_variance_days) as delay_days
    from shipments
    group by "Order Id"
)
select
	order_year_month,
	shipping_mode,
	count(*) filter(where order_canceled = 0) as eligible_orders,
	count(*) filter(where order_canceled = 0 and order_delayed = 1 ) as delayed_orders,
	round(100.0 * count(*) filter (where order_canceled = 0 and order_delayed = 1)/
	nullif(count(*) filter(where order_canceled = 0),0),2) as late_delivery_rate_pct,
	round(avg(delay_days) filter(where order_canceled = 0 and order_delayed = 1 ),2)  as avg_delay_days
from order_level
group by order_year_month , shipping_mode
order by order_year_month asc, late_delivery_rate_pct desc;





