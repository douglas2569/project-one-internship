<?php
class Maintenance_Inventory_model extends CI_Model {
   
    public function show( $columns = null, $queryEntity = 'maintenance_inventory' ) {
        $this->db->select("*");
        if(!is_null($columns)){             
            if($this->db->get($queryEntity)->result_id->num_rows > 0){  
               
                foreach($columns as $key => $column){                     
                    $this->db->where( $key,  $column);
                }
                
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
    
    public function insert($reference_number, $id_maintenance, $inventoryQuantity, $maintenanceInventoryQuantity
    ){             
        $data = array(
            'reference_number' => $reference_number,
            'id_maintenance' => $id_maintenance,
            'inventory_quantity' => $inventoryQuantity,
            'maintenance_inventory_quantity' => $maintenanceInventoryQuantity
        ); 

                
        $resultset = $this->db->query("CALL sp_register_maintenance_inventory('$data[reference_number]','$data[id_maintenance]', '$data[inventory_quantity]', '$data[maintenance_inventory_quantity]')")->result_array();
        return array('status'=> intval(explode('/',$resultset[0]['track_no'])[0]), 'mensage'=> $resultset[0]['@full_error']); 
        
        

    }
    
        
    public function delete($reference_number,  $quantity){        

        $data = array(
            'reference_number' => $reference_number,
            'quantity' => $quantity                    
        );         
          
        $resultset = $this->db->query("CALL sp_delete_maintenance_inventory('$data[reference_number]', '$data[quantity]')")->result_array();
        return array('status'=> intval(explode('/',$resultset[0]['track_no'])[0]), 'mensage'=> $resultset[0]['@full_error']);  

    }

    public function updateQuantityMaintenanceInventory($idMaintenance, $referenceNumber, $newQuanityMaintenanceInventory, $newQuanityInventory){   
        $data = array(
            'id_maintenance' => $idMaintenance,
            'reference_number' => $referenceNumber,
            'quantity_maintenance_inventory' => $newQuanityMaintenanceInventory,
            'quantity_inventory' => $newQuanityInventory            
         );                          
        
        $resultset =  $this->db->query("CALL sp_update_maintenance_inventory_inventory('$data[id_maintenance]', '$data[reference_number]', '$data[quantity_maintenance_inventory]','$data[quantity_inventory]')")->result_array();             
        
        return array('status'=> intval(explode('/',$resultset[0]['track_no'])[0]), 'mensage'=> $resultset[0]['@full_error']); 

    }    
    

}