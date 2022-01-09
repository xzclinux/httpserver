package main

import (
	"fmt"
	"io"
	"net/http"
	"os"
)

const form = `
    <html><body>
        <form action="#" method="post" name="bar">
            <input type="text" name="in" />
            <input type="submit" value="submit"/>
        </form>
    </body></html>
`

/* handle a simple get request */
func SimpleServer(w http.ResponseWriter, request *http.Request) {
	io.WriteString(w, "<h1>hello, world</h1>")


	os.Setenv("VERSION","0.1")
	version :=  os.Getenv("VERSION")
	w.Header().Set("VERSION",version)

	for k, v := range  request.Header{
		for _, vv := range v{
			w.Header().Set(k,vv)
		}
	}

}

func healthz(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "working")
}

func main() {
	http.HandleFunc("/test1", SimpleServer)
	http.HandleFunc("/health", healthz)
	if err := http.ListenAndServe(":8088", nil); err != nil {
		panic(err)
	}
}


