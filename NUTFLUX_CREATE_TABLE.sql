drop database if exists nutflux;
CREATE DATABASE if not exists nutflux;
USE nutflux;

-- create

create table if not exists directors(
  directorId integer  PRIMARY KEY,
  directorName text NOT NULL,
  gender varchar(10)
);

create table if not exists writers(writer_id varchar(10) primary key,writer_name text);

create table if not exists languages(language_id varchar(10) primary key,
										language_name varchar(30));

CREATE TABLE if not exists films(
  filmId integer PRIMARY KEY,
  FilmTitle text NOT NULL,
  GrossCollection decimal(20,9) NOT NULL,
  YearOfRelease integer NOT NULL,
  imdb_rate float,
  check(imdb_rate>=0),
  duration text,
  descriptions text
);

create table movie_multi_lang( film_id int,language_id varchar(10),
								foreign key(language_id) references languages(language_id),
                                foreign key(film_id) references films(filmid));

create table movie_directors(film_id int,
							director_id int, 
                            foreign key(film_id) references films(filmId),
							foreign key(director_id) references directors(directorId));
                            
CREATE TABLE if not exists actors(
  actorId integer PRIMARY KEY,
  actorName text NOT NULL,
  Nationality text NOT NULL,
  gender varchar(10)
);

CREATE TABLE if not exists roles (
  roleId integer PRIMARY KEY,
  roleName text NOT NULL
);

create table categories(categ_id int primary key,categ text);

create table role_category(role_id int, categ_id int,
							foreign key(role_id) references roles(roleId),
                            foreign key(categ_id) references categories(categ_id));
                            
create table if not exists movie_writers(film_id int ,writer_id varchar(10), 
									foreign key(film_id) references films(filmId),
                                    foreign key(writer_id) references writers(writer_id));
                                    
CREATE TABLE if not exists FILMCAST (
  filmId integer,
  actorId integer,
  roleId integer,
  salary integer,
  check(salary >0),
  FOREIGN KEY(filmId) 
    REFERENCES films(filmId)  ,
  FOREIGN KEY(actorId) 
    REFERENCES actors(actorId)  ,
  FOREIGN KEY(roleId) 
    REFERENCES roles(roleId)
);

create table if not exists ranking_table ( film_id int, ranking int unique key,check(ranking>0),
											foreign key(film_id) references films(filmId));
                                            
create table if not exists subscription_table( id int primary key, subs_type text);

create table if not exists users( user_id int primary key, user_name text, user_email text,
						user_pwd text,check(char_length(user_pwd)<=12),
						subs_type int,doj Date,date_of_birth Date, 
                        foreign key(subs_type) references subscription_table(id));
                        
create table cinematography(cin_id varchar(10) primary key,cin_name text);

create table movie_cinematography(film_id int,cin_id varchar(10),  
								foreign key(film_id) references films(filmId),
                                foreign key(cin_id) references cinematography(cin_id));

create table if not exists awards(award_id int primary key, award_name text);

create table if not exists film_award_nominee(film_id int ,award_id int,year int,
		foreign key(award_id) references awards(award_id), foreign key(film_id) references films(filmId));
	
create table if not exists release_update(status_id varchar(10) primary key,status_text text);

create table if not exists shows(show_id int primary key,show_type text);

create table if not exists statusOfFilm( film_id int, status_id varchar(10),show_id int,
										foreign key(film_id) references films(filmId),
										foreign key(status_id) references release_update(status_id),
                                        foreign key(show_id) references shows(show_id));

create table if not exists director_award(director_id int, film_id int,award_id int,year int,
								foreign key(director_id) references directors(directorId),
								foreign key(film_id) references films(filmId),
                                foreign key(award_id) references awards(award_id));

create table if not exists writer_award(writer_id varchar(10), film_id int,award_id int,year int,
								foreign key(writer_id) references writers(writer_id),
								foreign key(film_id) references films(filmId),
								foreign key(award_id) references awards(award_id));
                                
create table if not exists actor_award(actor_id int, film_id int,award_id int,year int, 
								foreign key(actor_id) references actors(actorId),
								foreign key(film_id) references films(filmId), 
                                foreign key(award_id) references awards(award_id));

create table if not exists director_award_nominee(director_id int, film_id int,award_id int,year int,
											foreign key(director_id) references directors(directorId),
											foreign key(film_id) references films(filmId),
                                            foreign key(award_id) references awards(award_id));
                                            
create table if not exists actor_award_nominee(actor_id int, film_id int,award_id int,year int,
											foreign key(actor_id) references actors(actorId),
											foreign key(film_id) references films(filmId), 
                                            foreign key(award_id) references awards(award_id));

create table cinematography_award(cin_id varchar(10), film_id int,award_id int,year int, foreign key(film_id) references films(filmId),
									foreign key(award_id) references awards(award_id), foreign key(cin_id) references cinematography(cin_id));
                                    
create table if not exists production_company(production_id varchar(10) primary key, production_name text);

create table production_movies( film_id int ,production_id varchar(10), 
								foreign key(film_id) references films(filmId),
								foreign key(production_id) references production_company(production_id));
                                
create table if not exists Musician(musician_id varchar(10) primary key, singer_name text);

create table movie_musicians(film_id int,musician_id varchar(10), 
							foreign key(film_id) references films(filmId), 
                            foreign key(musician_id) references Musician(musician_id));
                            

create table if not exists music_award(musician_id varchar(10),film_id int, award_id int, year int,
										foreign key(musician_id) references Musician(musician_id),
                                        foreign key(film_id) references films(filmId),
                                        foreign key(award_id) references awards(award_id));
                                        
create table if not exists genres(genre_id varchar(10) primary key, genre text);

create table if not exists movie_genre(film_id int,genre_id varchar(10),
										foreign key(film_id) references films(filmId),
                                        foreign key(genre_id) references genres(genre_id));
                                        
create table if not exists critic_reviews(film_id int, rev text,critic_score int, 
									foreign key(film_id) references films(filmId));
                                    

create table if not exists user_review(user_id int,film_id int,review_text text,rating int, 
									foreign key(film_id) references films(filmId), 
                                    foreign key(user_id) references users(user_id));