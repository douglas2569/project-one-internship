<?php if($this->session-> permissions['maintenance']['update'] == 0): ?>
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
                <h1>Alterar Manuteção</h1>
            </div>              
            <?php echo form_open('index.php/maintenance/edit/'.$maintenance[0]['id']); ?>                
                <label for="vehicle" class="form-label">Veiculo*</label>
                <select name="license_plate" class="form-select form-select-md mb-3" aria-label="select">                
                    <?php foreach($vehiclesList as $vehicle): ?>
                        <?php if($vehicle['license_plate'] == $maintenance[0]['vehicles_customer_license_plate']): ?>
                            <option selected value="<?= $vehicle['license_plate'] ?>"><?= $vehicle['license_plate'] ?></option>
                         <?php else: ?>   
                            <option value="<?= $vehicle['license_plate'] ?>"><?= $vehicle['license_plate'] ?></option>
                        <?php endif ?>  
                    <?php endforeach ?>    
                </select> 

                <label class="form-label" for="reason">Problema*</label>
                <input class="form-control" type="text" name='reason' required value="<?= $maintenance[0]['reason'] ?>"/> 

                <label class="form-label" for="description">Descrição</label>
                <textarea class="form-control" name="description"  cols="30" rows="10"><?= $maintenance[0]['description'] ?></textarea>

                <?php if(!empty($maintenance[0]['initial_date'])):  ?>
                    <div>
                        <label class="form-label">
                            <strong>Data Inicial:</strong>
                            <?php if(empty($maintenance[0]['initial_date'])):  ?>                                
                                    Não iniciada 
                            <?php elseif(!empty($maintenance[0]['final_date'])): 
                                echo $maintenance[0]['initial_date']  ?>                                   
                            <?php else: 
                                echo $maintenance[0]['initial_date']  ?>   
                                <a href="<?= site_url('index.php/maintenance/eraseinitialdate/'.$maintenance[0]['id']) ?>" class='btn'><i class="bi bi-trash3"></i></a>  
                            <?php endif;  ?>
                        </label>
                    </div>  
                <?php endif;  ?> 

                <?php if(!empty($maintenance[0]['final_date'])):  ?>
                    <div>
                        <label class="form-label">
                            <strong>Data Final:</strong>      
                            <?php echo $maintenance[0]['final_date']  ?>   
                                <a href="<?= site_url('index.php/maintenance/erasefinaldate/'.$maintenance[0]['id']) ?>" class='btn'>
                                    <i class="bi bi-trash3"></i>
                                </a> 
                        </label>
                    </div>  
                <?php endif;  ?>  

                <div class="form-footer">
                    <button class="btn btn-primary" type='submit'>Salvar</button>              
                   <a class="btn btn-secondary" href="<?= site_url() ?>"> Voltar </a>             
                </div>             
            </form>                        
        </div>
    </main>
