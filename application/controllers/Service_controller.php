<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Service_controller extends CI_Controller {	

	 public function __construct() {
		parent::__construct();		
		checkAuthentication();
		$this->load->model('Service_model');							
	 }	

	public function index(){
		$data['servicesList'] = $this->Service_model->show();		
        
		$this->load->view('templates/header', $data);
		$this->load->view('service', $data);
		$this->load->view('templates/footer');
	}

	public function store() {					
		
		$this->form_validation->set_rules('name', 'Nome', 'trim|required|min_length[5]|max_length[50]');
		$this->form_validation->set_rules('description', 'Descrição', 'trim|min_length[5]|max_length[255]');
		$this->form_validation->set_rules('estimatedTime ', 'Tempo estimado', '|numeric|trim|min_length[1]|max_length[50]');
		$this->form_validation->set_rules('cost', 'Valor', 'trim|numeric|min_length[1]|max_length[50]|required');				
				
		if(!$this->form_validation->run() == FALSE){											
			$name = $this->input->post('name');
			$description = $this->input->post('description');
			$estimatedTime = $this->input->post('estimatedTime');
			$cost = $this->input->post('cost');									
			
			try{				
				$return = $this->Service_model->insert($name, $description, $estimatedTime, $cost);
								
				$this->session->set_flashdata('message', array('type'=>'success','content'=>'Cadastrado com sucesso'));
				redirect('index.php/service');						
			}catch(Exception $e){	
				$this->session->set_flashdata('message', array('type'=>'error','content'=>'Não foi possivel cadastrar. Erro: '.$e->getMessage()));
			}

		}
				
		$this->load->view('templates/header.php');
		$this->load->view('service_register_form.php');
		$this->load->view('templates/footer.php');	

		
	}

	public function destroy($id) {
		$resultset = $this->Service_model->show(array('id'=>$id));		
		if(count($resultset) == 1 && $this->Service_model->delete($id)){			
			$this->session->set_flashdata('message', array('type'=>'success','content'=>'Registro deletado com sucesso'));						
		}else{
			$this->session->set_flashdata('message', array('type'=>'error','content'=>'Não foi possivel deletar seu registro'));				
		}

		redirect('index.php/service');

	}

	public function edit($id) {
		$resulset = $this->Service_model->show(array('id'=> $id));		
		
		if(count($resulset) != 1){			
			$this->session->set_flashdata('message', array('type'=>'error','content'=>'Id invalido'));				
			
		}else{			
			
			$this->form_validation->set_rules('name', 'Nome', 'trim|required|min_length[5]|max_length[50]');
			$this->form_validation->set_rules('description', 'Descrição', 'trim|min_length[5]|max_length[255]');
			$this->form_validation->set_rules('estimatedTime ', 'Tempo estimado', '|numeric|trim|min_length[1]|max_length[50]');
			$this->form_validation->set_rules('cost', 'Valor', 'trim|numeric|min_length[1]|max_length[50]|required');		

			$data['service'] = $resulset;

			if($this->form_validation->run() == FALSE){								
				$this->load->view('templates/header.php');
				$this->load->view('service_update_form.php',$data);
				$this->load->view('templates/footer.php');

			}else{		
			
				$name = $this->input->post('name');
				$description = $this->input->post('description');
				$estimatedTime = $this->input->post('estimatedTime');
				$cost = $this->input->post('cost');	
				$status = $this->input->post('status');	

				try{					
					$return = $this->Service_model->update($id, $name, $description, $estimatedTime, $cost, $status);
					
					$this->session->set_flashdata('message', array('type'=>'success','content'=>'Atualizado com sucesso'));
					redirect('index.php/service');
					
				}catch(Exception $e){	
					$this->session->set_flashdata('message', array('type'=>'error','content'=>'Não foi possivel Atualizar. Erro: '.$e->getMessage()));
					redirect('index.php/service/edit/'.$id);
				}
				
			}
		}
		
	}
}

