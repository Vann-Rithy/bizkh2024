<?php
header('Content-Type: application/json');
$conn = new mysqli('localhost', 'plexustrust_user_api', '5o{B@ki_zu)w', 'plexustrust_api');

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

function numerology_sum($number) {
    $sum = 0;
    while ($number > 0) {
        $sum += $number % 10;
        $number = (int)($number / 10);
    }
    if ($sum > 9) {
        return numerology_sum($sum);
    }
    return $sum;
}

$phone_number = $_POST['phone_number'];
$number_sum = numerology_sum((int)$phone_number);

$prediction = '';

switch ($number_sum) {
    case 1:
        $prediction = 'ល្អ';
        break;
    case 2:
        $prediction = 'មធ្យម';
        break;
    case 3:
        $prediction = 'អាក្រក់';
        break;
    case 4:
        $prediction = 'ល្អ';
        break;
    case 5:
        $prediction = 'មធ្យម';
        break;
    case 6:
        $prediction = 'ល្អ';
        break;
    case 7:
        $prediction = 'អាក្រក់';
        break;
    case 8:
        $prediction = 'មធ្យម';
        break;
    case 9:
        $prediction = 'ល្អ';
        break;
    default:
        $prediction = 'មិនស្គាល់';
        break;
}

$sql = "INSERT INTO phone_predictions (phone_number, prediction) VALUES ('$phone_number', '$prediction')";
$conn->query($sql);

$response = [
    'phone_number' => $phone_number,
    'prediction' => $prediction
];

$conn->close();

echo json_encode($response);
?>
