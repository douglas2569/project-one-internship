<?php
defined('BASEPATH') OR exit('No direct script access allowed');

$route['default_controller'] = 'Maintenance_controller';
$route['404_override'] = '';
$route['translate_uri_dashes'] = FALSE;

$route['auth'] = 'Auth_controller';
$route['auth/login'] = 'Auth_controller/login';
$route['auth/logout'] = 'Auth_controller/logout';

$route['user'] = 'User_controller';
$route['user/store'] = 'User_controller/store';
$route['user/edit/(:num)'] = 'User_controller/edit/$1';
$route['user/destroy/(:num)'] = 'User_controller/destroy/$1';

$route['employee'] = 'Employee_controller';
$route['employee/store'] = 'Employee_controller/store';
$route['employee/edit/(:num)'] = 'Employee_controller/edit/$1';
$route['employee/destroy/(:num)'] = 'Employee_controller/destroy/$1';

$route['inventory'] = 'Inventory_controller';
$route['inventory/store'] = 'Inventory_controller/store';
$route['inventory/edit/(:any)'] = 'Inventory_controller/edit/$1';
$route['inventory/destroy/(:any)/(:num)'] = 'Inventory_controller/destroy/$1/$2';

$route['vehiclecustomer'] = 'Vehicle_customer_controller';
$route['vehiclecustomer/store'] = 'Vehicle_customer_controller/store';
$route['vehiclecustomer/edit/(:any)/(:any)'] = 'Vehicle_customer_controller/edit/$1/$2';
$route['vehiclecustomer/destroy/(:any)'] = 'Vehicle_customer_controller/destroy/$1';

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
$route['maintenanceinventory/destroy/(:num)/(:any)/(:num)'] = 'Maintenance_Inventory_controller/destroy/$1/$2/$3'; 

$route['service'] = 'Service_controller';
$route['service/store'] = 'Service_controller/store';
$route['service/edit/(:num)'] = 'Service_controller/edit/$1';
$route['service/destroy/(:num)'] = 'Service_controller/destroy/$1';

$route['serviceprovided/store/(:num)'] = 'Service_Provided_controller/store/$1'; 
$route['serviceprovided/destroy/(:num)/(:num)'] = 'Service_Provided_controller/destroy/$1/$2'; 

