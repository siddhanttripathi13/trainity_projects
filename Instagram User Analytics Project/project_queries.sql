 # 5 oldest users
select
  *
from
  users
order by
  created_at
limit
  5;

# Inactive users
select
  u.id,
  u.username
from
  users u
  left join photos p on u.id = p.user_id
where
  p.id is null;

# User with most likes on a single photo
with
  likes_per_photo as (
    select
      photo_id,
      count(user_id) no_of_likes
    from
      likes
    group by
      photo_id
  )
select
  p.user_id,
  u.username,
  p.id photo_id,
  p.image_url,
  lpp.no_of_likes
from
  photos p
  join likes_per_photo lpp on p.id = lpp.photo_id
  join users u on u.id = p.user_id
order by
  no_of_likes desc
limit
  1;

# Top 5 most popular hashtags
select
  pt.tag_id,
  t.tag_name,
  count(pt.photo_id) tag_use_count
from
  photo_tags pt
  join tags t on pt.tag_id = t.id
group by
  pt.tag_id
order by
  tag_use_count desc
limit
  5;

# Day of week with most user sign-ups
select
  dayname(created_at) day_of_week,
  count(id) no_of_users
from
  users
group by
  dayname(created_at)
order by
  no_of_users desc;

/* Launch Campaigns on Weekends

Start running your ad campaigns on Fridays, Saturdays and Sundays to align with days when the most number of new users have joined recently.

Launch short-duration campaign bursts to maximize visibility for new weekend users
Include strong Calls-To-Action in ads asking new users to engage right awayZ

Increase intensity of your ad penetration Tuesdays through Thursdays to build momentum through the week culminating with the Sunday sign-up peak.

Gradual buildup allows you to gauge campaign impact as week progresses
Monitor new user growth velocity to optimize spend
Fine-tune messaging to keep middle week users engaged
In summary, correlate ad timing with moments of spiking new user growth to capture attention when sign-ups are happening. Ramp up aggressiveness as week continues towards the weekend high point. */
# User engagement
with
  comments_per_user as (
    select
      user_id,
      count(id) num_comments
    from
      comments
    group by
      user_id
  ),
  photos_per_user as (
    select
      user_id,
      count(id) num_photos
    from
      photos
    group by
      user_id
  ),
  likes_per_user as (
    select
      user_id,
      count(*) num_likes
    from
      likes
    group by
      user_id
  )
select
  u.id,
  u.username,
  ifnull(num_comments, 0) num_comments,
  ifnull(num_photos, 0) num_photos,
  ifnull(num_likes, 0) num_likes,
  (
    ifnull(num_comments, 0) + ifnull(num_photos, 0) + ifnull(num_likes, 0)
  ) avg_num_posts,
  (ifnull(num_photos, 0)) avg_num_photos
from
  users u
  left join comments_per_user cpu on u.id = cpu.user_id
  left join photos_per_user ppu on u.id = ppu.user_id
  left join likes_per_user lpu on u.id = lpu.user_id
where
  (
    num_comments < 257
    or num_comments is null
  )
  and (
    num_comments is not null
    or num_photos is not null
    or num_likes is not null
  );

with
  comments_per_user as (
    select
      user_id,
      count(id) num_comments
    from
      comments
    group by
      user_id
  ),
  photos_per_user as (
    select
      user_id,
      count(id) num_photos
    from
      photos
    group by
      user_id
  ),
  likes_per_user as (
    select
      user_id,
      count(*) num_likes
    from
      likes
    group by
      user_id
  )
select
  avg(
    ifnull(num_comments, 0) + ifnull(num_photos, 0) + ifnull(num_likes, 0)
  ) avg_num_posts,
  avg(ifnull(num_photos, 0)) avg_num_photos
from
  users u
  left join comments_per_user cpu on u.id = cpu.user_id
  left join photos_per_user ppu on u.id = ppu.user_id
  left join likes_per_user lpu on u.id = lpu.user_id
where
  (
    num_comments < 257
    or num_comments is null
  )
  and (
    num_comments is not null
    or num_photos is not null
    or num_likes is not null
  );

/* including bot accounts: avg posts 165.27, avg photos 2.57
excluding bot account: avg posts 113.1609, avg photos 2.954
excluding bot accounts and totally inactive users: avg posts 133.0405, avg photos 3.473 */
# Bot accounts
select
  user_id,
  u.username,
  count(*) num_likes
from
  likes l
  join users u on l.user_id = u.id
group by
  user_id
having
  count(*) = (
    select
      count(id)
    from
      photos
  );