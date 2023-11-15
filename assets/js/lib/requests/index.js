async function getAll(url){

    const response = {
        'error': '',
        'data': ''
    }

    try{
        const request = await fetch(url)
        response.data =  await request.json()
    }catch(e){
        response.error = e
    }

    return response        
}

export { getAll }