<!DOCTYPE html>
<html lang = "ru">
    <head>
        <meta charset="UTF-8">
        <title>Определение високосного года</title> 
    </head>
    <body>
        <form action="LeapYear.php" method="post">
            <label>Введите год</label>
            <input type="number" name="year" required>
            <button type="submit">Определить</button>
        </form>
    </body>
</html>

<?php   
if (isset($_POST['year'])) {
     $year = $_POST['year'];
     if (($year % 4 == 0) && (($year % 100 != 0) || ($year % 400 == 0))) {
          echo "Yes";
     } else {
          echo "No";
     }  
}
?>