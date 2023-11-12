<?php if($this->session-> permissions['employees']['update'] == 0): ?>
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
                <h1>Alterar de Funcionário</h1>
            </div>              
            <?php echo form_open('index.php/employee/edit/'.$employee[0]['id']); ?>  

                <div class="form-group"> 
                    <label for="auto-part" class="form-label"><strong>Cargo*</strong></label>
                    <select name="positionId" class="form-select form-select-md mb-3" aria-label="select">                
                        <?php foreach($positionsList as $position): ?>
                            <?php if($position['name'] != 'root'): ?>  
                                <option value="<?= $position['id']?>" <?php ($position['id'] == $employee[0]['positions_id'])?'selected':''?>   >
                                    <?= $position['name'] ?>                                 
                                </option>
                            <?php endif ?>    
                        <?php endforeach ?>    
                    </select>   
                </div> 
               
                <div class="form-group">
                    <label class="form-label" for="name" >Nome*</label>
                    <input class="form-control" type="text" name='name' value="<?= $employee[0]['name'] ?>"  id="name" required/>
                <div>
                <div class="form-group">
                    <label class="form-label" for="cpf">CPF*</label>
                    <input class="form-control" type="tel" name='cpf' id="cpf" value="<?= $employee[0]['cpf'] ?>"  required/> 
                </div>
                <div class="form-group">
                    <label class="form-label" for="phone-number">Telefone*</label>
                    <input class="form-control" type="tel" value="<?= $employee[0]['phone_number'] ?>"  name='phoneNumber' id="phone-number" required/> 
                </div>
                <div class="form-group">
                    <label class="form-label" for="email">Email*</label>
                    <input class="form-control" type="email"  value="<?= $employee[0]['email'] ?>" name="email"  required />
                </div>   

                <div class="form-group">
                    <label class="form-label" for="address">Endereço</label>
                    <input class="form-control" value="<?= $employee[0]['address'] ?>"  type="text" name="address"/>
                </div>
                
                <div class="form-footer">
                    <button class="btn btn-primary" type='submit'>Salvar</button>              
                        <a class="btn btn-secondary" href="<?= site_url('index.php/employee') ?>"> Voltar </a>             
                </div>            
            </form> 
                        
        </div>
    </main>


