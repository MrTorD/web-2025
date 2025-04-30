
<!DOCTYPE html>
<html lang = "ru">
    <head>
        <meta charset="UTF-8">
        <title>Определение знака зодиака</title> 
    </head>
    <body>
        <form action="ZodiacAdd.php" method="post">
            <label>Введите дату</label>
            <input type="text" name="date" required>
            <button type="submit">Определить</button>
        </form>
    </body>
</html>    

<?php
function convertMonthToInt(string $month) : int {
     $month = mb_strtolower($month);
     switch ($month) {
          case "january":
               return 1;
               break;
          case "february":
               return 2;
               break;
          case "march":
               return 3;
               break;
          case "april":
               return 4;
               break;
          case "may":
               return 5;
               break;
          case "june":
               return 6;
               break;
          case "july":
               return 7;
               break;
          case "august":
               return 8;
               break;
          case "september":
               return 9;
               break;
          case "october":
               return 10;
               break;
          case "november":
               return 11;
               break;
          case "december":
               return 12;
               break; 
          default:
               return 0;                                
     }
}
function ParseDate(string $recievedData) {
     $array = [];
     if (str_contains($recievedData, ".")) {
          $array = explode(".", $recievedData);
     } elseif (str_contains($recievedData, " ")) {
          $array = explode(" ", $recievedData);
     } elseif (str_contains($recievedData, "-")) {
          $array = explode("-", $recievedData);
     }
     $date = [];


     foreach ($array as $elm) {
          if ($elm > 12 && $elm <= 31) {
               $date['day'] = $elm;
          } elseif ($elm > 0 && $elm <= 12 &&!isset($date['month'])) {
               $date['month'] = $elm;
          } elseif ($elm > 0 && $elm <= 12 && isset($date['month'])) {
               $date['day'] = $elm;
          } elseif ((int)$elm == false) {
               if(convertMonthToInt($elm) != 0) {
                    $date['month'] = convertMonthToInt($elm);  
               }
          }       
           
     }

     return $date;
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

     $date = ParseDate($RecievedDate);

     if(isset($date['day']) && isset($date['month'])) {
          echo DefineZodiac($date['day'], $date['month']);
     } else {
          echo "Ошибка";
     }

}
?>