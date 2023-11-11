<?php if($this->session-> permissions['usuarios']['read'] != 1): ?>
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
                    <a href='<?= site_url('index.php/user/store') ?>' class="btn ">
                        <i class="bi bi-plus-circle"></i>
                        Novo
                    </a> 
                    <form class="form-inline">
                        <input class="form-control mr-sm-2 search-item" type="search" placeholder="Search" aria-label="Search">
                        <a class="btn my-sm-0">
                            <i class="bi bi-search"></i>
                        </a>
                    </form>                  
                </div>
                <div class="users-list-main">
                <?php  if(count($userList) > 0): ?>
                    <ul class="users-list container-fluid">
                        <?php foreach($userList as $user): ?>    
                        <li class="users-item item" >
                            <div class="item-body"> 
                                <div> <strong>CPF: </strong> <?= $user['cpf'] ?> </div>
                                <div> <strong>Nome: </strong> <?= $user['name'] ?> </div>
                                <div> <strong>Username: </strong> <?= $user['username'] ?> </div>
                                <div> <strong>Cargo: </strong> <?= $user['position'] ?> </div>                                 
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
                                <a  href="<?= site_url('index.php/user/edit/'.$user['cpf']) ?>" class="btn edit-button">
                                    <i class="bi bi-pencil-square"></i>
                                    Editar
                                </a>
                                <a  href="<?= site_url('index.php/user/destroy/'.$user['cpf']) ?>" class="btn destroy-button">
                                    <i class="bi bi-trash3"></i>
                                    Excluir
                                </a>
                            </div>
                        </li>
                        <?php endforeach ?>
                    </ul>
                    <?php  else: ?>                         
                        <p class="h6" >Nenhum serviço cadastrado</p>
                    <?php endif; ?> 
                </div>
            </div>
        </div>
    </main>
 