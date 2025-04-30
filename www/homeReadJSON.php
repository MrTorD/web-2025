<?php
    function addUserInfo ($post,  $users)   {
        foreach ($users as $user) {
            if ($user['id'] == $post['created_by']) {
                return $user + $post;
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
                $post = array_pop($posts);
                $post = addUserInfo($post, $users);
            ?>    

            <img class="avatar" src="<?php echo $post['avatar']?>" alt="Аватар">
            <p class="name"><?php echo $post['name']; ?></p>
            <img class="post" src="<?php echo $post['img'] ?>">
            <button name="like">❤️<?php echo $post['likes']?></button>
            <p><?php echo $post['title']?></p>
            <p class="time"><?php echo date("d.m.y h:i", $post['timestamp']) ?></p>

            <?php 
                $post = array_pop($posts);
                $post = addUserInfo($post, $users);
            ?>   

            <img class="avatar" src="<?php echo $post['avatar']?>" alt="Аватар">
            <p class="name"><?php echo $post['name']; ?></p>
            <img class="post" src="<?php echo $post['img'] ?>">
            <button name="like">❤️<?php echo $post['likes']?></button>
            <p><?php echo $post['title']?></p>
            <p class="time"><?php echo date("d.m.y h:i", $post['timestamp']) ?></p>

            <?php 
                $post = array_pop($posts);
                $post = addUserInfo($post, $users);
            ?>   

            <img class="avatar" src="<?php echo $post['avatar']?>" alt="Аватар">
            <p class="name"><?php echo $post['name']; ?></p>
            <img class="post" src="<?php echo $post['img'] ?>">
            <button name="like">❤️<?php echo $post['likes']?></button>
            <p><?php echo $post['title']?></p>
            <p class="time"><?php echo date("d.m.y h:i", $post['timestamp']) ?></p>
            
        </div>    
    </body>
</html>