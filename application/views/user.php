<?php if($this->session-> permissions['users']['read'] == 0): ?>
      <?php 
        redirect('/');
        exit;      
      ?>
      
<?php endif ?>  

    <main>
        <div class="container"> 
            <div class="title-box">
                <h1>Usuários</h1>
            </div> 
                               
            <div class="users">
                <div class="users-header toolbar">   
                    <?php if($this->session-> permissions['users']['create'] == 1): ?> 
                        <a href='<?= site_url('index.php/user/store') ?>' class="btn  new-btn">
                            <i class="bi bi-plus-circle"></i>
                            Novo
                        </a> 
                    <?php else: ?>
                        <a></a> 
                    <?php endif ?>

                    <form class="form-inline">
                        <input class="form-control mr-sm-2 search-item" type="search" placeholder="Digite para pesquisar" aria-label="Search">
                        
                    </form>                  
                </div>
                <div class="users-list-main">
                <?php  if(count($userList) > 0): ?>
                    <ul class="users-list container-fluid">
                        <?php foreach($userList as $user): ?>    
                            <?php if($user['position_name'] != 'root'): ?>    
                                <li class="users-item item" >
                                    <div class="item-body"> 
                                        <div> <strong>CPF: </strong> <?= $user['cpf'] ?> </div>
                                        <div> <strong>Nome: </strong> <?= $user['employee_name'] ?> </div>
                                        <div> <strong>Username: </strong> <?= $user['username'] ?> </div>
                                        <div> <strong>Cargo: </strong> <?= $user['position_name'] ?> </div>                                 
                                        <div> 
                                                <strong>Status: </strong> 
                                                <?php 
                                                    switch($user['status']):
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
                                        <?php if($this->session-> permissions['users']['update'] == 1): ?> 
                                            <a  href="<?= site_url('index.php/user/edit/'.$user['user_id']) ?>" class="btn edit-button">
                                                <i class="bi bi-pencil-square"></i>
                                                Editar
                                            </a>
                                        <?php endif ?>
                                        
                                        <?php if($this->session-> permissions['users']['delete'] == 1): ?> 
                                            <a  href="<?= site_url('index.php/user/destroy/'.$user['user_id']) ?>" class="btn destroy-button">
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
 