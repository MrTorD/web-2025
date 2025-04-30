    <img style='height: 32px; width: 32px'class='avatar' echo src="<?php echo PathToImg.$post['avatar']?>" alt="Аватар">
    <p class="name"><?php echo $post["name"]; ?></p>
    <img class="post" src="<?php echo PathToImg.$post["img"] ?>">
    <button name="like">❤️<?php echo $post["likes"]?></button>
    <p><?php echo $post["title"]?></p>
    <p class="time"><?php echo $post["created_at"]?></p>
   