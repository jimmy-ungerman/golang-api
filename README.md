# Golang API 
A simple Golang REST API that responds with an Epoch timestamp and a string in JSON format.

## Running the API with Go

Clone the repo to your local machine and navigate to the directory you've cloned it to.

Run the following command to start the API server 
```bash
$ go run main.go
``` 

Navigate in your web browser to `localhost:80` to get the JSON response. Alternatively, run the following command to get the response in a terminal

```bash
$ curl localhost                  

{"message":"Automate all the things!","time":1688761073}
```
