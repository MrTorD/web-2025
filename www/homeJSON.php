<?php
    function findUserInfo(array $users, array $post) {
        foreach ($users as $user) {
            if ($post['created_by'] == $user['id']) {
                return  $post + $user;
            }
        }
    }

    $posts = json_decode(file_get_contents("json/posts.json"), true);
    $users = json_decode(file_get_contents("json/users.json"), true);

?>
<!DOCTYPE html>
<html lang = "ru">
    <head>
        <meta charset="UTF-8">
        <title>Лента</title>
        <link href="css/home.css" rel="stylesheet">      
    </head>
    <body>
        <div>
            <?php
                foreach ($posts as $post) {
                    $fullPostInfo = findUserInfo($users, $post);
                    if (isset($_GET['id']) && $_GET['id'] == $fullPostInfo['created_by']) {
                        include("php/sampleJSON.php");
                    } elseif (!isset($_GET['id'])) {
                        include("php/sampleJSON.php");
                    }
                }
            ?>  
        </div>  
        <table>
    </body>
</html>