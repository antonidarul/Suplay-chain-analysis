-- Question : Is late delivery associated with lower order profitability

select 
	"Order Id",
	count(*) as item_count,
	count(distinct "Order Profit Per Order") as distinct_profit_values,
	min("Order Profit Per Order") as min_profit,
	min("Order Profit Per Order") as max_profit
from shipments
group by "Order Id"
having count(*)>1
order by item_count desc
limit 20;


with order_level as (
	select 
		"Order Id",
		max(is_canceled) as order_canceled,
		max(is_delayed) as order_delayed,
		max("Sales") as order_sales,
		max("Order Profit Per Order") as order_profit
	from shipments
	group by "Order Id"
)
select 
	case 
		when order_delayed = 1 then 'Delayed' 
		when order_delayed = 0 then 'Not Delayed'
	end as delivery_group,
	count(*) as total_orders,
	round(sum(order_profit)::numeric, 2) as total_profit,
	round(sum(order_sales)::numeric, 2) as total_sales,
	round(avg(order_profit)::numeric , 2) as avg_profit_per_order,
	count(*) filter( where order_profit < 0 ) as loss_making_orders,
	round(100.0 * count(*) filter(where order_profit < 0)/ nullif(count(*),0),2) as loss_making_rate_pct
from order_level
where order_canceled = 0
group by delivery_group
order by delivery_group;


-- Wilayah & Shipping Mode terhadap Profit & Late Rate
with order_level as(
	select
		"Order Id",
		min("Order Region") as order_region,
		min("Shipping Mode") as shipping_mode,
		max(is_canceled) as order_canceled,
		max(is_delayed) as order_delayed,
		max("Sales") as order_sales,
		max("Order Profit Per Order") as order_profit
	from shipments
	group by "Order Id"
)
select 
	order_region,
	shipping_mode,
	count(*) filter(where order_canceled = 0) as eligible_orders,

	round(100.0 * count(*) filter(where order_canceled = 0 and order_delayed = 1)/ 
	nullif(count(*) filter (where order_canceled = 0),0),2) as late_delivery_rate_pct,

	round(sum(order_sales)::numeric, 2) as total_sales,
	round(sum(order_profit)::numeric, 2) as total_profit,
	round(avg(order_profit)::numeric, 2) as avg_profit_per_orders,
	count(*) filter(where order_canceled = 0 and order_profit < 0) as loss_making_orders
from order_level
group by order_region, shipping_mode
order by late_delivery_rate_pct desc, total_profit asc;

	
-- Kategori Produk, Keterlambatan, dan Profitabilitas
with order_level as(
	select
		"Order Id",
		min("Category Name") as product_category,
		max(is_canceled) as order_canceled,
		max(is_delayed) as order_delayed,
		max("Sales") as order_sales,
		max("Order Profit Per Order") as order_profit
	from shipments
	group by "Order Id"
)
select
	product_category,
	count(*) filter(where order_canceled = 0) as eligible_orders,

	round(100.0 * count(*) filter(where order_canceled = 0 and order_delayed = 1)/
	nullif(count(*) filter (where order_canceled = 0),0),2) as late_delivery_rate_pct,

	round(sum(order_sales)::numeric,2) as total_sales,
	round(sum(order_profit)::numeric,2) as total_profit,
	round(avg(order_profit)::numeric,2) as avg_profit_per_order,

	count(*) filter(where order_canceled = 0 and order_profit < 0) as loss_making_orders
from order_level
group by product_category
order by late_delivery_rate_pct desc , total_profit asc;
