<?php
class Vehicle_customer_model extends CI_Model {
   
    public function show( $column = null ) {         

        $this->db->select("*");

        if(!is_null($column)){
            $this->db->where( key($column),  $column[key($column)]);            
            
            return $this->db->get("v_vehicles_customers")->result_array();
        }        
        
        return $this->db->get("v_vehicles_customers")->result_array();
    } 
    
    public function insert($cpf, $name, $address, $phoneNumber, $email, $licensePlate, $model, $brand, $auto_vehicle_workstops_id ='35'){   
        
        $data = array(
            'cpf' => $cpf,
            'name' => $name,
            'address' => $address,
            'phone_number' => $phoneNumber,
            'email' => $email,
            'license_plate' => $licensePlate,
            'model' => $model,
            'brand' => $brand,
            'auto_vehicle_workstops_id' => $auto_vehicle_workstops_id
                    
        ); 
        
              
        $resultset = $this->db->query("CALL sp_register_vehicle_costumer('$data[cpf]', '$data[name]', '$data[address]', '$data[phone_number]',
        '$data[email]', '$data[auto_vehicle_workstops_id]', '$data[license_plate]', '$data[model]', '$data[brand]')")->result_array();
        return array('status'=> intval(explode('/',$resultset[0]['track_no'])[0]), 'mensage'=> $resultset[0]['@full_error']);  
         
        

    }

    public function delete($licensePlate){
        $this->db->where('license_plate', $licensePlate);                     
        return $this->db->delete('vehicles_customer');
    }

    public function update($cpfOld, $cpfNew, $name, $address, $phoneNumber, $email, $licensePlateOld, $licensePlateNew){   
        $data = array(
            'cpf_old' => $cpfOld,
            'cpf_new' => $cpfNew,
            'name' => $name,
            'address' => $address,
            'phone_number' => $phoneNumber,
            'email' => $email,
            'license_plate_old' => $licensePlateOld,
            'license_plate_new' => $licensePlateNew,                          
        ); 
               
        $resultset =  $this->db->query("CALL sp_update_vehicles_customer('$data[cpf_new]', '$data[cpf_old]', '$data[name]', '$data[address]', '$data[phone_number]',
        '$data[email]', '$data[license_plate_old]', '$data[license_plate_new]')")->result_array();             
        
        return array('status'=> intval(explode('/',$resultset[0]['track_no'])[0]), 'mensage'=> $resultset[0]['@full_error']); 
        

    }

    

}