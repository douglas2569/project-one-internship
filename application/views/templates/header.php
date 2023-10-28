<!DOCTYPE html>
<html lang="pt-pt">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="<?= site_url('assets/css/global_sytle.css') ?>">  
    
    <title><?= siteTitle() ?></title>
</head>
<body>
    <header>
        <div class="container">
            <?php if(isset($this->session->message)) echo renderMessage($this->session->message) ?>
            <div class='header-top'>                                               
                        <span>Olá, <strong> <?= $this->session->name ?>  </strong> </span> 
                                               

                <?php  if($this->session->position == 'gerente'):  ?>                                
                     <h4>Gerente</h4>
                <?php endif ?>
                
                    <a href="<?=site_url('index.php/auth/logout') ?>">Sair</a>
            </div>
        </div>
    </header>
