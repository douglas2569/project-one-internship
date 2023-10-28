<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Vehicle_controller extends CI_Controller {	

	 public function __construct() {
		parent::__construct();		
		checkAuthentication();
		$this->load->model('Vehicle_model');							
	 }	

	public function index(){
		$data['vehiclesList'] = $this->Vehicle_model->show();		
        
		$this->load->view('templates/header', $data);
		$this->load->view('vehicle', $data);
		$this->load->view('templates/footer');
	}
}

