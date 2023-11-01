    <main>
        <div class="container">  
            <div class="title-box">
                <h1>Manutenções</h1> 
            </div>   

            <div class="maintenance">
                <div class="maintenance-header toolbar">  
                    <?php if($this->session-> position == 'atendente'): ?>                                          
                        <a href="<?= site_url('index.php/maintenance/store') ?>"  class="btn" role="button">
                            <i class="bi bi-plus-circle"></i>
                            Nova
                        </a>  
                    <?php endif ?>                                                                                 

                    <form class="form-inline">
                        <input class="form-control mr-sm-2 d-none" type="search" placeholder="Search" aria-label="Search">
                        <a class="btn my-sm-0">
                        <i class="bi bi-search"></i>
</a>
                    </form>                   
                </div>
                <div class="maintenance-main">
                    <?php  if(is_array($maintenanceList)): ?>
                        <table class="table table-dark">
                            <thead>
                                <th>N°</th>
                                <th>Placa</th>
                                <th>Problema</th>
                                <th>Estado</th>                        
                                <th>*</th>                        
                            </thead>
                            <tbody>
                                
                                    <?php foreach($maintenanceList as $maintenance): ?>                            
                                            <tr> 
                                                <td> <?= $maintenance['id'] ?></td>                                
                                                <td><?= $maintenance['license_plate_vehicles_customer_fk'] ?></td>                                
                                                <td>
                                                <a  href="<?= site_url('index.php/maintenance/change/'.$maintenance['id']) ?>">
                                                    <?= $maintenance['reason'] ?></a> 
                                                </td>                                
                                                <td>
                                                    <?php 
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
                                                    ?>
                                                </td> 
                                                <td>
                                                <?php if($this->session-> position == 'atendente'): ?> 
                                                    <a  href="<?= site_url('index.php/maintenance/edit/'.$maintenance['id'] ) ?>" class="btn edit-button">
                                                        <i class="bi bi-pencil-square"></i>
                                                    
                                                    </a>
                                                    <a  href="<?= site_url('index.php/maintenance/delete/'.$maintenance['id'] ) ?>" class="btn delete-button">
                                                        <i class="bi bi-trash3"></i>
                                                        
                                                    </a>
                                                <?php endif ?> 
                                                </td>
                                                                            
                                            </tr>                        
                                                                    
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
 