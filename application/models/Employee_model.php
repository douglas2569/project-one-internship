<?php
class Employee_model extends CI_Model {
   
    public function show( $column = null ) {         

        $this->db->select("*");

        if(!is_null($column)){
            $this->db->where( key($column),  $column[key($column)]);            
            
            return $this->db->get("v_employees")->result_array();
        }        
        
        return $this->db->get("v_employees")->result_array();
    } 
    
    public function insert($cpf, $name, $address, $phoneNumber, $email, $positionId, $auto_vehicle_workstops_id ='35'){  
        
        $data = array(
            'cpf' => $cpf,
            'name' => $name,
            'address' => $address,
            'phone_number' => $phoneNumber,
            'email' => $email,            
            'positions_id' => $positionId,            
            'auto_vehicle_workshops_id' => $auto_vehicle_workstops_id
                    
        );         
              
        if(!$this->db->insert('employees', $data)){
            $db_error = $this->db->error();        
            if (!empty($db_error)) {            
                throw new Exception($db_error['message']);
            }
        }         
        

    }

    public function delete($id){        
        $resultset =  $this->db->query("CALL sp_delete_employee('$id')")->result_array();
        return array('status'=> intval(explode('/',$resultset[0]['track_no'])[0]), 'mensage'=> $resultset[0]['@full_error']);
    }
    
    public function update($id, $cpf, $name, $address, $phoneNumber, $email, $positionsId){ 
        
        $data = array(            
            'cpf' => $cpf,
            'name' => $name,
            'address' => $address,
            'phone_number' => $phoneNumber,
            'email' => $email,                         
            'positions_id' => $positionsId                         
        ); 
               
        $this->db->where('id', $id);
        
        if(!$this->db->update('employees', $data)){
            $db_error = $this->db->error();        
            if (!empty($db_error)) {            
                throw new Exception($db_error['message']);                
            }
        }
        

    }

    

}