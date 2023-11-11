<?php
class Position_model extends CI_Model {
   
    public function show( $column = null ) {         

        $this->db->select("*");

        if(!is_null($column)){
            $this->db->where( key($column),  $column[key($column)]);            
            
            return $this->db->get("positions")->result_array();
        }        
        
        return $this->db->get("positions")->result_array();
    } 
    
    public function insert($name){             
        $data = array(
            'name' => $name
        );        
        
        if(!$this->db->insert('positions', $data)){
            $db_error = $this->db->error();        
            if (!empty($db_error)) {            
                throw new Exception($db_error['message']);
            }
        }

    }

      

}