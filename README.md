# Dog Adoption Assistant

## IMPORTANT:

- reset DB 
- open up `scratch.http`

## josh prompts: 
- DP says "SDKs" (he'll show anthropic website in the MCP), christian and golden hair
- DP talks about workflow patterns: "wait, doc, are you saying we could use (Spring Integration, Spring Batch, Spring Statemachine, Spring Cloud Stream, Camel, Flowable, a freaking ForkJoinPool, or even just a freaking loop??) + Spring AI?" (he says yes to each of them)

## tool descriptions
- `schedule an appointment to visit or adopt a dog`



## jokes 

- youre such a tool! 
- thats not a good demo tho cuz its always 
- picture of christian with glorious long hair and now bald: hairline receede half a meter!!!

## very important HTTP prompts:

(check IntelliJ scratches!)

question = "do you have any neurotic dogs?"
question = "great. when can i visit to adopt Prancer?"


## outline 

- intro 
- prancer
- start.spring.io  (jdbc, web, ai, actuator, pgvector, mcp client)
- application.properties (SQL DB, openai api key)
- `/{id}/inquire` controller 
- `ChatClient` 
- user prompt
- 'im josh', 'whats my name?'
- observability and actuator
- no memory? advisors 
- it works. can it help us with finding the dog of our nightmares?
- nope! 
- it not acting like an employee
- system prompt 
- better, but no data! 
- RAG
- tools
- MCP
- agentic 


## important snippets:

on the MCP client:
```
 .defaultTools(new SyncMcpToolCallbackProvider(mcpSyncClient))
```

on the MCP service:
```
    @Bean
    ToolCallbackProvider toolCallbackProvider(DogAdoptionScheduler scheduler) {
        return MethodToolCallbackProvider
                .builder()
                .toolObjects(scheduler)
                .build();
    }
```


