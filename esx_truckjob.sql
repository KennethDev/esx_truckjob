USE `es_extended`;

INSERT INTO `jobs` (`name`, `label`) VALUES
  ('trucker', 'Trucker')
;

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
  ('trucker', 0, 'driver', 'Driver', 300, '{"tshirt_1":59,"torso_1":89,"arms":31,"pants_1":36,"decals_2":0,"hair_color_2":0,"helmet_2":0,"hair_color_1":0,"face":2,"torso_2":1,"shoes":35,"hair_1":0,"skin":0,"sex":0,"pants_2":0,"hair_2":0,"decals_1":0,"tshirt_2":0,"helmet_1":5}', '{"tshirt_1":36,"torso_1":0,"arms":68,"pants_1":30,"decals_2":0,"hair_color_2":0,"helmet_2":0,"hair_color_1":0,"face":27,"torso_2":11,"shoes":26,"hair_1":5,"skin":0,"sex":1,"pants_2":2,"hair_2":0,"decals_1":0,"tshirt_2":0,"helmet_1":19}')
;