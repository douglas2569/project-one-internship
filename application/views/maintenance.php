<link rel="stylesheet" href="style.css">  
    <main>
        <div class="container">  
            <div class="title-box">
                <h1 style="width:100%">Manutenções</h1> 
            </div>   

            <div class="maintenance">
                <div class="maintenance-header toolbar">                                            
                    <a href="<?= site_url('index.php/maintenance/store') ?>"  class="btn" role="button">
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
                <div class="maintenance-main">
                <table class="table table-dark">
                    <thead>
                        <th>N°</th>
                        <th>Placa</th>
                        <th>Problema</th>
                        <th>Estado</th>                        
                        <th>Inicio</th>                        
                    </thead>
                    <tbody>
                        <!-- <tr class="table-active"></tr> -->
                        <?php foreach($maintenanceList as $maintenance): ?>
                            <tr> 
                                <td><?= $maintenance['id'] ?></td>                                
                                <td><?= $maintenance['license_plate_vehicles_customer_fk'] ?></td>                                
                                <td><?= $maintenance['reason'] ?></td>                                
                                <td>
                                    <?php 
                                        switch($maintenance['status']):
                                            case 0:
                                                echo 'Não iniciada';
                                            break;

                                            case 1:
                                                echo 'Concluida';
                                            break;

                                            case 2:
                                                echo 'Pausada';
                                            break;

                                            case 3:
                                                echo 'Cancelada';
                                            break;
                                        endswitch
                                    ?>
                                </td>  
                                <td>
                                    <?php 
                                        if(is_null($maintenance['initialDate'])):
                                           echo '-' ;
                                        endif     
                                    ?>
                                </td>                               
                                                              
                            </tr>                        
                        <?php endforeach ?>
                    </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>
 