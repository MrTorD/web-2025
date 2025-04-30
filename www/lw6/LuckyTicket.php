<!DOCTYPE html>
<html lang = "ru">
    <head>
        <meta charset="UTF-8">
        <title>Вычисление счастливого билета</title> 
    </head>
    <body>
        <form action = "" method="post">
            <label>Введите числа</label>
            <input type="number" name="num1" id="num1" required>
            <input type="number" name="num2" id="num2" required>
            <button type="submit">Вычислить</button>
        </form>
     </body>
</html> 

<?php

if (isset($_POST['num1']) && isset($_POST['num2'])) {
     $num1 = $_POST['num1'];
     $num2 = $_POST['num2'];

     function CheckForLuck(int $num): bool {
          $left_part = intdiv($num, 100000) + intdiv($num, 10000) % 10 + intdiv($num, 1000) % 10;
          $right_part = intdiv($num % 1000, 100) + intdiv($num % 100, 10) + $num % 10;
          if ($left_part == $right_part) {
               return true;
          } else {
               return false;
          }
     } 

     while ($num1 <= $num2) {
          if (CheckForLuck($num1)) {
               echo $num1;
               echo "<br>";
          };
          $num1 = $num1 + 1;
     }       
}

?>

