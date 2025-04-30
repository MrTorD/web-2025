<!DOCTYPE html>
<html lang = "ru">
    <head>
        <meta charset="UTF-8">
        <title>Конвертация числа</title> 
    </head>
    <body>
        <form action="Convert.php" method="post">
            <label>Введите число</label>
            <input type="number" name="digit" required>
            <button type="submit">Вычислить</button>
        </form>
    </body>
</html>

<?php
if (isset($_POST['digit'])) {
     $digit = $_POST['digit'];
     switch ($digit) {
          case 0:
               echo "Ноль";
               break;
          case 1: 
               echo "Один";
               break;
          case 2: 
               echo "Два";
               break;
          case 3: 
               echo "Три";
               break;
          case 4: 
               echo "Четыре";
               break;
          case 5: 
               echo "Пять";
               break;
          case 6: 
               echo "Шесть";
               break;
          case 7: 
               echo "Один";
               break;
          case 8:
               echo "Восемь";
               break;
          case 9:
               echo "Девять";
               break;
          default:
               echo "Некорректное число";
     }  
}
?>