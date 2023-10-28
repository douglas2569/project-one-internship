<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Home_controller extends CI_Controller {	

	 public function __construct() {
		parent::__construct();		
		checkAuthentication();			
	 }	

	public function index(){	
		$data = array();
        
		$this->load->view('templates/header', $data);
		$this->load->view('home/home', $data);
		$this->load->view('templates/footer');
	}
}

