<?php

function CalcFactorial(int $num) : int {
    if ($num <= 1) {
         return 1;
    } 
    return $num * (CalcFactorial($num - 1));
} 

?>

<!DOCTYPE html>
<html lang = "ru">
    <head>
        <meta charset="UTF-8">
        <title>Вычисление факториала</title> 
    </head>
    <body>
        <form action="Factorial.php" method="post">
            <label>Введите число в интервале от 0 до 20</label>
            <input type="number" name="num" required>
            <button type="submit">Вычислить</button>
        </form>
    </body>
</html>    

<?php

if (isset($_POST['num'])) {
     $number = $_POST['num'];
     if ($number >= 0 && $number  <= 20) {
        echo CalcFactorial($number);
     } else {
        echo "Введите число из допустимого диапазона";
     } 
}

?>