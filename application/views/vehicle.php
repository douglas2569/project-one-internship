  
    <main>
        <div class="container"> 
            
            <h1>Veiculos</h1>
                               
            <div class="vehicles">
                <div class="vehicles-header toolbar">                                            
                    <button type="button" class="btn ">
                        <i class="bi bi-plus-circle"></i>
                        Nova
                    </button> 
                    <form class="form-inline">
                        <input class="form-control mr-sm-2 d-none" type="search" placeholder="Search" aria-label="Search">
                        <button class="btn my-sm-0" type="submit">
                        <i class="bi bi-search"></i>
                        </button>
                    </form>                   
                </div>
                <div class="vehiclesList-main">
                    <ul class="vehicles-list">
                        <?php foreach($vehiclesList as $vehicle): ?>    
                        <li class="vehicles-item">
                            <div class="item-main"> 
                                <span class="vehicle-customer-name"> <?= $vehicle['name'] ?> </span>
                                <span class="vehicle-licence-plate"> <?= $vehicle['license_plate'] ?> </span>
                                <span class="vehicle-model">  <?= $vehicle['model_vehicles_fk'] ?> </span>
                                <span class="vehicle-brand"> <?= $vehicle['brand'] ?> </span>
                            </div>
                            <div class="item-footer">
                                <button type="button" class="btn edit-button" referenceNumber='<?= $vehicle['cpf'] ?>'>
                                    <i class="bi bi-pencil-square"></i>
                                    Editar
                                </button>
                                <button type="button" class="btn delete-button" referenceNumber='<?= $vehicle['cpf'] ?>'>
                                    <i class="bi bi-trash3"></i>
                                    Excluir
                                </button>
                            </div>
                        </li>
                        <?php endforeach ?>
                    </ul>
                </div>
            </div>
        </div>
    </main>
 