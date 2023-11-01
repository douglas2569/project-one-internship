<?php
class Inventory_model extends CI_Model {
   
    public function show( $column = null ) {         

        $this->db->select("*");

        if(!is_null($column)){
            $this->db->where( key($column),  $column[key($column)]);            
            
            return $this->db->get("v_inventory")->result_array();
        }    
        
        return $this->db->get("v_inventory")->result_array();
    }  
    
    public function insert($address, $reference, $name, $brand, $description, $unitValue, $quantity){   
        $data = array(
            'address' => $address,
            'reference' => $reference,
            'name' => $name,
            'brand' => $brand,
            'description' => $description,
            'unitValue' => $unitValue,            
            'quantity' => $quantity 
        ); 
        
               
        $resultset = $this->db->query("CALL sp_register_inventory('$data[address]', '$data[reference]', '$data[name]', '$data[brand]',
        '$data[description]', '$data[unitValue]', '$data[quantity]')")->result_array();          
        return array('status'=> intval(explode('/',$resultset[0]['track_no'])[0]), 'mensage'=> $resultset[0]['@full_error']);
    

    }
    
    public function delete($reference){
            
        $resultset = $this->db->query("CALL sp_delete_part_inventory('$reference')")->result_array(); 
        return array('status'=> intval(explode('/',$resultset[0]['track_no'])[0]), 'mensage'=> $resultset[0]['@full_error']);
    

        
    }

    public function update($referenceOld, $address, $referenceNew, $name, $brand, $description, $unitValue, $quantity, $status){   
        $data = array(
            'address' => $address,
            'reference' => $referenceNew,
            'name' => $name,
            'brand' => $brand,
            'description' => $description,
            'unitValue' => $unitValue,            
            'quantity' => $quantity, 
            'status' => $status, 
        ); 
        
               
        $resultset = $this->db->query("CALL sp_update_inventory('$referenceOld','$data[address]', '$data[reference]', '$data[name]', '$data[brand]',
        '$data[description]', '$data[unitValue]', '$data[quantity]', '$data[status]')")->result_array();               
        return array('status'=> intval(explode('/',$resultset[0]['track_no'])[0]), 'mensage'=> $resultset[0]['@full_error']);
        

    }

    public function updateOnlyInventory($reference_number, $quantity){   
        $data = array(
            'quantity' => $quantity
         );                          
            
        $this->db->where('reference_number', $reference_number);
        
        if(!$this->db->update('inventory', $data)){
            $db_error = $this->db->error();        
            if (!empty($db_error)) {            
                throw new Exception($db_error['message']);                
            }
        }

    }

    

}