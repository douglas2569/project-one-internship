<main>
        <div class="container">
            
            <?php if(validation_errors() !== ''):             
                        echo renderMessage(array('type'=> 'error', 'content'=> validation_errors() ));
                   endif
            ?> 
            <div class="title-box">
                <h1>Adicionar Peça </h1>
            </div>              
            <?php echo form_open_multipart('index.php/maintenanceinventory/store/'.$maintenance_id ); ?>
                    <div class="form-group">
                        <label for="auto-part" class="form-label">
                            <strong>N° Manutenção:</strong> <?= $maintenance_id ?>
                        </label>
                    </div> 

                    <div class="form-group"> 
                        <label for="auto-part" class="form-label"><strong>Peça*</strong></label>
                            <select name="reference_number_quantity" class="form-select form-select-md mb-3" aria-label="select">                
                                <?php foreach($partList as $part): ?>
                                    <option value="<?= $part['reference_number']."|".$part['quantity'] ?>">
                                        <?= $part['name'] ?> - Qt: <?= $part['quantity'] ?>
                                        
                                    </option>
                                <?php endforeach ?>    
                        </select>   
                    </div>                 
                    <div class="form-group">                        
                        <label class="form-label" for="quantity"><strong>Quantidade*</strong></label>
                        <input class="form-control" inputmode="numeric" pattern="\d*"  type="number" name='quantity' id="quantity" value='1' min="1" /> 
                    </div>

                    <button class="btn  btn-primary" type='submit'>Adcionar</button>              
            </form> 
            <a class="nav-link" href="<?= site_url() ?>">
                     <i class="bi bi-arrow-left  h2"></i>                     
            </a>             
        </div>
    </main>


