<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="<?= site_url('assets/css/global_sytle.css') ?>">   
    <title><?= siteTitle() ?></title>
</head>
<body>
    <header>
        <div class="container">
            <?php if(isset($this->session->message)) echo renderMessage($this->session->message) ?>
        </div>
    </header>
    <main>
        <div class="login-screen">
             <?php if(validation_errors() !== ''):             
                        echo renderMessage(array('type'=> 'error', 'content'=> validation_errors() ));
                   endif
            ?>
            <div class="title-box">
                <h1>Login</h1>  
            </div>
            <?php echo form_open("index.php/auth"); ?>                 
                <label  for="username" class="form-label">Usuário*</label >
                <input class="form-control" type="text" name='username' id='username' required/>

                <label class="form-label" for="password">Senha*</label>
                <input class="form-control" type="password" name='password'  required />  
                  
                <button class="btn  btn-primary" type='submit'>Entrar</button>        
            </form>
        </div>

    </main>
