<?php
include("db_query.php");

if ($_SERVER['REQUEST_METHOD'] == 'GET') {

    $result = mysqli_query($bridge, "SELECT * FROM post");
    $list = array();

    while ($rowdata = $result->fetch_assoc()) {
        $list[] = $rowdata;
    }

    echo json_encode($list);
}