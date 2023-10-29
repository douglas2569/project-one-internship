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
				$this->Inventory_model->insert($address, $reference, $name, $brand, $description, $unitValue, $quantity);
				$this->session->set_flashdata('message', array('type'=>'success','content'=>'Cadastrado com sucesso'));											
					
			}catch(Exception $e){
				$this->session->set_flashdata('message', array('type'=>'error','content'=>'Não foi possivel cadastrar. Erro: '.$e->getMessage()));
				unlink('assets/images/'.$$address);
			}
			

		}
				
		$this->load->view('templates/header.php');
		$this->load->view('inventory_input_form.php');
		$this->load->view('templates/footer.php');	

		
	}
}

