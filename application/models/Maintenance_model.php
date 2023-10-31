<?php
class Maintenance_model extends CI_Model {
   
    public function show( $column = null, $queryEntity = 'maintenance' ) {
        $this->db->select("*");
        if(!is_null($column)){ 

            if($this->db->get($queryEntity)->result_id->num_rows > 0){  
                $this->db->where( key($column),  $column[key($column)]); 
                
                return $this->db->get($queryEntity)->result_array();
            }                
              
        }else{             
            
            if($this->db->get($queryEntity)->result_id->num_rows > 0)
                    return $this->db->get($queryEntity)->result_array();
            return false;  

        }   
        
        
    }
    
    public function insert($license_plate, $reason, $description){        
        $data = array(
            'license_plate_vehicles_customer_fk' => $license_plate,
            'reason' => $reason,
            'description' => $description
        );        
        
        if(!$this->db->insert('maintenance', $data)){
            $db_error = $this->db->error();        
            if (!empty($db_error)) {            
                throw new Exception($db_error['message']);
                return false; 
            }
        }

    }
    
    public function delete($id){        
        try{    
            $this->db->query("CALL sp_delete_maintenance('$id')"); 
           
        }catch(Exception $e){	
            throw new Exception($e);       
        }        
    }

    

}