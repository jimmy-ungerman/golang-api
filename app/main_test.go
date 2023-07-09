package main
 
import (
	"testing"
	"net/http"
    "net/http/httptest"
	"time"
	"fmt"
	"strings"
)

func TestAPI(t *testing.T) {
	req, err := http.NewRequest("GET", "/", nil)
	if err != nil {
		t.Fatal(err)
	}
	rr := httptest.NewRecorder()
	handler := http.HandlerFunc(golangAPI)
	handler.ServeHTTP(rr, req)

	if status := rr.Code; status != http.StatusOK {
		t.Errorf("handler returned wrong status code: got %v want %v",
		status, http.StatusOK)
	}

	test := rr.Body.String()
	// Remove New Line from end of the response
	test = strings.Replace(test, "\n", "", -1)

	Time := time.Now().Unix()
	
	expected := fmt.Sprintf(`{"message":"Automate all the things!","time":%d}`, Time)
	if test != expected {
		t.Errorf("handler returned unexpected body: got %v want %v",
			test, expected)
	}

}
