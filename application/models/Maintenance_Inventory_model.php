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
    
    public function insert($reference_number, $id_maintenance, $quantity
    ){             
        $data = array(
            'reference_number' => $reference_number,
            'id_maintenance' => $id_maintenance,
            'quantity' => $quantity
        );        
        
        if(!$this->db->insert('maintenance_inventory', $data)){
            $db_error = $this->db->error();        
            if (!empty($db_error)) {            
                throw new Exception($db_error['message']);
            }
        }

    }
    
        
    public function delete($reference_number,  $quantity){        

        $data = array(
            'reference_number' => $reference_number,
            'quantity' => $quantity                    
        );         
          
        $resultset = $this->db->query("CALL sp_delete_maintenance_inventory('$data[reference_number]', '$data[quantity]')")->result_array();
        return array('status'=> intval(explode('/',$resultset[0]['track_no'])[0]), 'mensage'=> $resultset[0]['@full_error']);  

    }

    public function updateQuantityMaintenanceInventory($referenceNumber, $newQuanityMaintenanceInventory, $newQuanityInventory){   
        $data = array(
            'reference_number' => $referenceNumber,
            'quantity_maintenance_inventory' => $newQuanityMaintenanceInventory,
            'quantity_inventory' => $newQuanityInventory            
         );                          
        
        $resultset =  $this->db->query("CALL sp_update_maintenance_inventory_inventory('$data[reference_number]', '$data[quantity_maintenance_inventory]','$data[quantity_inventory]')")->result_array();             
        
        return array('status'=> intval(explode('/',$resultset[0]['track_no'])[0]), 'mensage'=> $resultset[0]['@full_error']); 

    }
    

}