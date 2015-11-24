-- report page
select ename, emp_id, type, emp_email, emp_office, emp_phone, emp_status, status_eff, lab_name, right
  from F15B5_EMP e, F15B5_lab l, F15B5_auth a
where emp_id = :P2_EMP AND e.F15B5_lab_lab_id = l.lab_id AND e.F15B5_auth_auth_id = a.auth_id

-- view rfes
SELECT UNIQUE rfe_id, explanation, alt_protect, approval_rev, rfe_status, ename as Submitter
FROM F15B5_emp e JOIN F15B5_rfe r ON e.emp_id = r.F15B5_emp_emp_id
     JOIN F15B5_status s ON r.F15B5_status_status_id = s.status_id
     JOIN F15B5_auth a ON e.F15B5_auth_auth_id = a.auth_id
     LEFT JOIN Contacts con ON r.rfe_id = con.F15B5_rfe_rfe_id
     LEFT JOIN Contacts con ON e.emp_id = con.F15B5_emp_emp_id
     LEFT JOIN Approvers app ON r.rfe_id = app.F15B5_rfe_rfe_id
     LEFT JOIN Approvers app ON e.emp_id = app.F15B5_emp_emp_id
WHERE r.F15B5_emp_emp_id = (CASE WHEN a.auth_id = 1 THEN :P2_EMP 
                    ELSE Null END) 
      OR :P2_EMP = con.F15B5_emp_emp_id 
      OR :P2_EMP = app.F15B5_emp_emp_id

-- comments
select UNIQUE COMM_ID,
       ENTRY_DATE,
       COMMENTS
  from F15B5_COMM c, F15B5_rfe r
  where c.F15B5_rfe_rfe_id = :P5_rfe_id 

 -- documents
 select DOC_ID ,
       FILENAME,
       MIMETYPE,
       CHARSET,
       FILE_BLOB,
       FILE_COM,
       TAGS
  from F15B5_DOC d JOIN F15B5_rfe r ON d.F15B5_rfe_rfe_id = r.rfe_id 

-- history
select hist_id, eff_date, rfe_status, description
from F15B5_HIST h JOIN F15B5_RFE r ON h.F15B5_rfe_rfe_id = r.rfe_id
                  JOIN F15B5_STATUS s ON s.status_id = r.F15B5_status_status_id

-- tasks
select task_id, eff_Date, task_abbr, task_desc
from F15B5_TASK t, rfe_task rt, F15B5_rfe r
where r.rfe_id = rt.F15B5_rfe_rfe_id AND rt.F15B5_task_task_id = t.task_id

-- Contacts
select UNIQUE emp_id, ename, emp_email, emp_phone, emp_office 
from Contacts c, F15B5_rfe r, F15B5_emp e
where r.rfe_id = c.F15B5_rfe_rfe_id and c.F15B5_emp_emp_id = e.emp_id

-- approvers
select UNIQUE emp_id, type, ename, emp_email, emp_phone, emp_office 
from F15B5_rfe r JOIN approvers a ON r.rfe_id = a.F15B5_rfe_rfe_id
                 JOIN F15B5_emp e ON a.F15B5_emp_emp_id = e.emp_id









