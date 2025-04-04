// package main

// import (
// 	"fmt"
// 	"net/http"

// 	"github.com/akhil/golang-chat/pkg/websocket"
// )

// func serveWS(pool *websocket.Pool, w http.ResponseWriter, r *http.Request) {
// 	fmt.Println("websocket endpoint reached")

// 	conn, err := websocket.Upgrade(w, r)

// 	if err != nil {
// 		fmt.Fprintf(w, "%+v\n", err)
// 	}
// 	client := &websocket.Client{
// 		Conn: conn,
// 		Pool: pool,
// 	}
// 	pool.Register <- client
// 	client.Read()
// }

// func setupRoutes() {
// 	pool := websocket.NewPool()
// 	go pool.Start()

// 	http.HandleFunc("/ws", func(w http.ResponseWriter, r *http.Request) {
// 		serveWS(pool, w, r)
// 	})
// }

// func main() {
// 	fmt.Println("Lessgo! with the crazy project")
// 	setupRoutes()
// 	http.ListenAndServe(":9000", nil)
// }

package main

import (
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/akhil/golang-chat/pkg/websocket"
)

func serveWS(pool *websocket.Pool, w http.ResponseWriter, r *http.Request) {
	fmt.Println("websocket endpoint reached")

	conn, err := websocket.Upgrade(w, r)

	if err != nil {
		fmt.Fprintf(w, "%+v\n", err)
	}
	client := &websocket.Client{
		Conn: conn,
		Pool: pool,
	}
	pool.Register <- client
	client.Read()
}

func main() {
	port := os.Getenv("PORT") // Heroku provides this
	if port == "" {
		port = "9000" // Local fallback
	}

	pool := websocket.NewPool()
	go pool.Start()

	http.HandleFunc("/ws", func(w http.ResponseWriter, r *http.Request) {
		serveWS(pool, w, r)
	})

	log.Printf("Starting server on :%s", port)
	log.Fatal(http.ListenAndServe(":"+port, nil))
}
