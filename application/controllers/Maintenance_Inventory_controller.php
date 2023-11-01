<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Maintenance_Inventory_controller extends CI_Controller {	

	 public function __construct() {
		parent::__construct();		
		checkAuthentication();
		$this->load->model('Maintenance_model');								
		$this->load->model('Inventory_model');			
		$this->load->model('Maintenance_Inventory_model');			
	 }	

	public function index(){
		$data['MaintenanceInventoryList'] = $this->Maintenance_Inventory_model->show();	
		echo json_encode($data);
	}

	public function store($idMaintenance) {
		$data['partList'] = $this->Inventory_model->show();		
		$data['maintenance_id'] = $idMaintenance;		
		
		$this->form_validation->set_rules('quantity', 'Quantidade', 'numeric|required|min_length[1]|max_length[50]');		
				
		if($this->form_validation->run() == FALSE){								
			$this->load->view('templates/header.php');
			$this->load->view('maintenance_add_part_form.php',$data);
			$this->load->view('templates/footer.php');
		}else{
			$quantity = $this->input->post('quantity');
			$referenceNumberAndQuantity = $this->input->post('reference_number_quantity');
			$referenceNumberAndQuantity = explode('|',$referenceNumberAndQuantity);			
			
			if($quantity > $referenceNumberAndQuantity[1] || $referenceNumberAndQuantity[1] == 0){
				$this->session->set_flashdata('message', array('type'=>'error','content'=>'Não a peça suficiente'));
				redirect('index.php/maintenanceinventory/store/'.$idMaintenance);
			}
			
			try{				

				if(!count($this->Maintenance_Inventory_model->show(array('reference_number'=>$referenceNumberAndQuantity[0]))) > 0){					
					$this->Maintenance_Inventory_model->insert($referenceNumberAndQuantity[0], $idMaintenance);
				}

				$newQuanityInventory = $referenceNumberAndQuantity[1] - $quantity;
				$this->Inventory_model->updateOnlyInventory($referenceNumberAndQuantity[0], $newQuanityInventory);
				$this->session->set_flashdata('message', array('type'=>'success','content'=>'Adicionada com sucesso'));
			}catch(Exception $e){
				$this->session->set_flashdata('message', array('type'=>'error','content'=>$e->getMessage()));
			}
			
			redirect('index.php/maintenance/change/'. $idMaintenance);

		}
		
	}


	public function delete($reference_number) {
		$resultset = $this->Maintenance_Inventory_model->show(array('reference_number'=>$reference_number));		
		if(count($resultset) == 1 && $this->Maintenance_Inventory_model->delete($reference_number)){			
			$this->session->set_flashdata('message', array('type'=>'success','content'=>'Registro deletado com sucesso'));						
		}else{
			$this->session->set_flashdata('message', array('type'=>'error','content'=>'Não foi possivel deletar seu registro'));				
		}

		redirect('index.php/maintenance/change/'.$resultset[0]['id_maintenance']);



	}

}
