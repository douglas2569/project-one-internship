<?php if($this->session-> permissions['users']['update'] == 0): ?>
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
                <h1>Alterar de Usuário</h1>
            </div>              
            <?php echo form_open('index.php/user/edit/'.$user[0]['user_id']); ?> 
            
                <div class="form-group"> 
                    <label for="auto-part" class="form-label"><strong>Funcionário*</strong></label>
                    <input class="form-control" disabled type="text" name='name' value="<?= $user[0]['employee_name'] ?>" required/>
                    <input type="hidden" name='employeeId' value="<?= $user[0]['employees_id'] ?>"/>   
                </div> 
                
                <div class="form-group">
                    <label for="name" class="form-label">Username*</label>
                    <input class="form-control" type="text" name='username' id="username" required/>
                <div>
                <div class="form-group">
                    <label class="form-label" for="password">Senha</label>
                    <input  type='password' class="form-control" name="password" id="password" cols="30" rows="10">
                </div> 
                
                <div class="form-group">
                        <label class="form-label">Estado</label>
                        <div class='status-radio'>
                            <div class="form-check">
                                <?php if($user[0]['status'] == '1'): ?>
                                    <input class="form-check-input" type="radio" name="status" id="status" value="1" checked>
                                    <?php else: ?>
                                        <input class="form-check-input" type="radio" name="status" id="status" value="1" >
                                <?php endif ?>
                                <label class="form-check-label" for="status">
                                    Ativar
                                </label>
                            </div>                            
                                
                            
                            <div class="form-check">
                                <?php if($user[0]['status'] == '0'): ?>
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


