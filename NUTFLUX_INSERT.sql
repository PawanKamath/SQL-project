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


insert into directors values(01,'Frank Darabont','male');
insert into directors values(02,'Prashanth Neel','male');
INSERT INTO directors VALUES (037,'Jocky','female');
insert into directors values(03,"Sydney Newman","male");
insert into directors values(04,"Joss Whedon","male");
insert into directors values(05,"W.S. Van Dyke","male");
insert into directors values(06,"Jack Conway","male");
insert into directors values(07,"George Cukor","male");
insert into directors values(08,"Richard Thorpe","male");

                                        
insert into languages values("lang1","English");
insert into languages values("lang2","Irish");
insert into languages values("lang3","Japaneese");
insert into languages values("lang4","Korean");
insert into languages values("lang5","Kannada");
insert into languages values("lang6","Hindi");
insert into languages values("lang7","Spanish");



insert into films values(11,'The Shawshank Redemption',28884504,1992,9.3,"2h 22m","Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.");
insert into films values(12,'KGF 2',7000000000,2022,9.6,"2h 48m","In the blood-soaked Kolar Gold Fields, Rocky's name strikes fear into his foes. While his allies look up to him, the government sees him as a threat to law and order. Rocky must battle threats from all sides for unchallenged supremacy.");
insert into films values(13,'KGF 1',288754198,2018,8.5,"2h 36m","In the 1970s, a gangster goes undercover as a slave to assassinate the owner of a notorious gold mine.");
insert into films values(14,"The avengers",150056732,1969,8.3,"1961-1969","A quirky spy show of the adventures of eccentrically suave British Agent John Steed and his predominately female partners.");
insert into films values(15,"The avengers",623357910,2012,8.0,"2h 23m","Earth's mightiest heroes must come together and learn to fight as a team if they are going to stop the mischievous Loki and his alien army from enslaving humanity.");
insert into films values(16,"Avengers: Age of Ultron",642317670,2015,7.3,"2h 21m","When Tony Stark and Bruce Banner try to jump-start a dormant peacekeeping program called Ultron, things go horribly wrong and it's up to Earth's mightiest heroes to stop the villainous Ultron from enacting his terrible plan.");
insert into films values(17,"Manhattan Melodrama",165234852,1934,7.1,"1h 33m","The friendship between two orphans endures even though they grow up on opposite sides of the law and fall in love with the same woman.");
insert into films values(18,"The thin Man",165234852,1934,7.9,"1h 32m","Former detective Nick Charles and his wealthy wife Nora investigate a murder case, mostly for the fun of it.");
insert into films values(19,"Double Wedding",65234852,1937,6.9,"1h 27m","Two sisters of differing temperaments, the younger's milquetoast fiancé, and a free-spirited artist in an auto trailer are all experiencing romantic complications.");
insert into films values(20,'KGF 3',0000000,2026,0.0,"0h 00m","--");
insert into films values(21,'Salaar',0000000,2026,0.0,"0h 00m","--");
insert into films values(22,'X-Men: Days of Future Past',234156278,2014,7.5,"2h 35m","X-Men: Days of Future Past");
insert into films values(23,' X-Men: First Class',234156278,2011,7.9,"2h 35m","X-Men: Days of Future Past");


insert into movie_multi_lang values(11,'lang1');
insert into movie_multi_lang values(14,'lang1');
insert into movie_multi_lang values(15,'lang1');
insert into movie_multi_lang values(16,'lang1');
insert into movie_multi_lang values(17,'lang1');
insert into movie_multi_lang values(18,'lang1');
insert into movie_multi_lang values(19,'lang1');
insert into movie_multi_lang values(12,'lang1');
insert into movie_multi_lang values(12,'lang2');
insert into movie_multi_lang values(12,'lang3');
insert into movie_multi_lang values(12,'lang4');
insert into movie_multi_lang values(12,'lang5');
insert into movie_multi_lang values(12,'lang6');
insert into movie_multi_lang values(12,'lang7');
insert into movie_multi_lang values(13,'lang1');
insert into movie_multi_lang values(13,'lang2');
insert into movie_multi_lang values(13,'lang3');
insert into movie_multi_lang values(13,'lang4');
insert into movie_multi_lang values(13,'lang5');
insert into movie_multi_lang values(13,'lang6');
insert into movie_multi_lang values(13,'lang7');
insert into movie_multi_lang values(20,'lang5');
insert into movie_multi_lang values(21,'lang5');
insert into movie_multi_lang values(22,'lang1');
insert into movie_multi_lang values(23,'lang1');


                                            
insert into movie_directors values(11,01);
insert into movie_directors values(12,02);
insert into movie_directors values(13,02);
insert into movie_directors values(13,037);
insert into movie_directors values(14,03);
insert into movie_directors values(15,04);
insert into movie_directors values(16,04);
insert into movie_directors values(17,05);
insert into movie_directors values(17,06);
insert into movie_directors values(17,07);
insert into movie_directors values(18,05);
insert into movie_directors values(19,08);
insert into movie_directors values(20,02);
insert into movie_directors values(21,02);
insert into movie_directors values(22,02);
insert into movie_directors values(23,06);


insert into actors values(21,'Tim Robbins','USA','male');
insert into actors values(22,'Freeman','USA','male');
insert into actors values(23,'Bob Guntan','USA','male');
insert into actors values(24,'Yash','India','male');
insert into actors values(25,'Sanjay Dutt','India','male');
insert into actors values(26,'Srinidhi Shetty','India','female');
insert into actors values(27,'Ramachandra Raju','India','male');
insert into actors values(28,'Patrick Macnee','UK','male');
insert into actors values(29,'Diana Rigg','UK','female');
insert into actors values(210,'Honor Blackman','UK','male');
insert into actors values(211,"Robert Downey Jr.","USA",'male');
insert into actors values(212,"Chris Evans","USA",'male');
insert into actors values(213,"Scarlett Johansson","USA",'female');
insert into actors values(214,"Mark Ruffalo","USA",'male');
insert into actors values(215,"Myrna Loy","USA","female");
insert into actors values(216,"William Powell","USA","male");
insert into actors values(217,"Ian McKellen","USA","male");
insert into actors values(218," Michael Fassbender","USA","male");
insert into actors values(219,"James McAvoy","USA","male");
insert into actors values(220,"Kevin Bacon","USA","male");


insert into roles values(31,'Andy Dufresne');
insert into roles values(32,'Ellis Boyd Red Redding');
insert into roles values(33,'Warden Norton');
insert into roles values(34,'Rocky Bhai');
insert into roles values(35,'Adheera');
insert into roles values(36,'Reena');
insert into roles values(37,'Garuda');
insert into roles values(38,'John steed');
insert into roles values(39,'Emma Peel');
insert into roles values(310,'Catherine Gale');
insert into roles values(311,"Tony Stark");
insert into roles values(312,"Steve Rogers");
insert into roles values(313,"Natasha Romanoff");
insert into roles values(314,"Bruce Banner");
insert into roles values(315,"Eleanor");
insert into roles values(316,"Jim Wade");
insert into roles values(317,"Nick Charles");
insert into roles values(318,"Nora Charles");
insert into roles values(319,"Margit Agnew");
insert into roles values(320,"Charles Lodge");



insert into categories values(1,'hero');
insert into categories values(2,'heroine');
insert into categories values(3,'anti hero');
insert into categories values(4,'villian');
insert into categories values(5,'love interest');
insert into categories values(6,'superhero');
insert into categories values(7,'spy');



insert into role_category values(34,1);
insert into role_category values(34,3);
insert into role_category values(34,5);
insert into role_category values(35,4);
insert into role_category values(37,4);
insert into role_category values(36,2);
insert into role_category values(36,7);
insert into role_category values(36,5);
insert into role_category values(31,1);
insert into role_category values(32,1);
insert into role_category values(33,1);
insert into role_category values(38,7);
insert into role_category values(39,7);
insert into role_category values(39,5);
insert into role_category values(310,4);
insert into role_category values(311,6);
insert into role_category values(312,6);
insert into role_category values(313,6);
insert into role_category values(314,4);
insert into role_category values(315,2);
insert into role_category values(316,1);
insert into role_category values(317,1);
insert into role_category values(318,2);
insert into role_category values(319,2);
insert into role_category values(320,4);

insert into writers values("writer1","Stephen King");
insert into writers values("writer2","Frank Darabont");
insert into writers values("writer3","Prashanth Neel");
insert into writers values("writer4","Shivgopal Krishna");
insert into writers values("writer5","Mayank Saxena");
insert into writers values("writer6","Brian clemens");
insert into writers values("writer7","Sydney Newman");
insert into writers values("writer8","Joss Whedon");
insert into writers values("writer9","Zak Penn");
insert into writers values("writer10","Stan Lee");
insert into writers values("writer11","Jack Kirby");
insert into writers values("writer12","Oliver H.P. Garrett");
insert into writers values("writer13","Arthur Caesar");
insert into writers values("writer14","Albert Hackett");
insert into writers values("writer15","Jo Swerling");



insert into movie_writers values(11,"writer1");
insert into movie_writers values(11,"writer2");
insert into movie_writers values(12,"writer3");
insert into movie_writers values(13,"writer3");
insert into movie_writers values(13,"writer4");
insert into movie_writers values(13,"writer5");
insert into movie_writers values(14,"writer6");
insert into movie_writers values(14,"writer7");
insert into movie_writers values(15,"writer8");
insert into movie_writers values(15,"writer9");
insert into movie_writers values(16,"writer8");
insert into movie_writers values(16,"writer10");
insert into movie_writers values(16,"writer11");
insert into movie_writers values(17,"writer12");
insert into movie_writers values(17,"writer13");
insert into movie_writers values(18,"writer14");
insert into movie_writers values(19,"writer15");
insert into movie_writers values(20,"writer3");
insert into movie_writers values(21,"writer3");
insert into movie_writers values(22,"writer3");
insert into movie_writers values(23,"writer11");


insert into filmcast values(11,21,31,1000000);
insert into filmcast values(11,22,32,1200000);
insert into filmcast values(11,23,33,1300000);
insert into filmcast values(12,24,34,1500000);
insert into filmcast values(12,25,35,1220000);
insert into filmcast values(12,26,36,1220000);
insert into filmcast values(13,26,36,1220000);
insert into filmcast values(13,24,34,1220000);
insert into filmcast values(13,27,37,1220000);
insert into filmcast values(14,28,38,1220000);
insert into filmcast values(14,29,39,1220000);
insert into filmcast values(14,210,310,1220000);
insert into filmcast values(15,211,311,2348358);
insert into filmcast values(15,212,312,2348358);
insert into filmcast values(15,213,313,2348358);
insert into filmcast values(16,211,311,2348358);
insert into filmcast values(16,212,312,2348358);
insert into filmcast values(16,214,314,2348358);
insert into filmcast values(17,215,315,1031175);
insert into filmcast values(17,216,316,1031175);
insert into filmcast values(18,215,317,1031175);
insert into filmcast values(18,216,318,1031175);
insert into filmcast values(19,215,319,1031175);
insert into filmcast values(19,216,320,1031175);
insert into filmcast values(20,26,36,1220000);
insert into filmcast values(20,24,34,1220000);
insert into filmcast values(20,25,35,1220000);
insert into filmcast values(21,24,34,1220000);
insert into filmcast values(22,217,320,1031175);
insert into filmcast values(22,218,320,1031175);
insert into filmcast values(22,219,320,1031175);
insert into filmcast values(23,218,315,1031175);
insert into filmcast values(23,219,316,1031175);
insert into filmcast values(23,220,319,1031175);




insert into ranking_table values(11,2);
insert into ranking_table values(12,1);
insert into ranking_table values(13,153);
insert into ranking_table values(14,700345);
insert into ranking_table values(15,352);
insert into ranking_table values(16,595);
insert into ranking_table values(17,783);
insert into ranking_table values(18,713);
insert into ranking_table values(19,933);
insert into ranking_table values(22,513);
insert into ranking_table values(23,197);



insert into subscription_table values (41,'standard');
insert into subscription_table values (42,'Pro');



insert into users values(51,'Pawan','pawan98ppk@gmail.com','@21March1998',41,"2018-03-25","1998-03-21");
insert into users values(52,'Dominic','dominic@gmail.com','@22March1997',42,"2019-09-12","1996-03-22");
insert into users values(53,'Linas','linas@gmail.com','@23March1997',42,"2019-09-12","1995-03-23");
insert into users values(54,'Carly','carly@gmail.com','@24March1997',42,"2022-04-24","1994-03-24");



insert into cinematography values("cin1","Roger Deakins");
insert into cinematography values('cin2',"Bhuvan Gowda");
insert into cinematography values('cin3',"Sydney Newman");
insert into cinematography values('cin4' ,"Joss Whedon");
insert into cinematography values('cin5',"Seamus McGarvey");
insert into cinematography values('cin6',"Ben Davis");
insert into cinematography values('cin7',"James Wong Howe");
insert into cinematography values('cin8',"William H. Daniels");


insert into movie_cinematography values(11,"cin1");
insert into movie_cinematography values(12,'cin2');
insert into movie_cinematography values(13,'cin2');
insert into movie_cinematography values(14,'cin3');
insert into movie_cinematography values(15,'cin4');
insert into movie_cinematography values(15,'cin5');
insert into movie_cinematography values(16,'cin6');
insert into movie_cinematography values(17,'cin7');
insert into movie_cinematography values(18,'cin7');
insert into movie_cinematography values(19,'cin8');
insert into movie_cinematography values(20,'cin2');
insert into movie_cinematography values(21,'cin2');
insert into movie_cinematography values(22,'cin8');
insert into movie_cinematography values(23,'cin7');

-- awards


insert into awards values(61,"Japan Academy Prize for Outstanding Foreign Language Film");
insert into awards values(62,"American Society of Cinematographers Award for Outstanding Achievement in Cinematography in Theatrical Releases");
insert into awards values(63,"Humanitas Prize for Best Film");
insert into awards values(64,"USC Scripter Award ");
insert into awards values(65," Directors Guild of America Award for Outstanding Directing ");
insert into awards values(66,' Writers Guild of America Award for Best Adapted Screenplay');
insert into awards values(67," Saturn Award for Best Action or Adventure Film");
insert into awards values(68," Saturn Award for Best Writing");
insert into awards values(69,"oscar - best actor in a leading role");
insert into awards values(610,"oscar - Best Cinematography");
insert into awards values(611,"oscar - Best Writing, Screenplay Based on Material Previously Produced or Published");
insert into awards values(612,"Best Music, Original Score");
insert into awards values(613,"Outstanding Performance by a Male Actor in a Leading Role");
insert into awards values(614,"Felix - Best cinematography");
insert into awards values(615,"Oscar - Best cinemtography");
insert into awards values(616,"Felix - Best Actor");
insert into awards values(617,"Felix - Best Director");
insert into awards values(618,"Felix - Best Adapted screen play");
insert into awards values(619,"Chlotrudis Award - Best Actor");
insert into awards values(620,"Filmfare Award - Kannada Film Industry - Best Actor");
insert into awards values(621,"SIIMA - Kannada -Best Actor");
insert into awards values(622,"SIIMA - Kannada -Best Director");
insert into awards values(623,"SIIMA - Kannada -Best Cinematographer");
insert into awards values(624,"SIIMA - Kannada -Best Film");
insert into awards values(625,"Primetime Emmy - Outstanding Dramatic Series");
insert into awards values(626,"Outstanding Continued Performance by an Actress in a Leading Role in a Dramatic Series");



insert into film_award_nominee values(11,65,1994);
insert into film_award_nominee values(11,66,1994);
insert into film_award_nominee values(11,67,1994);
insert into film_award_nominee values(11,68,1994);
insert into film_award_nominee values(14,625,1968);

create table if not exists movie_award(film_id int,award_id int,year int,
		foreign key(film_id) references films(filmId), foreign key(award_id) references awards(award_id));

insert into movie_award values(11,61,1994);
insert into movie_award values(11,62,1994);
insert into movie_award values(11,63,1994);
insert into movie_award values(11,64,1994);
insert into movie_award values(13,624,2018);
insert into movie_award values(15,67,2013);

-- movies, tv shows and series

insert into release_update values("s1","Released");
insert into release_update values("s2","Upcoming");



insert into shows values(1000,"Movie");
insert into shows values(1001,"TV show");
insert into shows values(1002,"Series");


insert into statusOfFilm values(11,"s1",1000);
insert into statusOfFilm values(12,"s1",1000);
insert into statusOfFilm values(13,"s1",1000);
insert into statusOfFilm values(14,"s1",1001);
insert into statusOfFilm values(15,"s1",1000);
insert into statusOfFilm values(16,"s1",1000);
insert into statusOfFilm values(17,"s1",1000);
insert into statusOfFilm values(18,"s1",1000);
insert into statusOfFilm values(19,"s1",1000);
insert into statusOfFilm values(20,"s2",1000);
insert into statusOfFilm values(21,"s2",1000);
insert into statusOfFilm values(22,"s1",1000);
insert into statusOfFilm values(23,"s1",1000);


                                            
insert into director_award values(01,11,618,1994);
insert into director_award values(02,13,622,2018);
insert into director_award values(04,15,611,2013);


insert into writer_award values("writer13",17,611,1935);
insert into writer_award values("writer14",18,611,1934);


insert into actor_award values(22,11,619,1994);
insert into actor_award values(24,13,620,2018);
insert into actor_award values(24,13,621,2018);
insert into actor_award values(211,15,621,2013);
insert into actor_award values(211,15,620,2013);
    

                                            
insert into director_award_nominee values(01,11,611,1994);
insert into director_award_nominee values(01,11,617,1994);
insert into director_award_nominee values(05,18,611,1934);

insert into actor_award_nominee values(22,11,69,1994);
insert into actor_award_nominee values(21,11,613,1994);
insert into actor_award_nominee values(22,11,613,1994);
insert into actor_award_nominee values(22,11,616,1994);
insert into actor_award_nominee values(29,14,626,1968);
insert into actor_award_nominee values(212,15,69,2013);
insert into actor_award_nominee values(216,18,69,1934);


insert into cinematography_award values("cin1",11,614,1994);
insert into cinematography_award values("cin1",11,615,1994);
insert into cinematography_award values("cin2",13,623,2018);

create table cinematography_award_nominee(cin_id varchar(10), film_id int,award_id int,year int, foreign key(film_id) references films(filmId),
									foreign key(award_id) references awards(award_id), foreign key(cin_id) references cinematography(cin_id));
-- production company tables



insert into production_company values("prod1","Castle Rock Company");
insert into production_company values("prod2","Hombale films");
insert into production_company values("prod3","Albert Fennell");
insert into production_company values("prod4","Brian Clemens");
insert into production_company values("prod5","Victoria Alonso");
insert into production_company values("prod6","David O. Selznick");


                                
 insert into production_movies values (11,"prod1");                                                              
 insert into production_movies values (12,"prod2");      
 insert into production_movies values (13,"prod2"); 
 insert into production_movies values (14,"prod3"); 
 insert into production_movies values (14,"prod4"); 
 insert into production_movies values(15,'prod5');
 insert into production_movies values(16,'prod5');
 insert into production_movies values(17,'prod6');
 insert into production_movies values(18,'prod6');
 insert into production_movies values(18,'prod5');
insert into production_movies values (20,"prod2");      
insert into production_movies values (21,"prod2");      
insert into production_movies values (22,"prod6");      
insert into production_movies values (23,"prod6");      

-- songs and singers table



insert into Musician values("mus1","Thomas NewMan");
insert into Musician values("mus2","Ravi Basrur");
insert into Musician values("mus3","Vijay Prakash");
insert into Musician values("mus4","A.W. Lumkin");
insert into Musician values("mus5","William Axt");
insert into Musician values("mus6","Wayne Allen");


                            
insert into movie_musicians values(11,'mus1');
insert into movie_musicians values(12,'mus2');
insert into movie_musicians values(12,'mus3');
insert into movie_musicians values(13,'mus2');
insert into movie_musicians values(13,'mus3');
insert into movie_musicians values(14,'mus4');
insert into movie_musicians values(15,'mus4');
insert into movie_musicians values(16,'mus4');
insert into movie_musicians values(17,'mus5');
insert into movie_musicians values(18,'mus5');
insert into movie_musicians values(19,'mus6');
insert into movie_musicians values(22,'mus4');
insert into movie_musicians values(23,'mus4');


insert into music_award values("mus1",11,612,1994);

-- genres


insert into genres values("gen1","Drama");
insert into genres values("gen2","Action");
insert into genres values("gen3","Crime");
insert into genres values("gen4","Thriller");
insert into genres values("gen5","Sci-Fi");
insert into genres values("gen6","Adventure");
insert into genres values("gen7","Romance");
insert into genres values("gen8","Comedy");
insert into genres values("gen9","Mystery");


                                        
                                        
insert into movie_genre values(11,"gen1");
insert into movie_genre values(12,"gen1");
insert into movie_genre values(12,"gen2");
insert into movie_genre values(12,"gen3");
insert into movie_genre values(12,"gen4");
insert into movie_genre values(13,"gen1");
insert into movie_genre values(13,"gen2");
insert into movie_genre values(13,"gen3");
insert into movie_genre values(13,"gen4");
insert into movie_genre values(14,"gen2");
insert into movie_genre values(14,"gen3");
insert into movie_genre values(14,"gen4");
insert into movie_genre values(15,"gen5");
insert into movie_genre values(15,"gen2");
insert into movie_genre values(15,"gen6");
insert into movie_genre values(16,"gen5");
insert into movie_genre values(16,"gen2");
insert into movie_genre values(16,"gen6");
insert into movie_genre values(17,"gen1");
insert into movie_genre values(17,"gen3");
insert into movie_genre values(17,"gen7");
insert into movie_genre values(18,"gen8");
insert into movie_genre values(18,"gen9");
insert into movie_genre values(19,"gen7");
insert into movie_genre values(19,"gen8");
insert into movie_genre values(20,"gen1");
insert into movie_genre values(20,"gen2");
insert into movie_genre values(20,"gen3");
insert into movie_genre values(20,"gen4");
insert into movie_genre values(21,"gen1");
insert into movie_genre values(21,"gen2");
insert into movie_genre values(21,"gen3");
insert into movie_genre values(21,"gen4");
insert into movie_genre values(22,"gen1");
insert into movie_genre values(22,"gen3");
insert into movie_genre values(22,"gen7");
insert into movie_genre values(23,"gen1");
insert into movie_genre values(23,"gen3");
insert into movie_genre values(23,"gen7");




insert into critic_reviews values(11,"It's the no-bull performances that hold back the flood of banalities. Robbins and Freeman connect with the bruised souls of Andy and Red to create something undeniably powerful and moving.",90);
insert into critic_reviews values(11,"Gripping...compelling.",90);
insert into critic_reviews values(11,"Central to the film's success is a riveting, unfussy performance from Robbins. Freeman has the showier role, allowing him a grace and dignity that come naturally.",90);
insert into critic_reviews values(11,"At times poignant, joyful, and terrifying, Shawshank Redemption is an altogether brilliant movie and the debut of an equally brilliant director.",89);
insert into critic_reviews values(11,"Whitmore's Brooks is a brilliantly-realized character, and the scenes with him attempting to cope with life outside of Shawshank represents one of the film's most moving -- and effective -- sequences.",88);
insert into critic_reviews values(11,"Some of The Shawshank Redemption'' comes across as outrageously improbable. Yet the film keeps pulling you back with its sense of striving humanity slowly turning the tables against evil.",75);
insert into critic_reviews values(11,"Shouldering a laconic-good-guy, neo- Gary Cooper role, Robbins never quite makes emotional contact with the audience.",67);
insert into critic_reviews values(11,"Speaking of jail, Shawshank-the-movie seems to last about half a life sentence. The story, chiefly about the 20-year friendship between Freeman and Robbins, becomes incarcerated in its own labyrinthine sentimentality.",40);
insert into critic_reviews values(13,"A worthy attempt by prashanth neel and team.",60);
insert into critic_reviews values(13,"Must watch, the swag carried by Yash is definitely a thing to mention and not forget the bollywood actors carried it really well",90);
insert into critic_reviews values(14,"One time watch series",75);
insert into critic_reviews values(14,"Cast carried the characters well, but not well scripted",60);
insert into critic_reviews values(15,"Must watch a perfect adventure thriller",90);
insert into critic_reviews values(15,"The avengers would be the one people would remember for a very long time",100);
insert into critic_reviews values(16,"Age of Ultron disappoints not because it's irredeemably bad but because it fails to achieve the level of its predecessor in nearly every facet. Dialogue, acting, character interaction, battle scenes, payoff, tone, style, suspense - all these things are below the bar established by The Avengers.",66);
insert into critic_reviews values(16,"The downside of Marvel’s ongoing cinematic universe is that the Avengers films, which bring together players from several individual series, have to spend so much time juggling elements thrown in the air by other movies and setting up plot threads planned for the next clutch of sequels that their actual stories get squeezed thin.",75); 


                                    
insert into user_review values(51,11,"Amazing!! must watch",9);
insert into user_review values(51,12,"Superb movie",10);
insert into user_review values(52,13,"crazy direction and acting...",8.5);
insert into user_review values(51,14,"fun overloaded",8);
insert into user_review values(52,15,"Sucks,no logic",1);
insert into user_review values(51,16,"ROFL",1);
insert into user_review values(51,17,"Bang bang!",9);
insert into user_review values(51,18,"cute couple, awwwww...",9);
insert into user_review values(51,19,"Paisa barabaad behnchod",2);
insert into user_review values(51,20,"ahhhhh!",9);
insert into user_review values(51,21,"Goosebumps guaranteed",9);
insert into user_review values(51,22,"Wowwwwww!",9);
insert into user_review values(51,23,"Not worth it!",5);
