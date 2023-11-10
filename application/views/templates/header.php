<!DOCTYPE html>
<html lang="pt-pt">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css" integrity="sha384-b6lVK+yci+bfDmaY1u0zE8YYJt0TZxLEAFyYSLHId4xoVvsrQu3INevFKo+Xir8e" crossorigin="anonymous">
    
    <link rel="stylesheet" href="<?= site_url('assets/css/global_style.css') ?>">  
    
    <title><?= siteTitle() ?></title>
</head>
<body>
    <header>
        <div class="container">
            <?php if(isset($this->session->message)):
                    echo renderMessage($this->session->message);
                 endif
            ?>
            
            <nav class="navbar fixed-top navbar-expand-md px-3 navbar-light bg-light"  id="navbar">
                <div class="container">
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo01" aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarTogglerDemo01">
                        <a class="navbar-brand" href="#">
                               <span><?=  ucfirst($this->session->position) ?></span>
                        </a>
                        <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
                            <li class="nav-item active">
                                <a class="nav-link" href="<?= site_url() ?>">Manutenções</a>
                            </li>
                            <?php if($this->session-> position == 'gerente'): ?> 
                                <li class="nav-item">
                                    <a class="nav-link" href="<?= site_url('index.php/inventory') ?>">Estoque</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="<?= site_url('index.php/service') ?>">Serviço</a>
                                </li>
                            <?php endif ?> 
                            
                            <?php if($this->session-> position == 'atendente'): ?> 
                                <li class="nav-item">
                                    <a class="nav-link" href="<?= site_url('index.php/vehicle') ?>">Veiculos</a>
                                </li>
                            <?php endif ?> 
                            <li class="nav-item">
                                <a class="nav-link" href="<?= site_url('index.php/auth/logout') ?>">Sair</a>
                            </li>
                        </ul>
                        
                    </div>
                </div>
            </nav> 

        </div>
    </header>
