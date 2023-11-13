<?php if($this->session-> permissions['permissions']['read'] == 0): ?>
      <?php 
        redirect('/');
        exit;      
      ?>
      
<?php endif ?>  

    <main>
        <div class="container"> 
            <div class="title-box">
                <h1>Permissões</h1>
            </div> 
                               
            <div>
                <div class="permissions-header toolbar">
                    <?php if($this->session-> permissions['permissions']['create'] == 1): ?> 
                        <a href='<?= site_url('index.php/permissionsfeatures/store') ?>' class="btn ">
                            <i class="bi bi-plus-circle"></i>
                            Novo
                        </a> 
                    <?php else: ?>
                        <a class="btn "></a> 
                    <?php endif ?>

                    <form class="form-inline">
                        <input class="form-control mr-sm-2 search-item" type="search" placeholder="Search" aria-label="Search">
                        <a class="btn my-sm-0">
                            <i class="bi bi-search"></i>
                        </a>
                    </form>                  
                </div>

                <div class="permissions-list-main">
                <?php  if(count($permissionsfeaturesList) > 0): ?>
                    <ul class="permissions-list container-fluid">
                        <?php foreach($permissionsfeaturesList as $permissionsfeatures): ?>    
                            <?php if($permissionsfeatures['permissionsfeaturesname'] != 'root'): ?>    
                                <li class="permissions-item item" >
                                    <div class="item-body"> 
                                        <div> <strong>CPF: </strong> <?= $permissionsfeatures['cpf'] ?> </div>
                                        <div> <strong>Nome: </strong> <?= $permissionsfeatures['employee_name'] ?> </div>
                                        <div> <strong>permissionsfeaturesname: </strong> <?= $permissionsfeatures['permissionsfeaturesname'] ?> </div>
                                        <div> <strong>Cargo: </strong> <?= $permissionsfeatures['position_name'] ?> </div>                                 
                                        <div> 
                                                <strong>Status: </strong> 
                                                <?php 
                                                    switch($permissionsfeatures['status']):
                                                        case '0':
                                                                echo "Desativado";
                                                            break;
                                                        case '1':
                                                            echo "Ativado";
                                                        break;
                                                    endswitch;
                                                ?>
                                            </div>
                                    </div>
                                    <div class="item-footer">
                                        <?php if($this->session-> permissions['permissions']['update'] == 1): ?> 
                                            <a  href="<?= site_url('index.php/permissionsfeatures/edit/'.$permissionsfeatures['permissionsfeatures_id']) ?>" class="btn edit-button">
                                                <i class="bi bi-pencil-square"></i>
                                                Editar
                                            </a>
                                        <?php endif ?>
                                        
                                        <?php if($this->session-> permissions['permissions']['delete'] == 1): ?> 
                                            <a  href="<?= site_url('index.php/permissionsfeatures/destroy/'.$permissionsfeatures['permissionsfeatures_id']) ?>" class="btn destroy-button">
                                                <i class="bi bi-trash3"></i>
                                                Excluir
                                            </a>
                                        <?php endif ?>
                                    </div>
                                </li>

                            <?php endif ?>
                        <?php endforeach ?>
                    </ul>
                    <?php  else: ?>                         
                        <p class="h6" >Nenhum serviço cadastrado</p>
                    <?php endif; ?> 
                </div>
            </div>
        </div>
    </main>
 