select
  event_type,
  count(*)
from
  events
group by
  event_type;

select
  *
from
  events
where
  event_type = 'signup_flow';

select
  *
from
  events;

select
  occurred_at,
  week(occurred_at),
  weekofyear(occurred_at)
from
  events;

with
  weekly_engagement as (
    select
      week(occurred_at) week,
      count(*) engagement
    from
      events
    where
      event_type = 'engagement'
      and week(occurred_at) between 18 and 34
    group by
      week(occurred_at)
  )
select
  avg(engagement) avg_weekly_engagement
from
  weekly_engagement;

#########################################
# Weekly user engagement
SELECT
  FLOOR(DATEDIFF(occurred_at, '2012-12-30') / 7) AS week, # assigning unique week number, week starts from Monday
  COUNT(DISTINCT user_id) AS weekly_active_users
FROM
  events
WHERE
  event_type = 'engagement'
GROUP BY
  FLOOR(DATEDIFF(occurred_at, '2012-12-30') / 7)
ORDER BY
  week;
  
SELECT
	DAYNAME(occurred_at) AS weekday,
  WEEKDAY(occurred_at) AS num_weekday,
  COUNT(DISTINCT user_id) AS active_users
FROM
	events
WHERE
	event_type = 'engagement'
GROUP BY
	DAYNAME(occurred_at),
  WEEKDAY(occurred_at)
ORDER BY
	2;

###########################################
select
  state,
  count(*)
from
  users
group by
  state;

###################################################
# Weekly User Growth
WITH
  new_weekly_users AS (
    SELECT
      FLOOR(DATEDIFF(created_at, '2012-12-30') / 7) AS week,
      COUNT(DISTINCT user_id) AS weekly_new_users,
      COUNT(DISTINCT user_id) - LAG(COUNT(DISTINCT user_id)) OVER (
        ORDER BY
          FLOOR(DATEDIFF(created_at, '2012-12-30') / 7)
      ) AS weekly_incremental_new_users
    FROM
      users
    GROUP BY
      FLOOR(DATEDIFF(created_at, '2012-12-30') / 7)
  )
SELECT
  week,
  weekly_new_users,
  weekly_incremental_new_users,
  SUM(weekly_new_users) over (
    ORDER BY
      week ROWS BETWEEN UNBOUNDED PRECEDING
      AND CURRENT ROW
  ) AS cumulative_users
FROM
  new_weekly_users
ORDER BY
  week;

########################################################################
select
  weekofyear('2013-01-01');

select
  *
from
  events
order by
  user_id,
  occurred_at;

select
  user_id,
  created_at,
  activated_at
from
  users
where
  activated_at < created_at + interval 4 minute;

 # all users activated within 4 minutes of account creation
drop view
  signup_login_engagement;

select distinct
  yearweek(occurred_at) engagement_week,
  user_id
from
  events
order by
  2;

WITH RECURSIVE
  week_numbers AS (
    SELECT
      1 AS week_num
    UNION ALL
    SELECT
      week_num + 1
    FROM
      week_numbers
    WHERE
      week_num <= (
        SELECT
          MAX(weeks_after_signup)
        from
          signup_engagement
      )
  )
select
  week_num
from
  week_numbers;

SET
  @ref_day = '2012-12-30';

SELECT
  DAYNAME(@ref_day);

SELECT
  FLOOR(DATEDIFF(activated_at, '2012-12-30') / 7) AS week,
  count(user_id)
from
  users
group by
  FLOOR(DATEDIFF(activated_at, '2012-12-30') / 7);

select
  *
from
  users
order by
  activated_at;

select
  week('2013-01-01');

select
  *
from
  signup_engagement;

WITH RECURSIVE
  week_numbers AS (
    SELECT
      0 AS week_num
    UNION ALL
    SELECT
      week_num + 1
    FROM
      week_numbers
    WHERE
      week_num <= (
        SELECT
          MAX(weeks_after_signup)
        from
          signup_engagement
      )
  )
select
  se.signup_week,
  se.weeks_after_signup,
  w.week_num,
  se.user_id
from
  signup_engagement se
  cross join week_numbers w
where
  weeks_after_signup = week_num;

group by
  1
order by
  1;

select
  *
from
  signup_login_engagement;

####################################
# Weekly user retention
CREATE VIEW signup_engagement AS (
    WITH cte AS (
        SELECT
            DISTINCT FLOOR(DATEDIFF(activated_at, '2012-12-30') / 7) AS signup_week,
            FLOOR(DATEDIFF(occurred_at, '2012-12-30') / 7) AS engagement_week,
            u.user_id
        FROM
            users u
            LEFT JOIN events e ON u.user_id = e.user_id
    )
    SELECT
        engagement_week - signup_week AS weeks_after_signup,
        engagement_week,
        signup_week,
        user_id
    FROM
        cte
);
WITH signups_per_week AS (
    SELECT
        FLOOR(DATEDIFF(activated_at, '2012-12-30') / 7) AS week,
        COUNT(user_id) AS num_users
    FROM
        users
    GROUP BY
        FLOOR(DATEDIFF(activated_at, '2012-12-30') / 7)
),
weekly_retention AS (
    SELECT
        DISTINCT signup_week,
        IFNULL(weeks_after_signup, -1) AS weeks_after_signup,
        COUNT(user_id) OVER (
            PARTITION BY signup_week,
            weeks_after_signup
            ORDER BY
                signup_week
        ) AS engagement_user_count
    FROM
        signup_engagement
)
SELECT
    signup_week,
    SUM(engagement_user_count / num_users)/( (
        SELECT
            MAX(engagement_week)
        FROM
            signup_engagement
    ) - signup_week + 1)  AS avg_retention
FROM
    weekly_retention AS wr
    JOIN signups_per_week AS spw ON wr.signup_week = spw.week
WHERE
    signup_week <> (
        SELECT
            MAX(signup_week)
        FROM
            signup_engagement
    ) AND weeks_after_signup NOT IN (-1)
GROUP BY
    signup_week
ORDER BY
    1;
################################################
#######################################
# Weekly engagement per device
CREATE TABLE
  devices (device VARCHAR(50), type VARCHAR(10));

INSERT INTO
  devices (device, type)
VALUES
  ('dell inspiron notebook', 'laptop'),
  ('iphone 5', 'phone'),
  ('iphone 4s', 'phone'),
  ('windows surface', 'tablet'),
  ('macbook air', 'laptop'),
  ('iphone 5s', 'phone'),
  ('macbook pro', 'laptop'),
  ('kindle fire', 'tablet'),
  ('ipad mini', 'tablet'),
  ('nexus 7', 'tablet'),
  ('nexus 5', 'phone'),
  ('samsung galaxy s4', 'phone'),
  ('lenovo thinkpad', 'laptop'),
  ('samsumg galaxy tablet', 'tablet'),
  ('acer aspire notebook', 'laptop'),
  ('asus chromebook', 'laptop'),
  ('samsung galaxy note', 'phone'),
  ('mac mini', 'desktop'),
  ('hp pavilion desktop', 'desktop'),
  ('ipad air', 'tablet'),
  ('htc one', 'phone'),
  ('dell inspiron desktop', 'desktop'),
  ('amazon fire phone', 'phone'),
  ('acer aspire desktop', 'desktop'),
  ('nokia lumia 635', 'phone'),
  ('nexus 10', 'tablet');

WITH cte AS (
    SELECT
        DISTINCT FLOOR(DATEDIFF(occurred_at, '2012-12-30') / 7) week,
        e.device,
        type,
        user_id
    FROM
        events e
        JOIN devices d ON e.device = d.device
    WHERE
        event_type = 'engagement'
)
SELECT
    week,
    SUM(
        CASE
            WHEN type = 'desktop' THEN 1
            ELSE 0
        END
    ) desktop,
    SUM(
        CASE
            WHEN type = 'laptop' THEN 1
            ELSE 0
        END
    ) laptop,
    SUM(
        CASE
            WHEN type = 'tablet' THEN 1
            ELSE 0
        END
    ) tablet,
    SUM(
        CASE
            WHEN type = 'phone' THEN 1
            ELSE 0
        END
    ) phone
FROM
    cte
GROUP BY
    week;

##################################################
select distinct
  device
from
  events;

select
  *
from
  email_events
order by
  1,
  2;

select
  action,
  count(*)
from
  email_events
group by
  action;

##############################################
# Weekly Email Engagement
SELECT
  FLOOR(DATEDIFF(occurred_at, '2012-12-30') / 7) AS week,
  sum(
    case
      when action like 'sent%' then 1
      else 0
    end
  ) deliveries,
  sum(
    case
      when action = 'email_clickthrough' then 1
      else 0
    end
  ) clicks,
  sum(
    case
      when action = 'email_open' then 1
      else 0
    end
  ) opens,
  sum(
    case
      when action = 'email_clickthrough' then 1
      else 0
    end
  ) / sum(
    case
      when action like 'sent%' then 1
      else 0
    end
  ) CTR,
  sum(
    case
      when action = 'email_clickthrough' then 1
      else 0
    end
  ) / sum(
    case
      when action = 'email_open' then 1
      else 0
    end
  ) CTOR
from
  email_events
group by
  FLOOR(DATEDIFF(occurred_at, '2012-12-30') / 7)
order by
  week;

# Weekday email engagement
SELECT
  dayname(occurred_at) AS weekday,
  weekday(occurred_at) num_weekday,
  sum(
    case
      when action like 'sent%' then 1
      else 0
    end
  ) deliveries,
  sum(
    case
      when action = 'email_clickthrough' then 1
      else 0
    end
  ) clicks,
  sum(
    case
      when action = 'email_open' then 1
      else 0
    end
  ) opens,
  sum(
    case
      when action = 'email_clickthrough' then 1
      else 0
    end
  ) / sum(
    case
      when action like 'sent%' then 1
      else 0
    end
  ) CTR,
  sum(
    case
      when action = 'email_clickthrough' then 1
      else 0
    end
  ) / sum(
    case
      when action = 'email_open' then 1
      else 0
    end
  ) CTOR
from
  email_events
group by
  dayname(occurred_at),
  weekday(occurred_at)
order by
  2;

# Weekly re-engagement metrics
SELECT
  FLOOR(DATEDIFF(occurred_at, '2012-12-30') / 7) AS week,
  count(*) re_enagagements
from
  email_events
where
  action = 'sent_reengagement_email'
group by
  FLOOR(DATEDIFF(occurred_at, '2012-12-30') / 7);

# Weekday re-enagagement metrics
SELECT
  dayname(occurred_at) AS weekday,
  weekday(occurred_at) num_weekday,
  count(*) re_engagements
from
  email_events
where
  action = 'sent_reengagement_email'
group by
  dayname(occurred_at),
  weekday(occurred_at)
order by
  2;

###################################################
select distinct
  user_type
from
  email_events;









