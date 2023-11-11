<?php
class Maintenance_model extends CI_Model {
   
    public function show( $column = null, $queryEntity = 'maintenance' ) {
        $this->db->select("*");
        if(!is_null($column)){ 

            if($this->db->get($queryEntity)->result_id->num_rows > 0){  
                $this->db->where( key($column),  $column[key($column)]); 
                
                return $this->db->get($queryEntity)->result_array();
            }                
              
        }else{             
            
            if($this->db->get($queryEntity)->result_id->num_rows > 0)
                    return $this->db->get($queryEntity)->result_array();
            return false;  

        }   
        
        
    }
    
    public function insert($license_plate, $reason, $description){        
        $data = array(
            'vehicles_customer_license_plate' => $license_plate,
            'reason' => $reason,
            'description' => $description
        );        
        
        if(!$this->db->insert('maintenance', $data)){
            $db_error = $this->db->error();        
            if (!empty($db_error)) {            
                throw new Exception($db_error['message']);
            }
        }

    }
    
    public function delete($id){  
        $resultset =  $this->db->query("CALL sp_delete_maintenance('$id')")->result_array();
        return array('status'=> intval(explode('/',$resultset[0]['track_no'])[0]), 'mensage'=> $resultset[0]['@full_error']);
    }

    public function update($id, $license_plate, $reason, $description){   
        $data = array(            
            'id' => $id,
            'vehicles_customer_license_plate' => $license_plate,
            'reason' => $reason,
            'description' => $description,
         );
                          
            
        $this->db->where('id', $id);
        
        if(!$this->db->update('maintenance', $data)){
            $db_error = $this->db->error();        
            if (!empty($db_error)) {            
                throw new Exception($db_error['message']);                
            }
        }

    }

    public function updateDate($id, $initialDate, $finalDate=''){               
        if(empty($finalDate)){
            $data = array(            
                'id' => $id,
                'initial_date' => $initialDate,
                'status' => 1
             );
        }else{
            $data = array(            
                'id' => $id,                
                'final_date' => $finalDate,
                'status' => 2
             );
        } 

        
         
            
        $this->db->where('id', $id);
        
        if(!$this->db->update('maintenance', $data)){
            $db_error = $this->db->error();        
            if (!empty($db_error)) {            
                throw new Exception($db_error['message']);                
            }
        }

    }
    

}