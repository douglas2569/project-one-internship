<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Employee_controller extends CI_Controller {	

	 public function __construct() {
		parent::__construct();		
		checkAuthentication();
		$this->load->model('Employee_model');							
		$this->load->model('Position_model');							
	 }	

	public function index(){
		$data['employeesList'] = $this->Employee_model->show();		
        
		$this->load->view('templates/header.php', $data);
		$this->load->view('employee.php', $data);
		$this->load->view('templates/footer.php');
	}
	
	public function store() {			
		
		$this->form_validation->set_rules('cpf', 'CPF', 'trim|required|min_length[11]|max_length[50]');
		$this->form_validation->set_rules('name', 'Nome', 'trim|required|min_length[5]|max_length[50]');
		$this->form_validation->set_rules('address', 'Endereço', 'trim|min_length[5]|max_length[255]');
		$this->form_validation->set_rules('phoneNumber', 'Telefone', 'trim|required|min_length[5]|max_length[50]');
		$this->form_validation->set_rules('email', 'Email', 'trim|valid_email|min_length[5]|max_length[100]');		
		
		$data['positionsList'] = $this->Position_model->show();	
		
		if(!$this->form_validation->run() == FALSE){											
			$cpf = $this->input->post('cpf');
			$name = $this->input->post('name');
			$address = $this->input->post('address');
			$phoneNumber = $this->input->post('phoneNumber');
			$email = $this->input->post('email');
			$positionId= $this->input->post('positionId');							
			
			try{				
				$this->Employee_model->insert($cpf, $name, $address, $phoneNumber, $email, $positionId);								
				$this->session->set_flashdata('message', array('type'=>'success','content'=>'Cadastrado com sucesso'));
				redirect('index.php/employee');						
			}catch(Exception $e){	
				$this->session->set_flashdata('message', array('type'=>'error','content'=>'Não foi possivel cadastrar. Erro: '.$e->getMessage()));
			}

		}
				
		$this->load->view('templates/header.php');
		$this->load->view('employee_register_form.php', $data);
		$this->load->view('templates/footer.php');	

		
	}

	public function destroy($id) {
		$resultset = $this->Employee_model->show(array('id'=>$id));

		if(count($resultset) == 1){		
			try{
				$return = $this->Employee_model->delete($id);	
				if($return['status']){
					throw new Exception($return['mensage']);
				}	
				$this->session->set_flashdata('message', array('type'=>'success','content'=>'Registro deletado com sucesso.'));

			}catch(Exception $e){
				$this->session->set_flashdata('message', array('type'=>'error','content'=>'Não foi possivel deletar seu registro. Erro:'.$e->getMessage()));
			}
		}else{
			$this->session->set_flashdata('message', array('type'=>'error','content'=>'Não foi possivel deletar seu registro'));				
		}

		redirect('index.php/employee');

	}

	public function edit($id) {
		$resulset = $this->Employee_model->show(array('id'=> $id));	
		$data['positionsList'] = $this->Position_model->show();	

		if(count($resulset) != 1){			
			$this->session->set_flashdata('message', array('type'=>'error','content'=>'Id invalido'));				
			
		}else{			
			
			$this->form_validation->set_rules('cpf', 'CPF', 'trim|required|min_length[11]|max_length[50]');
			$this->form_validation->set_rules('name', 'Nome', 'trim|required|min_length[5]|max_length[50]');
			$this->form_validation->set_rules('address', 'Endereço', 'trim|min_length[5]|max_length[255]');
			$this->form_validation->set_rules('phoneNumber', 'Telefone', 'trim|required|min_length[5]|max_length[50]');
			$this->form_validation->set_rules('email', 'Email', 'trim|valid_email|min_length[5]|max_length[100]');			
			
			$data['employee'] = $resulset;			

			if($this->form_validation->run() == FALSE){								
				$this->load->view('templates/header.php');
				$this->load->view('employee_update_form.php',$data);
				$this->load->view('templates/footer.php');

			}else{		
			
			$cpf = $this->input->post('cpf');			
			$name = $this->input->post('name');
			$address = $this->input->post('address');
			$phoneNumber = $this->input->post('phoneNumber');
			$email = $this->input->post('email');
			$positionsId = $this->input->post('positionId');			

			try{					
				$return = $this->Employee_model->update($id, $cpf, $name, $address, $phoneNumber, $email, $positionsId);	
							
				if($return['status']){
					throw new Exception($return['mensage']);
				}

				$this->session->set_flashdata('message', array('type'=>'success','content'=>'Atualizado com sucesso'));
				redirect('index.php/employee');
				
			}catch(Exception $e){	
				$this->session->set_flashdata('message', array('type'=>'error','content'=>'Não foi possivel Atualizar. Erro: '.$e->getMessage()));
				redirect('index.php/employee/edit/'.$id);
			}
				
			}
		}
		
	}
}

