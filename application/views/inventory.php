<?php if($this->session-> permissions['inventory']['read'] == 0): ?>
      <?php 
        redirect('/');
        exit;      
      ?>
      
<?php endif ?>  

    <main>
        <div class="container">
            <div class="title-box">
                <h1>Estoque de peças</h1>
            </div> 
                                          
            <div class="inventory">
                <div class="inventory-header toolbar">   
                <?php if($this->session-> permissions['inventory']['create'] == 1): ?>                                        
                    <a href='<?= site_url('index.php/inventory/store') ?>' class="btn ">
                        <i class="bi bi-plus-circle"></i>
                        Nova
                    </a> 
                <?php else: ?>                                         
                    <a class="btn "></a>
                <?php endif ?>                                         
                <form class="form-inline">
                    <input class="form-control mr-sm-2 search-item" type="search" placeholder="Pesquisar" aria-label="Search">
                    <a class="btn my-sm-0">
                        <i class="bi bi-search"></i>
                    </a>
                </form>               
                
                </div>
                <div class="inventory-main">
                    <?php  if(count($partsList) > 0): ?>
                    <ul class="parts-list container-fluid">
                        <?php foreach($partsList as $part): ?>    
                        <li class="parts-item item">
                            <div class="item-body">
                                <div class="left-content">
                                    <?php if(!empty($part['image_address'])): ?>
                                        <img class="img-fluid" src="<?= site_url('assets/images/'). $part['image_address']  ?>" alt="<?= $part['name'] ?>">
                                    <?php endif ?>
                                </div>
                                <div class="right-content">
                                    <div class="part-reference"> 
                                            <strong>Ref: </strong> <?= $part['reference_number'] ?> 
                                    </div>
                                    <div>
                                        <strong>Name: </strong> <?= $part['name'] ?> 
                                    </div>
                                    <div> 
                                        <strong>Marca: </strong> <?= $part['brand'] ?>
                                    </div>

                                    <div>  
                                        <strong>Quantidade: </strong> <?= $part['quantity'] ?> 
                                    </div>
                                    <?php if($this->session-> permissions['inventory']['update'] == 1): ?>
                                        <div> 
                                            <strong>Status: </strong> 
                                            <?php 
                                                switch($part['status']):
                                                    case '0':
                                                            echo "Desativada";
                                                        break;
                                                    case '1':
                                                        echo "Ativada";
                                                    break;
                                                endswitch;
                                            ?>
                                        </div>
                                    <?php endif ?>
                                </div>
                            </div>
                            <div class="item-footer">
                                <?php if($this->session-> permissions['inventory']['update'] == 1): ?>
                                    <a  href="<?= site_url('index.php/inventory/edit/'.$part['reference_number']) ?>" class="btn edit-button">
                                        <i class="bi bi-pencil-square"></i>
                                        Editar
                                    </a>
                                <?php endif ?>
                                <?php if($this->session-> permissions['inventory']['delete'] == 1): ?>
                                    <a  href="<?= site_url('index.php/inventory/destroy/'.$part['reference_number']).'/'.$part['automotive_parts_id'] ?>" class="btn destroy-button">
                                        <i class="bi bi-trash3"  ></i>
                                        Excluir
                                    </a>
                                <?php endif ?>
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
 