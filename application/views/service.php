<?php if($this->session-> permissions['services']['read'] == 0): ?>
      <?php 
        redirect('/');
        exit;      
      ?>
      
<?php endif ?>  

    <main>
        <div class="container"> 
            <div class="title-box">
                <h1>Serviços</h1>
            </div> 
                               
            <div class="services">
                <div class="services-header toolbar">
                <?php if($this->session-> permissions['services']['create'] == 1): ?>                                            
                    <a href='<?= site_url('index.php/service/store') ?>' class="btn ">
                        <i class="bi bi-plus-circle"></i>
                        Nova
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
                <div class="services-list-main">
                <?php  if(count($servicesList) > 0): ?>
                    <ul class="services-list container-fluid">
                        <?php foreach($servicesList as $service): ?>    
                        <li class="services-item item" >
                            <div class="item-body"> 
                                <div> <strong>Nome: </strong> <?= $service['name'] ?> </div>
                                <div> <strong>Descrição: </strong> 
                                    <?php echo empty($service['description'])?'Sem descrição': $service['description'] ?> 
                                </div>
                               
                                <div>  <strong>Tempo estimado: </strong> 
                                    <?php  echo empty($service['estimatedTime'])? 'Não estimado' : $service['estimatedTime'].' min'?>

                                 </div>
                                <div> <strong>Valor: </strong> <?= $service['cost'] ?> </div>
                                <div> 
                                         <strong>Status: </strong> 
                                         <?php 
                                            switch($service['status']):
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
                                <?php if($this->session-> permissions['services']['update'] == 1): ?>
                                    <a  href="<?= site_url('index.php/service/edit/'.$service['id']) ?>" class="btn edit-button">
                                        <i class="bi bi-pencil-square"></i>
                                        Editar
                                    </a>
                                <?php endif ?>
                                <?php if($this->session-> permissions['services']['delete'] == 1): ?>
                                <a  href="<?= site_url('index.php/service/destroy/'.$service['id']) ?>" class="btn destroy-button">
                                    <i class="bi bi-trash3"></i>
                                    Excluir
                                </a>
                                <?php endif ?>
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
 