<?php
class Vehicle_model extends CI_Model {
   
    public function show( $column = null ) {         

        $this->db->select("*");

        if(!is_null($column)){
            $this->db->where( key($column),  $column[key($column)]);            
            
            return $this->db->get("v_vehicles")->result_array();
        }        
        
        return $this->db->get("v_vehicles")->result_array();
    }   

    

}