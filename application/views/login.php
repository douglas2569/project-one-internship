<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css" integrity="sha384-b6lVK+yci+bfDmaY1u0zE8YYJt0TZxLEAFyYSLHId4xoVvsrQu3INevFKo+Xir8e" crossorigin="anonymous">
       
    
    <link rel="stylesheet" href="<?= site_url('assets/css/global_style.css') ?>">   
    <title><?= siteTitle() ?></title>
</head>
<body>
    <header>
        <div class="container">
            <?php if(isset($this->session->message)) echo renderMessage($this->session->message) ?>
        </div>
    </header>
    <main>
        <div class="container">
            <div class="login-screen">            
                <?php if(validation_errors() !== ''):             
                            echo renderMessage(array('type'=> 'error', 'content'=> validation_errors() ));
                    endif
                ?>
                <div class="title-box">
                    <h1>Login</h1>  
                </div>
                <?php echo form_open("index.php/auth", array('class'=>'form-login')); ?>    
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text" id="basic-addon1">
                                <i class="bi bi-person-circle"></i>
                            </span>
                        </div>
                        <input type="text" class="form-control" placeholder="Username" aria-label="Username" aria-describedby="basic-addon1" name='username' id='username' required>
                    </div>            
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text" id="basic-addon2">
                                <i class="bi bi-key-fill"></i>
                            </span>
                        </div>
                        <input type="password" class="form-control" placeholder="Senha" aria-label="Password" aria-describedby="basic-addon2" name='password' required>
                    </div>
                    <div class='login-footer'>
                              
                        <button class="btn  btn-primary" type='submit'>Entrar</button>        
                    </div>

                </form>
            </div>

            <ul class="form-group mt-5 login-screen">
                <li>  <label class="form-label h5">Gerente</label>
                    <ul>
                        <li> <label class="form-label"><strong>Usersname:</strong> cassio00</label></li>
                    </ul>
                </li>

                <li>  <label class="form-label h5">Atendentes</label>
                    <ul>
                        <li> <label class="form-label"><strong>Usersname:</strong> angelo02, leticia02</label></li>
                    </ul>
                </li>

                <li>  <label class="form-label h5">Mecânicos</label>
                    <ul>
                        <li> <label class="form-label"><strong>Usersname:</strong> pedro01, antonio01, joao01</label></li>
                    </ul>
                </li>

                <li>  <label class="form-label h5">Root</label>
                    <ul>
                        <li> <label class="form-label"><strong>Usersname:</strong> root</label></li>
                    </ul>
                </li>

                <li><label class="form-label"><strong>Senhas:</strong> 123</label></li>
            </ul>    

    </div>
    </main>
