# restaurant_sales_analysis
# A Pizza Restaurant Sales Data Analysis

In this personal project, I utilized a fictitious pizza place sales data. The data contains 

*Dataset Link: https://www.mavenanalytics.io/data-playground?search=pizza

There were four (.csv) files. The following table is the dataset description:

![image](https://github.com/Su-Jung-Choi/restaurant_sales_analysis/assets/88897881/674a5b73-8812-462e-9bad-5b0f6ac620bf)


To leverage the project files effectively, I created SQL views by joining common attributes across the four files. First, "OrderDetailsView" combines information from the "orders" and "order_details" tables, "PizzaDetailsView" combines data from the "pizzas" and "pizza_types" tables, and finally, "JoinedOrderView" is formed by joining the previous two views based on the common attribute "pizza_id." 

![image](https://github.com/Su-Jung-Choi/restaurant_sales_analysis/assets/88897881/4f4032e5-cddf-4e53-9452-e306ae6326ab)
