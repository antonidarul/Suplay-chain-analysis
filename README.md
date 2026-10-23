
# Supply Chain Delivery Performance & Operational Risk Analysis

Analyze delivery performance, identify patterns of delays based on delivery method, time, and region, and evaluate the relationship between delivery on-time performance and order profitability to help management prioritize operational improvements.

## Objectives of the Analysis

1. Measure delivery performance: Calculate the number of orders, late orders, on-time orders, the late delivery rate, and the average delay.
2. Identify high-risk areas: Compare performance across shipping modes, regions, markets, categories, and time periods.
3. Evaluate business performance: Examine whether late orders exhibit different profitability patterns compared to on-time orders.
4. Develop operational recommendations: Identify areas requiring further investigation and metrics that can be used to track improvements.


## Bussines Question 

1. How well is the suplay chain performing?.
2. which shipping mode have the highest late delivery rate ?.
3. Which regions have the worst delivery performance?.
4. How has delivery performance changed over time?.
5. Which product categories experience more delivery delays?.
6. is late delivery associated with lower order profitability?.
7. Which operational areas should be prioritized for investigation?.

## WORKFLOW END TO END: SQL + PYTHON + POWER BI 
1. Business Understanding & Data Profiling.
2. Data Preparation
3. SQL Business Analysis.
4. Explporatory Data Analysis & Statistical Analysis. 
5. Dashboard Design.
6. Business Report.

# Insight & Recommendation

## Suplay Chain Performance
**Overall assesment**: Poor/High Risk 

According to the result the suplay chain is currently underperforming significantly due to severe fulfillment delays.
Out of 180.519 total order item (Across 65.752 transactions):
- Late delivery rate : 57.29%(98.977 items) delay.
- Delivery On-time : 40.88% (73.788 items) arrive on schedule.
- Canceled : 4.29% (7.754 items) canceled before delivery.
More than half of the delivered items fail to reach customers on time. This high failure rate directly impacts customer satisfaction, operational cost, and overall brand reputation

## Shipping Mode With Highest Late Delivery 
First class has the highest late delivery rate at a critical 100%, followed by second class as the second worst performer.
- First Class **(Worst)**: 100% items late delivery with average delay of 1 day.
- Second Class : 79.83% delay rate.
- Same Day & Standart Class: Performing relatively better. Both maintaining late delivery rate below 50% (Same Day 47.93%) and (Standart Class 39.77%)
The premium shipping option (First class & Second class) where customer usually expect the fastest delivery are experiencing  the worst operational bottlnecks

## Regional With The Worst Delivery

**1. Wosrt Based On Percentage Of Delays** 
- Central afrika recorded the highest rate of delay 60,04% with an average delay of 1 day.
- The order volume in this region is relatively small (only 556 items). although it accounts the highest percentage, its absolute impacts on overall operations is not as significants as that of regions with high order volumes.

**2. Worst Based On The Longest Delay Duration**
- Central asia holds the records for the longest average delay duration, at approximately  1.74 days. Late delivery rate 56,67%(with total order only 184 items)

**3. Region Most Severely Affected By The Problem In The Terms Of Volumes**
- Western europe is the most critical region for business , with a total of 10010 items ordered and an alarming late delivery rate of 58,40% with an average delay of 1.63 days 


Although the percentage in central asia is slightly higher , the issues in western europe have had the greatest negative impact on customer satisfaction on a massive scale, as they involve thousands of orders.

## Product Categories Experience More Delays
**1. Highest Late Delivery Rate**
- Golf Bags & Carts: Had the highest failure rate proportionally, at 68.85% (with 42 items delayed out of a total of 61 items).
- Lacrosse: Followed in second place with a delay rate of 62.61% (206 items delayed out of 343 items).
- Pet Supplies: Has a late delivery rate of 61.44% (290 late items out of 492).
- Cameras: The failure rate reached 61.21% (344 late items out of 592).

Although these categories account for the highest percentage of delay risk (over 60%), their physical demand volume is relatively small, so their absolute impact on overall warehouse capacity is not significant.

**2. Highest Delayed Volume & Business Impact**
- Cleats: This category accounted for the largest share of late items in operations, with 13,496 late items (a late rate of 57.40% of the total 24,551 items) and generated very high total sales and profit ($494.64K profit).
- Fishing: A massive operational burden with 9,516 late items (a late rate of 57.34% of the total 17,325 items) and profit reaching $756.22K.
- Women’s Apparel: Recorded 11,476 late items (a delay rate of 57.05% of the total 21,035 items) with a profit of $350.42K.
- Men’s Footwear & Camping & Hiking: Each category recorded more than 12,121 and 7,487 late items, respectively, with profit values of $311.90K and $427.46K, respectively.

Categories such as Golf Bags & Carts do indeed show the highest percentage of delays (68.85%), but in absolute terms, the number is small (only 42 delayed items). In contrast, massive categories such as Cleats, Fishing, Women’s Apparel, and Men’s Footwear account for tens of thousands of delayed items. Therefore, efforts to improve daily logistics operations and warehouse management must prioritize these high-volume categories, as they account for the majority of supply chain bottlenecks and have a massive impact on customer satisfaction.
## Overtime Delivery
- **Consistently Delay Rate** : The delivery delay rate fluctuated within high range of 55% to 59% throughout  2015-2017. Delivery performance hits its worst point in june 2016 (59.3%) and achieved its best imporovement in july 2016 (55.1%)
- **Stabel Delayed Product Volume** : In terms of physical item quantity, the volume of delayed products remained remarkably stabel at 2.600 to 3.000 items per month or roughly 1.500 to 2.000 delayed orders per month from 2015 through mid 2017 

## Is late delivery associated with lower order profitability?
### Statistical Analysis

Python EDA compared profit distributions between late and non-late items.

### Hypotheses

- **Null hypothesis (\(H_0\)):** There is no statistically significant difference between the profit distributions of late and non-late items.
- **Alternative hypothesis (\(H_1\)):** The profit distributions differ between late and non-late items.

| Profit Metric | Late Items | Non-Late Items |
|---|---:|---:|
| Mean profit per item | 21.62 | 22.58 |
| Median profit per item | 31.43 | 31.68 |

The Mann–Whitney U test returned a **p-value of 0.155373**.

At the 5% significance level, the result does not provide sufficient evidence to reject the null hypothesis.

Late items have slightly lower mean and median profit in the observed data, but the statistical test does not establish a significant difference in the overall profit distributions. This finding should not be interpreted as proof that delivery delays have no financial consequences.

SQL also reported average profit per order of 64.35 for late deliveries and 64.78 for non-late deliveries. These figures use a different reported aggregation level from the Python item-level analysis and should not be directly compared until the metric definitions and populations are aligned.

---

## 7. Which operational areas should be prioritized for investigation?

The combined SQL and Python findings identify several areas that warrant operational investigation.

| Priority Area | Evidence | Business Implication |
| --- | --- | --- |
| First Class reliability | 100% reported delay rate | Investigate delivery commitments, scheduling, and delay calculations |
| Second Class delay duration | 79.83% reported delay rate and high average delay duration | Investigate factors associated with longer delivery delays in second-tier channels |
| Standard Class order volume | 39,324 order items and 39.85% reported delay rate | Evaluate the operational impact of delays across a large volume |
| Central Africa | 60.04% reported delay rate | Investigate regional delivery performance and delay severity |
| Central Asia | Highest average delay of 1.74 days | Investigate long transit times and regional distribution bottlenecks |
| Western Europe | 58.40% reported delay rate and 10,010 reported orders | Assess the volume of orders exposed to delivery delays |
| High-volume product categories | Cleats (7,206 delayed items) and Camping & Hiking (6,670 delayed items) | Optimize inventory placement and dispatch workflows for top revenue-generating categories |
| Niche product categories | Strength Training (71.43%) and Lacrosse (66.67%) delay rates | Investigate potential overlap between delivery risk and operational constraints |
| Historical data consistency | Dataset volume dropped significantly beginning in October 2017 | Validate data comparability before evaluating historical trends |

## Recommendation 
### 1. Complete Overhaul of Expedited Shipping Services

* **First Class SLA Audit:** Given that **First Class exhibits a 100% delay rate**, conduct an immediate audit and re-evaluation of logistics partners for this shipping option. Temporarily suspend unrealistic delivery promises on the platform until operational issues are resolved.
* **Second Class Restructuring:** Evaluate the root causes behind long delay durations in Second Class (79.83% delay rate). Renegotiate Service Level Agreements (SLAs) with carriers or reallocate order volume to more reliable logistics providers.

---

### 2. Impact-Driven Resource Allocation

* **Focus on Core High-Volume Categories:** Allocate supply chain optimization and inventory management efforts toward categories generating the highest volume of delayed items—specifically **Cleats** (~7,206 delayed items) and **Camping & Hiking** (~6,670 delayed items). Improvements here will directly enhance overall customer satisfaction and safeguard core revenues.
* **Operational Priority in Western Europe:** Prioritize operational support and budget allocation for Western Europe, as it accounts for the largest order exposure (10,010 items) alongside a high delay rate of 58.40%.

---

### 3. Targeted Regional Logistics Solutions

* **Regional Logistics Optimization (Central Africa & Central Asia):** For regions experiencing the highest failure rates, such as **Central Africa (60.04% delay rate)**, and those with the longest delay durations, such as **Central Asia (1.74 days average delay)**, review customs clearance procedures, transit routes, and local courier reliability.

---

### 4. Safeguarding Long-Term Customer Lifetime Value

* **Mitigating Hidden Downstream Costs:** Statistical hypothesis testing confirms that delivery delays do not significantly erode immediate unit profitability at point-of-sale ($p\text{-value} = 0.155$). However, proactive delay prevention remains essential to prevent **hidden downstream costs**, including return requests, customer service compensation vouchers, and long-term customer churn.

---

### 5. Data Governance & Integrity Monitoring

* **Investigate Q4 2017 Data Anomalies:** Perform a technical audit on the database regarding the sharp drop in reported monthly delayed items in late 2017 (falling from ~3,000 down to ~1,100 items/month). Verify whether this decline represents a genuine shift in order volume or a data logging/cutoff lag within the logistics pipeline.

## Conclusion

The analysis reveals that delivery timeliness is a critical operational bottleneck, with a reported overall late delivery rate of 57.29% across 180,519 order items. Delivery performance varies significantly across shipping modes, geographic regions, and product categories:
- Shipping Modes: First Class represents the most severe failure with a 100% delay rate, while Second Class exhibits a high delay rate of 79.83%. Although Standard Class has a lower delay rate (~39.85%), it accounts for the largest absolute volume of delayed items (39,324 items).
- Geographic & Product Exposure: Western Europe presents the largest order exposure with 10,010 items (58.40% delay rate), while Central Africa registers the highest regional failure rate (60.04%). In terms of product impact, high-volume revenue drivers like Cleats (~7,206 delayed items) and Camping & Hiking (~6,670 delayed items) account for the vast majority of physical delivery delays.
- Profitability Impact: A non-parametric Mann–Whitney U test ($p\text{-value} = 0.155$) indicates no statistically significant difference in profit distributions between delayed and on-time items. While immediate unit profit margins remain stable at the point of sale, delivery delays pose serious risks to long-term profitability through hidden downstream costs, such as customer churn and support overhead.