package main

import (
	"context"
	"flag"
	"log"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"time"

	"github.com/jfkonecn/.dotfiles/gobins/internal/llm"
	"github.com/philippgille/chromem-go"
)

const (
	question = "According the journal entries, what tasks were done?"
	// We use a local LLM running in Ollama for the embedding: https://huggingface.co/nomic-ai/nomic-embed-text-v1.5
	embeddingModel = "nomic-embed-text"
)

func main() {
	folderPath := flag.String("f", "", "Path to the folder containing markdown files")
	flag.Parse()

	if *folderPath == "" {
		log.Fatal("Please provide a folder path using the -f flag")
	}

	ctx := context.Background()

	// Warm up Ollama, in case the model isn't loaded yet
	log.Println("Warming up Ollama...")
	_ = llm.AskLLM(ctx, nil, "Hello!")

	// First we ask an LLM a fairly specific question that it likely won't know
	// the answer to.
	log.Println("Question: " + question)
	log.Println("Asking LLM...")
	reply := llm.AskLLM(ctx, nil, question)
	log.Printf("Initial reply from the LLM: \"" + reply + "\"\n")

	// Now we use our vector database for retrieval augmented generation (RAG),
	// which means we provide the LLM with relevant knowledge.

	// Set up chromem-go with persistence, so that when the program restarts, the
	// DB's data is still available.
	log.Println("Setting up chromem-go...")
	db, err := chromem.NewPersistentDB("./db", false)
	if err != nil {
		panic(err)
	}
	// Create collection if it wasn't loaded from persistent storage yet.
	// You can pass nil as embedding function to use the default (OpenAI text-embedding-3-small),
	// which is very good and cheap. It would require the OPENAI_API_KEY environment
	// variable to be set.
	// For this example we choose to use a locally running embedding model though.
	// It requires Ollama to serve its API at "http://localhost:11434/api".
	collection, err := db.GetOrCreateCollection("Wikipedia", nil, chromem.NewEmbeddingFuncOllama(embeddingModel, ""))
	if err != nil {
		panic(err)
	}
	// Add docs to the collection, if the collection was just created (and not
	// loaded from persistent storage).
	var docs []chromem.Document
	if collection.Count() == 0 {
		log.Println("Searching for markdown files...")
		err = filepath.Walk(*folderPath, func(path string, info os.FileInfo, err error) error {
			if err != nil {
				return err
			}
			if !info.IsDir() && strings.HasSuffix(info.Name(), ".md") {
				content, readErr := os.ReadFile(path)
				if readErr != nil {
					return readErr
				}
				doc := chromem.Document{
					ID:       path,
					Metadata: map[string]string{"path": path},
					Content:  string(content),
				}
				docs = append(docs, doc)
			}
			return nil
		})
		if err != nil {
			panic(err)
		}

		log.Println("Adding documents to chromem-go, including creating their embeddings via Ollama API...")
		err = collection.AddDocuments(ctx, docs, runtime.NumCPU())
		if err != nil {
			panic(err)
		}
	} else {
		log.Println("Not reading JSON lines because collection was loaded from persistent storage.")
	}

	// Search for documents that are semantically similar to the original question.
	// We ask for the two most similar documents, but you can use more or less depending
	// on your needs and the supported context size of the LLM you use.
	// You can limit the search by filtering on content or metadata (like the article's
	// category), but we don't do that in this example.
	start := time.Now()
	log.Println("Querying chromem-go...")
	// "nomic-embed-text" specific prefix (not required with OpenAI's or other models)
	query := "search_query: " + question
	docRes, err := collection.Query(ctx, query, 5, nil, nil)
	if err != nil {
		panic(err)
	}
	log.Println("Search (incl query embedding) took", time.Since(start))
	// Here you could filter out any documents whose similarity is below a certain threshold.
	// if docRes[...].Similarity < 0.5 { ...

	// Print the retrieved documents and their similarity to the question.
	for i, res := range docRes {
		// Cut off the prefix we added before adding the document (see comment above).
		// This is specific to the "nomic-embed-text" model.
		content := strings.TrimPrefix(res.Content, "search_document: ")
		log.Printf("Document %d (similarity: %f): \"%s\"\n", i+1, res.Similarity, content)
	}

	// Now we can ask the LLM again, augmenting the question with the knowledge we retrieved.
	// In this example we just use both retrieved documents as context.
	contexts := []string{docRes[0].Content, docRes[1].Content}
	log.Println("Asking LLM with augmented question...")
	reply = llm.AskLLM(ctx, contexts, question)
	log.Printf("Reply after augmenting the question with knowledge: \"%s\"\n", reply)

	/* Output (can differ slightly on each run):
	2024/03/02 20:02:30 Warming up Ollama...
	2024/03/02 20:02:33 Question: When did the Monarch Company exist?
	2024/03/02 20:02:33 Asking LLM...
	2024/03/02 20:02:34 Initial reply from the LLM: "I cannot provide information on the Monarch Company, as I am unable to access real-time or comprehensive knowledge sources."
	2024/03/02 20:02:34 Setting up chromem-go...
	2024/03/02 20:02:34 Reading JSON lines...
	2024/03/02 20:02:34 Adding documents to chromem-go, including creating their embeddings via Ollama API...
	2024/03/02 20:03:11 Querying chromem-go...
	2024/03/02 20:03:11 Search (incl query embedding) took 231.672667ms
	2024/03/02 20:03:11 Document 1 (similarity: 0.655357): "Malleable Iron Range Company was a company that existed from 1896 to 1985 and primarily produced kitchen ranges made of malleable iron but also produced a variety of other related products. The company's primary trademark was 'Monarch' and was colloquially often referred to as the Monarch Company or just Monarch."
	2024/03/02 20:03:11 Document 2 (similarity: 0.504042): "The American Motor Car Company was a short-lived company in the automotive industry founded in 1906 lasting until 1913. It was based in Indianapolis Indiana United States. The American Motor Car Company pioneered the underslung design."
	2024/03/02 20:03:11 Asking LLM with augmented question...
	2024/03/02 20:03:32 Reply after augmenting the question with knowledge: "The Monarch Company existed from 1896 to 1985."
	*/
}
