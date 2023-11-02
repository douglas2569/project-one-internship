<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Service_Provided_controller extends CI_Controller {	

	 public function __construct() {
		parent::__construct();		
		checkAuthentication();			
	 }	

	public function index(){
		$data['serviceList'] = $this->ServiceProvided_model->show();	
		echo json_encode($data);
	}

	public function store($idMaintenance) {
		echo "idMaintenance";
		
	}


	public function destroy($reference_number, $quantity) {
		
		echo "destroy";
	}

}
