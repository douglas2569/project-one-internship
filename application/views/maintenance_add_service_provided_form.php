<main>
        <div class="container">
            
            <?php if(validation_errors() !== ''):             
                        echo renderMessage(array('type'=> 'error', 'content'=> validation_errors() ));
                   endif
            ?> 
            <div class="title-box">
                <h1>Adicionar Serviço </h1>
            </div>              
            <?php echo form_open_multipart('index.php/serviceprovided/store/'.$maintenance_id ); ?>
                <input type="hidden" name='cpfMechanics' value='<?= $this->session->cpf ?>'> 

                    <div class="form-group">
                        <label for="auto-part" class="form-label">
                            <strong>N° Manutenção:</strong> <?= $maintenance_id ?>
                        </label>
                    </div> 

                    <div class="form-group"> 
                        <label for="auto-part" class="form-label"><strong>Serviço*</strong></label>
                            <select name="serviceId" class="form-select form-select-md mb-3" aria-label="select">                
                                <?php foreach($serviceList as $service): ?>
                                    <option value="<?= $service['id']?>">
                                        <?= $service['name'] ?>
                                    </option>
                                <?php endforeach;  ?>    
                        </select>   
                    </div>  
                    
                    <div class="form-group">                        
                        <label class="form-label" for="quantity"><strong>Quantidade*</strong></label>
                        <input class="form-control" inputmode="numeric" pattern="\d*"  type="number" name='quantity' id="quantity" value='1' min="1" /> 
                    </div>
                    
                   
                    <button class="btn  btn-primary" type='submit'>Adicionar</button>              
            </form> 
            <a class="nav-link" href="<?= site_url() ?>">
                     <i class="bi bi-arrow-left  h2"></i>                     
            </a>             
        </div>
    </main>


