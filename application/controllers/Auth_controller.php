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
			$resultset = $this->User_model->show(array('username'=> $username));
		
			if (count($resultset) != 1) {	
				$this->session->set_flashdata('message', array('type'=>'error','content'=>'Usuário invalido.'));									
				
			}else{

				$this->load->helper(array('passwordVerifyHash', 'encrypt'));
				
				if(passwordVerifyHash($password, $resultset[0]['password'])){			
					$array = array(					
						'username' => $resultset[0]['username'],
						'name' => $resultset[0]['name'],
						'position' => $resultset[0]['position'],
						'cpf' => $resultset[0]['cpf']
										
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
