 --  validate the loaded dataset
select 
	count(*) as total_rows,
	count(distinct "Order Item Id") as unique_order_items,
	count(distinct "Order Id") as unique_orders,
	count(*) filter(where is_canceled = 1) as items_canceled,
	count(*) filter(where is_delayed = 1) as items_delayed,
	count(*) filter(where is_not_delayed = 1) as items_not_delayed
from shipments;


--  check order level status consistency
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

-- 2. Which shipping modes have the highest late delivery risk
with order_level as(
	select
		"Order Id",
		"Sales",
		"Order Profit Per Order" as profit,
		min("Shipping Mode") as shipping_mode,
		max(is_canceled) as order_canceled,
		max(is_delayed) as order_delayed,
		max(is_not_delayed) as order_not_delayed,
		max(schedule_variance_days) as delay_days
	from shipments
	group by "Order Id", "Sales", profit
)
select
	shipping_mode,
	round(sum("Sales")) as total_sales,
	round(sum(profit)) as total_profit,
	count(*) filter(where order_canceled = 1) as canceled_orders,
	count(*) filter(where order_canceled = 0 and order_delayed = 1) as delayed_orders,
	count(*) filter(where order_canceled = 0 and order_not_delayed = 1) as on_time_orders,
	round(100.0 * count(*) filter( where order_canceled = 0 and order_delayed = 1)
	/ nullif(count(*) filter(where order_canceled = 0),0),2) as late_delivery_rate_pct,
	round(avg(delay_days) filter(where order_canceled = 0 and order_delayed = 1),2) as avg_delay_days
from order_level
group by shipping_mode 
order by late_delivery_rate_pct desc;

-- 3. Which regions have the worst delivery performance

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
	round(100.0 * delayed_orders / nullif (sum(delayed_orders) over (),0),2) as share_of_total_delayed_pct
from regional 
order by late_delivery_rate_pct desc;


--4. Which product categories experience more delivery delays?.
SELECT 
    "Category Name" AS product_category,
    COUNT(*) AS total_items,
    SUM(CASE WHEN "Delivery Status" <> 'Shipping canceled' THEN 1 ELSE 0 END) AS valid_items,
    SUM(CASE WHEN "Delivery Status" <> 'Shipping canceled' AND "Days for shipping (real)" > "Days for shipment (scheduled)" THEN 1 ELSE 0 END) AS delayed_item_volume,
    ROUND(
        100.0 * SUM(CASE WHEN "Delivery Status" <> 'Shipping canceled' AND "Days for shipping (real)" > "Days for shipment (scheduled)" THEN 1 ELSE 0 END) 
        / NULLIF(SUM(CASE WHEN "Delivery Status" <> 'Shipping canceled' THEN 1 ELSE 0 END), 0), 
        2
    ) AS delayed_rate_pct,
    ROUND(SUM("Sales"::numeric), 2) AS total_sales,
    ROUND(SUM("Order Profit Per Order"::numeric), 2) AS total_profit
FROM shipments
GROUP BY "Category Name"
ORDER BY delayed_rate_pct DESC;


-- 5. How has delivery performance changed over time?.
SELECT 
    order_year_month,
    COUNT(*) AS total_order_items,
    COUNT(*) FILTER (WHERE is_canceled = 1) AS canceled_items,
    COUNT(*) FILTER (WHERE is_canceled = 0 AND is_delayed = 1) AS delayed_items,
    ROUND(100.0 * COUNT(*) FILTER (WHERE is_canceled = 0 AND is_delayed = 1) / 
        NULLIF(COUNT(*) FILTER (WHERE is_canceled = 0), 0), 2) AS late_delivery_rate_pct,
    ROUND(AVG(schedule_variance_days) FILTER (WHERE is_canceled = 0 AND is_delayed = 1), 2) AS avg_delay_days
FROM shipments
GROUP BY order_year_month
ORDER BY order_year_month DESC;

-- 6.Is late delivery associated with lower order profitability



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

