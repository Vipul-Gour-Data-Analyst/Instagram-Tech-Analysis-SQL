use gdb0120 ;
Select *from dim_dates;
select *from fact_account;
Select *from fact_content ;

-- Instagram Analysis: SQL
 
-- 1. How many unique post types are found in the 'fact_content' table? 

Select distinct post_type from fact_content ;

-- 2. What are the highest and lowest recorded impressions for each post type? 

Select post_type,
	max(impressions) as Highest_Impression ,
	min(impressions) as Lowest_Impression from fact_content
group by post_type 
order by post_type ; 

-- 3. Filter all the posts that were published on a weekend in the month of March and April and export them to a separate csv file. 

select *from fact_content f 
inner join dim_dates d on 
f.date=d.date where d.weekday_or_weekend='weekend' and month(f.date) in (3,4); 

-- 4. Create a report to get the statistics for the account. The final output includes the following fields: 
-- • month_name 
-- • total_profile_visits 
-- • total_new_followers 

Select monthname(d.date) as Month_Name, 
	sum(profile_visits) as Profile_Visit,
	sum(new_followers) as New_Followers  
from fact_account f 
inner join dim_dates d 
on f.date=d.date 
group by monthname(d.date);

-- 5. Write a CTE that calculates the total number of 'likes’ for each 'post_category' during the month of 'July' and subsequently, arrange the 'post_category' values in descending order according to their total likes. 

With like_cte as 
(
	Select 
f.post_category,sum(f.likes) as 'Total_Likes' 
from fact_content f
	inner join dim_dates d 
	on f.date=d.date
    where month(d.date)=7
    group by f.post_category
    )
    
    Select post_category,
    Total_Likes from like_cte 
    order by Total_Likes desc ;

-- 6. Create a report that displays the unique post_category names alongside their respective counts for each month. The output should have three columns:  
-- • month_name 
-- • post_category_names  
-- • post_category_count 

-- Example:  
-- • 'April', 'Earphone,Laptop,Mobile,Other Gadgets,Smartwatch', '5' 
-- • 'February', 'Earphone,Laptop,Mobile,Smartwatch', '4' 

Select monthname(d.date) as Month_Name ,
group_concat(
distinct f.post_category
order by f.post_category 
SEPARATOR   ',') AS Post_Category_Names,
count(Distinct f.post_category) as Post_Category_Count
from fact_content f 
inner join dim_dates d 
on f.date=d.date 
group by monthname(d.date) 
order by Post_Category_Count desc ;

-- 7. What is the percentage breakdown of total reach by post type?  The final output includes the following fields: 
-- • post_type 
-- • total_reach 
-- • reach_percentage 

Select post_type,
sum(reach) as 'Total_Reach',
Round(
(sum(reach)*100)
/(select sum(reach) from fact_content),2) as 'Reach_Percentage'
from fact_content 
group by post_type 
order by Reach_Percentage desc ;

-- 8. Create a report that includes the quarter, total comments, and total saves recorded for each post category. Assign the following quarter groupings: 
-- (January, February, March) → “Q1” 
-- (April, May, June) → “Q2” 
-- (July, August, September) → “Q3” 
-- The final output columns should consist of: 
-- • post_category 
-- • quarter 
-- • total_comments 
-- • total_saves 

Select post_category,
	case
		when month(d.date) IN (1,2,3) then 'Q1'
        when month(d.date) IN (4,5,6) then 'Q2'
        when month(d.date) IN (7,8,9) then 'Q3' 
	End as 'Quart',
sum(comments) as 'Total_Comments',
sum(saves) as 'Total_Saves'
from fact_content f 
inner join dim_dates d on f.date=d.date 
where month(d.date) BETWEEN 1 AND 9
group by 
post_category,
	case
		when month(d.date) IN (1,2,3) then 'Q1'
        when month(d.date) IN (4,5,6) then 'Q2'
        when month(d.date) IN (7,8,9) then 'Q3' 
	End 
order by 
f.post_category,
Quart;
	
-- 9. List the top three dates in each month with the highest number of new followers. The final output should include the following columns: 
-- • month 
-- • date 
-- • new_followers 

With Follower_Gain as (
Select  monthname(d.date) as 'Month_Name',d.date, 
sum(new_followers) as 'New_Followers' from fact_account f 
inner join dim_dates d on f.date=d.date 
group by d.date ,monthname(d.date)
order by New_Followers desc
),
Ranked As (
Select Month_Name,date,New_Followers,
Rank() Over(partition by Month_Name order by New_Followers desc) as 'Ranking' from Follower_Gain 
)

Select Month_Name,date,New_Followers
from Ranked where Ranking<=3
order by MONTH(date),New_Followers desc,date;


-- Create a stored procedure that takes the 'Week_no' as input and generates a report displaying the total shares for each 'Post_type'. The output of the procedure should consist of two columns: 
-- post_type 
-- total_shares 

-- Calling The Stored Procedure
/*-- Stored Procedure Query
SELECT 
        post_type,
        SUM(shares) AS total_shares
    FROM fact_content F
    inner join dim_dates D on F.date=D.date
	WHERE D.week_no = p_week_no
    GROUP BY post_type
    ORDER BY total_shares DESC;
*/

call gdb0120.Get_Shares_By_Post_Type('W1');
call gdb0120.Get_Shares_By_Post_Type('W2');
