<?php
class Maintenance_inventory_model extends CI_Model {
   
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
    
    public function insert($automotivePartsId, $referenceNumber, $maintenanceId, $inventoryQuantity, $maintenanceInventoryQuantity
    ){             
        $data = array(
            'automotive_parts_Id' => $automotivePartsId,
            'reference_number' => $referenceNumber,
            'maintenance_id' => $maintenanceId,
            'inventory_quantity' => $inventoryQuantity,
            'maintenance_inventory_quantity' => $maintenanceInventoryQuantity
        ); 

                
        $resultset = $this->db->query("CALL sp_register_maintenance_inventory('$data[automotive_parts_Id]','$data[reference_number]','$data[maintenance_id]', '$data[inventory_quantity]', '$data[maintenance_inventory_quantity]')")->result_array();
        return array('status'=> intval(explode('/',$resultset[0]['track_no'])[0]), 'mensage'=> $resultset[0]['@full_error']); 
        
        

    }
    
        
    public function delete($automotivePartsId, $reference_number,  $quantity){        

        $data = array(
            'automotive_parts_id' => $automotivePartsId,
            'reference_number' => $reference_number,
            'quantity' => $quantity                    
        );         
          
        $resultset = $this->db->query("CALL sp_delete_maintenance_inventory('$data[automotive_parts_id]','$data[reference_number]', '$data[quantity]')")->result_array();
        return array('status'=> intval(explode('/',$resultset[0]['track_no'])[0]), 'mensage'=> $resultset[0]['@full_error']);  

    }

    public function updateQuantityMaintenanceInventory($maintenanceId, $automotivePartsId, $referenceNumber, $newQuanityMaintenanceInventory, $newQuanityInventory){   
        $data = array(
            'maintenance_id' => $maintenanceId,
            'automotive_parts_id' => $automotivePartsId,
            'reference_number' => $referenceNumber,
            'quantity_maintenance_inventory' => $newQuanityMaintenanceInventory,
            'quantity_inventory' => $newQuanityInventory            
         );                          
        
        $resultset =  $this->db->query("CALL sp_update_maintenance_inventory_inventory('$data[maintenance_id]', '$data[automotive_parts_id]', '$data[reference_number]', '$data[quantity_maintenance_inventory]','$data[quantity_inventory]')")->result_array();             
        
        return array('status'=> intval(explode('/',$resultset[0]['track_no'])[0]), 'mensage'=> $resultset[0]['@full_error']); 

    }    
    

}