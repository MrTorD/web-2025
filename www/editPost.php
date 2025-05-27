<?php

require_once("php/functionsSQL.php");
$connection = connectDatabase();

$post = findPostInDatabase($connection, $_GET['post-id']);
?>
<!DOCTYPE html>
<html lang = "ru">
    <head>
        <meta charset="UTF-8">
        <title>Редактировать пост</title> 
        <link href="css/addPost.css" rel="stylesheet">  
        <script defer src="js/slider.js"></script>
        <script defer src="js/editPost.js"></script> 
    </head>
    <body>
        <input type="file" id="upload" style="display: none;" multiple>
        <div class="add-post">
            <div class="add-post__sidebar">
                <img id="home" class="add-post__sidebar__icon" src="images/Home 24.png">
                <img id="profile" class="add-post__sidebar__icon" src="images/User 24.png">
                <img id="add" class="add-post__sidebar__icon" src="images/Plus 24.png">
            </div>
            <div class="add-post__interface">
                <p class="add-post__interface__created-by" style="display: none"><?=$post['created_by']?></p>
                <p class="add-post__interface__post-id" style="display: none"><?=$_GET['post-id']?></p>
                <div class="add-post__interface__window">
                    <div class="posts__post__slider">
                            <img class="posts__post__slider__left-button" src="images/Slider Button left.png">
                            <img class="posts__post__slider__right-button" src="images/Slider Button right.png">
                            <?php
                                foreach ($post['images'] as $image) {
                                    echo "<img class='posts__post__slider__image' src='images/", $image, "'>";
                                }
                            ?>
                        </div>
                    <div class="add-post__interface__window__content">

                    </div>
                </div>
                <label for="upload" class="add-post__interface__add-photo">
                    <img class="add-post__interface__add-photo__img" src="images/Plus-square 16.png">
                    Добавить фото
                </label>
                <?="<input type='text' class='add-post__interface__add-title' placeholder='Добавьте подпись...' value='", $post['title'],"'>" ?>
                <button class="add-post__interface__submit">Изменить</button>
            </div>
        </div>
        <div class="success">
            <h2>Пост успешно сохранен!</h2>
        </div>
    </body>
</html>