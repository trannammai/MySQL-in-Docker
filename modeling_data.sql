ALTER TABLE students MODIFY id_sch_fk FLOAT;
ALTER TABLE studying MODIFY id_std_fk FLOAT;
ALTER TABLE studying MODIFY id_crs_fk FLOAT;

ALTER TABLE students ADD FOREIGN KEY (id_sch_fk) REFERENCES schools(id_sch);
ALTER TABLE studying ADD FOREIGN KEY (id_std_fk) REFERENCES students(id_std);
ALTER TABLE studying ADD FOREIGN KEY (id_crs_fk) REFERENCES courses(id_crs);

ALTER TABLE studying ADD id_studying FLOAT NOT NULL PRIMARY KEY AUTO_INCREMENT;
$$