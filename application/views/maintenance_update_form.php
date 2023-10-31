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
                                        <?= $maintenance[0]['license_plate_vehicles_customer_fk'] ?>
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
                                    </label>
                                </li>                                
                                <li>
                                     <label class="form-label">
                                        <strong>Data inicial:</strong>
                                        <?php if(empty($maintenance[0]['initial_date'])):  ?>
                                           <a href="<?= site_url('index.php/maintenance/initialdate/'.$maintenance[0]['id']) ?>" class='btn btn-primary' >Iniciar</a>     
                                        <?php else: echo $maintenance[0]['initial_date']  ?>   
                                            
                                        <?php endif;  ?>
                                        
                                    </label>
                                </li>
                                <?php if(!empty($maintenance[0]['initial_date'])):  ?>
                                    <li>
                                        <label class="form-label">
                                            <strong>Data final:</strong>
                                            <?php if(empty($maintenance[0]['final_date'])):  ?>
                                                <a href="<?= site_url('index.php/maintenance/finaldate/'.$maintenance[0]['id']) ?>" class='btn btn-primary'>Finalizar</a>     
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
                        <?php  if(is_array($maintenanceParts)): ?>
                            <ul>
                                <?php foreach($maintenanceParts as $part ): ?>
                                    <li>
                                        <label class="form-label">
                                            <img src="<?= site_url('assets/images/'.$part['image_address']) ?>" alt="">                                            
                                        </label>
                                        <label class="form-label">
                                            <strong>Nº Ref:</strong>
                                            <?= $part['reference_number'] ?>
                                        </label>
                                        <label class="form-label">
                                            <strong>Nome:</strong>
                                            <?= $part['name'] ?>
                                        </label>                                         
                                    </li>
                                <?php endforeach ?>
                            </ul>
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
                    
                    <?php  if(is_array($maintenanceService)): ?>
                        <ul>
                            <?php foreach($maintenanceService as $service ): ?>
                                <li>
                                    <label class="form-label">
                                        <strong>Código:</strong>
                                        <?= $service['id_services_fk'] ?>
                                    </label>
                                    <label class="form-label">
                                        <strong>Quantidade:</strong>
                                        <?= $service['service_name'] ?>
                                    </label>
                                    <label class="form-label">
                                        <strong>Quantidade:</strong>
                                        <?= $service['quantity_service'] ?>
                                    </label>
                                    <label class="form-label">
                                        <strong>Mecânico:</strong>
                                        <?= $service['mechanic_name'] ?>
                                    </label>                                         
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

            
            <a class="nav-link" href="<?= site_url() ?>">
                     <i class="bi bi-arrow-left  h2"></i>                     
            </a>             
        </div>


    </main>


