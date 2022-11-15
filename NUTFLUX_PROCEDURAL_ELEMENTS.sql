-- PROCEDURES
drop procedure if exists sp_password_update;
SET SQL_SAFE_UPDATES = 0;
delimiter //
create procedure sp_password_update(in username text,in old_pwd text, in new_pwd text)
begin
	if exists(select * from users where user_email=username and user_pwd=old_pwd) then
		update users u1 set u1.user_pwd = new_pwd  where u1.user_email = username and u1.user_pwd=old_pwd;
	else
		SIGNAL SQLSTATE VALUE '10581'
		SET MESSAGE_TEXT = "Wrong username and password";
	end if;
end
//
delimiter ;

drop procedure if exists sp_email_update;

delimiter //
create procedure sp_email_update(in username text,in old_pwd text, in new_email text)
begin
	if exists(select * from users where user_email=username and user_pwd=old_pwd) then
		update users u1 set u1.user_email = new_email  where u1.user_email = username and u1.user_pwd=old_pwd;
    else
		SIGNAL SQLSTATE VALUE '10581'
		SET MESSAGE_TEXT = "Wrong username and password";
	end if;
end
//
delimiter ;


SET SQL_SAFE_UPDATES = 1;

DELIMITER //
drop procedure if exists sp_userRecommendations//
CREATE PROCEDURE sp_userRecommendations(in username varchar(30))
BEGIN
	select distinct filmtitle,actors,directors,cinematographers,producers,writers,musicians from movie_dashboard
	join filmcast on filmcast.filmId=movie_dashboard.filmId
	where filmcast.actorId in (
	select a.actorid
	from user_review u
	join filmcast fc on u.film_id = fc.filmId
	join actors a on a.actorId = fc.actorId
	join users us on us.user_id=u.user_id
	join films f on f.filmId=fc.filmId
	where user_email=username and u.rating>5)
    group by filmTitle,actors;
END //
DELIMITER ;

call sp_userRecommendations('pawan98ppk@gmail.com');

drop procedure if exists filter_movies ;
delimiter //
create procedure filter_movies(in start_year int, in end_year int, in sort_on text)
begin
if sort_on = "imdb_rating" then
select filmtitle,descriptions,imdb_rate,YearOfRelease,duration
from films f
where f.YearOfRelease >start_year and f.YearOfRelease<end_year
order by f.imdb_rate desc;
elseif sort_on = "critics_rating" then
select filmtitle,descriptions,imdb_rate,YearOfRelease,duration,critic_score
from films f
join critic_reviews cr
on f.filmId = cr.film_id
where f.YearOfRelease >start_year and f.YearOfRelease<end_year
group by f.filmId
order by avg(cr.critic_score) desc;
elseif sort_on = "release date" then
select filmtitle,descriptions,imdb_rate,YearOfRelease,language_name,duration
from films f
join languages l on l.language_id=f.language_id
where f.YearOfRelease >start_year and f.YearOfRelease<end_year
group by f.filmId
order by f.YearOfRelease;
else
SIGNAL SQLSTATE VALUE '10581'
SET MESSAGE_TEXT = "Incorrect Sorting type : Choose either imdb_rating / critics_rating / release date";
end if;
end //
delimiter ;

call sort_movie_ratings(1934,2020,"release date");


-- TRIGGERS
DELIMITER $$

DROP TRIGGER IF EXISTS validate_user_email $$	
CREATE TRIGGER validate_user_email BEFORE INSERT ON users 
for each row
BEGIN
	declare msg varchar(128);
    if NEW.user_email NOT LIKE '%_@%_.__%' THEN 
		set msg = concat('Invalid email: ', cast(new.user_id as char));
        signal sqlstate '45000' set message_text = msg;
	end if;
END;
$$

DELIMITER ;

DROP TRIGGER IF EXISTS user_email_already_exists ;
DELIMITER //
CREATE TRIGGER user_email_already_exists
BEFORE INSERT
ON users
FOR EACH ROW
Begin
declare message varchar(128);
IF NEW.user_email in (select users.user_email from users) THEN
	set message = 'Email Already exists. Please Login using Credential:';
	signal sqlstate '45000' set message_text = message;
END IF;
end
//

DELIMITER ;

-- EVENTS
SET GLOBAL event_scheduler = ON;

-- user recommendation
drop event if exists recommendation_event;
CREATE EVENT recommendation_event
    ON SCHEDULE
      EVERY 1 day
    COMMENT ''
    DO
      call sp_userRecommendations('pawan98ppk@gmail.com');

-- subscription end notification
drop event if exists subscription_end_notify;
CREATE EVENT subscription_end_notify
    ON SCHEDULE EVERY  25 day
    COMMENT ''
    DO
      SIGNAL SQLSTATE VALUE '10581'
	  SET MESSAGE_TEXT = "subscription about to end";


