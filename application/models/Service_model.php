<?php
class Service_model extends CI_Model {
   
    public function show( $column = null, $queryEntity = 'services' ) {
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
    
    public function insert($name, $description, $estimatedTime, $cost, $cnpj_auto_vehicle_workstops_fk = '01187817000183'){             
        $data = array(
            'name' => $name,
            'description' => $description,
            'estimatedTime' => $estimatedTime,
            'cost' => $cost,
            'cnpj_auto_vehicle_workstops_fk' => $cnpj_auto_vehicle_workstops_fk,
        );        
        
        if(!$this->db->insert('services', $data)){
            $db_error = $this->db->error();        
            if (!empty($db_error)) {            
                throw new Exception($db_error['message']);
            }
        }

    }
    
        
    public function delete($id){        

        $this->db->where('id', $id);                     
        return $this->db->delete('services');

    }

    public function update($id, $name, $description, $estimatedTime, $cost, $status){   
        $data = array(
            'name' => $name,
            'description' => $description,
            'estimatedTime' => $estimatedTime,
            'cost' => $cost,
            'status' => $status
        );             
            
        $this->db->where('id', $id);
        
        if(!$this->db->update('services', $data)){
            $db_error = $this->db->error();        
            if (!empty($db_error)) {            
                throw new Exception($db_error['message']);                
            }
        }

    }
    

}