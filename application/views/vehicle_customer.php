<?php if($this->session-> permissions['vehicles_customer']['read'] == 0): ?>
      <?php 
        redirect('/');
        exit;      
      ?>
      
<?php endif ?>  

    <main>
        <div class="container"> 
            <div class="title-box">
                <h1>Clientes</h1>
            </div> 
                               
            <div class="vehicles">
                <div class="vehicles-header toolbar">  
                    <?php if($this->session-> permissions['vehicles_customer']['create'] == 1): ?>
                        <a href='<?= site_url('index.php/vehiclecustomer/store') ?>' class="btn ">
                            <i class="bi bi-plus-circle"></i>
                            Nova
                        </a> 
                    <?php else: ?>
                        <a class="btn"></a> 
                    <?php endif ?>

                    <form class="form-inline">
                        <input class="form-control mr-sm-2 search-item" type="search" placeholder="Search" aria-label="Search">
                        <a class="btn my-sm-0">
                            <i class="bi bi-search"></i>
                        </a>
                    </form>                  
                </div>
                <div class="vehicles-list-main">
                <?php  if(count($vehicleCustomerList) > 0): ?>
                    <ul class="vehicles-list container-fluid">
                        <?php foreach($vehicleCustomerList as $vehicle): ?>    
                        <li class="vehicles-item item" >
                            <div class="item-body"> 
                                <div class="vehicle-customer-name"> <strong>Nome: </strong> <?= $vehicle['name'] ?> </div>
                                <div class="vehicle-licence-plate"> <strong>Placa: </strong> <?= $vehicle['license_plate'] ?> </div>
                                <div class="vehicle-model">  <strong>Modelo: </strong> <?= $vehicle['model'] ?> </div>
                                <div class="vehicle-brand"> <strong>Marca: </strong> <?= $vehicle['brand'] ?> </div>
                            </div>
                            <div class="item-footer">
                                <?php if($this->session-> permissions['vehicles_customer']['update'] == 1): ?>
                                    <a  href="<?= site_url('index.php/vehiclecustomer/edit/'.$vehicle['license_plate']).'/'.$vehicle['cpf'] ?>" class="btn edit-button">
                                        <i class="bi bi-pencil-square"></i>
                                        Editar
                                    </a>
                                <?php endif ?> 

                                <?php if($this->session-> permissions['vehicles_customer']['delete'] == 1): ?>  
                                    <a  href="<?= site_url('index.php/vehiclecustomer/destroy/'.$vehicle['license_plate']) ?>" class="btn destroy-button">
                                        <i class="bi bi-trash3"></i>
                                        Excluir
                                    </a>
                                <?php endif ?> 
                            </div>
                        </li>
                        <?php endforeach ?>
                    </ul>
                    <?php  else: ?>                         
                        <p class="h6" >Nenhum veiculo cadastrado</p>
                    <?php endif; ?> 
                </div>
            </div>
        </div>
    </main>
 