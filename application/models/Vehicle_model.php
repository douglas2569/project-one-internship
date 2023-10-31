<?php
class Vehicle_model extends CI_Model {
   
    public function show( $column = null ) {         

        $this->db->select("*");

        if(!is_null($column)){
            $this->db->where( key($column),  $column[key($column)]);            
            
            return $this->db->get("v_vehicles_customers")->result_array();
        }        
        
        return $this->db->get("v_vehicles_customers")->result_array();
    } 
    
    public function insert($cpf, $name, $address, $phoneNumber, $email, $licensePlate, $model, $brand, $cnpj_auto_vehicle_workstops_fk ='01187817000183'){   
        
        $data = array(
            'cpf' => $cpf,
            'name' => $name,
            'address' => $address,
            'phone_number' => $phoneNumber,
            'email' => $email,
            'license_plate' => $licensePlate,
            'model' => $model,
            'brand' => $brand,
            'cnpj_auto_vehicle_workstops_fk' => $cnpj_auto_vehicle_workstops_fk
                    
        ); 
        try{        
            $this->db->query("CALL sp_register_vehicle_costumer('$data[cpf]', '$data[name]', '$data[address]', '$data[phone_number]',
            '$data[email]', '$data[cnpj_auto_vehicle_workstops_fk]', '$data[license_plate]', '$data[model]', '$data[brand]')"); 
        }catch(Exception $e){	
            throw new Exception($e);
        }
        // print_r($resultset); exit;
        // if($resultset['track_no'] != '0/3'){                  
                      
        //     throw new Exception($resultset['track_no']);
        //     return false; 
            
        // }
        

    }

    public function delete($licensePlate){
        $this->db->where('license_plate', $licensePlate);                     
        return $this->db->delete('vehicles_customer');
    }

    public function update($cpf, $name, $address='', $phoneNumber, $email, $licensePlate, $model, $brand, $cnpj_auto_vehicle_workstops_fk ='01187817000183'){   
        $data = array(
            'cpf' => $cpf,
            'name' => $name,
            'address' => $address,
            'phone_number' => $phoneNumber,
            'email' => $email,
            'license_plate' => $licensePlate,
            'model' => $model,
            'brand' => $brand,
            'cnpj_auto_vehicle_workstops_fk' => $cnpj_auto_vehicle_workstops_fk                    
        );  
        
        try{        
            $this->db->query("CALL sp_update_vehicle_customer('$data[cpf]', '$data[name]', '$data[address]', '$data[phone_number]',
            '$data[email]', '$data[license_plate]', '$data[model]', '$data[brand]','$data[cnpj_auto_vehicle_workstops_fk]')"); 
        }catch(Exception $e){	
            throw new Exception($e);
        }

    }

    

}