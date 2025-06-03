
<div class="posts__post">
    <div class="posts__post__header">
        <p class="posts__post__header__post-id" style="display:none"><?=$post['post_id']?></p>
        <div class="posts__post__header__user">
            <img class="posts__post__header__user__avatar" src="<?php echo PathToImg.$post['avatar']?>" alt="Avatar">
            <p class="posts__post__header__user__name"><?= $post["name"]?></p>
        </div>
        <img class="posts__post__header__edit" src="images/edit 24.png">
    </div>
    <div class="posts__post__slider">
        <img class="posts__post__slider__left-button" src="images/Slider Button left.png">
        <img class="posts__post__slider__right-button" src="images/Slider Button right.png">
        <?php foreach ($post['images'] as $image) 
            echo ('<img class="posts__post__slider__image" src='.PathToImg.$image.'>');
        ?>
    </div>
    <button class=<?=($post['isLiked'] == "true") ? "posts__post__likes_true" : "posts__post__likes_false"?> name="likes">❤️<?=$post["likes"]?></button>
    <p class="posts__post__title"> <?= $post["title"]?>
    </p>
    <p class="posts__post__time"><?= $post["created_at"]?></p>
</div>
