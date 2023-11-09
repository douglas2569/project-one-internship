<main>
        <div class="container">
            
            <?php if(validation_errors() !== ''):             
                        echo renderMessage(array('type'=> 'error', 'content'=> validation_errors() ));
                   endif
            ?> 
            <div class="title-box">
                <h1>Cadastrar de Peça</h1>
            </div>              
            <?php echo form_open_multipart('index.php/inventory/store'); ?>
                    
                    <!-- <div class="input-group mb-3">
                        <label class="input-group-text" for="image-inventory-part">Upload Imagem</label>
                        <input type="file" class="form-control" id="image-inventory-part" name="imageInventoryPart">
                    </div> -->
                
                    <div class="form-group">
                        <label for="reference" class="form-label">Referência*</label>
                        <input class="form-control" type="text" name='reference' id="reference" required/>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="name">Nome*</label>
                        <input class="form-control" type="text" name='name' id="name" required/> 
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="brand">Marca*</label>
                        <input class="form-control" type="text" name="brand"  required />
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="description">Descrição</label>
                        <textarea class="form-control" name="description" id="description" cols="30" rows="10">
                        </textarea>
                        
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="unit-value" >Valor unitario*</label>
                        <input class="form-control" type="decimal" name='unitValue' id="unit-value" required/>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="quantity">Quantidade*</label>
                        <input class="form-control" inputmode="numeric" pattern="\d*"  type="number" name='quantity' id="quantity" value='1' min="1" /> 
                    </div>
                    <div class="form-footer">
                        <button class="btn btn-primary" type='submit'>Cadastrar</button>              
                        <a class="btn btn-secondary" href="<?= site_url() ?>"> Voltar </a>             
                    </div>
            </form> 
        </div>
    </main>


