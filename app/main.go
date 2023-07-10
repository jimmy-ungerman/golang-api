package main
 
import (
	"log"
	"time"
	"net/http"
	"encoding/json"
)

// Stup the JSON Structure for the API Response
type apiResponse struct {
    Message string    `json:"message"`
    Time    int64     `json:"time"`
}

func golangAPI(w http.ResponseWriter, r *http.Request){
	var response = apiResponse{Message: "Automate all the things!", Time: time.Now().Unix()}
	w.Header().Set("Content-Type", "application/json")
	
	body, err := json.Marshal(response)

	// Error checking brought up by linting job
	if err != nil {
		panic(err)
	}
	_, err2 := w.Write(body)

	// Error checking brought up by linting job
	if err2 != nil {
		panic(err2)
	}
}

func handleRequests() {
    http.HandleFunc("/", golangAPI)
    log.Fatal(http.ListenAndServe(":80", nil))
}

func main() {
    handleRequests()
}