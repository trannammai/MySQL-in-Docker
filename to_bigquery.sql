CREATE TABLE bq_data
SELECT id_std, name_std, dob_std, name_sch, name_crs, date_regist
FROM   (SELECT id_crs, name_crs, date_regist, id_std_fk
        FROM courses AS crs 
        JOIN studying AS sdn ON crs.id_crs = sdn.id_crs_fk
        ) AS sub1

JOIN   (SELECT id_std, name_std, dob_std, name_sch
        FROM students AS std 
        JOIN schools AS sch ON std.id_sch_fk = sch.id_sch) AS sub2
ON sub1.id_std_fk = sub2.id_std; 
$$