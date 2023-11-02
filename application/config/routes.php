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
$route['inventory/destroy/(:any)'] = 'Inventory_controller/destroy/$1';

$route['vehicle'] = 'Vehicle_controller';
$route['vehicle/store'] = 'Vehicle_controller/store';
$route['vehicle/edit/(:any)'] = 'Vehicle_controller/edit/$1';
$route['vehicle/destroy/(:any)'] = 'Vehicle_controller/destroy/$1';

$route['maintenance'] = 'Maintenance_controller';
$route['home'] = 'Maintenance_controller';
$route['maintenance/store'] = 'Maintenance_controller/store';
$route['maintenance/edit/(:any)'] = 'Maintenance_controller/edit/$1';
$route['maintenance/change/(:any)'] = 'Maintenance_controller/change/$1';
$route['maintenance/destroy/(:any)'] = 'Maintenance_controller/destroy/$1';
$route['maintenance/initialdate/(:any)'] = 'Maintenance_controller/initialDate/$1';
$route['maintenance/finaldate/(:any)'] = 'Maintenance_controller/finalDate/$1';

$route['maintenanceinventory/store/(:num)'] = 'Maintenance_Inventory_controller/store/$1'; 
$route['maintenanceinventory/destroy/(:any)'] = 'Maintenance_Inventory_controller/destroy/$1'; 
$route['maintenanceinventory/destroy/(:any)/(:num)'] = 'Maintenance_Inventory_controller/destroy/$1/$2'; 

$route['serviceprovided/store/(:num)'] = 'Service_Provided_controller/store/$1'; 

