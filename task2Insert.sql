CREATE TABLE brand (
 brand_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 brand VARCHAR(50)UNIQUE
);

ALTER TABLE brand ADD CONSTRAINT PK_brand PRIMARY KEY (brand_id);


CREATE TABLE genre (
 genre_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 genre VARCHAR(50)UNIQUE
);

ALTER TABLE genre ADD CONSTRAINT PK_genre PRIMARY KEY (genre_id);


CREATE TABLE instrument (
 instrument_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 type_of_instrument VARCHAR(50)UNIQUE,
 renting_fee INT
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (instrument_id);


CREATE TABLE lesson (
 lesson_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 duration INT
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (lesson_id);


CREATE TABLE lesson_instruments (
 lesson_id INT NOT NULL,
 instrument_id INT NOT NULL
);

ALTER TABLE lesson_instruments ADD CONSTRAINT PK_lesson_instruments PRIMARY KEY (lesson_id,instrument_id);


CREATE TABLE person (
 person_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 name VARCHAR(100) NOT NULL,
 personnummer CHAR(10)UNIQUE NOT NULL,
 phonenumber CHAR(10) NOT NULL,
 address VARCHAR(100) NOT NULL
);

ALTER TABLE person ADD CONSTRAINT PK_person PRIMARY KEY (person_id);


CREATE TABLE rentable_instrument (
 rentable_instrument_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instrument_id INT NOT NULL,
 brand_id INT NOT NULL
);

ALTER TABLE rentable_instrument ADD CONSTRAINT PK_rentable_instrument PRIMARY KEY (rentable_instrument_id);


CREATE TABLE room (
 room_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 room INT UNIQUE
);

ALTER TABLE room ADD CONSTRAINT PK_room PRIMARY KEY (room_id);


CREATE TABLE school (
 school_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 max_number_of_students INT,
 sibling_discount FLOAT(10)
);

ALTER TABLE school ADD CONSTRAINT PK_school PRIMARY KEY (school_id);


CREATE TABLE skilllevel_and_price (
 skilllevel_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 skilllevel VARCHAR(20)UNIQUE,
 individual_price INT,
 group_price INT,
 ensamble_price INT
);

ALTER TABLE skilllevel_and_price ADD CONSTRAINT PK_skilllevel_and_price PRIMARY KEY (skilllevel_id);


CREATE TABLE student (
 person_id INT NOT NULL,
 sibling_id INT,
 contact_id INT NOT NULL
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (person_id);


CREATE TABLE applies_to (
 school_id INT NOT NULL,
 person_id INT NOT NULL
);

ALTER TABLE applies_to ADD CONSTRAINT PK_applies_to PRIMARY KEY (school_id,person_id);


CREATE TABLE booking (
 dateTime DATE NOT NULL,
 lesson_id INT NOT NULL,
 room_id INT NOT NULL
);

ALTER TABLE booking ADD CONSTRAINT PK_booking PRIMARY KEY (dateTime,lesson_id,room_id);


CREATE TABLE group_lesson (
 lesson_id INT NOT NULL,
 minStudents INT,
 maxStudents INT
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (lesson_id);


CREATE TABLE group_lesson_genres (
 lesson_id INT NOT NULL,
 genre_id INT NOT NULL
);

ALTER TABLE group_lesson_genres ADD CONSTRAINT PK_group_lesson_genres PRIMARY KEY (lesson_id,genre_id);


CREATE TABLE instructor_genre (
 genre_id INT NOT NULL,
 person_id INT NOT NULL
);

ALTER TABLE instructor_genre ADD CONSTRAINT PK_instructor_genre PRIMARY KEY (genre_id,person_id);


CREATE TABLE person_booking (
 person_id INT NOT NULL,
 lesson_id INT NOT NULL,
 room_id INT NOT NULL,
 dateTime DATE NOT NULL
);

ALTER TABLE person_booking ADD CONSTRAINT PK_person_booking PRIMARY KEY (person_id,lesson_id,room_id,dateTime);


CREATE TABLE person_instrument_and_skilllevel (
 person_id INT NOT NULL,
 instrument_id INT NOT NULL,
 skilllevel_id INT NOT NULL
);

ALTER TABLE person_instrument_and_skilllevel ADD CONSTRAINT PK_person_instrument_and_skilllevel PRIMARY KEY (person_id,instrument_id,skilllevel_id);


CREATE TABLE rental_records (
 date_start DATE NOT NULL,
 date_end DATE NOT NULL,
 rentable_instrument_id INT NOT NULL,
 person_id INT NOT NULL
);

ALTER TABLE rental_records ADD CONSTRAINT PK_rental_records PRIMARY KEY (date_start,date_end,rentable_instrument_id,person_id);


ALTER TABLE lesson_instruments ADD CONSTRAINT FK_lesson_instruments_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);
ALTER TABLE lesson_instruments ADD CONSTRAINT FK_lesson_instruments_1 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);


ALTER TABLE rentable_instrument ADD CONSTRAINT FK_rentable_instrument_0 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);
ALTER TABLE rentable_instrument ADD CONSTRAINT FK_rentable_instrument_1 FOREIGN KEY (brand_id) REFERENCES brand (brand_id);


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (person_id) REFERENCES person (person_id)
ON DELETE CASCADE;

ALTER TABLE student ADD CONSTRAINT FK_student_1 FOREIGN KEY (person_id) REFERENCES student (person_id);
ALTER TABLE student ADD CONSTRAINT FK_student_2 FOREIGN KEY (sibling_id) REFERENCES student (person_id);
ALTER TABLE student ADD CONSTRAINT FK_student_3 FOREIGN KEY (contact_id) REFERENCES person (person_id);


ALTER TABLE applies_to ADD CONSTRAINT FK_applies_to_0 FOREIGN KEY (school_id) REFERENCES school (school_id);
ALTER TABLE applies_to ADD CONSTRAINT FK_applies_to_1 FOREIGN KEY (person_id) REFERENCES person (person_id)
ON DELETE CASCADE;


ALTER TABLE booking ADD CONSTRAINT FK_booking_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id)
ON DELETE CASCADE;
ALTER TABLE booking ADD CONSTRAINT FK_booking_1 FOREIGN KEY (room_id) REFERENCES room (room_id)
ON DELETE CASCADE;


ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id)
ON DELETE CASCADE;


ALTER TABLE group_lesson_genres ADD CONSTRAINT FK_group_lesson_genres_0 FOREIGN KEY (lesson_id) REFERENCES group_lesson (lesson_id)
ON DELETE CASCADE;
ALTER TABLE group_lesson_genres ADD CONSTRAINT FK_group_lesson_genres_1 FOREIGN KEY (genre_id) REFERENCES genre (genre_id)
ON DELETE CASCADE;


ALTER TABLE instructor_genre ADD CONSTRAINT FK_instructor_genre_0 FOREIGN KEY (genre_id) REFERENCES genre (genre_id)
ON DELETE CASCADE;
ALTER TABLE instructor_genre ADD CONSTRAINT FK_instructor_genre_1 FOREIGN KEY (person_id) REFERENCES person (person_id)
ON DELETE CASCADE;


ALTER TABLE person_booking ADD CONSTRAINT FK_person_booking_0 FOREIGN KEY (person_id) REFERENCES person (person_id)
ON DELETE CASCADE;
ALTER TABLE person_booking ADD CONSTRAINT FK_person_booking_1 FOREIGN KEY (lesson_id,room_id,dateTime) REFERENCES booking (lesson_id,room_id,dateTime)ON DELETE CASCADE;


ALTER TABLE person_instrument_and_skilllevel ADD CONSTRAINT FK_person_instrument_and_skilllevel_0 FOREIGN KEY (person_id) REFERENCES person (person_id)ON DELETE CASCADE;
ALTER TABLE person_instrument_and_skilllevel ADD CONSTRAINT FK_person_instrument_and_skilllevel_1 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id)ON DELETE CASCADE;
ALTER TABLE person_instrument_and_skilllevel ADD CONSTRAINT FK_person_instrument_and_skilllevel_2 FOREIGN KEY (skilllevel_id) REFERENCES skilllevel_and_price (skilllevel_id)ON DELETE CASCADE;


ALTER TABLE rental_records ADD CONSTRAINT FK_rental_records_0 FOREIGN KEY (rentable_instrument_id) REFERENCES rentable_instrument (rentable_instrument_id)ON DELETE CASCADE;
ALTER TABLE rental_records ADD CONSTRAINT FK_rental_records_1 FOREIGN KEY (person_id) REFERENCES student (person_id)ON DELETE CASCADE;


