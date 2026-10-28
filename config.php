<?php
declare(strict_types=1);
session_start();
date_default_timezone_set('Asia/Dhaka');

define('DB_HOST', 'localhost');
define('DB_NAME', 'aastha_grocery');
define('DB_USER', 'root');
define('DB_PASS', '');

// Set these in your hosting control panel before going live.
define('SITE_NAME', 'Aastha');
define('CURRENCY', '৳');

function db(): PDO {
    static $pdo = null;
    if ($pdo instanceof PDO) return $pdo;
    $dsn = 'mysql:host='.DB_HOST.';dbname='.DB_NAME.';charset=utf8mb4';
    $pdo = new PDO($dsn, DB_USER, DB_PASS, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false,
    ]);
    return $pdo;
}
function e(?string $v): string { return htmlspecialchars($v ?? '', ENT_QUOTES, 'UTF-8'); }
function money(float $v): string { return CURRENCY . ' ' . number_format($v, 2); }
function csrf_token(): string {
    if (empty($_SESSION['csrf'])) $_SESSION['csrf'] = bin2hex(random_bytes(32));
    return $_SESSION['csrf'];
}
function verify_csrf(): void {
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $token = $_POST['csrf'] ?? '';
        if (!is_string($token) || !hash_equals(csrf_token(), $token)) {
            http_response_code(419); exit('Session expired. Please go back and try again.');
        }
    }
}
function admin_required(): void {
    if (empty($_SESSION['admin_id'])) { header('Location: login.php'); exit; }
}
function flash(string $message, string $type='success'): void { $_SESSION['flash']=['message'=>$message,'type'=>$type]; }
function show_flash(): void {
    if (!empty($_SESSION['flash'])) {
        $f=$_SESSION['flash']; unset($_SESSION['flash']);
        echo '<div class="notice '.e($f['type']).'">'.e($f['message']).'</div>';
    }
}
