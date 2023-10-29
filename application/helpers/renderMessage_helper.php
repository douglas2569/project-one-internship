<?php
function renderMessage($message){
    
    switch($message['type']){
        case 'error':
            return"
                <div class= 'toast bg-danger show' role='alert' aria-live='assertive' aria-atomic='true'>
                    <div class='toast-body'>
                        <div>".$message["content"]."</div>
                        <button type='button' class='btn-close' data-bs-dismiss='toast' aria-label='Close'></button>
                    </div>  
                </div>
            ";
            
        
            case 'success':                
                return"
                    <div class= 'toast bg-success show' role='alert' aria-live='assertive' aria-atomic='true'>
                        <div class='toast-body'>
                            <div>".$message["content"]."</div>
                            <button type='button' class='btn-close' data-bs-dismiss='toast' aria-label='Close'></button>
                        </div>
                    </div>
                ";               
               
            default:
                return"
                    <div class= 'toast bg-warning show' role='alert' aria-live='assertive' aria-atomic='true'>
                        <div class='toast-body'>
                            <div>".$message["content"]."</div>
                            <button type='button' class='btn-close' data-bs-dismiss='toast' aria-label='Close'></button>
                        </div>
                    </div>
                ";
                
    }    
}