package main

/*
#include <stdlib.h>
#include "parser.h"
*/
import "C"
import (
    "fmt"
    "log"
    "net/http"
    "os"
    "unsafe"
    "io/ioutil"
)

func handler(w http.ResponseWriter, r *http.Request) {
    log.Print("zetasql-server received a request.")
    b, err := ioutil.ReadAll(r.Body)
    if err != nil || len(b) == 0 {
        w.WriteHeader(http.StatusBadRequest)
        return
    }
    cs := C.CString(string(b))
    defer C.free(unsafe.Pointer(cs))

    parseResult := C.parseQuery(cs)
    defer C.free(unsafe.Pointer(parseResult))

    w.Write([]byte(C.GoString(parseResult)))
}

func main() {
    log.Print("zetasql-server started.")

    http.HandleFunc("/", handler)

    port := os.Getenv("PORT")
    if port == "" {
        port = "8080"
    }

    log.Fatal(http.ListenAndServe(fmt.Sprintf(":%s", port), nil))
}
