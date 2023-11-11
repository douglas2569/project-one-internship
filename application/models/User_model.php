<?php
class User_model extends CI_Model {
   
    public function show( $column = null ) {         

        $this->db->select("*");

        if(!is_null($column)){
            $this->db->where( key($column),  $column[key($column)]);            
            
            return $this->db->get("v_users")->result_array();
        }        
        
        return $this->db->get("v_users")->result_array();
    } 
    
    public function insert($username, $password, $employeeId){             
        $data = array(
            'username' => $username,
            'password' => $password,
            'employees_id' => $employeeId
        );        
        
        if(!$this->db->insert('users', $data)){
            $db_error = $this->db->error();        
            if (!empty($db_error)) {            
                throw new Exception($db_error['message']);
            }
        }

    }

    public function update($id, $username, $password, $employeeId, $status){   
        $data = array(
            'username' => $username,
            'password' => $password,
            'employees_id' => $employeeId,
            'status' => $status,
        );             
            
        $this->db->where('id', $id);
        
        if(!$this->db->update('users', $data)){
            $db_error = $this->db->error();        
            if (!empty($db_error)) {            
                throw new Exception($db_error['message']);                
            }
        }

    }

    public function delete($id){        

        $this->db->where('id', $id);                     
        return $this->db->delete('users');

    }
      

}