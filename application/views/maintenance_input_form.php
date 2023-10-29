<main>
        <div class="container">
            
            <?php if(validation_errors() !== ''):             
                        echo renderMessage(array('type'=> 'error', 'content'=> validation_errors() ));
                   endif
            ?> 
            <div class="title-box">
                <h1>Cadastrar de Manuteção</h1>
            </div>              
            <?php echo form_open('index.php/maintenance/store'); ?>                
                <label for="vehicle" class="form-label">Veiculo*</label>
                <select name="license_plate" class="form-select form-select-md mb-3" aria-label="select">                
                    <?php foreach($vehiclesList as $vehicle): ?>
                        <option value="<?= $vehicle['license_plate'] ?>"><?= $vehicle['license_plate'] ?></option>
                    <?php endforeach ?>    
                </select> 

                <label class="form-label" for="reason">Problema*</label>
                <input class="form-control" type="text" name='reason' required/> 

                <label class="form-label" for="description">Descrição</label>
                <textarea class="form-control" name="description"  cols="30" rows="10">

                </textarea>

                <button class="btn  btn-primary" type='submit'>Cadastrar</button>              
            </form> 
            <a class="nav-link" href="<?= site_url() ?>">
                     <i class="bi bi-arrow-left  h2"></i>                     
            </a>             
        </div>
    </main>
