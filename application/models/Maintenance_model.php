<?php
class Maintenance_model extends CI_Model {
   
    public function show( $columns = null, $queryEntity = 'maintenance' ) {
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

    public function update($id, $license_plate, $reason, $description, $liveStatus){   
        $data = array(            
            'id' => $id,
            'vehicles_customer_license_plate' => $license_plate,
            'reason' => $reason,
            'description' => $description,
            'live_status' => $liveStatus
         );
                          
            
        $this->db->where('id', $id);
        
        if(!$this->db->update('maintenance', $data)){
            $db_error = $this->db->error();        
            if (!empty($db_error)) {            
                throw new Exception($db_error['message']);                
            }
        }

    }

    public function updateDateInitial($id, $initialDate, $status){               
        
        $data = array(                        
            'initial_date' => $initialDate,
            'status' => $status
        );
         
            
        $this->db->where('id', $id);
        
        if(!$this->db->update('maintenance', $data)){
            $db_error = $this->db->error();        
            if (!empty($db_error)) {            
                throw new Exception($db_error['message']);                
            }
        }

    }

    public function updateDateFinal($id, $finalDate, $status){               
        
        $data = array(                        
            'final_date' => $finalDate,
            'status' => $status
        );
         
            
        $this->db->where('id', $id);
        
        if(!$this->db->update('maintenance', $data)){
            $db_error = $this->db->error();        
            if (!empty($db_error)) {            
                throw new Exception($db_error['message']);                
            }
        }

    }
    

}