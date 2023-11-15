<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Permission_Feature_controller extends CI_Controller {

	 public function __construct() {
		parent::__construct();
		$this->load->model('Permission_Feature_model');									
		$this->load->model('Position_model');						
	 }
	
	 public function index(){
		$data['positionList'] = $this->Position_model->show();		
        
		$this->load->view('templates/header', $data);
		$this->load->view('permission_feature', $data);
		$this->load->view('templates/footer');
	 }

	 public function show($id){			
		$permissions = $this->Permission_Feature_model->show(array('positions_id'=>$id));			
		
		echo json_encode($permissions);
	}
	
	
}
