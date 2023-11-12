<?php if($this->session-> permissions['work_on_maintaining']['read'] == 0): ?>
      <?php 
        redirect('/');
        exit;      
      ?>
      
<?php endif ?>  

<main>
        <div class="container">
            
            <?php if(validation_errors() !== ''):             
                        echo renderMessage(array('type'=> 'error', 'content'=> validation_errors() ));
                   endif
            ?> 
            <div class="title-box">
                <h1>Manutenção</h1>
            </div>       
            <div class="accordion" id="accordionExample">
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                            Informações Gerais
                        </button>
                    </h2>
                    <div id="collapseOne" class="accordion-collapse collapse show" data-bs-parent="#accordionExample">
                        <div class="accordion-body">
                        <?php  if(is_array($maintenance)): ?>
                            <ul>
                                <li class="form-group">
                                    <label class="form-label"><strong>N°:</strong>
                                        <?= $maintenance[0]['id'] ?>
                                    </label>
                                </li>
                                <li>
                                    <label class="form-label">
                                        <strong>Placa:</strong>
                                        <?= $maintenance[0]['vehicles_customer_license_plate'] ?>
                                    </label>
                                </li>
                                <li>
                                    <label class="form-label">
                                        <strong>Problema:</strong>
                                        <?= $maintenance[0]['reason'] ?>
                                    </label>
                                </li>
                                <li>
                                     <label class="form-label">
                                        <strong>Descrição:</strong>
                                        <?php echo (empty($maintenance[0]['description']))?'Sem descrição':$maintenance[0]['description'] ?>
                                    </label>
                                </li>
                                <li>
                                     <label class="form-label">
                                        <strong>Status:</strong>
                                        <?php                                             
                                            switch($maintenance[0]['status']):
                                                case 0:
                                                    echo 'Não iniciada';
                                                break;

                                                case 1:                                                    
                                                    echo 'Iniciada';
                                                break;

                                                case 2:
                                                    echo 'Concluida';
                                                break;

                                            endswitch
                                        ?>
                                    </label>
                                </li>                                
                                <li>
                                     <label class="form-label">
                                        <strong>Data inicial:</strong>
                                        <?php if(empty($maintenance[0]['initial_date'])):  ?>                                         
                                            <?php if($this->session-> permissions['work_on_maintaining']['update'] == 1): ?>
                                                <a href="<?= site_url('index.php/maintenance/initialdate/'.$maintenance[0]['id']) ?>" class='btn btn-primary' >Iniciar</a>  
                                             <?php else: ?>
                                                    Não iniciada.    
                                            <?php endif; ?>    

                                        <?php else: echo $maintenance[0]['initial_date']  ?>   
                                            
                                        <?php endif;  ?>
                                        
                                    </label>
                                </li>
                                <?php if(!empty($maintenance[0]['initial_date'])):  ?>
                                    <li>
                                        <label class="form-label">
                                            <strong>Data final:</strong>
                                            <?php if(empty($maintenance[0]['final_date'])):  ?>
                                                <?php if($this->session-> permissions['work_on_maintaining']['update'] == 1): ?>
                                                <a href="<?= site_url('index.php/maintenance/finaldate/'.$maintenance[0]['id']) ?>" class='btn btn-primary'>Finalizar</a>  
                                                <?php else: ?>
                                                    Não finalizada 
                                                <?php endif ?>   
                                            <?php else: echo $maintenance[0]['final_date']  ?>   
                                            
                                            <?php endif;  ?>
                                        </label>
                                    </li>  
                                <?php endif;  ?>                              
                            </ul>
                        <?php endif; ?>

                    </div>
                    </div>
                </div>                
            <div class="accordion-item">
                <h2 class="accordion-header">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                        Peças
                    </button>
                </h2>
                <div id="collapseTwo" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
                    <div class="accordion-body">
                        <?php if($this->session-> permissions['work_on_maintaining']['create'] == 1 && $maintenance[0]['status'] != '2'): ?> 
                        <div class="accordion-sub-button">                            
                                <a href="<?= site_url('index.php/maintenanceinventory/store/'.$maintenance[0]['id']) ?>"  class="btn" role="button">
                                    <i class="bi bi-plus-circle"></i>
                                    Adicionar
                                </a>                             
                        </div>                            
                        <?php endif; ?>    
                        <?php  if(is_array($maintenanceParts)): ?>
                            
                                <?php foreach($maintenanceParts as $part ): ?>
                                    <div class="item">
                                        <div class="item-body">
                                            <?php if(!empty($part['image_address'])): ?>
                                            <!-- <tr>
                                                <td class="form-label">
                                                    <img src="<?= site_url('assets/images/'.$part['image_address']) ?>" alt="">                                            
                                                </td>
                                            </tr> -->
                                            <?php endif ?>
                                            
                                                <div >
                                                    <strong>Nº Ref:</strong>
                                                    
                                                    <?= $part['reference_number'] ?>
                                                </div>                                               
                                            
                                            
                                                <div >
                                                    <strong>Nome:</strong>
                                                    <?= $part['name'] ?>
                                                </div>                                                 
                                            

                                            
                                                <div  class="form-label"> 
                                                    <strong>Quantidade:</strong>
                                                    <?= $part['quantity'] ?>
                                                </div>                                                 
                                            
                                            
                                        </div>  

                                        <div class="item-footer" >                                        
                                            <?php if($this->session-> permissions['work_on_maintaining']['delete'] == 1  && $maintenance[0]['status'] != '2'): ?> 
                                                    <a href="<?= site_url('index.php/maintenanceinventory/destroy/'.$part['maintenance_id'].'/'.$part['reference_number'].'/'.$part['quantity']) ?>"  class="btn" role="button">
                                                        <i class="bi bi-trash3"></i>                               
                                                    </a>
                                                <?php endif ?>  
                                        </div>                                      
                                     </div>
                                <?php endforeach ?>
                            
                        <?php  else: ?>                         
                            <p class="h6" >Nenhuma peça adicionada</p>
                        <?php endif; ?>
                    </div>
                </div>
            </div>
            <div class="accordion-item">
                <h2 class="accordion-header">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                    Serviços
                </button>
                </h2>
                <div id="collapseThree" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
                <div class="accordion-body">
                
                    <?php if($this->session-> permissions['work_on_maintaining']['create'] == 1  && $maintenance[0]['status'] != '2'): ?> 
                        <div class="accordion-sub-button">                        
                            <a  href='<?= site_url('index.php/serviceprovided/store/'.$maintenance[0]['id']) ?>' class="btn" role="button">
                                <i class="bi bi-plus-circle"></i>
                                    Adicionar
                            </a>
                        </div>
                    <?php endif ?>     
                    
                    <?php  if(is_array($maintenanceService)): ?>
                        
                            <?php foreach($maintenanceService as $service ): ?>
                                <div class="item">
                                    <div class="item-body">
                                        <div>
                                            <strong>Código:</strong>
                                            <?= $service['id_services_fk'] ?>
                                        </div>
                                        
                                        <div>
                                            <strong>Quantidade:</strong>
                                            <?= $service['service_name'] ?>
                                        </div>
                                        
                                        
                                        <div class="form-label">
                                            <strong>Quantidade:</strong>
                                            <?= $service['quantity_service'] ?>
                                        </div>
                                    
                                        
                                        <div class="form-label">
                                            <strong>Mecânico:</strong>
                                            <?= $service['mechanic_name'] ?>
                                        </div> 
                                        
                                    </div> 
                                    
                                    <div class="item-footer" >
                                    
                                        <?php if($this->session-> permissions['work_on_maintaining']['delete'] == 1  && $maintenance[0]['status'] != '2'): ?> 
                                            <a href= "<?= site_url('index.php/serviceprovided/destroy/'.$maintenanceService[0]['id'].'/'.$maintenance[0]['id']) ?>"  class="btn" role="button">
                                                <i class="bi bi-trash3"></i>                               
                                            </a>
                                        <?php endif ?> 
                                    </div>                                       
                                </li>
                               
                            <?php endforeach ?>
                        </ul>
                    <?php  else: ?>
                         <p class="h6" >Nenhum serviço adcionado</p>
                    <?php endif; ?>     
                </div>
                </div>
            </div>
            </div>
                      
        </div>


    </main>


