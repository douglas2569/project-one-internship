<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Vehicle_controller extends CI_Controller {	

	 public function __construct() {
		parent::__construct();		
		checkAuthentication();
		$this->load->model('Vehicle_model');							
	 }	

	public function index(){
		$data['vehiclesList'] = $this->Vehicle_model->show();		
        
		$this->load->view('templates/header', $data);
		$this->load->view('vehicle', $data);
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
		$this->form_validation->set_rules('brand', 'Marca', 'trim|min_length[5]|max_length[50]');
				
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
				$this->Vehicle_model->insert($cpf, $name, $address, $phoneNumber, $email, $licensePlate, $model, $brand);				
				$this->session->set_flashdata('message', array('type'=>'success','content'=>'Cadastrado com sucesso'));
				redirect('index.php/vehicle');						
			}catch(Exception $e){	
				$this->session->set_flashdata('message', array('type'=>'error','content'=>'Não foi possivel cadastrar. Erro: '.$e->getMessage()));
			}

		}
				
		$this->load->view('templates/header.php');
		$this->load->view('vehicle_input_form.php');
		$this->load->view('templates/footer.php');	

		
	}
}

