<?php
defined('BASEPATH') OR exit('No direct script access allowed');

$route['default_controller'] = 'Maintenance_controller';
$route['404_override'] = '';
$route['translate_uri_dashes'] = FALSE;


$route['auth'] = 'Auth_controller';
$route['auth/login'] = 'Auth_controller/login';
$route['auth/logout'] = 'Auth_controller/logout';

$route['inventory'] = 'Inventory_controller';
$route['inventory/store'] = 'Inventory_controller/store';
$route['inventory/edit/(:any)'] = 'Inventory_controller/edit/$1';
$route['inventory/delete/(:any)'] = 'Inventory_controller/delete/$1';

$route['vehicle'] = 'Vehicle_controller';
$route['vehicle/store'] = 'Vehicle_controller/store';
$route['vehicle/edit/(:any)'] = 'Vehicle_controller/edit/$1';
$route['vehicle/delete/(:any)'] = 'Vehicle_controller/delete/$1';

$route['maintenance'] = 'Maintenance_controller';
$route['home'] = 'Maintenance_controller';
$route['maintenance/store'] = 'Maintenance_controller/store';
$route['maintenance/edit/(:any)'] = 'Maintenance_controller/edit/$1';
$route['maintenance/delete/(:any)'] = 'Maintenance_controller/delete/$1';


