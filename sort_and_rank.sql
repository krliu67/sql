
-- 并列要占位 当分数和上一次一样的时候取第一个分数的排名，当分数不一样的时候，取简单排名的名次。
SELECT t.user_id, t.miles, t.rank 
FROM
(SELECT u.user_id, u.miles, @rank := @rank + 1, 
@last_rank := CASE 
   WHEN @last_score = u.miles
     THEN @last_rank 
   WHEN @last_score := u.miles 
     THEN @rank 
  END AS rank    
FROM 
(SELECT user_id, sum(mile) miles FROM runner_daily_record WHERE date BETWEEN '2023-06-01' and '2023-06-30' GROUP BY user_id ORDER BY miles DESC) u, 
(SELECT @rank := 0, @last_score := NULL, @last_rank := 0) r
) t;


--  并列但不占位, 简单排名的基础上，多创建一个变量，用来记录上一个人的分数，然后通过比较来判断名次是否需要增加
-- SELECT u.user_id, u.miles,
--  CASE 
--    WHEN @last_score = u.miles
--      THEN @rank 
--    WHEN @last_score := u.miles 
--      THEN @rank := @rank + 1    
--   END AS rank    
-- FROM 
-- (SELECT user_id, sum(mile) miles FROM runner_daily_record WHERE date BETWEEN '2023-06-01' and '2023-06-30' GROUP BY user_id ORDER BY miles DESC) u, 
-- (SELECT @rank := 0, @last_score := NULL) r;

-- 简单的排名
-- select u.user_id, u.miles, @rank := @rank + 1 from (SELECT user_id, sum(mile) miles FROM runner_daily_record where runner_daily_record.date between '2023-06-01' and '2023-06-30' GROUP BY user_id ORDER BY miles desc) u, (SELECT @rank := 0) r;
