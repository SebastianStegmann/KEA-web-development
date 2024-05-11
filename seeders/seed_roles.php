<?php
require_once __DIR__.'/../_.php';
require_once __DIR__ . '/Faker/autoload.php';
$faker = Faker\Factory::create();

try{

  $db = _db();
  $q = $db->prepare('DROP TABLE IF EXISTS roles');
  $q->execute();

  $q = $db->prepare('
    CREATE TABLE roles(
      role_id           TEXT,
      role_name         TEXT,
      role_created_at   TEXT,
      role_updated_at   TEXT,
      PRIMARY KEY (role_id)
    )
  ');
  $q->execute();
  $created_at = time();
  // could / should the ids just be 1 2 3 and then refrence them instead
  $q = $db->prepare(" INSERT INTO roles VALUES 
                      ('113201f10aaa410f9b7b9f0a6477b443', 'partner', $created_at, 0),
                      ('a3280a85612746c38a17465530739090', 'customer', $created_at, 0),
                      ('4e8f0d641fff4cd6aed260c4521718e8', 'employee', $created_at, 0)");
  $q->execute();

  echo "+ roles".PHP_EOL;
}catch(Exception $e){
  echo $e;
}









