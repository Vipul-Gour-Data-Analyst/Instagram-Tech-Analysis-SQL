<<<<<<< HEAD
# 📊 Instagram Tech Analysis — SQL Project

## 📌 Project Overview

This project analyzes Instagram-style user, post, comment, like, follower, and engagement data using **SQL**.

The goal is to answer practical business and product questions such as:

- Who are the most active users?
- Which posts receive the highest engagement?
- Which users have the most followers?
- What content generates the most likes and comments?
- Which users are inactive?
- What are the overall engagement patterns?

This project demonstrates how SQL can be used to transform raw relational data into meaningful business insights.

---

## 🎯 Project Objectives

- Analyze Instagram user activity and engagement.
- Identify top-performing posts and users.
- Understand follower and interaction patterns.
- Find inactive or less-engaged users.
- Practice advanced SQL concepts used in real-world data analysis.
- Build interview-ready SQL problem-solving skills.

---

## 🗂️ Data Model

The analysis can be performed using tables such as:

| Table | Description |
|---|---|
| `users` | Stores Instagram user information |
| `photos` | Stores posts/photos uploaded by users |
| `likes` | Stores likes given by users |
| `comments` | Stores comments made on posts |
| `follows` | Stores follower/following relationships |
| `tags` | Stores hashtag information |
| `photo_tags` | Connects posts with hashtags |

### 🔗 Basic Relationships

```text
USERS
 ├── PHOTOS
 │    ├── LIKES
 │    ├── COMMENTS
 │    └── PHOTO_TAGS ── TAGS
 │
 └── FOLLOWS
```

---

## 🧠 SQL Concepts Used

This project focuses on practical SQL techniques, including:

- `SELECT`
- `WHERE`
- `ORDER BY`
- `GROUP BY`
- `HAVING`
- `DISTINCT`
- `INNER JOIN`
- `LEFT JOIN`
- Multiple-table joins
- Aggregate functions
  - `COUNT()`
  - `SUM()`
  - `AVG()`
  - `MAX()`
  - `MIN()`
- Subqueries
- Common Table Expressions (CTEs)
- Window functions
- `CASE WHEN`
- Date and time functions
- Ranking functions
- Conditional aggregation

---

## 🔍 Business Questions

### 👤 User Analysis

1. Find the total number of Instagram users.
2. Identify the most active users.
3. Find users who have never uploaded a post.
4. Find users who have never liked a post.
5. Identify users with the highest number of followers.
6. Find users who joined the platform during a specific period.

### 📸 Post Analysis

7. Find the most liked posts.
8. Find the most commented posts.
9. Identify users who uploaded the most posts.
10. Find posts with zero likes.
11. Calculate the average number of likes per post.
12. Find the top-performing posts based on engagement.

### ❤️ Engagement Analysis

13. Calculate total likes received by each user.
14. Calculate total comments received by each user.
15. Compare likes and comments for posts.
16. Calculate an engagement score for each post.
17. Rank users based on total engagement.

### #️⃣ Hashtag Analysis

18. Find the most frequently used hashtags.
19. Identify hashtags associated with the highest engagement.
20. Find users using specific hashtags.

### 👥 Follower Analysis

21. Find users with the highest follower count.
22. Identify mutual following relationships.
23. Find users who follow many accounts but have few followers.
24. Analyze follower/following activity.

---

## 📈 Example Analysis

### Top Posts by Likes

```sql
SELECT
    p.id AS post_id,
    p.user_id,
    COUNT(l.user_id) AS total_likes
FROM photos p
LEFT JOIN likes l
    ON p.id = l.photo_id
GROUP BY p.id, p.user_id
ORDER BY total_likes DESC;
```

### Users With No Posts

```sql
SELECT
    u.id,
    u.username
FROM users u
LEFT JOIN photos p
    ON u.id = p.user_id
WHERE p.id IS NULL;
```

### Rank Users by Engagement

```sql
WITH user_engagement AS (
    SELECT
        u.id,
        u.username,
        COUNT(DISTINCT l.photo_id) AS liked_posts,
        COUNT(DISTINCT c.id) AS comments_made
    FROM users u
    LEFT JOIN likes l
        ON u.id = l.user_id
    LEFT JOIN comments c
        ON u.id = c.user_id
    GROUP BY u.id, u.username
)
SELECT
    *,
    RANK() OVER (
        ORDER BY liked_posts + comments_made DESC
    ) AS engagement_rank
FROM user_engagement;
```

---

## 🛠️ Tools & Technologies

- **SQL**
- **MySQL 8.0+**
- GitHub
- Relational Database Concepts
- Data Analysis

---

## 🚀 How to Run the Project

### 1. Clone the repository

```bash
git clone YOUR_GITHUB_REPOSITORY_URL
```

### 2. Open MySQL

Use MySQL Workbench, MySQL CLI, or another compatible SQL client.

### 3. Create the database

```sql
CREATE DATABASE instagram_analysis;
USE instagram_analysis;
```

### 4. Import the dataset

Run the provided database/schema SQL file.

### 5. Execute the analysis queries

Open the SQL analysis file and execute the queries question by question.

---

## 📁 Suggested Repository Structure

```text
Instagram-Tech-Analysis-SQL/
│
├── database/
│   └── instagram_schema.sql
│
├── Business Requirments
│   └── SQL Question PDF
│
├── SQL Queries
│   └── Queries Results
│
├── SQL Queries
|   └── SQL Queries Solution
├── Presentation
|   └── Tech Instagram Presentation
|   └── Tech Instagram Presentation PDF
|   └── Tech Instagram Vedio Presentation
└── Readme

```

---

## 💡 Key Learning Outcomes

Through this project, I practiced:

- Writing SQL queries for real-world business problems.
- Joining multiple relational tables.
- Performing user and content-level analysis.
- Using aggregation to measure engagement.
- Applying CTEs and window functions.
- Converting raw database records into actionable insights.
- Structuring SQL projects for GitHub portfolios.

---

## 📌 Project Highlights

**Project Type:** SQL Case Study  
**Domain:** Social Media / Technology  
**Database:** MySQL  
**Focus:** User Activity, Content Performance & Engagement Analysis

---

## 👨‍💻 Author

**Vipul Gour**

---

## ⭐ If You Find This Project Useful

If this project helped you learn SQL or inspired your own analysis, consider giving the repository a ⭐ on GitHub.

---

## 📜 License

This project is created for educational, learning, and portfolio purposes.
=======
# Instagram-Influencer-Analysis-SQL
>>>>>>> b7b74cebc12c13e8e98a31763c1966c0098b1ace
