-- 1.How many Olympics games have been held?
select games ,count( games) from olympics_history
group by games
order by count(*) desc;
-- 2.	Extract all Olympics games held so far.
select distinct games from olympics_history;
-- 3.	Total no of nations who participated in each Olympics game?
select noc as country,count(distinct games) as total_games from  olympics_history
group by noc
order by total_games desc;
-- 4.	Which year saw the highest and lowest no of countries participating in Olympics?
select year ,count(noc) as no_of_countries from olympics_history
group by year
order by no_of_countries desc;
-- 5.	Which nation has participated in all of the Olympic games?
select noc from olympics_history group by noc
having count(distinct games) =(select count(distinct games) from olympics_history);
-- 6.	Find the Ratio of male and female athletes participated in all Olympic games.
-- select sex, count(*) from olympics_history group by sex;
with cte1 as(
select 
SUM(case when sex= 'M'then 1 else 0 end) as male_count,
SUM(case when sex='F' then 1 else 0 end) as female_count
from olympics_history)
select male_count,female_count,round(male_count*1/female_count,2) from cte1;

select count(case when sex='M' THEN 1 end) as male_count ,count(case when sex='F' then 1 end) as female_count,
round(count(case when sex='M' THEN 1 end) * 1.0/count(case when sex='F' then 1 end) ) as ratio from olympics_history;
         
-- 7.	Fetch the top 5 athletes who have won the most gold medals.
select name,sport ,count(medal) as gold_medal from olympics_history 
where medal= 'gold' 
group by name,sport
order by gold_medal desc
limit 5; 
-- 8.	Fetch the top 5 athletes who have won the most medals (gold/silver/bronze).
select name ,sport ,count(medal) as total_medals from olympics_history
group by name,sport
order by total_medals desc
limit 5;
-- 9.	Identify the sport which was played in all summer Olympics.
select season, sport  from olympics_history
where season = 'Summer'
group by season ,sport;
-- 10.	Which Sports were just played only once in the Olympics?
select sport ,count(games) from olympics_history
group by sport
having count(games)=1;
-- 11.	Fetch the total no of sports played in each Olympics game.
select games ,count(sport)as total_no_of_sport from olympics_history
group by games
order by count(sport) desc;
-- 12.	Fetch details of the oldest athletes to win a gold medal.
select name,age ,sport ,count(medal) as gold_medal from olympics_history
where medal='Gold'
group by name,age,sport
order by count(medal),age desc
limit 1;
-- 13.	Fetch the top 5 most successful countries in Olympics. Success is defined by no of medals won.
select noc,count(medal)  as total_no_medal from olympics_history
group by noc
order by total_no_medal desc
limit 5;
-- 14.	List down total gold, silver and bronze medals won by each country.
select noc,medal,count(medal)AS total_medals from olympics_history
where medal<>'NA'
group by noc,medal
ORDER BY  total_medals desc;
-- 15.	List down total gold, silver and bronze medals won by each country corresponding to each Olympic game.
select noc,games,medal,count(medal) as total_medals from olympics_history a
where medal!='NA'
GROUP BY noc,games,medal
order by total_medals desc;
-- 16.	Identify which country won the most gold, most silver and most bronze medals in each Olympic game.
with cte1 as(
select noc,games,medal,count(*) as total_medal from olympics_history where medal<>'NA'
GROUP BY noc,medal,games
order by total_medal desc),
cte2 as(
select a.*, dense_rank() over (partition by games,medal order by total_medal desc) as rnk from cte1 a)
select games ,medal,noc,total_medal from cte2 where rnk=1
order by total_medal desc;

-- 17.	Identify which country won the most gold, most silver, most bronze medals and the most medals in each Olympic game.

-- 18.	Which countries have never won gold medal but have won silver/bronze medals?
select region,
sum(case when medal= 'Gold ' then 1 else 0 end) as gold_medal,
sum(case when medal='silver' then 1 else 0 end) as silver_medal,
sum(case when medal= 'bronze' then 1 else 0 end) as bronze_medal
from olympics_history oh
join olympics_history_noc_regions oe
on oh.noc=oe.noc
where medal<> 'NA'
group by region
having gold_medal=0 and (silver_medal>0 or bronze_medal>0)
order by silver_medal,bronze_medal desc;

-- 19.	In which Sport/event, India has won highest medal
select noc,sport,event ,medal,count(*)as total_count FROM olympics_history where noc='IND' and medal<>'NA'
group by noc,sport,event,medal
order by total_count desc;
-- 20.	Break down all Olympic games where India won medal for Hockey and how many medals in each Olympic games.
select games ,sport,medal,count(medal) as total_count from olympics_history where noc='ind' and sport='Hockey'and medal<>"NA" 
group by games,medal,sport
order by total_count desc;
select * from olympics_history;
select * from olympics_history_noc_regions;
