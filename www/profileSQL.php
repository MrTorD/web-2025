<?php
    require_once("php/functionsSQL.php");
    $connection = connectDatabase();
    if (isset($_GET['id'])) {
        $id = $_GET['id'];
    } else {
        $id = 1;
    }
?>    
<!DOCTYPE html>
<html lang = "ru">
    <head>
        <meta charset="UTF-8">
        <title>Профиль</title>
        <link href="css/profile.css" rel="stylesheet">
    </head>
    <body>
        <?php
            try {
                $user = findUserInDatabase($connection, $id);
                $user_posts = findUserPostsInDatabase($connection, $id);
            } catch (RunTimeException) {
                header("Location:homeSQL.php");
                exit();
            }
            
        ?>    
        <img class="avatar" src="<?php echo PathToImg.$user['avatar']?>" alt="Ваня Денисов" height="123" width="123">
        <h1><?php echo $user['name']; ?></h1>
        <p class="description"><?php echo $user['description']?></p> 
        <div class="num_posts">
            <img class="post_img" src="images/posts.png" height="16" width="16">
            <p class="text_posts"><?php echo count($user_posts)?> поста(ов)</p>
        </div>
        <div class="pictures">
            <?php
                foreach ($user_posts as $post) {
                    echo "<img style=\"margin\"src=\"", PathToImg, $post['img'], "\">";
                }
            ?>
        </div>
        </div>
    </body>
</html>