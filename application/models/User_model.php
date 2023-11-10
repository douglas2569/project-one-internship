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

    // public function showPostionByUser($cpf) {
    //     $resultset = $this->db->query("CALL sp_position_user('$cpf')")->result_array();
    //     return array('status'=> intval(explode('/',$resultset[0]['track_no'])[0]), 'mensage'=> $resultset[0]['@full_error']);
    // }   

}