module.exports.handler = async (event) => {
  console.log('Request: ', event);

  let responseMessage = 'status: ok';
  console.log('Response: ', responseMessage);

  return {
    statusCode: 200,
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      message: responseMessage,
    }),
  }
  
}

