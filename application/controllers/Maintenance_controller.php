<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Maintenance_controller extends CI_Controller {	

	 public function __construct() {
		parent::__construct();		
		checkAuthentication();
		$this->load->model('Maintenance_model');			
		$this->load->model('Vehicle_customer_model');			
		$this->load->model('Inventory_model');							
		$this->load->model('Service_provided_model');			
	 }	

	public function index(){
		$data['maintenanceList'] = $this->Maintenance_model->show();				
        
		$this->load->view('templates/header', $data);
		$this->load->view('maintenance', $data);
		$this->load->view('templates/footer');
	}

	public function store() {		
		$data['vehiclesList'] = $this->Vehicle_customer_model->show();				
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

	public function destroy($id) {
		$resultset = $this->Maintenance_model->show(array('id'=>$id));	
		try{	
			if(count($resultset) == 1){			
				$return = $this->Maintenance_model->delete($id);			
				if($return['status']){
					throw new Exception($return['mensage']);
				}
				$this->session->set_flashdata('message', array('type'=>'success','content'=>'Registro deletado com sucesso'));						
			}else{
				$this->session->set_flashdata('message', array('type'=>'error','content'=>'Id invalido'));				
			}	
		}catch(Exception $e){	
			$this->session->set_flashdata('message', array('type'=>'error','content'=>'Não foi possivel apagar deu registro. Erro: '.$e->getMessage()));			
		}	

		redirect('/');



	}
	public function workOn($id) {
		$maintenace = $this->Maintenance_model->show(array('id'=> $id));
		$maintenaceParts = $this->Maintenance_model->show(array('maintenance_id'=> $id), 'v_maintenance_inventory_parts');
		$maintenanceService = $this->Service_provided_model->show(array('maintenance_id'=> $id), 'v_services_provided_mechanics');				
		
		
		if(!is_array($maintenace)){						
			$this->session->set_flashdata('message', array('type'=>'error','content'=>'Id invalido'));				
			
		}else{			
			
			$this->form_validation->set_rules('cpf', 'CPF', 'trim|required|min_length[11]|max_length[50]');
			$this->form_validation->set_rules('name', 'Nome', 'trim|required|min_length[5]|max_length[50]');
			$this->form_validation->set_rules('address', 'Endereço', 'trim|min_length[5]|max_length[255]');
			$this->form_validation->set_rules('phoneNumber', 'Telefone', 'trim|required|min_length[5]|max_length[50]');
			$this->form_validation->set_rules('email', 'Email', 'trim|valid_email|min_length[5]|max_length[100]');

			$this->form_validation->set_rules('licensePlate', 'Placa', 'trim|min_length[6]|max_length[50]|required');

			$this->form_validation->set_rules('model', 'Modelo', 'trim|min_length[5]|max_length[50]');
			$this->form_validation->set_rules('brand', 'Marca', 'trim|min_length[1]|max_length[50]');	
			
			if($this->form_validation->run() == FALSE){								
				$data['maintenance'] = ($maintenace) ? $maintenace:false;
				$data['maintenanceParts'] = ($maintenaceParts) ? $maintenaceParts: false;
				$data['maintenanceService'] = ($maintenanceService) ? $maintenanceService: false;
				
				$this->load->view('templates/header.php');
				$this->load->view('maintenance_work_on_form.php',$data);
				$this->load->view('templates/footer.php');

			}
		}
		
	}

	public function edit($id) {
		$resulset = $this->Maintenance_model->show(array('id'=>$id));		
		$data['Vehicle_customersList'] = $this->Vehicle_customer_model->show();	
		
		if(count($resulset) != 1){			
			$this->session->set_flashdata('message', array('type'=>'error','content'=>'Id invalido'));				
			
		}else{

			$this->form_validation->set_rules('reason', 'Problema', 'trim|required|min_length[5]|max_length[50]');
			$this->form_validation->set_rules('description', 'Descrição', 'trim|min_length[10]');

			$data['maintenance'] = $resulset;	

			if($this->form_validation->run() == FALSE){		
				$this->load->view('templates/header.php');
				$this->load->view('maintenance_update_form.php',$data);
				$this->load->view('templates/footer.php');

			}else{
				$license_plate = $this->input->post('license_plate');
				$reason = $this->input->post('reason');
				$description = $this->input->post('description');		
				
				try{
					$this->Maintenance_model->update($id, $license_plate, $reason, $description);				
					$this->session->set_flashdata('message', array('type'=>'success','content'=>'Cadastrado com sucesso'));
					redirect('/');						
				}catch(Exception $e){	
					$this->session->set_flashdata('message', array('type'=>'error','content'=>'Não foi possivel cadastrar. Erro: '.$e->getMessage()));
					redirect('index.php/maintenance/edit/'.$id);						
				}
			}

		}	
		
		
	}

	public function initialDate($id) {		

		try{
			$this->Maintenance_model->updateDate($id, date("Y-m-d H:i:s"));				
			$this->session->set_flashdata('message', array('type'=>'success','content'=>'Manutenção Iniciada'));
		}catch(Exception $e){	
			$this->session->set_flashdata('message', array('type'=>'error','content'=>'Não foi possivel iniciar a manutenção '.$e->getMessage()));					
		}						
		redirect('index.php/maintenance/workon/'.$id);						
		
		
	}

	public function finalDate($id) {		

		try{
			$this->Maintenance_model->updateDate($id, '', date("Y-m-d H:i:s"));				
			$this->session->set_flashdata('message', array('type'=>'success','content'=>'Manutenção Iniciada'));
		}catch(Exception $e){	
			$this->session->set_flashdata('message', array('type'=>'error','content'=>'Não foi possivel iniciar a manutenção '.$e->getMessage()));					
		}						
		redirect('index.php/maintenance/workon/'.$id);						
		
		
	}

}
