<!DOCTYPE html>
<html lang = "ru">
    <head>
        <meta charset="UTF-8">
        <title>Вычисление значения</title> 
    </head>
    <body>
        <form action="PolishNotation.php" method="post">
            <label>Введите выражение</label>
            <input type="text" name="expression" required>
            <button type="submit">Вычислить</button>
        </form>
    </body>
</html>

<?php
if (isset($_POST['expression'])) {
     $expression = $_POST['expression'];
     $expression = str_replace(" ", "", $expression);

     $result = [];

     while (strlen($expression) > 0) {
          $char = mb_substr($expression, 0, 1);
          $expression = mb_substr($expression, -(strlen($expression) - 1), strlen($expression) - 1);
          if ($char >= 0 && $char <= 9) {
               array_push($result, $char);
          } else {
               $b = array_pop($result);
               $a = array_pop($result);

               switch ($char) {
                    case "+":
                         array_push($result, $a + $b);
                         break;
                    case "-":
                         array_push($result, $a - $b);
                         break;
                    case "*":
                         array_push($result, $a * $b);
                         break;
                    case "/":
                         array_push($result, $a / $b);
                         break;
                    default:
                         echo "Некорректная операция";
                         echo "<br>";
               }
          }
     }

     if(isset($result['0'])) {
          echo $result['0'];
     } else {
          echo "Ошибка";
     }

}
?>
