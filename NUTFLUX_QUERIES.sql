-- POWER USER QUERIES

-- pair of actors audience like - pro user
select f1.filmTitle, a1.actorName,a2.actorName,count(*) as films_together
from films f1
join filmcast fc1 on fc1.filmId=f1.filmId
join actors a1 on a1.actorId = fc1.actorId
join films f2 on f1.filmId=f2.filmId
join filmcast fc2 on fc2.filmId=f2.filmId
join actors a2 on a2.actorId = fc2.actorId
where a1.actorId<>a2.actorId
group by a1.actorName,a2.actorName
having count(*)>2 limit 1;

-- pair of actors who worked for same director in different films( actors director like)    
select DISTINCT D.DirectorName,a1.ActorName as Actor1,a2.ActorName as Actor2
from movie_directors md 
JOIN DIRECTORS D ON md.director_Id=D.directorId
JOIN filmcast fc1 ON md.film_Id = fc1.filmId
JOIN actors a2 ON fc1.actorId=a2.actorId
JOIN filmcast fc ON fc.filmId = md.film_Id
JOIN actors a1 ON fc.actorId=a1.actorId
WHERE a1.ActorName <> a2.ActorName
AND EXISTS (SELECT * FROM movie_directors f1
	WHERE md.director_Id = f1.director_Id 
	AND md.film_Id <> f1.film_Id)
GROUP BY md.film_Id;

-- bacon number( degree 1)
select count(distinct actorId) as Bacon_number from filmcast where filmid in (
    select filmid from filmcast where actorid in (
        select distinct actorid from filmcast where filmid in (
            select filmid from filmcast join actors on filmcast.actorid=actors.actorid where actorName='Kevin Bacon')))
and actorid not in  
    (select distinct actorid from filmcast where filmid in (
        select filmid from filmcast join actors on filmcast.actorid=actors.actorid where actorName='Kevin Bacon'));
 
 
 -- hit percentage of director based on user_review and Gross collection
 set @budget = 100000000;
 
 select hits.directorName,hits, (hits/total_movies)*100 as hit_percentage from 
 (select directorName, count(*) as hits
 from directors d
 join movie_directors md on directorId=director_id
 join films f on f.filmId = md.film_id
 join user_review ur on ur.film_id=f.filmId
 where ur.rating > 5 and GrossCollection > @budget 
 group by directorName
 order by hits desc) as hits
 join
 (select directorName,count(*) as total_movies from directors d
 join movie_directors md on md.director_id=d.directorId
 join statusOfFilm s on s.film_id=md.film_id
 join release_update r on r.status_id = s.status_id
 where r.status_text="Released"
 group by directorName
 order by total_movies desc)as tot_movies on hits.directorName = tot_movies.directorName;

-- STANDARD USER QUERIES
select * from movie_dashboard; 

use nutflux;
DELIMITER //
drop procedure if exists sp_GetMoviesByRating;
CREATE PROCEDURE sp_GetMoviesByRating(IN rating float)
BEGIN
    select filmId,descriptions,YearOfRelease,imdb_rate from films where imdb_rate=rating;
END //
DELIMITER ;

CALL sp_GetMoviesByRating(9.3)

DELIMITER //
drop procedure if exists sp_GetMoviesByGenre//
CREATE PROCEDURE sp_GetMoviesByGenre(IN gen text)
BEGIN
    select * from films 
    join movie_genre as mg on films.filmId = mg.film_id
    join genres as g on g.genre_id = mg.genre_id
    where g.genre=gen;
END //
DELIMITER ;

CALL sp_GetMoviesByGenre('Drama')

DELIMITER //
drop procedure if exists sp_GetMoviesByFilmName//
CREATE PROCEDURE sp_GetMoviesByFilmName(IN film text)
BEGIN
    select * from films 
    join movie_genre as mg on films.filmId = mg.film_id
    join genres as g on g.genre_id = mg.genre_id
    where films.FilmTitle=film;
END //
DELIMITER ;

CALL sp_GetMoviesByFilmName('The Shawshank Redemption')

DELIMITER //

drop procedure if exists sp_FilmAwardsAndNominee//
CREATE PROCEDURE sp_FilmAwardsAndNominee(film text)
BEGIN
   select filmTitle,a.award_name
   from films
   join movie_award ma on ma.film_id = films.filmId
   join awards a on a.award_id=ma.award_id
   where filmTitle = film;
END //
DELIMITER ;

CALL sp_FilmAwardsAndNominee("KGF 1");


