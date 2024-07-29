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

$phone_number = isset($_POST['phone_number']) ? $_POST['phone_number'] : '';

if (!preg_match('/^\d+$/', $phone_number)) {
    echo json_encode(['error' => 'Invalid phone number']);
    $conn->close();
    exit();
}

$number_sum = numerology_sum((int)$phone_number);

$prediction = '';
$details = '';

switch ($number_sum) {
    case 1:
        $prediction = 'ល្អ'; // Good
        $details = 'អ្នកប្រើលេខនេះចេះពិចារណាមុននឹងធ្វើអ្វីមួយ។ មានទំនាក់ទំនងល្អនៅក្នុងសង្គម។ អ្នកប្រើលេខនេះ​​ការចចរចាទ្រព្យ​មានការសម្រចចិត្តបានខ្ពស់។';
        break;
    case 2:
        $prediction = 'មធ្យម'; // Average
        $details = 'អ្នកប្រើលេខនេះត្រូវការការប្រយុទ្ធយ៉ាងច្រើនក្នុងការប្រើប្រាស់ជីវិតប្រចាំថ្ងៃ។';
        break;
    case 3:
        $prediction = 'អាក្រក់'; // Bad
        $details = 'អ្នកប្រើលេខនេះអាចជួបប្រទៈបញ្ហាប្រសិនបើមិនមានការយកចិត្តទុកដាក់ជាថ្មី។';
        break;
    case 4:
        $prediction = 'ល្អ'; // Good
        $details = 'អ្នកប្រើលេខនេះមានទំនួលខុសត្រូវខ្ពស់ និងការពិចារណា។';
        break;
    case 5:
        $prediction = 'មធ្យម'; // Average
        $details = 'អ្នកប្រើលេខនេះអាចមានការលំបាកក្នុងការប្រឈមមុខនឹងការងារដែលអាចបង្ហាញពីការលំបាកជាក់ស្តែង។';
        break;
    case 6:
        $prediction = 'ល្អ'; // Good
        $details = 'អ្នកប្រើលេខនេះមានភាពអនុភាព និងការប្រកួតប្រជែងប្រសើរជាមួយអ្នកដទៃ។';
        break;
    case 7:
        $prediction = 'អាក្រក់'; // Bad
        $details = 'អ្នកប្រើលេខនេះអាចមានការលំបាកក្នុងការអនុវត្តន៍ផែនការនិងការទទួលបានជោគជ័យ។';
        break;
    case 8:
        $prediction = 'មធ្យម'; // Average
        $details = 'អ្នកប្រើលេខនេះអាចមានភាពចម្រុះក្នុងការអនុវត្តន៍បុគ្គលិកក្នុងការងារ។';
        break;
    case 9:
        $prediction = 'ល្អ'; // Good
        $details = 'អ្នកប្រើលេខនេះស្ថិតនៅក្នុងចំណោមនឹងភាពសកម្មភាព និងការបង្ហាញពីការយកចិត្តទុកដាក់។';
        break;
    default:
        $prediction = 'មិនស្គាល់'; // Unknown
        $details = 'ព័ត៌មាននេះមិនអាចបង្ហាញបាន។';
        break;
}

// Use prepared statements to prevent SQL injection
$stmt = $conn->prepare("INSERT INTO phone_predictions (phone_number, prediction, details) VALUES (?, ?, ?)");
$stmt->bind_param("sss", $phone_number, $prediction, $details);

if ($stmt->execute()) {
    $response = [
        'phone_number' => $phone_number,
        'prediction' => $prediction,
        'details' => $details
    ];
} else {
    $response = ['error' => 'Database error'];
}

$stmt->close();
$conn->close();

echo json_encode($response);
?>
