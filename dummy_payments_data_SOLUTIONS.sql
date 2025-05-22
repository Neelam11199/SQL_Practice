WITH monthly_revenue AS(    -- Using CTE
	SELECT 
    DATE_FORMAT(Payment_date, '%Y-%m')AS month,
    ROUND(sum(amount_paid),2) AS Total_revenue
    FROM `dummy_payments_data`
    GROUP BY DATE_FORMAT(Payment_date, '%Y-%m')),
GROWTH_CALC AS(
	SELECT 
    MONTH,
    Total_revenue,
    ROUND(LAG(Total_revenue) OVER (ORDER BY MONTH),2) AS Previous_month_revenue
    FROM monthly_revenue)
SELECT 
	month,
    Total_revenue,
    Previous_month_revenue,
    ROUND(
		(Total_revenue - previous_month_revenue)/previous_month_revenue*100,2) AS Revenue_growth_pct
        FROM GROWTH_CALC;
        
    