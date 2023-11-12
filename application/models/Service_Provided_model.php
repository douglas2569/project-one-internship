<?php
class Service_provided_model extends CI_Model {
   
    public function show( $columns = null, $queryEntity = 'services_provided' ) {
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
    
    public function insert($maintenanceId, $employeesId, $serviceId, $quantity
    ){             
        $data = array(
            'maintenance_id' => $maintenanceId,
            'employees_id' => $employeesId,
            'services_id' => $serviceId,
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

    public function updateOnlyQuantity($serviceId , $employeesId, $quantity){
        $data = array(                        
            'quantity' => $quantity,
         );
                          
            
        $this->db->where('services_id', $serviceId);
        $this->db->where('employees_id', $employeesId);
        
        if(!$this->db->update('services_provided', $data)){
            $db_error = $this->db->error();        
            if (!empty($db_error)) {            
                throw new Exception($db_error['message']);                
            }
        }
    }

       

}