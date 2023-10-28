<?php
function checkAuthentication(){
    
    if(!isset($_SESSION['username']) || empty($_SESSION['username'])){
        redirect('index.php/auth/login');  

    }
}