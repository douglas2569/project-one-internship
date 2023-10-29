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
    
    public function insert($cpf, $name, $address=null, $phoneNumber, $email, $licensePlate, $model, $brand, $cnpj_auto_vehicle_workstops_fk ='01187817000183'){        
        $data = array(
            'cpf' => $cpf,
            'name' => $name,
            'address' => $address,
            'phoneNumber' => $phoneNumber,
            'email' => $email,
            'license_plate' => $licensePlate,
            'model' => $model,
            'brand' => $brand,
            'cnpj_auto_vehicle_workstops_fk' => $cnpj_auto_vehicle_workstops_fk
                    
        );                
        if(!$this->db->query("sp_vehicle_costumer($data[cpf],$data[name],$data[address],$data[phoneNumber],$data[email], $data[cnpj_auto_vehicle_workstops_fk], $data[license_plate],$data[model],$data[brand])")){
            $db_error = $this->db->error();        
            if (!empty($db_error)) {            
                throw new Exception($db_error['message']);
                return false; 
            }
        }

    }

    

}