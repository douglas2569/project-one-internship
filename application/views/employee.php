<?php if($this->session-> permissions['employees']['read'] == 0): ?>
      <?php 
        redirect('/');
        exit;      
      ?>
      
<?php endif ?>  

    <main>
        <div class="container"> 
            <div class="title-box">
                <h1>Funcionários</h1>
            </div> 
                               
            <div class="employees">
                <div class="employees-header toolbar">  
                    <?php if($this->session-> permissions['employees']['create'] == 1): ?>
                        <a href='<?= site_url('index.php/employee/store') ?>' class="btn ">
                            <i class="bi bi-plus-circle"></i>
                            Novo
                        </a> 
                    <?php else: ?>
                        <a class="btn"></a> 
                    <?php endif ?>

                    <form class="form-inline">
                        <input class="form-control mr-sm-2 search-item" type="search" placeholder="Pesquisar" aria-label="Search">
                        <a class="btn my-sm-0">
                            <i class="bi bi-search"></i>
                        </a>
                    </form>                  
                </div>
                <div class="employees-list-main">
                <?php  if(count($employeesList) > 0): ?>
                    <ul class="employees-list container-fluid">
                            <?php foreach($employeesList as $employee): ?> 
                                <?php if($employee['position_name'] != 'root'): ?>      
                                    <li class="employees-item item" >
                                        <div class="item-body"> 
                                            <div class="employee-customer-name"> <strong>CPF: </strong> <?= $employee['cpf'] ?> </div>
                                            <div> <strong>Nome: </strong> <?= $employee['name'] ?> </div>
                                            <div>  <strong>Endereço: </strong> <?= $employee['address'] ?> </div>
                                            <div> <strong>Telefone: </strong> <?= $employee['phone_number'] ?> </div>
                                            <div> <strong>Email: </strong> <?= $employee['email'] ?> </div>
                                            <div> <strong>Cargo: </strong> <?= $employee['position_name'] ?> </div>
                                        </div>
                                        <div class="item-footer">
                                            <?php if($this->session-> permissions['employees']['update'] == 1): ?>
                                                <a  href="<?= site_url('index.php/employee/edit/'.$employee['id']) ?>" class="btn edit-button">
                                                    <i class="bi bi-pencil-square"></i>
                                                    Editar
                                                </a>
                                            <?php endif ?> 

                                            <?php if($this->session-> permissions['employees']['delete'] == 1): ?>  
                                                <a  href="<?= site_url('index.php/employee/destroy/'.$employee['id']) ?>" class="btn destroy-button">
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
                        <p class="h6" >Nenhum funcionário cadastrado</p>
                    <?php endif; ?> 
                </div>
            </div>
        </div>
    </main>
 