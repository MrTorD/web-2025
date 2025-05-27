<?php

require_once("php/functionsSQL.php");

$connection = connectDatabase();

$json = [];
$json = json_decode(file_get_contents($_FILES['json']['tmp_name']), true);
$post_id = $json['post_id'];
$user_id = $json['user_id'];

if (changeLikeState($connection, $post_id, $user_id)) {
    echo "true";
} else {
    echo "false";
}

?>