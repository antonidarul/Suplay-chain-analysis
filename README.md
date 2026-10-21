
# Supply Chain Delivery Performance & Operational Risk Analysis

Menganalisis performa pengiriman, mengidentifikasi pola keterlambatan berdasarkan metode pengiriman, waktu, dan wilayah, serta mengevaluasi hubungan antara ketepatan pengiriman dan profitabilitas order untuk membantu manajemen menentukan prioritas perbaikan operasional.

## Tujuan Analysis

1. Mengukur delivery performance: Menghitung jumlah order, order terlambat, order tepat waktu, late delivery rate, dan rata-rata keterlambatan.
2. Mengidentifikasi area berisiko: Membandingkan performa antar-shipping mode, wilayah, pasar, kategori, dan periode waktu.
3. Mengevaluasi performa bisnis: Memeriksa apakah order yang terlambat memiliki pola profitabilitas berbeda dibandingkan order yang tepat waktu.
4. Menyusun rekomendasi operasional: Menentukan area yang perlu diperiksa lebih lanjut dan metrik yang bisa dipakai untuk memantau perbaikan.

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
# Business Insights

## Overall Delivery Performance

- The reported overall delivery delay rate is **57.31%**, indicating that delivery delays are a major operational concern in the analyzed dataset.
- The high delay rate suggests that delivery reliability requires management attention rather than being treated as an isolated operational issue.
- However, the overall metric must be interpreted alongside its calculation method and denominator. The analysis contains differences in reported order and order-item counts that should be validated before the metric is used as an official performance benchmark.
- The available analysis does not establish whether performance meets the company's delivery commitments because no verified service-level target or benchmark has been provided.

## Shipping Mode Performance

- **First Class has a reported delay rate of 100%**, with an average delay of approximately 1 day. This makes it an immediate priority for investigation, although the delay calculation and underlying order population should be validated.
- **Second Class has the longest reported average delay at 4 days**, indicating a potential issue with delivery duration even though its overall delay rate requires further validation.
- Standard Class handles the largest reported volume, at **39,324 order items**, with a delay rate of **39.85%** and an average delay of approximately 2 days.
- Same Day has a reported average delay of approximately 1 day.
- These findings show that delivery reliability and delay severity are different dimensions of performance. A shipping mode can experience shorter delays but still have a high proportion of late deliveries.
- Standard Class deserves attention because of its high volume, while First Class and Second Class warrant investigation because of their reported reliability and delay-duration problems.

## Regional Delivery Performance

- Central Asia has the highest reported regional delay rate among the highlighted findings at **60.04%**, with an average delay of approximately **1.74 days**.
- Western Europe has a reported delay rate of **58.40%** and the highest reported regional volume, at approximately **10,010 orders**.
- Central Asia represents a potential severity concern because of its high delay rate and average delay duration.
- Western Europe represents a potential volume-related concern because delays may affect a large number of orders.
- These findings suggest that regional performance should be evaluated using both delay rate and affected-order volume. However, the current analysis does not establish the underlying causes of regional differences.

## Delivery Performance Over Time

- Monthly delay rates fluctuate between approximately **54% and 60%**, indicating that delivery delays recur throughout much of the observed period.
- June 2016 recorded a reported monthly delay rate of approximately **58.86%**.
- Monthly average delay duration remained relatively stable at approximately **1.56–1.65 days**.
- Python EDA identified a substantial change in dataset structure beginning in **October 2017**, including changes in order-item patterns and market composition.
- The recurring delay rates suggest that the issue is not limited to a single month. However, the apparent stability of the trend does not necessarily prove that operational performance was stable because changes in data coverage or granularity may affect comparisons.
- Historical trend comparisons after September 2017 should therefore be validated before drawing conclusions about operational improvement or deterioration.

## Product Subcategory Risk

- Lacrosse and Tennis & Racquet have reported delivery delay rates of approximately **65–66%**, higher than the reported overall delay rate of 57.31%.
- Both subcategories also have a reported loss-making order ratio above **10%**.
- The combination of elevated delay rates and loss-making orders makes these subcategories candidates for further investigation.
- However, the available analysis does not establish that delivery delays cause financial losses. The relationship may also be influenced by product costs, discounts, order characteristics, shipping mode, or regional factors.
- Further analysis should compare delay rates, affected-order volumes, and profitability across subcategories to determine which areas warrant the greatest operational attention.

## Statistical Analysis

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

**Methodological limitation:** The analysis should verify the independence assumptions of the statistical comparison because multiple items may belong to the same order. The current results are exploratory and do not establish a causal relationship between delivery delays and profitability.

## Delivery Risk and Operational Priorities

The combined SQL and Python findings identify several areas that warrant operational investigation.

| Priority Area | Evidence | Business Implication |
|---|---|---|
| First Class reliability | 100% reported delay rate | Investigate delivery commitments, scheduling, and delay calculations |
| Second Class delay duration | Highest reported average delay of 4 days | Investigate factors associated with longer delivery delays |
| Standard Class order volume | 39,324 order items and 39.85% reported delay rate | Evaluate the operational impact of delays across a large volume |
| Central Asia | 60.04% reported delay rate | Investigate regional delivery performance and delay severity |
| Western Europe | 58.40% reported delay rate and 10,010 reported orders | Assess the volume of orders exposed to delivery delays |
| Product subcategories | Lacrosse and Tennis & Racquet at approximately 65–66% delay rates | Investigate potential overlap between delivery risk and loss-making orders |
| Historical data consistency | Dataset structure changed beginning in October 2017 | Validate data comparability before evaluating historical trends |

### Operational Prioritization

The findings support prioritizing investigations according to both **delay severity and the number of affected orders**.

First Class should be investigated because of its reported 100% delay rate. Second Class warrants attention because of its longer average delay duration. Standard Class should also remain a priority because its high order-item volume may expose a substantial number of orders to delays despite its lower reported delay rate.

Regional analysis should then examine Central Asia and Western Europe, followed by product-level investigation of Lacrosse and Tennis & Racquet.

These are investigation priorities, not confirmed root causes. The current dataset does not contain enough operational detail to determine whether delays originate from warehouse processing, inventory availability, carrier handoffs, route conditions, delivery commitments, or other factors.

## Data Limitations and Next Steps

- **Metric consistency:** Reported order and order-item counts are inconsistent across the available summaries. Validate the data grain, distinct order counts, and delay-rate denominator before publishing final KPIs.
- **Delivery definitions:** Confirm the definition of late delivery and ensure that delay rate and average delay duration use consistent populations and calculations.
- **Historical comparability:** Investigate the change in dataset structure beginning in October 2017 before comparing performance across the entire period.
- **Profitability interpretation:** Align SQL and Python aggregation levels and validate the statistical assumptions before drawing stronger conclusions about the relationship between delays and profit.
- **Root-cause limitations:** The available findings identify patterns but do not prove why delays occur. More detailed carrier, warehouse, route, inventory, fulfillment-time, and delay-reason data would support deeper investigation.
- **Historical scope:** The analysis describes patterns in the available historical dataset. It should not be presented as evidence of current supply chain performance.

## Recommendations

1. **Validate the delivery performance KPIs.** Confirm order counts, order-item grain, delay definitions, and denominators before using the overall delay rate as an official benchmark.
2. **Investigate First Class reliability.** Review its delivery commitments, scheduling, and actual delivery records to understand why the reported delay rate reaches 100%.
3. **Investigate Second Class delay duration.** Examine the processes and operational conditions associated with its reported average delay of 4 days.
4. **Prioritize Standard Class by volume.** Evaluate the operational impact of delays across its 39,324 reported order items rather than focusing exclusively on the highest delay rate.
5. **Examine regional differences.** Investigate Central Asia for its elevated delay rate and Western Europe for its combination of high reported volume and elevated delay rate. Compare shipping-mode performance within each region.
6. **Investigate high-risk product subcategories.** Examine Lacrosse and Tennis & Racquet to determine whether their elevated delay rates are concentrated in particular regions, shipping modes, or order characteristics.
7. **Avoid unsupported profitability claims.** The current statistical test does not establish a significant difference in overall profit distributions between late and non-late items. Validate the metrics and investigate specific segments before attributing financial outcomes to delays.
8. **Improve operational data collection.** Collect more detailed information about carriers, warehouses, routes, inventory availability, fulfillment stages, and recorded delay reasons to support root-cause analysis.

## Conclusion

The analysis indicates that **delivery timeliness is a major operational concern**, with a reported overall delay rate of 57.31%. Delivery performance varies across shipping modes and regions, while selected product subcategories show elevated delay rates that warrant further investigation.

First Class and Second Class are important investigation targets because of their reported delay patterns. Standard Class also requires attention because of its large order-item volume. Central Asia, Western Europe, Lacrosse, and Tennis & Racquet represent additional areas for focused analysis.

The profitability analysis shows slightly lower mean and median profit for late items, but the statistical test does not provide sufficient evidence of a significant difference in overall profit distributions. Consequently, the current findings do not establish that delays cause lower profitability.

**Overall recommendation:** Validate the delivery performance metrics, investigate high-risk shipping modes and regions, examine affected product subcategories, and improve operational data collection before making final decisions about root causes or financial impact.

These findings provide a foundation for monitoring delivery performance, identifying operational risks, and directing further investigation. They should be treated as evidence of historical patterns rather than a definitive assessment of current supply chain performance.