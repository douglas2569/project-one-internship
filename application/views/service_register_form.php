<?php if($this->session-> permissions['services']['create'] == 0): ?>
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
                <h1>Cadastrar de Serviço</h1>
            </div>              
            <?php echo form_open('index.php/service/store'); ?>                   
                
                <div class="form-group">
                    <label for="name" class="form-label">Nome*</label>
                    <input class="form-control" type="text" name='name' id="name" required/>
                <div>
                <div class="form-group">
                    <label class="form-label" for="description">Descrição</label>
                    <textarea class="form-control" name="description" id="description" cols="30" rows="10">
                    </textarea>
                </div>
                <div class="form-group">
                    <label class="form-label" for="estimatedTime ">Tempo estimado</label>
                    <input class="form-control" type="decimal" name="estimatedTime" />
                </div> 

                <div class="form-group">
                    <label class="form-label" for="brand">Valor*</label>
                    <input class="form-control" type="decimal" name="cost"  required />
                </div>                    
                                
                <div class="form-footer">
                    <button class="btn btn-primary" type='submit'>Cadastrar</button>              
                        <a class="btn btn-secondary" href="<?= site_url('index.php/service') ?>"> Voltar </a>             
                </div>            
            </form> 
                        
        </div>
    </main>


