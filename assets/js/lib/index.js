import { getAll } from "./requests/index"

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


 function getPermissionsByPosition(){
    const positionList = document.querySelector('.select-position-list')
    if(!positionList) return    
    positionList.addEventListener('change', async (event)=>{
        const permissionsPanel = document.querySelector('.permissions-panel')
        
        let url = (window.location.href).split('index.php')[0]
        
        let endpoint = `${url}index.php/permissionfeature/show/${event.target.value}`        
        let resultset = await getAll(endpoint)
        console.log(endpoint)
        if(resultset.error){
            console.log(resultset.error)
        }else{
            permissionsPanel.style.display = 'block'
            const permissions = resultset.data[0]         
            
            // const inputs = document.querySelectorAll(".permissions-panel > div .form-check input")

            //     inputs.forEach((input)=>{
            //         for (const [key, value] of Object.entries(permissions)) {
            //             if(input.name == key ){
            //                 input.value = value
            //                 break
            //             }
            //         }
            //     })
              
            
        }

    })


}




export {showSandwichMenu, showAccordionMaintenance, searchItem, recordDeletionAlert, getPermissionsByPosition}