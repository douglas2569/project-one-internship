  
    <main>
        <div class="container"> 
            <div class="title-box">
                <h1>Veiculos</h1>
            </div> 
                               
            <div class="vehicles">
                <div class="vehicles-header toolbar">                                            
                    <a href='<?= site_url('index.php/vehicle/store') ?>' class="btn ">
                        <i class="bi bi-plus-circle"></i>
                        Nova
                    </a> 
                    <form class="form-inline">
                        <input class="form-control mr-sm-2 search-item" type="search" placeholder="Search" aria-label="Search">
                        <a class="btn my-sm-0">
                            <i class="bi bi-search"></i>
                        </a>
                    </form>                  
                </div>
                <div class="vehiclesList-main">
                <?php  if(count($vehiclesList) > 0): ?>
                    <ul class="vehicles-list">
                        <?php foreach($vehiclesList as $vehicle): ?>    
                        <li class="vehicles-item itens-list" >
                            <div class="item-main"> 
                                <div class="vehicle-customer-name"> <strong>Nome: </strong> <?= $vehicle['name'] ?> </div>
                                <div class="vehicle-licence-plate"> <strong>Placa: </strong> <?= $vehicle['license_plate'] ?> </div>
                                <div class="vehicle-model">  <strong>Modelo: </strong> <?= $vehicle['model_vehicles_fk'] ?> </div>
                                <div class="vehicle-brand"> <strong>Marca: </strong> <?= $vehicle['brand'] ?> </div>
                            </div>
                            <div class="item-footer">
                                <a  href="<?= site_url('index.php/vehicle/edit/'.$vehicle['license_plate']) ?>" class="btn edit-button">
                                    <i class="bi bi-pencil-square"></i>
                                    Editar
                                </a>
                                <a  href="<?= site_url('index.php/vehicle/destroy/'.$vehicle['license_plate']) ?>" class="btn destroy-button">
                                    <i class="bi bi-trash3"></i>
                                    Excluir
                                </a>
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
 