<!DOCTYPE html>
<html lang = "ru">
    <head>
        <meta charset="UTF-8">
        <title>Определение знака зодиака</title> 
    </head>
    <body>
        <form action="Zodiac.php" method="post">
            <label>Введите дату в формате ДД.ММ.ГГГГ</label>
            <input type="text" name="date" required>
            <button type="submit">Определить</button>
        </form>
    </body>
</html>    
<?php

function ParseDate(string $date) {  
     $array = explode(".", $date);
     $parsed = [];
     foreach ($array as $num) {
          if ($num <= 31) {
               array_push($parsed, $num);
          }
     }     
     return $parsed;
}

function DefineZodiac(int $day, int $month): string {
     if (($day >= 21 && $month == 3) || ($day <= 20 && $month == 4)) {
          
          return "Овен";

     } elseif (($day >= 21 && $month == 4) || ($day <= 20 && $month == 5)) {
         
          return "Телец";

     } elseif (($day >= 21 && $month == 5) || ($day <= 21 && $month == 6)) {
          
          return "Близнецы";

     } elseif (($day >= 22 && $month == 6) || ($day <= 22 && $month == 7)) {
          
          return "Рак";

     } elseif (($day >= 23 && $month == 7) || ($day <= 23 && $month == 8)) {
         
          return "Лев";

     } elseif (($day >= 24 && $month == 8) || ($day <= 23 && $month == 9)) {
          
          return "Дева";

     } else if (($day >= 24 && $month == 9) || ($day <= 23 && $month == 10)) {
          
          return "Весы";
          
     } else if (($day >= 24 && $month == 10) || ($day <= 22 && $month == 11)) {
         
          return "Скорпион";

     } elseif (($day >= 23 && $month == 11) || ($day <= 21 && $month == 12)) {
          
          return "Стрелец";

     } elseif (($day >= 22 && $month == 12) || ($day <= 20 && $month == 1)) {
          
          return "Козерог";

     } elseif (($day >= 21 && $month == 1) || ($day <= 20 && $month == 2)) {
          
          return "Водолей";

     } elseif (($day >= 21 && $month == 2) || ($day <= 20 && $month == 3)) {
          
          return "Рыбы";

     } else {

          return "Ошибка";

     }

}

if (isset($_POST['date'])) {
     $RecievedDate = $_POST['date'];

     $ParsedDate = ParseDate($RecievedDate);

     echo DefineZodiac($ParsedDate[0], $ParsedDate[1]);
}

?>