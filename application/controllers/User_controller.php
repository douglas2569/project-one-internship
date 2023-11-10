<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class User_controller extends CI_Controller {

	 public function __construct() {
		parent::__construct();
		$this->load->model('User_model');		
	 }
	
	 public function index(){
		$data['userList'] = $this->User_model->show();		
        
		$this->load->view('templates/header', $data);
		$this->load->view('user', $data);
		$this->load->view('templates/footer');
	 }	
	
}
