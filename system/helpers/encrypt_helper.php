<?php
function encryptHash($string, $type='one-way'){
    if(empty($string)){
       return $string; 
    }
    
    if($type == 'md5'){
        return md5($string);
    }

    return password_hash($string, PASSWORD_DEFAULT);
}