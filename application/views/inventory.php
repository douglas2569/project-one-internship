  
    <main>
        <div class="container"> 
                           
            <h1>Estoque de peças</h1>
                                          
            <div class="inventory">
                <div class="inventory-header toolbar">                                            
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
                <div class="inventory-main">
                    <ul class="parts-list">
                        <?php foreach($partsList as $part): ?>    
                        <li class="parts-item">
                            <div class="item-main">
                                <div>
                                    <img src="<?= site_url('assets/images/'). $part['image_address'] ?>" alt="<?= $part['name'] ?>">
                                </div>
                                <div>
                                    <span class="part-reference"> <?= $part['reference_number'] ?> </span>
                                    <span class="part-name"> <?= $part['name'] ?> </span>
                                    <span class="part-brand"> <?= $part['brand'] ?> </span>
                                    <span class="part-quantity">  <?= $part['quantity'] ?> </span>
                                </div>
                            </div>
                            <div class="item-footer">
                                <button type="button" class="btn edit-button" referenceNumber='<?= $part['reference_number'] ?>'>
                                    <i class="bi bi-pencil-square"></i>
                                    Editar
                                </button>
                                <button type="button" class="btn delete-button" referenceNumber='<?= $part['reference_number'] ?>'>
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
 