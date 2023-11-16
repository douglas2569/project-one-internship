<?php
function passwordVerifyHash($password, $hash){
    if(empty($hash)){
       return $hash; 
    }

    return password_verify($password, $hash);
}