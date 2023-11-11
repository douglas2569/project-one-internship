<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class User_controller extends CI_Controller {

	 public function __construct() {
		parent::__construct();
		$this->load->model('User_model');		
		$this->load->model('Employee_model');		
		$this->load->helper('encrypt_helper');		
	 }
	
	 public function index(){
		$data['userList'] = $this->User_model->show();		
        
		$this->load->view('templates/header', $data);
		$this->load->view('user', $data);
		$this->load->view('templates/footer');
	 }	

	public function store() {
		$this->form_validation->set_rules('username', 'Username', 'trim|required|min_length[5]|max_length[50]');
		$this->form_validation->set_rules('password', 'Senha', 'trim|min_length[3]');
		$data['employeeList'] =  $this->Employee_model->show();		
		
		if(!$this->form_validation->run() == FALSE){											
			$username = $this->input->post('username');
			$password = $this->input->post('password');
			$employeeId = $this->input->post('employeeId');			
			$resultsetUser = $this->User_model->show(array('username'=> $username));
			
			if (count($resultsetUser) == 1) {	
				$this->session->set_flashdata('message', array('type'=>'error','content'=>'Esse usuário ja existe.'));									
				
			}else{
				try{				
					$this->User_model->insert($username, encryptHash($password), $employeeId);									
					$this->session->set_flashdata('message', array('type'=>'success','content'=>'Cadastrado com sucesso'));
					redirect('index.php/user');						
				}catch(Exception $e){	
					$this->session->set_flashdata('message', array('type'=>'error','content'=>'Não foi possivel cadastrar. Erro: '.$e->getMessage()));
				}
			}
			

		}
				
		$this->load->view('templates/header.php');
		$this->load->view('user_register_form.php',$data);
		$this->load->view('templates/footer.php');	

		
	}

	public function destroy($id) {
		$resultset = $this->User_model->show(array('user_id'=>$id));		
		if(count($resultset) == 1 && $this->User_model->delete($id)){			
			$this->session->set_flashdata('message', array('type'=>'success','content'=>'Registro deletado com sucesso'));						
		}else{
			$this->session->set_flashdata('message', array('type'=>'error','content'=>'Não foi possivel deletar seu registro'));				
		}

		redirect('index.php/user');

	}

	public function edit($id) {
		$this->form_validation->set_rules('username', 'Username', 'trim|required|min_length[5]|max_length[50]');
		$this->form_validation->set_rules('password', 'Senha', 'trim|min_length[3]');
		$data['user'] =  $this->User_model->show(array('user_id'=>$id));						
		
		if(!$this->form_validation->run() == FALSE){											
			$username = $this->input->post('username');
			$password = $this->input->post('password');
			$employeeId = $this->input->post('employeeId');	
			$status = $this->input->post('status');	
			
			$resultsetUser = $this->User_model->show(array('username'=> $username));
			
			if (count($resultsetUser) == 1) {
				$this->session->set_flashdata('message', array('type'=>'error','content'=>'Esse usuário ja existe.'));
				
			}else{
				try{				
					$this->User_model->update($id, $username, encryptHash($password), $employeeId, $status);									
					$this->session->set_flashdata('message', array('type'=>'success','content'=>'Atualizado com sucesso'));
					redirect('index.php/user');						
				}catch(Exception $e){	
					$this->session->set_flashdata('message', array('type'=>'error','content'=>'Não foi possivel atualizar. Erro: '.$e->getMessage()));
				}									

			}
			

		}
				
		$this->load->view('templates/header.php');
		$this->load->view('user_update_form.php',$data);
		$this->load->view('templates/footer.php');	

		
	}
	
}
