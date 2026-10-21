--  1. How well is the suplay chain performing?.

select
	count(distinct "Order Id") as total_unique_orders,
	count(*) as total_order_items,
	count(*) filter(where is_canceled = 1) as canceled_orders,
	count(*) filter(where is_canceled = 0 and is_delayed = 1) as delayed_orders,
	count(*) filter(where is_canceled = 0 and is_not_delayed = 1) as on_time_orders,
	round(100.0 * count(*)filter(where is_canceled = 0 and is_delayed = 1)
	/ nullif (count(*)filter(where is_canceled = 0),0 ),2 ) as late_delivery_rate_pct,
	round(avg("schedule_variance_days") filter(where "schedule_variance_days"= 1),2 ) as avg_delay_days ,
	round(sum("Sales")) as total_sales,
	round(sum("Order Profit Per Order")) as total_profit,
	ROUND(100.0 * SUM("Order Profit Per Order")::numeric / NULLIF(SUM("Sales")::numeric, 0), 2) AS profit_margin_pct
from shipments;

-- Shipping Mode Performance by sales & profit

select
	"Shipping Mode",
	count(*) as total_order_items,
	round(sum("Sales")) as total_sales,
	round(sum("Order Profit Per Order")) as total_profit
from shipments
group by "Shipping Mode";

-- regional Performance by sales dan profit 

select
	"Order Region",
	count(*) as total_order_items,
	round(sum("Sales")) as total_sales,
	round(sum("Order Profit Per Order")) as total_profit
from shipments
group by "Order Region"
order by total_profit desc;

