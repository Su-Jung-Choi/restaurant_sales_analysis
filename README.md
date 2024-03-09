# 🍕 A Pizza Restaurant Sales Data Analysis

In this personal project, I conducted an analysis on a fictitious pizza place sales data using MySQL. The dataset contains a year's pizza sales (2015-01-01 to 2015-12-31) and consists of four (.csv) files.

🌼 Dataset Link: [Maven Analytics](https://www.mavenanalytics.io/data-playground?search=pizza)

## 📚 Dataset Description:

![image](https://github.com/Su-Jung-Choi/restaurant_sales_analysis/assets/88897881/f0b69bdc-5933-4751-8f74-f5ee1c47f467)



**The main objective of the analysis was to identify peak hours of the day, peak days of the week, and any seasonality (monthly trends) in sales. Additionally, I aimed to find the most-sold pizzas and least-sold pizzas.**

Below is a brief overview of the steps I took to conduct this analysis, along with some outputs.

### 1. Data Preparation:
   Created SQL views by joining common attributes across the four files: "OrderDetailsView" (by joining the "orders" and "order_details"), "PizzaDetailsView" (by joining the "pizzas" and "pizza_types"), "JoinedOrderView" (by joining the previous two views based on the common attribute "pizza_id") 

### 2. Peak Hours of the Day:
   Extracted the hour from the 'time' column and counted pizza orders. The following is the result of the query, indicating that 12 - 1 p.m. is the peak hours for this pizza place:

![image](https://github.com/Su-Jung-Choi/restaurant_sales_analysis/assets/88897881/4f4032e5-cddf-4e53-9452-e306ae6326ab)

### 3. The busiest day of the week:
   Used `DATE_FORMAT` to extract the abbreviated day of the week from the 'date' column, then counted the number of pizza orders. The following is the result of the query, revealing that Friday and Saturday were the peak days, while Sunday was the slowest day of the week:
   
![image](https://github.com/Su-Jung-Choi/restaurant_sales_analysis/assets/88897881/18996d03-0d2f-4e71-b98d-9cc182b103af)

### 4. Bestseller pizzas:
   Grouped pizzas by name, counted the number of pizzas sold for each type, ordered in descending order, and limited to the top 5. This process identified the top 5 popular pizzas out of 32 different types available. The following result shows the top five pizzas:
   
![image](https://github.com/Su-Jung-Choi/restaurant_sales_analysis/assets/88897881/229b9c9d-304a-4b50-9161-811e77a39ef0)

### 5. Total Sales for 2015:
   Extracted the year from the 'date' column, used SUM for price, and grouped by year. The following is the result:
   
![image](https://github.com/Su-Jung-Choi/restaurant_sales_analysis/assets/88897881/fc39a254-6f2b-43ed-acdb-0eeec1282a60)

> [!NOTE]
> For detailed data exploration and results, refer to the **"pizza_sales_project.sql"** file. \
> I also created a dashboard using **Tableau**, including the key findings from this data analysis. \
> To view and interact with the Tableau dashboard, visit [here](https://public.tableau.com/views/pizza_sales_17100051216020/Dashboard2?:language=en-US&publish=yes&:sid=&:display_count=n&:origin=viz_share_link)
