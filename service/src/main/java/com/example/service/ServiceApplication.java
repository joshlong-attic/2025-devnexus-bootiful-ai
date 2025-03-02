package com.example.service;

import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.client.advisor.PromptChatMemoryAdvisor;
import org.springframework.ai.chat.client.advisor.QuestionAnswerAdvisor;
import org.springframework.ai.chat.memory.InMemoryChatMemory;
import org.springframework.ai.document.Document;
import org.springframework.ai.tool.annotation.Tool;
import org.springframework.ai.tool.annotation.ToolParam;
import org.springframework.ai.vectorstore.VectorStore;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.annotation.Id;
import org.springframework.data.repository.ListCrudRepository;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.time.Instant;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;


// todo eventually well use MCp to move the appointment functionality out to another MCP service

@SpringBootApplication
public class ServiceApplication {
    public static void main(String[] args) {
        SpringApplication.run(ServiceApplication.class, args);
    }
}


@Configuration
class ConversationalConfiguration {

    @Bean
    ChatClient chatClient(DogAdoptionAppointmentScheduler scheduler, DogRepository repository, VectorStore vectorStore, ChatClient.Builder builder) {

        if (false)
            repository.findAll().forEach(dog -> {
                var dogument = new Document("id: %s, name: %s, description: %s".formatted(dog.id(), dog.name(), dog.description()));
                vectorStore.add(List.of(dogument));
            });

        var system = """
                You are an AI powered assistant to help people adopt a dog from the adoption\s
                agency named Pooch Palace with locations in Atlanta, Antwerp, Seoul, Tokyo, Singapore, Paris,\s
                Mumbai, New Delhi, Barcelona, San Francisco, and London. Information about the dogs available\s
                will be presented below. If there is no information, then return a polite response suggesting we\s
                don't have any dogs available.
                """;
        return builder
                .defaultSystem(system)
                .defaultTools(scheduler)
                .build();
    }

}

interface DogRepository extends ListCrudRepository<Dog, Integer> {
}

record Dog(@Id int id, String name, String owner, String description) {
}

record DogAdoptionAppointment(int id, String name, Instant date) {
}

@Component
class DogAdoptionAppointmentScheduler {

    @Tool(description = "schedule an appointment to adopt a dog " +
            "at the Pooch Palace dog adoption agency")
    DogAdoptionAppointment scheduleDogAdoptionAppointment(
            @ToolParam(description = "the id of the dog") int id,
            @ToolParam(description = "the name of the dog") String name) {
        var appointment = new DogAdoptionAppointment(id, name, Instant.now());
        System.out.println("confirming the appointment: " + appointment);
        return appointment;
    }
}

@Controller
@ResponseBody
class ConversationalController {

    private final ChatClient chatClient;
    private final QuestionAnswerAdvisor questionAnswerAdvisor;
    private final Map<Long, PromptChatMemoryAdvisor> chatMemory = new ConcurrentHashMap<>();

    ConversationalController(VectorStore vectorStore, ChatClient chatClient) {
        this.chatClient = chatClient;
        this.questionAnswerAdvisor = new QuestionAnswerAdvisor(vectorStore);
    }

    // http --form POST http://localhost:8080/2/inquire question="Do you have any neurotic dogs?"
    @PostMapping("/{id}/inquire")
    String inquire(@PathVariable Long id, @RequestParam String question) {
        var promptChatMemoryAdvisor = this.chatMemory
                .computeIfAbsent(id, key -> PromptChatMemoryAdvisor.builder(new InMemoryChatMemory()).build());
        return chatClient
                .prompt()
                .user(question)
                .advisors(this.questionAnswerAdvisor, promptChatMemoryAdvisor)
                .call()
                .content();
    }
}