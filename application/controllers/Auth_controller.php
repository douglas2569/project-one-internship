<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Auth_controller extends CI_Controller {

	 public function __construct() {
		parent::__construct();
		$this->load->model('User_model');		
	 }
	
	public function index() {
		$this->form_validation->set_rules('username', 'Username', 'trim|required|min_length[5]|max_length[50]');
		$this->form_validation->set_rules('password', 'Senha', 'trim|min_length[3]');
				
		if(!$this->form_validation->run() == FALSE){
			$username = $this->input->post('username');
			$password = $this->input->post('password');
			$resultsetUser = $this->User_model->show(array('username'=> $username));			
			$permissionsFeature = $this->Permissions_features_model->show('v_permissions_features', $resultsetUser[0]['position_id']);
			
			$permissionList  = [];
			foreach($permissionsFeature as $permissionFeature){				
				$permissionList  = array(
					$permissionFeature[0]['features_name'] 
					=> 
					$this->Permissions_model->show($permissionFeature[0]['permissions_id']) 
				);
				
			}			
		
			if (count($resultsetUser) != 1) {	
				$this->session->set_flashdata('message', array('type'=>'error','content'=>'Usuário invalido.'));									
				
			}else{

				$this->load->helper('passwordVerifyHash');
				
				if(passwordVerifyHash($password, $resultsetUser[0]['password'])){			
					$array = array(					
						'username' => $resultsetUser[0]['username'],
						'employees_name' => $resultsetUser[0]['employees_name'],
						'positions_name' => $resultsetUser[0],['positions_name'],										
						'employees_id' => $resultsetUser[0]['employees_id'],										
						'permissions' => $permissionList
					);				
					$this->session->set_userdata($array, 86400);								
					redirect('/');				
				}else{								
					$this->session->set_flashdata('message', array('type'=>'error','content'=>'Senha invalida.'));								
				}
				
				
			}

		}	

		$this->load->view('login');
		$this->load->view('templates/footer');
		

	}
	public function login() {
		if(isset($_SESSION['username'])) redirect('/'); 		
		$this->load->view('login');
		$this->load->view('templates/footer');
	}	
	
	public function logout() {
		
		unset($_SESSION['username']);		
		unset($_SESSION['name']);
		unset($_SESSION['position']);				
		unset($_SESSION['cpf']);				
		$this->session->set_flashdata('message', array('type'=>'success','content'=>'Deslogado com sucesso'));		
		redirect("index.php/auth/login");
		exit;
	}
}
