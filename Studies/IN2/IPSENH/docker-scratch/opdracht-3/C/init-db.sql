CREATE TABLE movie (
  id INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL,
  genre VARCHAR(100) NOT NULL
);

CREATE TABLE actor (
  id INT PRIMARY KEY AUTO_INCREMENT,
  lastname VARCHAR(255) NOT NULL,
  age INT NOT NULL
);

CREATE TABLE actor_movie (
  actor_id INT,
  movie_id INT,
  PRIMARY KEY (actor_id, movie_id),
  FOREIGN KEY (actor_id) REFERENCES actor(id),
  FOREIGN KEY (movie_id) REFERENCES movie(id)
);

CREATE TABLE rating (
  source VARCHAR(255) NOT NULL,
  movie_id INT,
  FOREIGN KEY (movie_id) REFERENCES movie(id)
);

