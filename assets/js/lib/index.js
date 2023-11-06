function showSandwichMenu(){
    const sandwichMenuButton = document.querySelector('.navbar-toggler')
    sandwichMenuButton &&
    sandwichMenuButton.addEventListener('click', ()=>{        
        document.querySelector('#navbarTogglerDemo01').classList.toggle('collapse')        
    })    
}

function showAccordionMaintenance(){
    console.log('showAccordionMaintenance')
}

function searchItem(){       
    let searchItem = document.querySelector('.search-item');

    if(searchItem == null){
        return;
    }

    searchItem.addEventListener('keyup',()=>{
        let input = document.querySelector('.search-item').value
        input=input.toLowerCase().normalize('NFD').replace(/[\u0300-\u036f]/g, "");
        
        let x = document.querySelectorAll('.item');            
        
        for (let i = 0; i < x.length; i++) {             
             if (!x[i].outerText.toLowerCase().normalize('NFD').replace(/[\u0300-\u036f]/g, "").includes(input)) {
                x[i].style.display="none";
            }
            else {
                switch(x[0].localName){
                    case 'li':
                        x[i].style.display="block";                 
                        break;
                    case 'tr':
                        x[i].style.display="table-row";                 
                        break;

                }

            }
        }
        
    });
}

function recordDeletionAlert(){
    const destroyButton = document.querySelectorAll('.destroy-button')
    destroyButton.forEach((btn)=>{
        btn.addEventListener('click',(e)=>{        
            if(!confirm("Realmente deseja excluir esse registo?")){
               e.preventDefault()
            }
        });
    })    
    
}

export {showSandwichMenu, showAccordionMaintenance, searchItem, recordDeletionAlert}