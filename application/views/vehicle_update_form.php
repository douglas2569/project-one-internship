<main>
        <div class="container">
            
            <?php if(validation_errors() !== ''):             
                        echo renderMessage(array('type'=> 'error', 'content'=> validation_errors() ));
                   endif
            ?> 
            <div class="title-box">
                <h1>Alterar Veiculo</h1>
            </div>              
            <?php echo form_open('index.php/vehicle/edit/'.$vehicle[0]['license_plate']); ?>   
                <fieldset class="form-group border">
                    <legend>Veiculo</legend>
                    <div class="form-group">
                        <label for="license-plate" class="form-label">Placa*</label>
                        <input class="form-control" type="text" name='licensePlate' id="license-plate" required value="<?= $vehicle[0]['license_plate'] ?>"/>
                    <div>
                    <div class="form-group">
                        <label class="form-label" for="model">Modelo*</label>
                        <input class="form-control" type="text" name='model' id="model" required value="<?= $vehicle[0]['model_vehicles_fk']?>"/> 
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="brand">Marca*</label>
                        <input class="form-control" type="text" name="brand"  required  value="<?= $vehicle[0]['brand'] ?>"/>
                    </div>    
                </fieldset>  
                
                <fieldset class="form-group  border">
                    <legend>Proprietario</legend>
                    <div class="form-group">
                        <label class="form-label" for="name" >Nome*</label>
                        <input class="form-control" type="text" name='name' id="name" value="<?= $vehicle[0]['name'] ?>"  required/>
                    <div>
                    <div class="form-group">
                        <label class="form-label" for="cpf">CPF*</label>
                        <input class="form-control" type="tel" name='cpf' id="cpf" required value="<?= $vehicle[0]['cpf'] ?>" /> 
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="phone-number">Telefone*</label>
                        <input class="form-control" type="tel" name='phoneNumber' id="phone-number" required value="<?= $vehicle[0]['phone_number'] ?>" /> 
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="email">Email*</label>
                        <input class="form-control" type="email" name="email"  required value="<?= $vehicle[0]['email'] ?>"/>
                    </div>   

                    <div class="form-group">
                        <label class="form-label" for="address">Endereço</label>
                        <input class="form-control" type="text" name="address" value="<?= $vehicle[0]['address'] ?>" />
                    </div>  
                </fieldset>

                <button class="btn  btn-primary" type='submit'>Atualizar</button>              
            </form> 
            <a class="nav-link" href="<?= site_url() ?>">
                     <i class="bi bi-arrow-left  h2"></i>                     
            </a>             
        </div>
    </main>


