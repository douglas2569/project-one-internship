<?php if($this->session-> permissions['maintenance']['create'] == 0): ?>
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
                <h1>Cadastrar de Manuteção</h1>
            </div>              
            <?php echo form_open('index.php/maintenance/store', array('class'=>'form-register-upload')); ?> 
                <div class="form-group">
                    <label for="vehicle" class="form-label">Veiculo*</label>
                    <select name="license_plate" class="form-select form-select-md mb-3" aria-label="select">                
                        <?php foreach($vehiclesList as $vehicle): ?>
                            <option value="<?= $vehicle['license_plate'] ?>"><?= $vehicle['license_plate'] ?></option>
                        <?php endforeach ?>    
                    </select> 
                </div>               
                <div class="form-group">           
                    <label class="form-label" for="reason">Problema*</label>
                    <input class="form-control" type="text" name='reason' required/> 
                </div>
                <div class="form-group"> 
                    <label class="form-label" for="description">Descrição</label>
                    <textarea class="form-control" name="description"  cols="30" rows="10">
                        
                        </textarea>
                </div>            

                <div class="form-footer">
                    <button class="btn btn-primary" type='submit'>Cadastrar</button>              
                    <a class="btn btn-secondary" href="<?= site_url() ?>"> Voltar </a>             
                </div>              
            </form> 
                     
        </div>
    </main>
