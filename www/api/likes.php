<?php

require_once("../php/functionsSQL.php");

$connection = connectDatabase();

$json = [];
$json = json_decode(file_get_contents($_FILES['json']['tmp_name']), true);
$post_id = $json['post_id'];


session_name('auth');
session_start();
$user_id = $_SESSION['user_id'] ?? null;

if ($_SESSION['user_id'] == null) {
    header("This user does not exists", true, 401);
    exit();
}

if (changeLikeState($connection, $post_id, $user_id)) {
    echo "true";
} else {
    echo "false";
}

?>