<?php
include './conn.php';

// Ensure the request method is POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    header("Access-Control-Allow-Origin: *");
    $xok = 401;

    // Get user input
    $email = mysqli_real_escape_string($conn, $_POST['email']);
    $password = mysqli_real_escape_string($conn, $_POST['password']);

    // ตรวจสอบว่ามีค่า email และ password ที่ถูกส่งมาหรือไม่
    $stmt = mysqli_prepare($conn, "SELECT * FROM register WHERE email = ? AND password = ?");
    mysqli_stmt_bind_param($stmt, "ss", $email, $password);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);

    // Check if the query was successful
    if ($result) {
        $output = array();

        // Fetch results
        while ($row = mysqli_fetch_assoc($result)) {
            $output[] = $row;
            $xok = 200;
        }

        // Send response code and JSON data
        http_response_code($xok);
        echo json_encode($output);
    } else {
        // Send error response code
        http_response_code(500);
        echo json_encode(array("message" => "Internal Server Error"));
    }

    // Close prepared statement
    mysqli_stmt_close($stmt);

    // Close database connection
    mysqli_close($conn);
} else {
    // Invalid request method
    http_response_code(405); // Method Not Allowed
    echo json_encode(array("message" => "Invalid Request Method"));
}