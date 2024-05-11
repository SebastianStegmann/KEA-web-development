<?php

require_once __DIR__.'/../_.php';
require_once __DIR__ . '/Faker/autoload.php';
$faker = Faker\Factory::create();

try{

  $db = _db();
  $q = $db->prepare('DROP TABLE IF EXISTS employees');
  $q->execute();

  // Get users whom are employees to assign a salary to them
  $user_role_name = 'employee';
  $q = $db->prepare("SELECT user_id FROM users WHERE user_role_name == '$user_role_name'");
  $q->execute();
  $employees_ids = $q->fetchAll(PDO::FETCH_COLUMN); // ["a523cde0aa01318439aff66bf776d7e6","3ab2b29dbee4c17c843884647584ad4c"]
  // echo json_encode($users_ids); exit();
  
  $q = $db->prepare('
    CREATE TABLE employees(
      employee_id                       TEXT,
      employee_salary                   TEXT,
      employee_created_at               TEXT,
      employee_updated_at               TEXT,
      employee_deleted_at               TEXT,
      PRIMARY KEY (employee_id)
    )
  ');
  $q->execute();

  $employee_updated_at = 0; 
  $employee_deleted_at = 0; 
  
  $values = '';
  foreach($employees_ids as $employee_id){
    $employee_salary = rand(3500000, 25000000);
    $employee_created_at = rand(time()-1602343484, time());
    $values .= "('$employee_id', $employee_salary, $employee_created_at, 
    $employee_updated_at, $employee_deleted_at),";
  }
  $values = rtrim($values, ',');  
  $q = $db->prepare("INSERT INTO employees VALUES $values");
  $q->execute();

  echo "+ employees".PHP_EOL;
}catch(Exception $e){
  echo $e;
}














