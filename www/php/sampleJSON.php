    <img class="avatar" echo src="<?php echo $fullPostInfo['avatar']?>" alt="Аватар">
    <p class="name"><?php echo $fullPostInfo["name"]; ?></p>
    <img class="post" src="<?php echo $fullPostInfo["img"] ?>">
    <button name="like">❤️<?php echo $fullPostInfo["likes"]?></button>
    <p><?php echo $fullPostInfo["title"]?></p>
    <p class="time"><?php echo date("d.m.y h:i:s", $fullPostInfo["timestamp"])?></p>
