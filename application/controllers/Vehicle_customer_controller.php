<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Vehicle_customer_controller extends CI_Controller {	

	 public function __construct() {
		parent::__construct();		
		checkAuthentication();
		$this->load->model('Vehicle_customer_model');							
	 }	

	public function index(){
		$data['vehicleCustomerList'] = $this->Vehicle_customer_model->show();		
        
		$this->load->view('templates/header', $data);
		$this->load->view('Vehicle_customer', $data);
		$this->load->view('templates/footer');
	}

	public function store() {			
		
		$this->form_validation->set_rules('cpf', 'CPF', 'trim|required|min_length[11]|max_length[50]');
		$this->form_validation->set_rules('name', 'Nome', 'trim|required|min_length[5]|max_length[50]');
		$this->form_validation->set_rules('address', 'Endereço', 'trim|min_length[5]|max_length[255]');
		$this->form_validation->set_rules('phoneNumber', 'Telefone', 'trim|required|min_length[5]|max_length[50]');
		$this->form_validation->set_rules('email', 'Email', 'trim|valid_email|min_length[5]|max_length[100]');

		$this->form_validation->set_rules('licensePlate', 'Placa', 'trim|min_length[6]|max_length[50]|required');

		$this->form_validation->set_rules('model', 'Modelo', 'trim|min_length[5]|max_length[50]');
		$this->form_validation->set_rules('brand', 'Marca', 'trim|min_length[1]|max_length[50]');
				
		if(!$this->form_validation->run() == FALSE){											
			$cpf = $this->input->post('cpf');
			$name = $this->input->post('name');
			$address = $this->input->post('address');
			$phoneNumber = $this->input->post('phoneNumber');
			$email = $this->input->post('email');
			$licensePlate = $this->input->post('licensePlate');
			$model = $this->input->post('model');
			$brand = $this->input->post('brand');					
			
			try{				
				$return = $this->Vehicle_customer_model->insert($cpf, $name, $address, $phoneNumber, $email, $licensePlate, $model, $brand);
				if($return['status']){
					throw new Exception($return['mensage']);
				}				
				$this->session->set_flashdata('message', array('type'=>'success','content'=>'Cadastrado com sucesso'));
				redirect('index.php/vehiclecustomer');						
			}catch(Exception $e){	
				$this->session->set_flashdata('message', array('type'=>'error','content'=>'Não foi possivel cadastrar. Erro: '.$e->getMessage()));
			}

		}
				
		$this->load->view('templates/header.php');
		$this->load->view('vehicle_customer_register_form.php');
		$this->load->view('templates/footer.php');	

		
	}

	public function destroy($licensePlate) {
		$resultset = $this->Vehicle_customer_model->show(array('license_plate'=>$licensePlate));		
		if(count($resultset) == 1 && $this->Vehicle_customer_model->delete($licensePlate)){			
			$this->session->set_flashdata('message', array('type'=>'success','content'=>'Registro deletado com sucesso'));						
		}else{
			$this->session->set_flashdata('message', array('type'=>'error','content'=>'Não foi possivel deletar seu registro'));				
		}

		redirect('index.php/vehiclecustomer');

	}

	public function edit($licensePlate, $cpf) {
		$resulset = $this->Vehicle_customer_model->show(array('license_plate'=> $licensePlate));		
		
		if(count($resulset) != 1){			
			$this->session->set_flashdata('message', array('type'=>'error','content'=>'Id invalido'));				
			
		}else{			
			
			$this->form_validation->set_rules('cpf', 'CPF', 'trim|required|min_length[11]|max_length[50]');
			$this->form_validation->set_rules('name', 'Nome', 'trim|required|min_length[5]|max_length[50]');
			$this->form_validation->set_rules('address', 'Endereço', 'trim|min_length[5]|max_length[255]');
			$this->form_validation->set_rules('phoneNumber', 'Telefone', 'trim|required|min_length[5]|max_length[50]');
			$this->form_validation->set_rules('email', 'Email', 'trim|valid_email|min_length[5]|max_length[100]');

			$this->form_validation->set_rules('licensePlate', 'Placa', 'trim|min_length[6]|max_length[50]|required');

			$data['vehicleCustomer'] = $resulset;

			if($this->form_validation->run() == FALSE){								
				$this->load->view('templates/header.php');
				$this->load->view('vehicle_customer_update_form.php',$data);
				$this->load->view('templates/footer.php');

			}else{		
			
			$cpfNew = $this->input->post('cpf');
			$cpfOld = $cpf;
			$name = $this->input->post('name');
			$address = $this->input->post('address');
			$phoneNumber = $this->input->post('phoneNumber');
			$email = $this->input->post('email');
			$licensePlateNew = $this->input->post('licensePlate');
			$licensePlateOld = $licensePlate;


				try{					
					$return = $this->Vehicle_customer_model->update($cpfOld, $cpfNew, $name, $address, $phoneNumber, $email, $licensePlateOld, $licensePlateNew);	
								
					if($return['status']){// 0 =  success | n > 0 = error
						throw new Exception($return['mensage']);
					}

					$this->session->set_flashdata('message', array('type'=>'success','content'=>'Atualizado com sucesso'));
					redirect('index.php/vehiclecustomer');
					
				}catch(Exception $e){	
					$this->session->set_flashdata('message', array('type'=>'error','content'=>'Não foi possivel Atualizar. Erro: '.$e->getMessage()));
					redirect('index.php/vehiclecustomer/edit/'.$licensePlate);
				}
				
			}
		}
		
	}
}

