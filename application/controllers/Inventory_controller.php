<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Inventory_controller extends CI_Controller {	

	 public function __construct() {
		parent::__construct();		
		checkAuthentication();
		$this->load->model('Inventory_model');	
		$this->load->helper('encrypt_helper');
	 }	

	public function index(){
		$data['partsList'] = $this->Inventory_model->show();		
        
		$this->load->view('templates/header', $data);
		$this->load->view('inventory', $data);
		$this->load->view('templates/footer');
	}

	public function store() {			
		
		$this->form_validation->set_rules('reference', 'Numero de referência', 'trim|required|min_length[5]|max_length[255]');
		$this->form_validation->set_rules('name', 'Nome', 'trim|required|min_length[5]|max_length[50]');
		$this->form_validation->set_rules('brand', 'Marca', 'trim|required|min_length[2]|max_length[50]');
		$this->form_validation->set_rules('description', 'Descrição', 'trim|min_length[5]');
		$this->form_validation->set_rules('unitValue', 'Valor da unidade', 'trim|numeric|min_length[1]|max_length[50]');
		$this->form_validation->set_rules('quantity', 'Quantidade', 'trim|integer|min_length[1]|max_length[50]');

						
		if(!$this->form_validation->run() == FALSE){								
			$address = '';
			if ( isset($_FILES['imageInventoryPart']) && $_FILES['imageInventoryPart']['size'] > 0 ){
				$config['upload_path']          = './assets/images/';
				$config['allowed_types']        = 'jpg|png';
				$config['max_size']             = 200;
				$config['max_width']            = 1024;
				$config['max_height']           = 768;
				$config['overwrite']            = TRUE;
				$imageName = encryptHash(rand(99,9999).date("Y-m-d H:i:s"), 'md5');	
				$config['file_name']            =   $imageName;					
				
				$this->load->library('upload', $config);
				
				if($this->upload->do_upload('imageInventoryPart')){
					$imageType = $this->upload->data('file_ext');					
					$address = $imageName.$imageType;
				}
				
			}	
			
			$reference = $this->input->post('reference');
			$name = $this->input->post('name');
			$brand = $this->input->post('brand');
			$description = $this->input->post('description');						
			$unitValue = $this->input->post('unitValue');			
			$quantity = $this->input->post('quantity');
			
			try{
				$return = $this->Inventory_model->insert($address, $reference, $name, $brand, $description, $unitValue, $quantity);
				
				if($return['status']){
					throw new Exception($return['mensage']);
				}
				$this->session->set_flashdata('message', array('type'=>'success','content'=>'Cadastrado com sucesso'));	
				redirect('index.php/inventory');	
													
					
			}catch(Exception $e){
				$this->session->set_flashdata('message', array('type'=>'error','content'=>'Não foi possivel cadastrar. Erro: '.$e->getMessage()));
				if(!empty($address)) 
					unlink('assets/images/'.$address);
			}
			

		}
				
		$this->load->view('templates/header.php');
		$this->load->view('inventory_register_form.php');
		$this->load->view('templates/footer.php');	

		
	}

	public function destroy($reference, $automotive_parts_id) {
		$resultset = $this->Inventory_model->show(array('reference_number'=>$reference));
		try{
			if(count($resultset) == 1){
				$return = $this->Inventory_model->delete($reference, $automotive_parts_id);
				if($return['status']){
					throw new Exception($return['mensage']);
				}			
				unlink('assets/images/'.$resultset[0]['image_address']);
				$this->session->set_flashdata('message', array('type'=>'success','content'=>'Registro deletado com sucesso'));									
			}else{
				$this->session->set_flashdata('message', array('type'=>'error','content'=>'Id invalido'));						
				
			}
			
		}catch(Exception $e){
			$this->session->set_flashdata('message', array('type'=>'error','content'=>'Não foi possivel apagar seu registro. Erro: '.$e->getMessage()));						
		}

		redirect('index.php/inventory');

	}

	public function edit($reference) {
		$resulset = $this->Inventory_model->show(array('reference_number'=> $reference));		

		if(count($resulset) != 1){			
			$this->session->set_flashdata('message', array('type'=>'error','content'=>'Id invalido'));				
			
		}else{			
			
			$this->form_validation->set_rules('reference', 'Numero de referência', 'trim|required|min_length[5]|max_length[255]');
			$this->form_validation->set_rules('name', 'Nome', 'trim|required|min_length[5]|max_length[50]');
			$this->form_validation->set_rules('brand', 'Marca', 'trim|required|min_length[2]|max_length[50]');
			$this->form_validation->set_rules('description', 'Descrição', 'trim|min_length[5]');
			$this->form_validation->set_rules('unitValue', 'Valor da unidade', 'trim|numeric|min_length[1]|max_length[50]');
			$this->form_validation->set_rules('quantity', 'Quantidade', 'trim|integer|min_length[1]|max_length[50]');	
			$this->form_validation->set_rules('status', 'Estado', 'integer|min_length[1]|max_length[1]');
			
			
			$data['part'] = $resulset;
			
			if($this->form_validation->run() == FALSE){								
				$this->load->view('templates/header.php');
				$this->load->view('inventory_update_form.php',$data);
				$this->load->view('templates/footer.php');

			}else{
				
			if ( isset($_FILES['imageInventoryPart']) && $_FILES['imageInventoryPart']['size'] > 0 ){
				$config['upload_path']          = './assets/images/';
				$config['allowed_types']        = 'jpg|png';
				$config['max_size']             = 200;
				$config['max_width']            = 1024;
				$config['max_height']           = 768;
				$config['overwrite']            = TRUE;
				$imageName = encryptHash(rand(99,9999).date("Y-m-d H:i:s"), 'md5');	
				$config['file_name']            =   $imageName;					
				
				$this->load->library('upload', $config);
				
				if($this->upload->do_upload('imageInventoryPart')){
					$imageType = $this->upload->data('file_ext');					
					$address = $imageName.$imageType;
				}
				
			}else{
				$address = $this->input->post('imageInventoryPartOld');
			}				
			
			$name = $this->input->post('name');
			$brand = $this->input->post('brand');
			$description = $this->input->post('description');						
			$unitValue = $this->input->post('unitValue');			
			$quantity = $this->input->post('quantity');			
			$referenceNew = $this->input->post('reference');
			$status = $this->input->post('status');
			$referenceOld = $reference;

			try{				
				$return =  $this->Inventory_model->update($referenceOld, $address, $referenceNew, $name, $brand, $description, $unitValue, $quantity, $status);
				if($return['status']){
					throw new Exception($return['mensage']);
				}
				$this->session->set_flashdata('message', array('type'=>'success','content'=>'Atualizado com sucesso'));						
					
			}catch(Exception $e){
				$this->session->set_flashdata('message', array('type'=>'error','content'=>'Não foi possivel atualizar. Erro: '.$e->getMessage()));
				// if(!empty($address))
				// 	unlink('assets/images/'.$address);
			}

			redirect('index.php/inventory');
				
			}
		}
		
	}

}

