<?php

const  salt = "Salt";

require_once("../php/functionsSQL.php");

$method = $_SERVER['REQUEST_METHOD'];

if ($method != "POST") {
    throw new Exception("Wrong Method");
} else {
    $json = [];
    $json = json_decode(file_get_contents($_FILES['json']['tmp_name']), true);

    $login = $json['login'];
    $password = $json['password'];

    $password = hashPassword($password, salt);

    $connection = connectDataBase();

    $user = authUser($connection, $login, $password);

    if ($user == null) {
        header("This user does not exist", true, 401);
        exit();
    } else {
        $userId = $user['id'];
        $userName = $user['name'];
        session_name("auth");
        session_start();
        $_SESSION['user_id'] = $userId;
        $_SESSION['user_name'] = $userName;
    }
}


function hashPassword($password, $salt) 
{

    return $password = md5($password.$salt);

}














?>