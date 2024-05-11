<?php
require_once __DIR__.'/../_.php';
require_once __DIR__ . '/Faker/autoload.php';
$faker = Faker\Factory::create();

try{

  $db = _db();
  $q = $db->prepare('DROP TABLE IF EXISTS items');
  $q->execute();

  // Get users whom are partners to assign to items
  $user_role_name = 'partner';
  $q = $db->prepare("SELECT user_id FROM users WHERE user_role_name == '$user_role_name'");
  $q->execute();
  $users_ids = $q->fetchAll(PDO::FETCH_COLUMN); // ["admin","partner","user","employee"]
  // echo json_encode($users_ids); exit();
  $q = $db->prepare('
    CREATE TABLE items(
      item_id                   TEXT,
      item_name                 TEXT,
      item_price                TEXT,
      item_created_at           TEXT,
      item_updated_at           TEXT,
      item_deleted_at           TEXT,
      item_created_by_user_fk   TEXT,
      PRIMARY KEY (item_id)
    )
  ');
  $q->execute();
  $values = '';
  for($i = 0; $i < 100; $i++){
    $item_id = bin2hex(random_bytes(16));
    $item_name = str_replace("'", "''", $faker->unique->word);
    $item_price = rand(2, 150);
    $item_created_at = time();
    $item_updated_at = 0;
    $item_deleted_at = 0;
    $item_created_by_user_fk = $users_ids[array_rand($users_ids)];
    $values .= "('$item_id', '$item_name', $item_price, $item_created_at, $item_updated_at, $item_deleted_at, '$item_created_by_user_fk'),";
  }
  $values = rtrim($values, ',');  
  $q = $db->prepare("INSERT INTO items VALUES $values");
  $q->execute();

  echo "+ items".PHP_EOL;
}catch(Exception $e){
  echo $e;
}









