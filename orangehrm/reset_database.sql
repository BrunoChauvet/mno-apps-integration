DELETE FROM mno_id_map;
UPDATE ohrm_organization_gen_info SET name = null, tax_id = null, registration_number = null, phone = null, fax = null, email = null, country = null, province = null, city = null, zip_code = null, street1 = null, street2 = null, note = null;
DELETE FROM hs_hr_employee;
DELETE FROM ohrm_job_title;
DELETE FROM ohrm_location;
DELETE FROM ohrm_customer;
DELETE FROM ohrm_project;
DELETE FROM ohrm_project_activity;
