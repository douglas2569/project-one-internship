function showSandwichMenu(){
    const sandwichMenuButton = document.querySelector('.navbar-toggler')
    sandwichMenuButton.addEventListener('click', ()=>{        
        document.querySelector('#navbarTogglerDemo01').classList.toggle('collapse')        
    })    
}

function showAccordionMaintenance(){
    console.log('showAccordionMaintenance')      
}

export {showSandwichMenu, showAccordionMaintenance}