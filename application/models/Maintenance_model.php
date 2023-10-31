<?php
class Maintenance_model extends CI_Model {
   
    public function show( $column = null, $queryEntity = 'v_maintenance_inventory' ) {         
        
        $this->db->select("*");

        if(!is_null($column)){
            $this->db->where( key($column),  $column[key($column)]);            
            
            return $this->db->get($queryEntity)->result_array();
        }        
        
        return $this->db->get($queryEntity)->result_array();
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
            $this->db->query("CALL sp_delete_maintance('$id')"); 
           
        }catch(Exception $e){	
            throw new Exception($e);       
        }        
    }

    

}