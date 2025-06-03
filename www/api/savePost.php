<?php

require_once("../php/functionsSQL.php");

const Extension = ".jpg";

function checkParams($json) : bool {
    if (!is_int($json['likes']) || $json['likes'] < 0) {
        return false;
    }
    if (!is_string($json['title']) || strlen($json['title']) > 200) {
        return false;
    }
    return true;
}

function generateName($json) : string {
    $rand = rand();
    return $json['created_by'].$rand.time();
}


$method = $_SERVER['REQUEST_METHOD'];
if ($method == "POST") {
    $connection = connectDatabase();
    $json = [];

    session_name("auth");
    session_start();
    print_r($_SESSION);
    $userId = $_SESSION['user_id'] ?? null;

    if ($userId === null) {
        header("This user does not found", true, 401);
        exit();
    }
    $json = json_decode(file_get_contents($_FILES['json']['tmp_name']), true);
    $json['created_by'] = $userId; 

    $json['images'] = [];

    if (checkParams($json)) {
        foreach($_FILES['images']['tmp_name'] as $image) {
            $name = generateName($json);
            $name = $name.Extension;
            move_uploaded_file($image, PathToImg.$name); 
            array_push($json['images'], $name);
        }
        echo savePostToDatabase($connection, $json);
    } else {
        throw new Exception("Wrong params");
    }

}  else {
    throw new Exception("Wrong method");
}  

?>