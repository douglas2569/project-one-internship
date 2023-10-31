  
    <main>
        <div class="container">
            <div class="title-box">
                <h1>Estoque de peças</h1>
            </div> 
                                          
            <div class="inventory">
                <div class="inventory-header toolbar">                                            
                    <a href='<?= site_url('index.php/inventory/store') ?>' class="btn ">
                        <i class="bi bi-plus-circle"></i>
                         Nova
                    </a> 
                    <form class="form-inline">
                        <input class="form-control mr-sm-2 d-none" type="search" placeholder="Search" aria-label="Search">
                        <button class="btn my-sm-0" type="submit">
                        <i class="bi bi-search"></i>
                        </button>
                    </form>                   
                </div>
                <div class="inventory-main">
                    <?php  if(count($partsList) > 0): ?>
                    <ul class="parts-list container-fluid">
                        <?php foreach($partsList as $part): ?>    
                        <li class="parts-item">
                            <div class="item-main">
                                <div>
                                    <img class="img-fluid" src="<?= site_url('assets/images/'). $part['image_address']  ?>" alt="<?= $part['name'] ?>">
                                </div>
                                <div>
                                    <span class="part-reference"> <?= $part['reference_number'] ?> </span>
                                    <span class="part-name"> <?= $part['name'] ?> </span>
                                    <span class="part-brand"> <?= $part['brand'] ?> </span>
                                    <span class="part-quantity">  <?= $part['quantity'] ?> </span>
                                </div>
                            </div>
                            <div class="item-footer">
                                <a  href="<?= site_url('index.php/inventory/edit/'.$part['reference_number']) ?>" class="btn edit-button">
                                    <i class="bi bi-pencil-square"></i>
                                    Editar
                                </a>
                                <a  href="<?= site_url('index.php/inventory/delete/'.$part['reference_number']) ?>" class="btn delete-button">
                                    <i class="bi bi-trash3"></i>
                                    Excluir
                                </a>
                            </div>
                        </li>
                        <?php endforeach ?>
                    </ul>
                    <?php  else: ?>                         
                        <p class="h6" >Nenhuma peça cadastrada</p>
                    <?php endif; ?> 
                </div>
            </div>
        </div>
    </main>
 