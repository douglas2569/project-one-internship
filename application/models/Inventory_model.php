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
        try{        
            $this->db->query("CALL sp_invetory('$data[address]', '$data[reference]', '$data[name]', '$data[brand]',
            '$data[description]', '$data[unitValue]', '$data[quantity]')"); 
        }catch(Exception $e){	
            throw new Exception($e);
        }

    }

    

}