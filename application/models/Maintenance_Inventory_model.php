<?php
class Maintenance_Inventory_model extends CI_Model {
   
    public function show( $column = null, $queryEntity = 'maintenance_inventory' ) {
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
    
    public function insert($reference_number, $id_maintenance
    ){             
        $data = array(
            'reference_number' => $reference_number,
            'id_maintenance' => $id_maintenance
        );        
        
        if(!$this->db->insert('maintenance_inventory', $data)){
            $db_error = $this->db->error();        
            if (!empty($db_error)) {            
                throw new Exception($db_error['message']);
            }
        }

    }
    
        
    public function delete($reference_number){
        $this->db->where('reference_number', $reference_number);                     
        return $this->db->delete('maintenance_inventory');
    }
    

}