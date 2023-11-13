<?php 

    include_once "../app/config.php";
    include_once "../app/lib/Db.php";

    // echo "Test de base de datos";


    $db = new Db;

    $email = "jostace06@gmail.com";
    $pass = "1234567";
    $name = "John";
    $lastname1 = "Sanchez";
    $lastname2 = "Cespedes";
    $result = "";

    // $db->query("{ CALL Clickship_registerClient(?, ?, ?, ?, ?, ?) }");

    // $db->bind(1, $email);
    // $db->bind(2, $pass);
    // $db->bind(3, $name);
    // $db->bind(4, $lastname1);
    // $db->bind(5, $lastname2);
    // $db->bind(6, $result);

    // $db->execute();

    $db->query("{ CALL Clickship_loginClient(?, ?, ?) }");
    $db->bind(1, "jostace06@gmail.com");
    $db->bind(2, "1234567");
    $db->bind(3, $result);

    $db->execute();

    var_dump($db->result());

    $db->dbClose();

?>