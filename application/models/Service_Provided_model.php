<?php
class Service_provided_model extends CI_Model {
   
    public function show( $column = null, $queryEntity = 'services_provided' ) {
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
    
    public function insert($idMaintenance, $cpfMechanics, $serviceId, $quantity
    ){             
        $data = array(
            'id_maintenance_fk' => $idMaintenance,
            'cpf_mechanics_fk' => $cpfMechanics,
            'id_services_fk' => $serviceId,
            'quantity' => $quantity
        );        
        
        if(!$this->db->insert('services_provided', $data)){
            $db_error = $this->db->error();        
            if (!empty($db_error)) {            
                throw new Exception($db_error['message']);
            }
        }

    }
    
        
    public function delete($id){ 
        $this->db->where('id', $id);                     
        return $this->db->delete('services_provided');  

    }

    public function updateOnlyQuantity($serviceId , $quantity){
        $data = array(                        
            'quantity' => $quantity,
         );
                          
            
        $this->db->where('id_services_fk', $serviceId);
        
        if(!$this->db->update('services_provided', $data)){
            $db_error = $this->db->error();        
            if (!empty($db_error)) {            
                throw new Exception($db_error['message']);                
            }
        }
    }

       

}