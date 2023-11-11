<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Auth_controller extends CI_Controller {

	 public function __construct() {
		parent::__construct();
		$this->load->model('User_model');		
		$this->load->model('Permissions_features_model');		
		$this->load->model('Permissions_model');		
	 }
	
	public function index() {
		$this->form_validation->set_rules('username', 'Username', 'trim|required|min_length[5]|max_length[50]');
		$this->form_validation->set_rules('password', 'Senha', 'trim|min_length[3]');
				
		if(!$this->form_validation->run() == FALSE){
			$username = $this->input->post('username');
			$password = $this->input->post('password');
			$resultsetUser = $this->User_model->show(array('username'=> $username));			
			
			if (count($resultsetUser) != 1) {	
				$this->session->set_flashdata('message', array('type'=>'error','content'=>'Usuário invalido.'));									
				
			}else{
				$permissionsFeature = $this->Permissions_features_model->show(array('positions_id' =>$resultsetUser[0]['positions_id'] ));			
			
				$permissionList  = [];
				foreach($permissionsFeature as $permissionFeature){	
					$permissionList[$permissionFeature['features_name']]  = 
						$this->Permissions_model->show(array('id' => $permissionFeature['permissions_id']))[0];				 
					
				}

				$this->load->helper('passwordVerifyHash');
				
				if(passwordVerifyHash($password, $resultsetUser[0]['password'])){			
					$array = array(					
						'username' => $resultsetUser[0]['username'],
						'employee_name' => $resultsetUser[0]['employee_name'],
						'position_name' => $resultsetUser[0]['position_name'],		
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
		unset($_SESSION['employees_name']);
		unset($_SESSION['positions_name']);				
		unset($_SESSION['employees_id']);				
		unset($_SESSION['permissions']);	
					
		$this->session->set_flashdata('message', array('type'=>'success','content'=>'Deslogado com sucesso'));		
		redirect("index.php/auth/login");
		exit;
	}
}
