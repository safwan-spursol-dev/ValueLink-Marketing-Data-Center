<?php
// PHPMailer Files Include karein
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require 'PHPMailer/src/Exception.php';
require 'PHPMailer/src/PHPMailer.php';
require 'PHPMailer/src/SMTP.php';

function sendMail($to, $name, $subject, $body) {
    $mail = new PHPMailer(true);

    try {
        // --- Server Settings ---
        $mail->isSMTP();                                            // SMTP use karein
        $mail->Host       = 'smtp.gmail.com';                       // Gmail ka SMTP Server
        $mail->SMTPAuth   = true;                                   // Authentication On
        $mail->Username   = 'valuelinkmarketing@gmail.com';                 // APNA GMAIL LIKHO
        $mail->Password   = 'lqjnsvjmwcxrqurn';                  // WO 16-DIGIT APP PASSWORD LIKHO
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;         // Encryption
        $mail->Port       = 587;                                    // Port for TLS

        // --- Recipients ---
        $mail->setFrom('valuelinkmarketing@gmail.com', 'VMDC Admin');       // Bhejne wala (Aap)
        $mail->addAddress($to, $name);                              // Jisko bhejni hai (User)

        // --- Content ---
        $mail->isHTML(true);                                        // HTML format on
        $mail->Subject = $subject;
        $mail->Body    = $body;
        // Agar HTML load na ho to simple text:
        $mail->AltBody = strip_tags($body);

        $mail->send();
        return true;
    } catch (Exception $e) {
        // Error return karein agar fail ho
        return "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
    }
}
?>