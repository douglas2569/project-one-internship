<?php if($this->session-> permissions['permissions_features']['read'] == 0): ?>
      <?php 
        redirect('/');
        exit;      
      ?>
      
<?php endif ?>  

    <main>
        <div class="container"> 
            <div class="title-box">
                <h1>Permissões</h1>
            </div> 
                               
            <div>
                <div class="permissions-header toolbar">
                    <label for="position" class="form-label">Cargos*</label>
                    <select name="position_id" class="form-select form-select-md mb-3 select-position-list" aria-label="select">                
                        <option min='1'  value="0" selected>Escolha um opção</option>
                        <?php foreach($positionList as $position): ?>
                            <option value="<?= $position['id'] ?>"><?= $position['name'] ?></option>
                            <?php endforeach ?>    
                    </select>                 
                        
                </div>   
                    
                <div class="permissions-panel"> 
                    <label class="form-label h5">Estoque</label>
                    <div>
                        <div class="form-check form-switch">
                            <label class="form-check-label" for="create-check">Cadastrar</label>
                            <input class="form-check-input" type="checkbox" id="create-check" name="create">
                        </div>

                        <div class="form-check form-switch">
                            <label class="form-check-label" for="read-check">Visualizar</label>
                            <input class="form-check-input" type="checkbox" id="read-check" name="read">
                        </div>

                        <div class="form-check form-switch">
                            <label class="form-check-label" for="update-check">Atualizar</label>
                            <input class="form-check-input" type="checkbox" id="update-check" name="update">
                        </div>

                        <div class="form-check form-switch">
                            <label class="form-check-label" for="update-check">Excluir</label>
                            <input class="form-check-input" type="checkbox" id="delete-check" name="delete">
                        </div>
                    </div>

                </div>
                
            </div>
            



        </div>
    </main>
 