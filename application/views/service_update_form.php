<?php if($this->session-> permissions['services']['update'] == 0): ?>
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
                <h1>Alterar Serviço</h1>
            </div>              
            <?php echo form_open('index.php/service/edit/'.$service[0]['id']); ?>                   
                
                <div class="form-group">
                    <label for="name" class="form-label">Nome*</label>
                    <input class="form-control" type="text" name='name' id="name" value="<?= $service[0]['name']?>" required/>
                <div>
                <div class="form-group">
                    <label class="form-label" for="description">Descrição</label>
                    <textarea class="form-control" name="description" id="description" cols="30" rows="10"><?= $service[0]['description']?>
                    </textarea>
                </div>
                <div class="form-group">
                    <label class="form-label" for="estimatedTime ">Tempo estimado</label>
                    <input class="form-control" type="decimal" name="estimatedTime" value="<?= $service[0]['estimatedTime']?>" />
                </div> 

                <div class="form-group">
                    <label class="form-label" for="brand">Valor*</label>
                    <input class="form-control" type="decimal" name="cost"  value="<?= $service[0]['cost']?>" required />
                </div>    
                
                <div class="form-group">
                        <label class="form-label">Estado</label>
                        <div class='status-radio'>
                            <div class="form-check">
                                <?php if($service[0]['status'] == '1'): ?>
                                    <input class="form-check-input" type="radio" name="status" id="status" value="1" checked>
                                    <?php else: ?>
                                        <input class="form-check-input" type="radio" name="status" id="status" value="1" >
                                <?php endif ?>
                                <label class="form-check-label" for="status">
                                    Ativar
                                </label>
                            </div>                            
                                
                            
                            <div class="form-check">
                                <?php if($service[0]['status'] == '0'): ?>
                                    <input class="form-check-input" type="radio" name="status" id="status" value="0" checked>
                                    <?php else: ?>
                                        <input class="form-check-input" type="radio" name="status" id="status2" value="0" >
                                <?php endif ?>
                                <label class="form-check-label" for="status2">
                                    Desativar
                                </label>
                            </div>
                        </div>
                    </div>
                                
                <div class="form-footer">
                    <button class="btn btn-primary" type='submit'>Salvar</button>              
                        <a class="btn btn-secondary" href="<?= site_url() ?>"> Voltar </a>             
                </div>            
            </form> 
                        
        </div>
    </main>


