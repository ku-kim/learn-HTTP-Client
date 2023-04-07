client.test("Status code is 404", function (){
    client.assert(response.status === 404, "Response status is not 404")
});
