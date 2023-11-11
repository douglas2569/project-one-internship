<?php
class Permissions_model extends CI_Model {
   
    public function show( $column = null, $queryEntity = 'permissions' ) {
        $this->db->select("*");
        if(!is_null($column)){ 
            
            if($this->db->get($queryEntity)->result_id->num_rows > 0){  
                $this->db->where( key($column),  $column[key($column)]); 
                
                return $this->db->get($queryEntity)->result_array();
            }else{
                return array(); 
            }                
            
              
        }else{             
            
            if($this->db->get($queryEntity)->result_id->num_rows > 0)
                    return $this->db->get($queryEntity)->result_array();
            return false;  

        }   
        
        
    }
    

       

}