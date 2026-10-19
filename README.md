Project overview dan business problem.
Dataset dan data dictionary.
Tools dan workflow.
Business questions dan definisi KPI.
Hasil analisis yang benar-benar kamu temukan.
Screenshot dashboard.
Business recommendations.
Limitations dan langkah untuk mereproduksi project.



## PROJECT STATEMENT

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

1. Total Orders

Jumlah order unik, bukan jumlah baris dataset.
\[
\text{Total Orders}=\text{COUNT DISTINCT(Order ID)}
\]



2. Late Delivery Rate

Persentase order valid yang mengalami keterlambatan.
\[
\frac{\text{Late Orders}}{\text{Eligible Orders}}\times100\%
\]

Definisi order yang masuk denominator harus konsisten. Misalnya, order yang dibatalkan perlu diperlakukan sesuai aturan analisis yang ditetapkan.


3. On-Time Delivery Rate

Persentase order yang memenuhi jadwal pengiriman.
\[
\frac{\text{On-Time Orders}}{\text{Eligible Orders}}\times100\%
\]



4. Average Delay Days

Rata-rata jumlah hari keterlambatan pada order yang terlambat.
\[
\operatorname{AVG}(\text{Actual Days}-\text{Scheduled Days})
\]

Hanya hitung order yang memang terlambat, jika tujuan metriknya adalah mengukur tingkat keparahan keterlambatan.


5. Profit per Order

Total profit pada tingkat order dibagi jumlah order yang relevan, setelah memastikan definisi profit dan grain data sudah benar.

## WORKFLOW END TO END: SQL + PYTHON + POWER BI 
1. Business Understanding & Data Profiling.
2. Data Preparation
3. SQL Business Analysis.
4. Explporatory Data Analysis & Statistical Analysis. 
5. Dashboard Design.
6. Business Report.

## Dashboard 

### Page 1 : Executive Overview
Question : How well is our suplay chain performing?
Kpi card : Total Order, Late Delivery Rate, On-Time Orders, Average Delay Days. 
Visual : Trend delivery performance bulanan dan perbandingan shipping mode.
Slicer : Order Date , Market , Shipping Mode 
### Page 2 : Delivery Performance Analysis
Question : Where and under what conditions are delays concentrated?
Contain :
- Late delivery rate per region dan Shipping mode
- Tren keterlambatan bulanan 
- Perbandingan kategori product 
- Tabel area dengan volume order tinggi dan late rate tinggi 
Slicer : Market , Region , Shipping mode , Category
### Page 3 : Profitability & Operational Impact
Question : How does delivery performance relate to bussines profitability 
Contain : 
- Sales dan profit menurut status pengiriman 
- Profitabilitas order terlambat dibandingkan order tepat waktu 
- Profit per order menurut shipping mode 
- Kategori atau wilayah yang perlu diinvestigasi lebih lanjut 
Slicer : Order Date, Market, shipping Mode, Category

Visual di atas merupakan referensi gaya, bukan dashboard hasil analisis datasetmu. Jumlah dan jenis visual final ditentukan setelah hasil EDA diketahui.

