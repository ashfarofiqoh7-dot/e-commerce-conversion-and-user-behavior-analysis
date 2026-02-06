# e-commerce-conversion-and-user-behavior-analysis
end to end data analysis project focusing on conversion funnels, user behavior segmentation, and UX optimization. Leveraging PostgreSQL for data transformation and Power BI (DAX) for dynamic visualization.

## 📌 Business Overview
This project analyzes a customer journey dataset to identify why users drop off before completing a purchase. By analyzing over **12,720 rows of customer journey logs and 1,800 unique users**, I discovered critical UX friction points and segmented users to provide targeted business recommendations.

## 🛠️ Tech Stack
- **PostgreSQL:** Data profiling, cleaning, and feature engineering (creating business logic views).
- **Power BI:** Interactive dashboarding with complex funnel visualization.
- **DAX:** Dynamic measures for real-time KPI tracking (Bounce Rate, Retention, etc.).

## 📊 Project Workflow
1. **Data Profiling:** Investigating nulls, anomalies, and data distributions.
2. **Data Transformation (SQL):** Segmenting users into "Bargain Hunters", "Decisive Buyers", etc.
3. **Data Analysis (EDA):** Identifying that **77% of users** exit the homepage due to navigation friction.
4. **DAX Implementation:** Creating dynamic measures to ensure the dashboard reflects accurate unique user counts and bounce rates.

## 🧮 Key DAX Measures
- **Total Users:** `DISTINCTCOUNT(UserID)`
- **Bounce Rate:** `DIVIDE([Bounce Users], [Total Users], 0)`
- **Retention Rate:** Monitoring the % of users moving from 'Home' to 'Confirmation'.

## 💡 Top Recommendations
- **Fix Homepage Leakage:** Simplify navigation to reduce the 77% bounce rate.
- **Incentivize Bargain Hunters:** Use exit-intent pop-ups for the 44% user segment.
- **Optimize Product Pages:** Improve social proof to fix the high drop-off at the "Add to Cart" stage.

## 🖼️ Dashboard Preview
![Overview Dashboard](Dashboard_Screenshots/E-commerce_Conersion_and_user_behavior_insight_page_1.png)
![Pattern Risk Analysis](Dashboard_Screenshots/E-commerce_Conersion_and_user_behavior_insight_page_2.png)
