<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Inventory_controller extends CI_Controller {	

	 public function __construct() {
		parent::__construct();		
		checkAuthentication();
		$this->load->model('Inventory_model');							
	 }	

	public function index(){
		$data['partsList'] = $this->Inventory_model->show();		
        
		$this->load->view('templates/header', $data);
		$this->load->view('inventory', $data);
		$this->load->view('templates/footer');
	}
}

