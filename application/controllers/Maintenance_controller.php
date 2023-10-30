<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Maintenance_controller extends CI_Controller {	

	 public function __construct() {
		parent::__construct();		
		checkAuthentication();
		$this->load->model('Maintenance_model');			
		$this->load->model('Vehicle_model');			
	 }	

	public function index(){
		$data['maintenanceList'] = $this->Maintenance_model->show();		
        
		$this->load->view('templates/header', $data);
		$this->load->view('maintenance', $data);
		$this->load->view('templates/footer');
	}

	public function store() {
		$data['vehiclesList'] = $this->Vehicle_model->show();		
		
		$this->form_validation->set_rules('reason', 'Problema', 'trim|required|min_length[5]|max_length[50]');
		$this->form_validation->set_rules('description', 'Descrição', 'trim|min_length[10]');
				
		if(!$this->form_validation->run() == FALSE){								
			$license_plate = $this->input->post('license_plate');
			$reason = $this->input->post('reason');
			$description = $this->input->post('description');		
			
			try{
				$this->Maintenance_model->insert($license_plate, $reason, $description);				
				$this->session->set_flashdata('message', array('type'=>'success','content'=>'Cadastrado com sucesso'));
				redirect('/');						
			}catch(Exception $e){	
				$this->session->set_flashdata('message', array('type'=>'error','content'=>'Não foi possivel cadastrar. Erro: '.$e->getMessage()));
			}

		}
				
		$this->load->view('templates/header.php');
		$this->load->view('maintenance_register_form.php',$data);
		$this->load->view('templates/footer.php');	

		
	}

	public function delete($id) {
		$resultset = $this->Maintenance_model->show(array('id'=>$id));		
		if(count($resultset) == 1){			
			$this->Maintenance_model->delete($id);
			$this->session->set_flashdata('message', array('type'=>'success','content'=>'Registro deletado com sucesso'));						
		}else{
			$this->session->set_flashdata('message', array('type'=>'error','content'=>'Não foi possivel deletar seu registro'));				
		}

		redirect('/');

	}

	

}
