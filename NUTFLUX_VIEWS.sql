-- VIEWS
drop view if exists award_winning;
drop view if exists award_nominee;
drop view if exists ActorsAwardsAndNominations;

create view award_winning as (select ac.actorName,group_concat(a.award_name) as winning
   from actors ac
   join actor_award ma on ma.actor_id = ac.actorId
   join awards a on a.award_id=ma.award_id
   group by ac.actorName); 


create view award_nominee as (select ac.actorName,group_concat(a.award_name separator " ,") as nominee
   from actors ac
   join actor_award_nominee ma on ma.actor_id = ac.actorId
   join awards a on a.award_id=ma.award_id
   group by ac.actorName); 

-- view 1: 
create view ActorsAwardsAndNominations as
select A.actorname,winning,nominee from (select * from award_winning) as A left join 
   (select * from award_nominee ) as B ON A.actorName=B.actorName;


-- view 2:
drop view if exists versatality_view;

create view versatality_view as
select actorName,count(*) as factor
from (
select actorName,categ_id
from actors a
join filmcast fc on fc.actorId=a.actorId
join role_category rc on rc.role_id = fc.roleId
group by actorName,categ_id) as vc
group by actorName
order by factor desc;

select * from versatality_view;

-- view 3:
drop view if exists movie_dashboard;
create view movie_dashboard as
select  films.filmId,films.FilmTitle ,group_concat(distinct a.actorName) as actors,
	group_concat(distinct d.directorName) as directors,group_concat(distinct c.cin_name) as cinematographers, 
    group_concat(distinct w.writer_name) as writers,group_concat(distinct pc.production_name) as producers,
    group_concat(distinct Musician.singer_name) as Musicians
    from films
    join movie_directors as md on films.filmId = md.film_id
    join directors d on d.directorId = md.director_id
    join filmcast as m on films.filmId = m.filmId
    join actors a on a.actorId = m.actorId
    join movie_cinematography as mc on mc.film_id = films.filmId
    join cinematography c on c.cin_id = mc.cin_id
    join production_movies as pm on films.filmId = pm.film_id
    join production_company pc on pc.production_id = pm.production_id
    join movie_musicians as mm on films.filmId = mm.film_id
    join Musician on Musician.musician_id = mm.musician_id
    join movie_writers mw on mw.film_id = films.filmId
    join writers w on w.writer_id=mw.writer_id
    group by films.FilmTitle;

-- view 4:
drop view if exists multi_language_movie;
create view multi_language_movie as
select filmTitle, group_concat(language_name) in_languages from films f
join movie_multi_lang mml on mml.film_id=f.filmId
join languages l on l.language_id = mml.language_id
group by filmtitle
having count(*)>2;

select * from multi_language_movie;


