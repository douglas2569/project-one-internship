<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Maintenance_Inventory_controller extends CI_Controller {	

	 public function __construct() {
		parent::__construct();		
		checkAuthentication();
		$this->load->model('Maintenance_model');								
		$this->load->model('Inventory_model');			
		$this->load->model('Maintenance_inventory_model');			
	 }	

	public function index(){
		$data['MaintenanceInventoryList'] = $this->Maintenance_inventory_model->show();	
		echo json_encode($data);
	}

	public function store($maintenanceId) {
		$data['partList'] = $this->Inventory_model->show(array('status'=>'1'));		
		$data['maintenance_id'] = $maintenanceId;		
		
		$this->form_validation->set_rules('quantity', 'Quantidade', 'numeric|required|min_length[1]|max_length[50]');		
				
		if($this->form_validation->run() == FALSE){								
			$this->load->view('templates/header.php');
			$this->load->view('maintenance_add_part_form.php',$data);
			$this->load->view('templates/footer.php');
		}else{
			$quantity = $this->input->post('quantity');
			$automotivePartsIdAndReferenceNumberAndQuantity = $this->input->post('automotivePartsIdAndReferenceNumberAndQuantity');
			$automotivePartsIdAndReferenceNumberAndQuantity = explode('|',$automotivePartsIdAndReferenceNumberAndQuantity);	
			
			if($quantity > $automotivePartsIdAndReferenceNumberAndQuantity[1] || $automotivePartsIdAndReferenceNumberAndQuantity[2] == 0){
				$this->session->set_flashdata('message', array('type'=>'error','content'=>'Não a peça suficiente'));
				redirect('index.php/maintenanceinventory/store/'.$maintenanceId);
			}
			
			try{				
				$resultset = $this->Maintenance_inventory_model->show(array('maintenance_id'=>$maintenanceId,'automotive_parts_id'=>$automotivePartsIdAndReferenceNumberAndQuantity[0]));
				$newQuantityInventory = $automotivePartsIdAndReferenceNumberAndQuantity[2] - $quantity;
				
				if(count($resultset) > 0){					
					$newQuantityMaintenanceInventory = $quantity + $resultset[0]['quantity'];	 												
					$return = $this->Maintenance_inventory_model->updateQuantityMaintenanceInventory($maintenanceId, $automotivePartsIdAndReferenceNumberAndQuantity[0], $automotivePartsIdAndReferenceNumberAndQuantity[1], $newQuantityMaintenanceInventory, $newQuantityInventory);	
					
					if($return['status']){
						throw new Exception($return['mensage']);
					}									
					
				}else{
					$return = $this->Maintenance_inventory_model->insert($automotivePartsIdAndReferenceNumberAndQuantity[0], $automotivePartsIdAndReferenceNumberAndQuantity[1],
					$maintenanceId, $newQuantityInventory,
					$quantity);	
					if($return['status']){
						throw new Exception($return['mensage']);
					}
					
				}				

				$this->session->set_flashdata('message', array('type'=>'success','content'=>'Adicionada com sucesso'));
				

			}catch(Exception $e){
				$this->session->set_flashdata('message', array('type'=>'error','content'=>$e->getMessage()));
			}
			
			redirect('index.php/maintenance/workon/'. $maintenanceId);

		}
		
	}


	public function destroy($maintenanceId, $automotivePartsId, $reference_number, $quantity) {
		
		$resultset = $this->Maintenance_inventory_model->show(array('maintenance_id'=>$maintenanceId,'automotive_parts_id'=>$automotivePartsId));
		
				
		if(count($resultset) == 1){
			try{
				$return = $this->Maintenance_inventory_model->delete($automotivePartsId, $reference_number,  $quantity);	
				if($return['status']){
					throw new Exception($return['mensage']);
				}
				$this->session->set_flashdata('message', array('type'=>'success','content'=>'Removido com sucesso'));						
			}catch(Exception $e){
				$this->session->set_flashdata('message', array('type'=>'error','content'=>'Não foi possivel remover seu registro. Erro:'.$e->getMessage()));				
			}

			redirect('index.php/maintenance/workon/'.$resultset[0]['maintenance_id']);
		}
	}

}
