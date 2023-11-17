<?php if($this->session-> permissions['maintenance']['read'] == 0): ?>
      <?php 
        redirect('/');
        exit;      
      ?>
      
<?php endif ?>   

    <main>
        <div class="container" >  
            <div class="title-box">
                <h1>Manutenções</h1> 
            </div>   

            <div class="maintenance">
                <div class="maintenance-header toolbar">  
                    <?php if($this->session-> permissions['maintenance']['create'] == '1'): ?>                                          
                        <a href="<?= site_url('index.php/maintenance/store') ?>"  class="btn new-btn" role="button">
                            <i class="bi bi-plus-circle"></i>
                            Nova
                        </a> 

                    <?php else: ?>                                                                                 
                        <a> </a> 
                    <?php endif ?>                                                                                 

                    <form class="form-inline">
                        <input class="form-control mr-sm-2 search-item" type="search" placeholder="Digite para pesquisar" aria-label="Search">  
                                            
                    </form>                   
                </div>
                <div class="maintenance-main">
                    <?php  if(is_array($maintenanceList)): ?>
                        <table class="table table-dark" id="maintenance-table">
                            <thead>
                                <th>N°</th>
                                <th>Placa</th>
                                <th>Problema</th>
                                <th>Estado</th>                        
                                <th>*</th>                        
                            </thead>
                            <tbody>
                                
                                    <?php foreach($maintenanceList as $maintenance): ?> 
                                        <?php  if($maintenance['live_status'] == 1 || $this->session-> permissions['maintenance']['create'] == 1): ?>                           
                                            <tr class='itens-list item' > 
                                                <td> <?= $maintenance['id'] ?></td>                                
                                                <td><?= $maintenance['vehicles_customer_license_plate'] ?></td>                                
                                                <td>
                                                <a  href="<?= site_url('index.php/maintenance/workon/'.$maintenance['id']) ?>">
                                                    <?= $maintenance['reason'] ?></a> 
                                                </td>                                
                                                <td>
                                                    <?php 
                                                       if($maintenance['live_status']): 

                                                            switch($maintenance['status']):
                                                                case 0:
                                                                    echo 'Não iniciada';
                                                                break;
                
                                                                case 1:                                                    
                                                                    echo 'Iniciada';
                                                                break;
                
                                                                case 2:
                                                                    echo 'Concluida';
                                                                break;
                
                                                                endswitch;
                                                        else:
                                                            echo 'Desativada';
                                                        endif;
                                                    ?>
                                                </td> 
                                                <td>
                                                <?php if($this->session-> permissions['maintenance']['update'] == '1'): ?>  
                                                    <a  href="<?= site_url('index.php/maintenance/edit/'.$maintenance['id'] ) ?>" class="btn edit-button">
                                                        <i class="bi bi-pencil-square"></i>
                                                        
                                                    </a>
                                                <?php endif ?> 
                                                    
                                                <?php if($this->session-> permissions['maintenance']['delete'] == '2'): ?>  
                                                    <a  href="<?= site_url('index.php/maintenance/destroy/'.$maintenance['id'] ) ?>" class="btn destroy-button">
                                                        <i class="bi bi-trash3"></i>
                                                        
                                                    </a>
                                                <?php endif ?> 
                                                </td>
                                                                            
                                            </tr> 
                                            <?php  endif ?>                       
                                                                    
                                    <?php endforeach ?>                                                 
                                </tbody>
                            </table>
                    <?php  else: ?>                         
                        <p class="h6" >Nenhuma manutenção cadastrada</p>
                    <?php endif; ?>  
                </div>
            </div>
        </div>
    </main>
 