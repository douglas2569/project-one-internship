<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Home_controller extends CI_Controller {	

	 public function __construct() {
		parent::__construct();		
		checkAuthentication();
		$this->load->model('Maintenance_model');			
	 }	

	public function index(){
		$data['maintenanceList'] = $this->Maintenance_model->show();		
        
		$this->load->view('templates/header', $data);
		$this->load->view('home/home', $data);
		$this->load->view('templates/footer');
	}
}

